unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, DB, StdCtrls, Mask, DBCtrls, Buttons, Grids,
  DBGrids, ExtCtrls, dbcgrids, DBTables, jpeg, Utilidades;

type
  TFMain = class(TForm)
    DSReg: TDataSource;
    MainMenu1: TMainMenu;
    Participamntes1: TMenuItem;
    iposdePrueba1: TMenuItem;
    Participantes1: TMenuItem;
    N1: TMenuItem;
    Salir1: TMenuItem;
    PCMain: TPageControl;
    TSRegistros: TTabSheet;
    DBGrid1: TDBGrid;
    BBtnNuevo: TBitBtn;
    BBtnEditar: TBitBtn;
    BBtnCancelar: TBitBtn;
    BBtnBorrar: TBitBtn;
    BBtnGrabar: TBitBtn;
    Informes1: TMenuItem;
    Clasificaciones1: TMenuItem;
    N2: TMenuItem;
    Acercade1: TMenuItem;
    Panel3: TPanel;
    DTFecha: TDateTimePicker;
    Label17: TLabel;
    CBParticipantes: TComboBox;
    Label18: TLabel;
    EdNombrePrueba: TEdit;
    Label20: TLabel;
    CBTipoPrueba: TComboBox;
    Label19: TLabel;
    Panel2: TPanel;
    Label26: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Bevel2: TBevel;
    EdPP: TEdit;
    EdPRG: TEdit;
    EdPRGE: TEdit;
    EdPuntos: TEdit;
    Panel1: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    EdPosG: TEdit;
    EdPartG: TEdit;
    EdPartGE: TEdit;
    EdPosGE: TEdit;
    Panel4: TPanel;
    Image1: TImage;
    Informesindividuales1: TMenuItem;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Salir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBtnNuevoClick(Sender: TObject);
    procedure BBtnEditarClick(Sender: TObject);
    procedure BBtnCancelarClick(Sender: TObject);
    procedure BBtnGrabarClick(Sender: TObject);
    procedure BBtnBorrarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure EdPartGExit(Sender: TObject);
    procedure EdPosGExit(Sender: TObject);
    procedure EdPartGEExit(Sender: TObject);
    procedure EdPosGEExit(Sender: TObject);
    procedure Participantes1Click(Sender: TObject);
    procedure iposdePrueba1Click(Sender: TObject);
    procedure Clasificaciones1Click(Sender: TObject);
    procedure Acercade1Click(Sender: TObject);
    procedure Informesindividuales1Click(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CargaCombo(combo: TComboBox; tabla : TTable; campo1 : String;
                            campo2 : String; campo3 : String);
    procedure ActualizaPuntos;
  end;

var
  FMain: TFMain;
  nuevo, editar, RegGridClick : boolean;
  codigoReg, CodigoPart : LongInt;

implementation

uses DataModule1, Participantes, Pruebas, Acerca, Clasificaciones,
  InformeIndividual;

{$R *.dfm}

//##############################################################################################
procedure TFMain.ActualizaPuntos;
var
     PP : Integer; //Puntos por participar en el tipo de carrera.
    PGE : Integer; //Puntos a repartir por clasificación Global.
     PG : Integer; //Puntos a repartir por clasificación Grupo Edad..
  PorGE : Integer; //Porcentaje del total de participantes que se reparten puntos en G.E.
   PorG : Integer; //Porcentaje del total de participantes que se reparten puntos en G.E.
   Part : Integer; //Participantes en la carrera en el global.
 PartGE : Integer; //Participantes en la carrera en el G.E.
    Pos : Integer; //Posición del participante en la carrera.
  PosGE : Integer; //Posición del participante en el G.E.
CodPart : Integer; //Código del participante.
    Aux : String;
calcula : Boolean;
AuxG, AuxGE : Integer;

begin
  calcula:=True;
  //Obtengo datos del tipo de prueba.
  DM1.TPrue2.Open;
  if DM1.TPrue2.Locate('TipoPrueba',Trim(CBTipoPrueba.Text),[])
  then begin
          PP:=DM1.TPrue2.FieldByName('PParticipacion').AsInteger;
          PGE:=DM1.TPrue2.FieldByName('PGE').AsInteger;
          PG:=DM1.TPrue2.FieldByName('PGlobal').AsInteger;
          PorGE:=DM1.TPrue2.FieldByName('PorcentGE').AsInteger;
          PorG:=DM1.TPrue2.FieldByName('PorcentGlobal').AsInteger;
       end
  else begin
          ShowMessage ('Error al calcular puntos: El tipo de prueba es deconocido');
          calcula:=False;
       end;
  DM1.TPrue2.Close;

  //Obtengo los datos del participante en la carrera.
  if calcula
  then begin
          if Trim(EdPartG.Text)=''
          then Part:=-1
          else Part:=StrToInt(Trim(EdPartG.Text));
          if Trim(EdPartGE.Text)=''
          then PartGE:=-1
          else PartGE:=StrToInt(Trim(EdPartGE.Text));
          if Trim(EdPosG.Text)=''
          then Pos:=-1
          else Pos:=StrToInt(Trim(EdPosG.Text));
          if Trim(EdPosGE.Text)=''
          then PosGE:=-1
          else PosGE:=StrToInt(Trim(EdPosGE.Text));
       end;

  //Primero: Actualizo puntos por participar.
  if calcula
  then begin
          EdPP.Text:=IntToStr(PP);
       end;


  //Segundo: Actualizo puntos por clasificación Global.
  if (calcula AND (Pos<>-1) AND (Part<>-1) )
  then begin
          AuxG:=PG-Trunc( Pos/((Part*(PorG/100))/PG) );
          if AuxG<0 then AuxG:=0;
          EdPRG.Text:=IntToStr(AuxG);
       end;

  //Tercero: Actualizo puntos por clasificación en G.E.
  if (calcula AND (PosGE<>-1) AND (PartGE<>-1) )
  then begin
          AuxGE:=PGE-Trunc( PosGE/ ((PartGE*(PorGE/100))/PGE) );
          if AuxGE<0 then AuxGE:=0;
          EdPRGE.Text:=IntToStr(AuxGE);
       end;

  //Sumo los tres campos:
  EdPuntos.Text:=IntToStr(PP+AuxG+AuxGE);
end;




//##############################################################################################
procedure TFMain.CargaCombo(combo: TComboBox; tabla : TTable; campo1 : String;
                            campo2 : String; campo3 : String);
var
  cadena : String;

begin
   //Vacío el combo
   combo.Clear;

   //Lo vuelvo a cargar
   tabla.Open;
   While (NOT tabla.EOF) do
   begin
      cadena:=tabla.FieldByName(campo1).AsString;
      if campo2<>''
      then begin
              cadena:=cadena+' '+tabla.FieldByName(campo2).AsString;
              if campo3<>''
              then cadena:=cadena+' // '+tabla.FieldByName(campo3).AsString;
           end;
      combo.AddItem (cadena, combo);
      tabla.Next;
   end;
   tabla.Close;
end;

//##############################################################################################
procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('¿Desea cerrar la aplicación?', mtConfirmation,
    [mbOk, mbNo], 0)=mrOk
  then CanClose:=True
  else CanClose:=False;

end;

procedure TFMain.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  //Cargo los combos de participantes y tipos de pruebas
  CargaCombo(CBParticipantes,DM1.TPart,'Apellidos','Nombre', 'Atleta');
  CargaCombo(CBTipoPrueba,DM1.TPrue,'TipoPrueba','','');

  DM1.QReg.Open;

  RegGridClick:=True;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM1.QReg.Close;
  //DM1.TPart.Close;
  //DM1.TPrue.Close;
end;

procedure TFMain.BBtnNuevoClick(Sender: TObject);
begin
  nuevo:=true;
  RegGridClick:=False;

  //Cambio estado de los botones botones
  BBtnNuevo.Enabled:=False;
  BBtnEditar.Enabled:=False;
  BBtnCancelar.Enabled:=True;
  BBtnBorrar.Enabled:=False;
  BBtnGrabar.Enabled:=True;

  //Habilito campos para escritura
  DTFecha.Enabled:=True;
  CBParticipantes.Enabled:=True;
  CBTipoPrueba.Enabled:=True;
  EdNombrePrueba.ReadOnly:=False;
  EdPartG.ReadOnly:=False;
  EdPartGE.ReadOnly:=False;
  EdPosG.ReadOnly:=False;
  EdPosGE.ReadOnly:=False;

  //Borro campos
  DTFecha.Date:=now;
  CBParticipantes.Text:='';
  CBTipoPrueba.Text:='';
  EdNombrePrueba.Text:='';
  EdPartG.Text:='';
  EdPartGE.Text:='';
  EdPosG.Text:='';
  EdPosGE.Text:='';
  EdPP.Text:='0';
  EdPRG.Text:='0';
  EdPRGE.Text:='0';
  EdPuntos.Text:='0';

  //Paso el control al primer campo
  DTFecha.SetFocus;
end;

procedure TFMain.BBtnEditarClick(Sender: TObject);
begin
  editar:=true;
  RegGridClick:=False;

  //Cambio estado de los botones botones
  BBtnNuevo.Enabled:=False;
  BBtnEditar.Enabled:=False;
  BBtnCancelar.Enabled:=True;
  BBtnBorrar.Enabled:=False;
  BBtnGrabar.Enabled:=True;

  //Habilito campos para escritura
  DTFecha.Enabled:=True;
  CBParticipantes.Enabled:=True;
  CBTipoPrueba.Enabled:=True;
  EdNombrePrueba.ReadOnly:=False;
  EdPartG.ReadOnly:=False;
  EdPartGE.ReadOnly:=False;
  EdPosG.ReadOnly:=False;
  EdPosGE.ReadOnly:=False;
  
  //Paso el control al primer campo
  DTFecha.SetFocus;

  CodigoReg:=DM1.QReg.FieldByName('Codigo').AsInteger;
end;

procedure TFMain.BBtnCancelarClick(Sender: TObject);
begin
  nuevo:=false;
  editar:=false;
  RegGridClick:=True;
  
  //Cambio estado de los botones botones
  BBtnNuevo.Enabled:=True;
  BBtnEditar.Enabled:=True;
  BBtnCancelar.Enabled:=False;
  BBtnBorrar.Enabled:=True;
  BBtnGrabar.Enabled:=False;

  //Deshabilito campos para escritura
  DTFecha.Enabled:=False;
  CBParticipantes.Enabled:=False;
  CBTipoPrueba.Enabled:=False;
  EdNombrePrueba.ReadOnly:=True;
  EdPartG.ReadOnly:=True;
  EdPartGE.ReadOnly:=True;
  EdPosG.ReadOnly:=True;
  EdPosGE.ReadOnly:=True;

  //Borro campos
  DTFecha.Date:=now;
  CBParticipantes.Text:='';
  CBTipoPrueba.Text:='';
  EdNombrePrueba.Text:='';
  EdPartG.Text:='';
  EdPartGE.Text:='';
  EdPosG.Text:='';
  EdPosGE.Text:='';
  EdPP.Text:='0';
  EdPRG.Text:='0';
  EdPRGE.Text:='0';
  EdPuntos.Text:='0';
end;

procedure TFMain.BBtnGrabarClick(Sender: TObject);
var
  graba : boolean;
  codigoAux : String;

begin
  graba:=false;

  if MessageDlg('¿Desea grabar el registro?', mtConfirmation,
    [mbOk, mbNo], 0) = mrOk
  then graba:=true
  else graba:=false;

  //Compruebo que los datos sean correctos.
  if graba
  then begin
          //Miro si el participante existe.
          ObtenCodigo (CBParticipantes.Text,CodigoAux);
          CodigoPart:=StrToInt(CodigoAux);
          DM1.TPart.Open;
          if (NOT DM1.TPart.Locate('Atleta',CodigoPart,[]))
          then begin
                  graba:=false;
                  ShowMessage('Los datos del participante '+CodigoAux+' no son correctos');
               end;
          DM1.TPart.Close;
          DM1.TPrue.Open;
          //Miro si el tipo de prubea existe.
          if (NOT DM1.TPrue.Locate('TipoPrueba',trim(CBTipoPrueba.Text),[]))
          then begin
                  graba:=false;
                  ShowMessage('Los datos del tipo de prueba no son correctos');
               end;
          DM1.TPrue.Close;
          //Miro si se han calculado los puntos
          if Trim(EdPuntos.Text)=''
          then begin
                  ShowMessage ('No se han asignado puntos');
                  graba:=false;
               end;
       end;

  if graba
  then begin
          if nuevo
          then begin
                  DM1.TReg.Open;
                  DM1.TReg.Append;
               end;

          if editar
          then begin
                  DM1.TReg.Open;
                  DM1.TReg.Locate ('Codigo',CodigoReg,[]);
                  DM1.TReg.Edit;
               end;

          DM1.TReg.FieldByName('Fecha').AsDateTime:=DTFecha.Date;
          DM1.TReg.FieldByName('Atleta').AsInteger:=CodigoPart;
          DM1.TReg.FieldByName('TipoPrueba').AsString:=CBTipoPrueba.Text;
          DM1.TReg.FieldByName('NombrePrueba').AsString:=EdNombrePrueba.Text;
          DM1.TReg.FieldByName('PartG').AsString:=EdPartG.Text;
          DM1.TReg.FieldByName('PartGE').AsString:=EdPartGE.Text;
          DM1.TReg.FieldByName('PosG').AsString:=EdPosG.Text;
          DM1.TReg.FieldByName('PosGE').AsString:=EdPosGE.Text;
          DM1.TReg.FieldByName('PP').AsString:=EdPP.Text;
          DM1.TReg.FieldByName('PRG').AsString:=EdPRG.Text;
          DM1.TReg.FieldByName('PRGE').AsString:=EdPRGE.Text;
          DM1.TReg.FieldByName('Puntos').AsString:=EdPuntos.Text;

          DM1.TReg.Post;
          DM1.TReg.Close;

          //Cambio estado de los botones botones
          BBtnNuevo.Enabled:=True;
          BBtnEditar.Enabled:=True;
          BBtnCancelar.Enabled:=False;
          BBtnBorrar.Enabled:=True;
          BBtnGrabar.Enabled:=False;

          //Deshabilito campos para escritura
          DTFecha.Enabled:=False;
          CBParticipantes.Enabled:=False;
          CBTipoPrueba.Enabled:=False;
          EdNombrePrueba.ReadOnly:=True;
          EdPartG.ReadOnly:=True;
          EdPartGE.ReadOnly:=True;
          EdPosG.ReadOnly:=True;
          EdPosGE.ReadOnly:=True;

          nuevo:=False;
          editar:=false;
          RegGridClick:=True;

          //Actualizo la consulta.
          DM1.QReg.Close;
          DM1.QReg.Open;
          ShowMessage ('Registro grabado');
       end
  else begin
          ShowMessage ('Operación cancelada');
       end;
end;


procedure TFMain.BBtnBorrarClick(Sender: TObject);
var
  borrar : boolean;
  cadena : String;

begin
  borrar:=true;
  RegGridClick:=False;
  
  if CBParticipantes.Text=''
  then begin
         borrar:=False;
         ShowMessage ('No has seleccionado un registro para borrar.'+chr(13)+
                      'Selecciona uno de la lista de registros.');
       end;

  if borrar
  then begin
          cadena:='¿Desea borrar el siguiente registro ? :'+chr(13)+chr(13)+
                  'Fecha:' +DateToStr(DTFecha.Date)+chr(13)+
                  'Participante: '+CBParticipantes.Text+chr(13)+
                  'Tipo de prueba: '+CBTipoPrueba.Text+chr(13)+
                  'Nombre prueba: '+EdNombrePrueba.Text;
          if MessageDlg(cadena, mtConfirmation,[mbOk, mbNo], 0) = mrOk
          then borrar:=true
          else borrar:=false;
        end;

  if borrar
  then begin
          nuevo:=false;
          editar:=false;

          DM1.TReg.Open;
          if DM1.TReg.Locate('Codigo',CodigoReg,[])
          then DM1.TReg.Delete;
          DM1.TReg.Close;

          //Borro campos
          DTFecha.Date:=now;
          CBParticipantes.Text:='';
          CBTipoPrueba.Text:='';
          EdNombrePrueba.Text:='';
          EdPartG.Text:='';
          EdPartGE.Text:='';
          EdPosG.Text:='';
          EdPosGE.Text:='';
          EdPP.Text:='0';
          EdPRG.Text:='0';
          EdPRGE.Text:='0';
          EdPuntos.Text:='0';

          //Cambio estado de los botones botones
          BBtnNuevo.Enabled:=True;
          BBtnEditar.Enabled:=True;
          BBtnCancelar.Enabled:=False;
          BBtnBorrar.Enabled:=True;
          BBtnGrabar.Enabled:=False;

          //Deshabilito campos para escritura
          DTFecha.Enabled:=False;
          CBParticipantes.Enabled:=False;
          CBTipoPrueba.Enabled:=False;
          EdNombrePrueba.ReadOnly:=True;
          EdPartG.ReadOnly:=True;
          EdPartGE.ReadOnly:=True;
          EdPosG.ReadOnly:=True;
          EdPosGE.ReadOnly:=True;

          //Actualizo la consulta después de borra
          DM1.QReg.Close;
          DM1.QReg.Open;
       end
  else begin
          ShowMessage ('Operación cancelada');
       end;

   RegGridClick:=True;
end;

procedure TFMain.DBGrid1CellClick(Column: TColumn);
begin
  if RegGridClick
  then begin
          //Paso los datos del grid a los campos.
          CodigoReg:=DM1.QReg.FieldByName('Codigo').AsInteger;
          DTFecha.Date:=DM1.QReg.FieldByName('Fecha').AsDateTime;
          CodigoPart:=DM1.QReg.FieldByName('Atleta').AsInteger;
          DM1.TPart.Open;
          DM1.TPart.Locate ('Atleta',CodigoPart,[]);
          CBParticipantes.Text:=DM1.TPart.FieldByName('Apellidos').AsString+' '+
                       DM1.TPart.FieldByName('Nombre').AsString+' // '+
                       intToStr(CodigoPart);
          DM1.TPart.Close;
          CBTipoPrueba.Text:=DM1.QReg.FieldByName('TipoPrueba').AsString;
          EdNombrePrueba.Text:=DM1.QReg.FieldByName('NombrePrueba').AsString;
          EdPartG.Text:=DM1.QReg.FieldByName('PartG').AsString;
          EdPartGE.Text:=DM1.QReg.FieldByName('PartGE').AsString;
          EdPosG.Text:=DM1.QReg.FieldByName('PosG').AsString;
          EdPosGE.Text:=DM1.QReg.FieldByName('PosGE').AsString;
          EdPP.Text:=DM1.QReg.FieldByName('PP').AsString;
          EdPRG.Text:=DM1.QReg.FieldByName('PRG').AsString;
          EdPRGE.Text:=DM1.QReg.FieldByName('PRGE').AsString;
          EdPuntos.Text:=DM1.QReg.FieldByName('Puntos').AsString;
       end;
end;

procedure TFMain.EdPartGExit(Sender: TObject);
begin
  if (nuevo OR editar)
  then ActualizaPuntos;
end;

procedure TFMain.EdPosGExit(Sender: TObject);
begin
  if (nuevo OR editar)
  then ActualizaPuntos;
end;

procedure TFMain.EdPartGEExit(Sender: TObject);
begin
  if (nuevo OR editar)
  then ActualizaPuntos;
end;

procedure TFMain.EdPosGEExit(Sender: TObject);
begin
  if (nuevo OR editar)
  then ActualizaPuntos;
end;

procedure TFMain.Participantes1Click(Sender: TObject);
begin
  FPart:=TFPart.Create(self);
  FPart.ShowModal;
  FPart.Free;
end;

procedure TFMain.iposdePrueba1Click(Sender: TObject);
begin
  FPruebas:=TFPruebas.Create(self);
  FPruebas.ShowModal;
  FPruebas.Free;
end;

procedure TFMain.Clasificaciones1Click(Sender: TObject);
begin
  FClasificaciones:=TFClasificaciones.Create(self);
  FClasificaciones.ShowModal;
  FClasificaciones.Free;
end;

procedure TFMain.Acercade1Click(Sender: TObject);
begin
  FAcerca:=TFAcerca.Create(self);
  FAcerca.ShowModal;
  FAcerca.Free;
end;

procedure TFMain.Informesindividuales1Click(Sender: TObject);
begin
  FInfInd:=TFInfInd.Create(self);
  FInfInd.ShowModal;
  FInfInd.Free;
end;

procedure TFMain.Image1DblClick(Sender: TObject);
begin
  Image1.Picture:=nil;
end;

end.
