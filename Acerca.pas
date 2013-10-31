unit Acerca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TFAcerca = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAcerca: TFAcerca;

implementation

{$R *.dfm}

procedure TFAcerca.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
