unit InformeIndividual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dbcgrids, StdCtrls, ExtCtrls, ComCtrls, jpeg, Buttons, DB, Mask,
  DBCtrls, Utilidades, RpRave, RpDefine, RpCon, RpConDS, RpBase, RpFiler,
  RpRender, RpRenderPDF;

type
  TFInfInd = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BBtnImprime: TBitBtn;
    Panel2: TPanel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    CBPart: TComboBox;
    DTPDesde: TDateTimePicker;
    DTPHasta: TDateTimePicker;
    BBtnSemana: TBitBtn;
    BBtnMes: TBitBtn;
    BBtnAno: TBitBtn;
    BitBtn2: TBitBtn;
    PgProgreso: TProgressBar;
    DBCtrlGrid1: TDBCtrlGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DSInfInd: TDataSource;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel4: TBevel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    RvDSCInfInd: TRvDataSetConnection;
    RvPInfInd: TRvProject;
    RvDSAux: TRvDataSetConnection;
    RvRenderPDF1: TRvRenderPDF;
    procedure BitBtn1Click(Sender: TObject);
    procedure BBtnSemanaClick(Sender: TObject);
    procedure BBtnMesClick(Sender: TObject);
    procedure BBtnAnoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BBtnImprimeClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FInfInd: TFInfInd;

implementation

uses DataModule1,DateUtils;

{$R *.dfm}

procedure TFInfInd.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TFInfInd.BBtnSemanaClick(Sender: TObject);
begin
   DTPDesde.Date:=StartOfTheWeek(Date);
   DTPHasta.Date:=EndOfTheWeek(Date);
end;

procedure TFInfInd.BBtnMesClick(Sender: TObject);
begin
  DTPDesde.Date:=StartOfTheMonth(Date);
  DTPHasta.Date:=EndOfTheMonth(Date);
end;

procedure TFInfInd.BBtnAnoClick(Sender: TObject);
begin
  DTPDesde.Date:=StartOfTheYear(Date);
  DTPHasta.Date:=EndOfTheYear(Date);
end;

procedure TFInfInd.FormShow(Sender: TObject);
var
  cadena : String;

begin
  //Vacío el combo
  CBPart.Clear;

   //Lo vuelvo a cargar
   DM1.Tpart.Open;
   While (NOT DM1.Tpart.EOF) do
   begin
      cadena:=DM1.Tpart.FieldByName('Apellidos').AsString+' '+
              DM1.Tpart.FieldByName('Nombre').AsString+' // '+
              DM1.Tpart.FieldByName('Atleta').AsString;
      CBPart.AddItem (cadena, CBPart);
      DM1.Tpart.Next;
   end;
   DM1.Tpart.Close;

end;

procedure TFInfInd.BitBtn2Click(Sender: TObject);
var
  codigoAux : String;
  CodigoPart : Integer;
  CreaInforme : Boolean;

begin
  CreaInforme:=True;
  if (trim(CBPart.Text)='')
  then begin
         CreaInforme:=False;
         ShowMessage ('No has seleccionado un participante');
       end;

  if CreaInforme
  then begin
         if (DTPDesde.Date>DTPHasta.Date)
         then begin
                CreaInforme:=False;
                ShowMessage ('La fecha de inicio tiene que ser anterior a la de final');
              end;
       end;

  if CreaInforme
  then begin
         ObtenCodigo (CBPart.Text,CodigoAux);
         CodigoPart:=StrToInt(CodigoAux);
         DM1.QInfInd.Close;
         DM1.QInfInd.Params[0].AsInteger:=CodigoPart;
         DM1.QInfInd.Params[1].AsDateTime:=DTPDesde.Date-1;
         DM1.QInfInd.Params[2].AsDateTime:=DTPHasta.Date;
         DM1.QInfInd.Open;
       end;
end;

procedure TFInfInd.BBtnImprimeClick(Sender: TObject);
var
  CreaInforme : Boolean;

begin
  CreaInforme:=True;
  if (trim(CBPart.Text)='')
  then begin
         CreaInforme:=False;
         ShowMessage ('No has seleccionado un participante');
       end;

  if CreaInforme
  then begin
         if (DTPDesde.Date>DTPHasta.Date)
         then begin
                CreaInforme:=False;
                ShowMessage ('La fecha de inicio tiene que ser anterior a la de final');
              end;
       end;

  if CreaInforme
  then begin
         DM1.TAuxInfInd.Open;
         While (Not DM1.TAuxInfInd.EOF) do
            DM1.TAuxInfInd.Delete;
         DM1.TAuxInfInd.Append;
         DM1.TAuxInfInd.FieldByName('Nombre').AsString:=CBPart.Text;
         DM1.TAuxInfInd.FieldByName('FechaIni').AsDateTime:=DTPDesde.Date;
         DM1.TAuxInfInd.FieldByName('FechaFin').AsDateTime:=DTPHasta.Date;
         DM1.TAuxInfInd.Post;
         RVPInfInd.Execute;
         DM1.TAuxInfInd.Close;
       end;
end;

procedure TFInfInd.Image1Click(Sender: TObject);
begin
  Image1.Picture:=nil;
end;

end.
