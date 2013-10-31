{-------------------------------------------------------------------------------

        Bug workaround for 'The DecisionCube capacity is low' bug

________________________________________________________________________________

BUG DESCRIPTION
  If you have a lot of physical memory or a large page file, you may find that a
  DecisionCube raises the following exception whenever the DecisionCube's data
  set is opened:
    Exception class: ELowCapacityError
    Message: "The DecisionCube capacity is low. Please deactivate dimensions or
             change the data set."
  The exception will occur whenever the sum of the available physical memory and
  the available page file memory exceeds 2 GBytes. This is caused by a bug in
  Delphi - more specifically: an integer being out of range in the procedure
  GetAvailableMem (unit Mxarrays).

AFFECTED DELPHI VERSIONS
  Delphi 3-7 (with the DecisionCube package installed)

WORKAROUND
  Add this unit to your project.
-------------------------------------------------------------------------------}

unit DecisionCubeBugWorkaround;

interface

uses Windows, Mxarrays;

implementation

function GetAvailableMem: Integer;
const
  MaxInt: Int64 = High(Integer);
var
  MemStats: TMemoryStatus;
  Available: Int64;
begin
  GlobalMemoryStatus(MemStats);
  if (MemStats.dwAvailPhys > MaxInt) or (Longint(MemStats.dwAvailPhys) = -1) then
    Available := MaxInt
  else
    Available := MemStats.dwAvailPhys;
  if (MemStats.dwAvailPageFile > MaxInt) or (Longint(MemStats.dwAvailPageFile) = -1) then
    Inc(Available, MaxInt div 2)
  else
    Inc(Available, MemStats.dwAvailPageFile div 2);
  if Available > MaxInt then
    Result := MaxInt
  else
    Result := Available;
end;

initialization
  Mxarrays.SetMemoryCapacity(GetAvailableMem);
end.

end.
 