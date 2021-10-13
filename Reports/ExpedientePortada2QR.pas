unit ExpedientePortada2QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TQRExpedientePortada2 = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrshp2: TQRShape;
    qrlbl9: TQRLabel;
    qrlbl8: TQRLabel;
    qrdbtxtapellido1_ad4: TQRDBText;
    qrshp1: TQRShape;
    qrdbtxtapellido1_ad3: TQRDBText;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrshpPrimerApellido: TQRShape;
    qrlbl10: TQRLabel;
    qrlblPrimerApellido: TQRLabel;
    qrdbtxtPrimerApellido: TQRDBText;
    qrshp3: TQRShape;
    qrlbl11: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrshp18: TQRShape;
    qrlbl5: TQRLabel;
    qrlbl38: TQRLabel;
    qrshp19: TQRShape;
    qrlbl39: TQRLabel;
    qrlbl40: TQRLabel;
    qrlbl41: TQRLabel;
    qrlbl42: TQRLabel;
    qrlbl43: TQRLabel;
    qrlbl44: TQRLabel;
    qrshp26: TQRShape;
    qrlbl45: TQRLabel;
    qrlbl46: TQRLabel;
    qrlbl47: TQRLabel;
    qrlbl48: TQRLabel;
    qrlbl50: TQRLabel;
    qrshp59: TQRShape;
    qrshp61: TQRShape;
    qrbndPageHeaderBand1: TQRBand;
    imgLogoGeneralitat: TQRImage;
    imgEscudo: TQRImage;
    qrlbl3: TQRLabel;
    qrlbl52: TQRLabel;
    qrshp32: TQRShape;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrshp51: TQRShape;
    qrlbl4: TQRLabel;
    qrlbl33: TQRLabel;
    qrshp52: TQRShape;
    qrshp4: TQRShape;
    qrlbl12: TQRLabel;
    qrshp5: TQRShape;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrlbl15: TQRLabel;
    qrshp8: TQRShape;
    qrshp9: TQRShape;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrshp10: TQRShape;
    qrlbl27: TQRLabel;
    qrshp11: TQRShape;
    qrlbl54: TQRLabel;
    qrlbl55: TQRLabel;
    qrlbl64: TQRLabel;
    qrlblQRLFechaCentro: TQRLabel;
    qrlbl62: TQRLabel;
    qrlbl63: TQRLabel;
    qrlbl58: TQRLabel;
    qrlblFirmaDirectorCentro: TQRLabel;
    qrlbl59: TQRLabel;
    qrlblFirmaSecretarioCentro: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    qrshp12: TQRShape;
    qrshp13: TQRShape;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrlbl37: TQRLabel;
    qrlbl49: TQRLabel;
    qrlbl51: TQRLabel;
    qrlbl53: TQRLabel;
    qrlblFechaAllumno: TQRLabel;
    qrlbl57: TQRLabel;
    qrlbl65: TQRLabel;
    qrlbl66: TQRLabel;
    qrlbl67: TQRLabel;
    qrlblFirmaSecretarioAlumno: TQRLabel;
    qrlblFirmaDirectorAlumno: TQRLabel;
    qrlbl70: TQRLabel;
    qrlbl71: TQRLabel;
    qrlblFirmaAlumno: TQRLabel;
    qrshp14: TQRShape;
    qrlbl73: TQRLabel;
    qrlbl74: TQRLabel;
    qrlbl75: TQRLabel;
    qrlbl76: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    procedure qrdbtxtlibro_escolaridad_adPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxt2Print(sender: TObject; var Value: String);
    procedure qrdbtxt5Print(sender: TObject; var Value: String);
    procedure qrdbtxt3Print(sender: TObject; var Value: String);
    procedure qrdbtxt4Print(sender: TObject; var Value: String);
    procedure qrbndDetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sFechaInicio, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro, sDirector, sSecretario : string;
  public
    procedure LoadData( const AFechaInicio, ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro, ADirector, ASecretario: string );
  end;

var
  QRExpedientePortada2: TQRExpedientePortada2;

implementation

{$R *.DFM}

uses
   ExpedienteDM;

procedure TQRExpedientePortada2.LoadData( const AFechaInicio, ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro, ADirector, ASecretario: string );
begin
  sFechaInicio:= AFechaInicio;
  sCodCentro:= ACodCentro;
  sNomCentro:= ANomCentro;
  sPoblacionCentro:= APoblacionCentro;
  sProvinciaCentro:= AProvinciaCentro;

  sDirector:= ADirector;
  sSecretario:= ASecretario;
end;

procedure TQRExpedientePortada2.qrdbtxtlibro_escolaridad_adPrint(
  sender: TObject; var Value: String);
begin
  Value:= sFechaInicio;
end;

procedure TQRExpedientePortada2.qrdbtxt2Print(sender: TObject;
  var Value: String);
begin
  Value:= sCodCentro;
end;

procedure TQRExpedientePortada2.qrdbtxt5Print(sender: TObject;
  var Value: String);
begin
  Value:= sNomCentro;
end;

procedure TQRExpedientePortada2.qrdbtxt3Print(sender: TObject;
  var Value: String);
begin
  Value:= sPoblacionCentro;
end;

procedure TQRExpedientePortada2.qrdbtxt4Print(sender: TObject;
  var Value: String);
begin
  Value:= sProvinciaCentro;
end;

procedure TQRExpedientePortada2.qrbndDetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  qrlblFechaAllumno.Caption:= '__________________ , _____ de ______________ de 20__ ';
  qrlblFirmaDirectorAlumno.Caption:= '';
  qrlblFirmaSecretarioAlumno.Caption:= '';
  qrlblFirmaAlumno.Caption:= '';

  qrlblQRLFechaCentro.Caption:= '__________________ , _____ de ______________ de 20__ ';
  qrlblFirmaDirectorCentro.Caption:= '';
  qrlblFirmaSecretarioCentro.Caption:= '';
(*
  if bEntregaAlumno then
  begin
    qrlblFechaAllumno.Caption:= sFechaEntrega;
    qrlblFirmaDirectorAlumno.Caption:= sDirector;
    qrlblFirmaSecretarioAlumno.Caption:= sSecretario;
    qrlblFirmaAlumno.Caption:= Trim( DataSet.FieldByName('nombre_Ad').AsString ) + ' ' +
      Trim( DataSet.FieldByName('apellido1_ad').AsString ) + ' ' + Trim( DataSet.FieldByName('apellido2_ad').AsString );

    qrlblQRLFechaCentro.Caption:= '__________________ , _____ de ______________ de 20__ ';
    qrlblFirmaDirectorCentro.Caption:= '';
    qrlblFirmaSecretarioCentro.Caption:= '';

  end
  else
  begin
    qrlblFechaAllumno.Caption:= '__________________ , _____ de ______________ de 20__ ';
    qrlblFirmaDirectorAlumno.Caption:= '';
    qrlblFirmaSecretarioAlumno.Caption:= '';
    qrlblFirmaAlumno.Caption:= '';


    qrlblQRLFechaCentro.Caption:= sFechaEntrega;
    qrlblFirmaDirectorCentro.Caption:= sDirector;
    qrlblFirmaSecretarioCentro.Caption:= sDirector;
  end;
*)
end;

end.
