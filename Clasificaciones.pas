unit Clasificaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ComCtrls, Buttons, DateUtils, Grids,
  DBGrids, DB, Mxstore, MXDB, MXPIVSRC, MXGRID, DecisionCubeBugWorkaround,
  DBTables, MXTABLES, RpDefine, RpCon, RpConDS, RpConBDE, RpBase, RpSystem,
  RpRave;

type
  TFClasificaciones = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    CBPruebas: TComboBox;
    DTPDesde: TDateTimePicker;
    DTPHasta: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    RGGenero: TRadioGroup;
    BBtnSemana: TBitBtn;
    BBtnMes: TBitBtn;
    BBtnAno: TBitBtn;
    Bevel1: TBevel;
    Image1: TImage;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn2: TBitBtn;
    BBtnImprime: TBitBtn;
    PgProgreso: TProgressBar;
    DSClas: TDataSource;
    DBGrid1: TDBGrid;
    RGOrden: TRadioGroup;
    RvDataSetConnection1: TRvDataSetConnection;
    RvProject1: TRvProject;
    procedure BBtnSemanaClick(Sender: TObject);
    procedure BBtnMesClick(Sender: TObject);
    procedure BBtnAnoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBtnImprimeClick(Sender: TObject);
    procedure Image1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FClasificaciones: TFClasificaciones;

implementation

uses DataModule1;

{$R *.dfm}

procedure TFClasificaciones.BBtnSemanaClick(Sender: TObject);
begin
  DTPDesde.Date:=StartOfTheWeek(Date);
  DTPHasta.Date:=EndOfTheWeek(Date);
end;

procedure TFClasificaciones.BBtnMesClick(Sender: TObject);
begin
  DTPDesde.Date:=StartOfTheMonth(Date);
  DTPHasta.Date:=EndOfTheMonth(Date);
end;

procedure TFClasificaciones.BBtnAnoClick(Sender: TObject);
begin
  DTPDesde.Date:=StartOfTheYear(Date);
  DTPHasta.Date:=EndOfTheYear(Date);
end;

procedure TFClasificaciones.FormShow(Sender: TObject);
var
  cadena : String;

begin
  //Vacío la tabla de consultas
  DM1.TClas1.Open;
   while (NOT DM1.TClas1.EOF) do
    DM1.TClas1.Delete;
  DM1.TClas1.Close;

  //Vacío el combo
  CBPruebas.Clear;

  //Lo vuelvo a cargar
  CBPruebas.AddItem ('TODOS',CBPruebas);
  DM1.TPrue.Open;
  While (NOT DM1.TPrue.EOF) do
  begin
     cadena:=DM1.TPrue.FieldByName('TipoPrueba').AsString;
     CBPruebas.AddItem (cadena, CBPruebas);
     DM1.TPrue.Next;
  end;
  DM1.TPrue.Close;

  //Dejo seleccionado por defecto el primer elemento TODOS
  CBPruebas.ItemIndex:=0;

  //Fijo las fechas
  DTPDesde.Date:=StartOfTheYear(Date);
  DTPHasta.Date:=Date;

  //Seleciono el género
  RGGenero.ItemIndex:=2;
end;

procedure TFClasificaciones.BitBtn2Click(Sender: TObject);
var
  escribe : Boolean;
  Nombre, Apellidos, genero : String;
  Codigo, NPruebas : LongInt;
  PPAux, PGEAux, PGAux, PTAux : LongInt;
  fecha : TDate;

begin
   //Borro la última consulta
   DM1.TClas1.Open;
   while (NOT DM1.TClas1.EOF) do
    DM1.TClas1.Delete;

   //Preparo los datos de la barra de progreso.
   PGProgreso.Position:=0;
   PGProgreso.Min:=0;
   DM1.TPart.Open;
   PGProgreso.Max:=DM1.TPart.RecordCount;

   //Para cada miembro del club recorro la tabla de registros
   DM1.TPart.First;
   While (Not DM1.TPart.EOF) do
   begin
       NPruebas:=0;
       Codigo:=DM1.TPart.FieldByName ('Atleta').AsInteger;
       Nombre:=DM1.TPart.FieldByName ('Nombre').AsString;
       Apellidos:=DM1.TPart.FieldByName ('Apellidos').AsString;
       //Recorro la tabla de registros para pasar a Clas1 los que cumplan las condiciiones
       DM1.TReg2.Open;
       while (Not DM1.TReg2.EOF) do
       begin
          escribe:=false;
          //Compruebo si es un registro del usuario seleccionado
          if (Codigo=DM1.TReg2.FieldByName('Atleta').AsInteger)
          then escribe:=true
          else escribe:=false;

          //Compruebo si el registro es del tipo de prueba seleccionada.
          if ( escribe AND (CBPruebas.Text='TODOS') )
          then escribe:=true
          else begin
                  //Compruebo si la carrera es del tipo seleccionada
                  if ( escribe AND (CBPruebas.Text=DM1.TReg2.FieldByName('TipoPrueba').AsString) )
                  then escribe:=true
                  else escribe:=false;
               end;

          //Compruebo el sexo para el listado
          if (escribe)
          then begin
                  //Obtengo el género del atleta.
                  DM1.TPart2.Open;
                  DM1.TPart2.Locate ('Atleta',DM1.TReg2.FieldByName('Atleta').AsInteger,[]);
                  genero:=DM1.TPart2.FieldByName('Sexo').AsString;
                  DM1.TPart2.Close;
                  case RGGenero.ItemIndex of
                  0: begin//Masculino
                        if genero='M'
                        then escribe:=true
                        else escribe:=false;
                     end;
                  1: begin//Femenino
                        if genero='F'
                        then escribe:=true
                        else escribe:=false;
                     end;
                  2: begin//ambos
                        escribe:=true;
                     end;
                  end; // del case of
               end;

          //Por último comprobamos que el registro se haya producido dentro de las fechas seleccionadas.
          if (escribe)
          then begin
                  fecha:=DM1.TReg2.FieldByName('Fecha').AsDateTime;
                  if ( (fecha>=DTPdesde.Date-1) AND (fecha<=DTPHasta.Date) )
                  then escribe:=true
                  else escribe:=false;
               end;

          //Grabo los datos
          if escribe
          then begin
                  NPruebas:=NPruebas+1;
                  if DM1.TClas1.Locate('Atleta',Codigo,[])
                  then begin
                          PPAux:=DM1.TClas1.FieldByName('PP').AsInteger;
                          PGEAux:=DM1.TClas1.FieldByName('PGE').AsInteger;
                          PGAux:=DM1.TClas1.FieldByName('PG').AsInteger;
                          PTAux:=DM1.TClas1.FieldByName('PT').AsInteger;
                          DM1.TClas1.Edit;
                       end
                  else begin
                          PPAux:=0;
                          PGEAux:=0;
                          PGAux:=0;
                          PTAux:=0;
                          DM1.TClas1.Append;
                       end;
                  PTAux:=PTAux+DM1.TReg2.FieldByName('Puntos').AsInteger;
                  DM1.TClas1.FieldByName('Atleta').AsInteger:=Codigo;
                  DM1.TClas1.FieldByName('Nombre').AsString:=Nombre;
                  DM1.TClas1.FieldByName('Apellidos').AsString:=Apellidos;
                  DM1.TClas1.FieldByName('Pruebas').AsInteger:=NPruebas;
                  DM1.TClas1.FieldByName('AVGPT').AsFloat:=PTAux/NPruebas;
                  DM1.TClas1.FieldByName('PP').AsInteger:=PPAux+DM1.TReg2.FieldByName('PP').AsInteger;
                  DM1.TClas1.FieldByName('PGE').AsInteger:=PGEAux+DM1.TReg2.FieldByName('PRGE').AsInteger;
                  DM1.TClas1.FieldByName('PG').AsInteger:=PGAux+DM1.TReg2.FieldByName('PRG').AsInteger;
                  DM1.TClas1.FieldByName('PT').AsInteger:=PTAux;
                  DM1.TClas1.Post;
               end;
          DM1.TReg2.Next;
       end;
       DM1.TPart.Next;
       PGProgreso.Position:=PGProgreso.Position+1;
       DM1.TReg2.Close;
   end;
   DM1.TPart.Close;
   DM1.TClas1.Close;


   DM1.QClas1.Close;
   case RGOrden.ItemIndex of 
    0: begin //Por PP
          DM1.QClas1.SQL.Text:='SELECT Nombre, Apellidos, PP, PGE, PG, PT, Pruebas, AVGPT  '+
                               'FROM "c:\triliga\bases\clas1.DB" Clas1 '+
                               'ORDER BY PP DESC';
       end;
    1: begin //Por PGE
          DM1.QClas1.SQL.Text:='SELECT Nombre, Apellidos, PP, PGE, PG, PT, Pruebas, AVGPT '+
                               'FROM "c:\triliga\bases\clas1.DB" Clas1 '+
                               'ORDER BY PGE DESC';
       end;
    2: begin //Por PG
          DM1.QClas1.SQL.Text:='SELECT Nombre, Apellidos, PP, PGE, PG, PT, Pruebas, AVGPT '+
                               'FROM "c:\triliga\bases\clas1.DB" Clas1 '+
                               'ORDER BY PG DESC';
       end;
    3: begin //Por PT
          DM1.QClas1.SQL.Text:='SELECT Nombre, Apellidos, PP, PGE, PG, PT, Pruebas, AVGPT '+
                               'FROM "c:\triliga\bases\clas1.DB" Clas1 '+
                               'ORDER BY PT DESC';
       end;
     end;  
   DM1.QClas1.Open;
end;

procedure TFClasificaciones.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM1.QClas1.Close;
end;

procedure TFClasificaciones.BBtnImprimeClick(Sender: TObject);
begin
  RVProject1.Execute;
end;

procedure TFClasificaciones.Image1DblClick(Sender: TObject);
begin
  Image1.Picture:=nil;
end;

end.
