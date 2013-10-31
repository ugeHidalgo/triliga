unit Participantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, dbcgrids, DB;

type
  TFPart = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DSPart: TDataSource;
    DBCtrlGrid2: TDBCtrlGrid;
    DBEdApellidos: TDBEdit;
    DBedFenac: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdNombre: TDBEdit;
    DBEdCodigo: TDBEdit;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    BBtnBorrar: TBitBtn;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBtnBorrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPart: TFPart;

implementation

uses DataModule1;

{$R *.dfm}

procedure TFPart.FormShow(Sender: TObject);
begin
  DM1.TPart.Open;
end;

procedure TFPart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM1.TPart.Close;
end;

procedure TFPart.BBtnBorrarClick(Sender: TObject);
var
  borrar : Boolean;
  cadena : String;

begin
  borrar:=true;

  if borrar
  then begin
          cadena:='¿Desea borrar el siguiente registro ? :'+chr(13)+chr(13)+
                  'Codigo:' +DBEdCodigo.Text+chr(13)+
                  'Apellidos: '+DBEdApellidos.Text+chr(13)+
                  'Nombre: '+DBEdNombre.Text+chr(13);
          if MessageDlg(cadena, mtConfirmation,[mbOk, mbNo], 0) = mrOk
          then borrar:=true
          else borrar:=false;
        end;

  if borrar
  then begin
          if DM1.TPart.Locate('Atleta',trim(DBEdCodigo.Text),[])
          then DM1.TPart.Delete;
       end
  else begin
         ShowMessage ('Operación cancelada');
       end;

end;

end.
