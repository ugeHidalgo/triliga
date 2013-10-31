program triliga;

uses
  Forms,
  main in 'main.pas' {FMain},
  DataModule1 in 'DataModule1.pas' {DM1: TDataModule},
  Participantes in 'Participantes.pas' {FPart},
  Pruebas in 'Pruebas.pas' {FPruebas},
  Clasificaciones in 'Clasificaciones.pas' {FClasificaciones},
  Acerca in 'Acerca.pas' {FAcerca},
  DecisionCubeBugWorkaround in 'DecisionCubeBugWorkaround.pas',
  InformeIndividual in 'InformeIndividual.pas' {FInfInd},
  Utilidades in 'Utilidades.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TFPart, FPart);
  Application.CreateForm(TFPruebas, FPruebas);
  Application.CreateForm(TFClasificaciones, FClasificaciones);
  Application.CreateForm(TFAcerca, FAcerca);
  Application.CreateForm(TFInfInd, FInfInd);
  Application.Run;
end.
