program InformesFundacion;

{%ToDo 'InformesFundacion.todo'}

uses
  Forms,
  UMain in 'Forms\UMain.pas' {FMain},
  UDMMain in 'Data\UDMMain.pas' {DMMain: TDataModule},
  ActaConCV2015QR in 'Reports\ActaConCV2015QR.pas' {QRActaConCV2015: TQuickRep},
  ExpedienteDM in 'Data\ExpedienteDM.pas' {DMExpediente: TDataModule},
  Acta2015QR in 'Reports\Acta2015QR.pas' {QRActa2015: TQuickRep},
  HistorialPortada1QR in 'Reports\HistorialPortada1QR.pas' {QRHistorialPortada1: TQuickRep},
  HistorialPortada2QR in 'Reports\HistorialPortada2QR.pas' {QRHistorialPortada2: TQuickRep},
  UCodigoComun in 'Code\UCodigoComun.pas',
  UDMActas in 'Data\UDMActas.pas' {DMActas: TDataModule},
  HistorialPrimeroQR in 'Reports\HistorialPrimeroQR.pas' {QRHistorialPrimero: TQuickRep},
  HistorialSegundoQR in 'Reports\HistorialSegundoQR.pas' {QRHistorialSegundo: TQuickRep},
  HistorialTerceroQR in 'Reports\HistorialTerceroQR.pas' {QRHistorialTercero: TQuickRep},
  HistorialCuartoQR in 'Reports\HistorialCuartoQR.pas' {QRHistorialCuarto: TQuickRep},
  HistorialQuintoQR in 'Reports\HistorialQuintoQR.pas' {QRHistorialQuinto: TQuickRep},
  HistorialSextoQR in 'Reports\HistorialSextoQR.pas' {QRHistorialSexto: TQuickRep},
  ExpedienteF in 'Forms\ExpedienteF.pas' {FExpediente},
  ExpedientePortada1QR in 'Reports\ExpedientePortada1QR.pas' {QRExpedientePortada1: TQuickRep},
  ExpedientePortada2QR in 'Reports\ExpedientePortada2QR.pas' {QRExpedientePortada2: TQuickRep},
  ExpedientePrimeroQR in 'Reports\ExpedientePrimeroQR.pas' {QRExpedientePrimero: TQuickRep},
  ExpedienteSegundoQR in 'Reports\ExpedienteSegundoQR.pas' {QRExpedienteSegundo: TQuickRep},
  ExpedienteTerceroQR in 'Reports\ExpedienteTerceroQR.pas' {QRExpedienteTercero: TQuickRep},
  ExpedienteCuartoQR in 'Reports\ExpedienteCuartoQR.pas' {QRExpedienteCuarto: TQuickRep},
  ExpedienteQuintoQR in 'Reports\ExpedienteQuintoQR.pas' {QRExpedienteQuinto: TQuickRep},
  ExpedienteSextoQR in 'Reports\ExpedienteSextoQR.pas' {QRExpedienteSexto: TQuickRep},
  UDMResultados in 'Data\UDMResultados.pas' {DMResultados: TDataModule},
  ResultadosQR in 'Reports\ResultadosQR.pas' {QRResultados: TQuickRep},
  UFNotas in 'Forms\UFNotas.pas' {FNotas};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Informes Fundación Antonio Bonny';
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
