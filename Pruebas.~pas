unit Pruebas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, Mask, DBCtrls, dbcgrids, Buttons, ExtCtrls;

type
  TFPruebas = class(TForm)
    Panel2: TPanel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DBCtrlGrid1: TDBCtrlGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DSPrue: TDataSource;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BBtnBorrar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBtnBorrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPruebas: TFPruebas;

implementation

uses DataModule1;

{$R *.dfm}

procedure TFPruebas.FormShow(Sender: TObject);
begin
  DM1.TPrue.Open;
end;

procedure TFPruebas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM1.TPrue.Close;
end;

procedure TFPruebas.BBtnBorrarClick(Sender: TObject);
var
  borrar : boolean;
  cadena : String;

begin
  borrar:=true;

  if borrar
  then begin
          cadena:='¿Desea borrar el siguiente registro ? :'+chr(13)+chr(13)+
                  'Codigo:' +DBEdit1.Text+chr(13)+
                  'Prueba: '+DBEdit2.Text+chr(13);
          if MessageDlg(cadena, mtConfirmation,[mbOk, mbNo], 0) = mrOk
          then borrar:=true
          else borrar:=false;
        end;

  if borrar
  then begin
          if DM1.TPrue.Locate('TipoPrueba',trim(DBEdit1.Text),[])
          then DM1.TPrue.Delete;
       end
  else begin
         ShowMessage ('Operación cancelada');
       end;

end;

end.
