unit ExpedientePortada1QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TQRExpedientePortada1 = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrlbl1: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl2: TQRLabel;
    qrshpnia: TQRShape;
    qrlbl4: TQRLabel;
    qrdbtxtlibro_escolaridad_ad: TQRDBText;
    qrshpPrimerApellido: TQRShape;
    qrlblPrimerApellido: TQRLabel;
    qrdbtxtPrimerApellido: TQRDBText;
    qrshp1: TQRShape;
    qrshp2: TQRShape;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrshp3: TQRShape;
    qrlbl10: TQRLabel;
    qrdbtxtfecha_nac_ad: TQRDBText;
    qrshp4: TQRShape;
    qrshp5: TQRShape;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrshp8: TQRShape;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrshp9: TQRShape;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrdbtxtapellido1_ad: TQRDBText;
    qrdbtxtapellido1_ad1: TQRDBText;
    qrdbtxtapellido1_ad2: TQRDBText;
    qrdbtxtlugar_nac_ad: TQRDBText;
    qrdbtxtlugar_nac_ad1: TQRDBText;
    qrdbtxtnombre_ad: TQRDBText;
    qrdbtxtapellido1_ad3: TQRDBText;
    qrdbtxtapellido1_ad4: TQRDBText;
    qrshpDatosPersonales: TQRShape;
    qrlblDatosPersonales2: TQRLabel;
    qrlblDatosPersonales: TQRLabel;
    qrbndPageHeaderBand1: TQRBand;
    imgLogoGeneralitat: TQRImage;
    imgEscudo: TQRImage;
    qrshp10: TQRShape;
    qrlbl25: TQRLabel;
    imgSI: TQRImage;
    imgNo: TQRImage;
    qrlbl26: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrbndPageFooterBand1: TQRBand;
    qrlbl24: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrshp11: TQRShape;
    qrlbl3: TQRLabel;
    qrdbtxt2: TQRDBText;
    qrlbl32: TQRLabel;
    qrshp12: TQRShape;
    qrlbl33: TQRLabel;
    qrdbtxt5: TQRDBText;
    qrlbl51: TQRLabel;
    qrshp13: TQRShape;
    qrshp14: TQRShape;
    qrlbl36: TQRLabel;
    qrshp15: TQRShape;
    qrlbl38: TQRLabel;
    qrlbl39: TQRLabel;
    qrdbtxtNombre6: TQRDBText;
    qrdbtxtNombre5: TQRDBText;
    qrlbl37: TQRLabel;
    qrsbdtl1: TQRSubDetail;
    qrshp16: TQRShape;
    qrshp17: TQRShape;
    qrshp18: TQRShape;
    qrshp19: TQRShape;
    qrdbtxtcod_clase: TQRDBText;
    qrdbtxtcod_centro: TQRDBText;
    qrdbtxtdes_centro: TQRDBText;
    qrdbtxtcod_clase1: TQRDBText;
    qrshp20: TQRShape;
    qrlbl40: TQRLabel;
    qrlbl41: TQRLabel;
    qrbndPieSubdetalle: TQRBand;
    qrshp51: TQRShape;
    qrlbl42: TQRLabel;
    qrlbl43: TQRLabel;
    qrshp52: TQRShape;
    qrshp21: TQRShape;
    qrlbl44: TQRLabel;
    qrlbl45: TQRLabel;
    qrlbl46: TQRLabel;
    qrlbl47: TQRLabel;
    qrlbl48: TQRLabel;
    qrshp24: TQRShape;
    qrshp25: TQRShape;
    qrshp26: TQRShape;
    qrshp27: TQRShape;
    qrshp28: TQRShape;
    qrshp29: TQRShape;
    qrlbl49: TQRLabel;
    qrshp23: TQRShape;
    qrdbtxt4: TQRDBText;
    qrlbl50: TQRLabel;
    qrshp32: TQRShape;
    qrlbl52: TQRLabel;
    qrshp33: TQRShape;
    qrlbl53: TQRLabel;
    qrshp34: TQRShape;
    qrlbl54: TQRLabel;
    qrshp35: TQRShape;
    qrlbl55: TQRLabel;
    qrshp36: TQRShape;
    qrlbl56: TQRLabel;
    qrlbl57: TQRLabel;
    qrlbl58: TQRLabel;
    qrlbl59: TQRLabel;
    qrlbl60: TQRLabel;
    qrshp37: TQRShape;
    qrlbl61: TQRLabel;
    qrdbtxtNombre4: TQRDBText;
    qrlbl62: TQRLabel;
    qrshp38: TQRShape;
    qrdbtxtNombre3: TQRDBText;
    qrlbl63: TQRLabel;
    qrlbl64: TQRLabel;
    qrshp39: TQRShape;
    qrlbl65: TQRLabel;
    qrlbl66: TQRLabel;
    qrdbtxtNombre1: TQRDBText;
    qrshp40: TQRShape;
    qrlbl67: TQRLabel;
    qrdbtxtNombre7: TQRDBText;
    qrshp41: TQRShape;
    qrlbl68: TQRLabel;
    qrdbtxtNombre: TQRDBText;
    qrlbl69: TQRLabel;
    qrshp42: TQRShape;
    qrdbtxtNombre2: TQRDBText;
    qrlbl70: TQRLabel;
    qrlbl71: TQRLabel;
    qrlbl72: TQRLabel;
    qrlbl73: TQRLabel;
    qrshp43: TQRShape;
    qrlbl74: TQRLabel;
    qrlbl75: TQRLabel;
    qrlbl76: TQRLabel;
    qrlbl77: TQRLabel;
    qrshp44: TQRShape;
    qrshp45: TQRShape;
    qrshp46: TQRShape;
    qrshp47: TQRShape;
    qrshp48: TQRShape;
    qrshp49: TQRShape;
    qrshp50: TQRShape;
    qrlbl78: TQRLabel;
    qrlbl79: TQRLabel;
    qrlbl80: TQRLabel;
    qrlbl81: TQRLabel;
    qrlbl82: TQRLabel;
    qrlbl83: TQRLabel;
    qrlbl84: TQRLabel;
    qrlbl85: TQRLabel;
    qrlbl86: TQRLabel;
    qrlbl87: TQRLabel;
    qrlbl88: TQRLabel;
    qrlbl89: TQRLabel;
    qrlbl90: TQRLabel;
    qrshp30: TQRShape;
    qrshp31: TQRShape;
    qrshp53: TQRShape;
    qrshp54: TQRShape;
    qrshp55: TQRShape;
    qrshp56: TQRShape;
    qrshp57: TQRShape;
    qrlbl91: TQRLabel;
    qrlbl92: TQRLabel;
    qrlbl93: TQRLabel;
    qrlbl94: TQRLabel;
    qrlbl95: TQRLabel;
    qrlbl96: TQRLabel;
    qrlbl97: TQRLabel;
    qrlbl98: TQRLabel;
    qrlbl99: TQRLabel;
    qrlbl100: TQRLabel;
    qrlbl101: TQRLabel;
    qrlbl102: TQRLabel;
    qrlbl103: TQRLabel;
    qrshp58: TQRShape;
    qrshp59: TQRShape;
    qrlbl104: TQRLabel;
    qrlbl105: TQRLabel;
    qrlbl106: TQRLabel;
    qrlbl107: TQRLabel;
    qrlbl108: TQRLabel;
    qrlbl110: TQRLabel;
    qrlbl109: TQRLabel;
    qrlbl112: TQRLabel;
    qrlbl114: TQRLabel;
    qrlbl115: TQRLabel;
    qrlbl116: TQRLabel;
    qrlbl117: TQRLabel;
    qrlbl118: TQRLabel;
    qrlbl119: TQRLabel;
    qrlbl120: TQRLabel;
    qrlbl121: TQRLabel;
    qrshp60: TQRShape;
    qrlbl122: TQRLabel;
    qrshp61: TQRShape;
    qrshp62: TQRShape;
    qrshp63: TQRShape;
    qrshp64: TQRShape;
    qrshp65: TQRShape;
    qrshp66: TQRShape;
    qrdbtxtdes_centro1: TQRDBText;
    qrdbtxtdes_centro2: TQRDBText;
    qrshp68: TQRShape;
    qrlblN: TQRLabel;
    qrdbtxtNombre8: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    procedure qrdbtxtlugar_nac_ad1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtlugar_nac_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtapellido1_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtnombre_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtapellido1_ad1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtapellido1_ad2Print(sender: TObject;
      var Value: String);
    procedure qrbndDetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrdbtxt2Print(sender: TObject; var Value: String);
    procedure qrdbtxt5Print(sender: TObject; var Value: String);
    procedure qrdbtxt4Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre6Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre8Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre7Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre1Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre5Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre2Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombrePrint(sender: TObject; var Value: String);
    procedure qrdbtxtNombre3Print(sender: TObject; var Value: String);
    procedure qrdbtxtNombre4Print(sender: TObject; var Value: String);
    procedure qrdbtxtfecha_nac_adPrint(sender: TObject; var Value: String);
    procedure qrsbdtl1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure QRDBText2Print(sender: TObject; var Value: string);
  private
    SCodCentro, SDesCentro, sFEchaIni, sTelefono, sDomicilio, sLocalidad, sCodPostal, sProvincia: string;
    sFechaNac, sMunicipioNac, sProvinciaNac, sPaisNac, sNacionalidad, sMadre, sTelefonoMadre, sPadre, sTelefonoPadre, sSexo: string;

 public
    procedure LoadData( const  AFechaInicio, ACodCentro, ANomCentro, AFechaNac, AMunicipioNac, AProvinciaNac, APaisNac, ANacionalidad, ASexo,
                                     AMadre, ATelefonoMadre, APadre, ATelefonoPadre, ATelefono, ADomicilio, ALocalidad, ACodPostal, AProvincia: string );
  end;

var
  QRExpedientePortada1: TQRExpedientePortada1;

implementation

{$R *.DFM}

uses
   ExpedienteDM;

procedure TQRExpedientePortada1.LoadData( const  AFechaInicio, ACodCentro, ANomCentro, AFechaNac, AMunicipioNac, AProvinciaNac, APaisNac, ANacionalidad, ASexo,
                                     AMadre, ATelefonoMadre, APadre, ATelefonoPadre, ATelefono, ADomicilio, ALocalidad, ACodPostal, AProvincia: string );


begin
  SCodCentro:= ACodCentro;
  SDesCentro:= ANomCentro;
  sFEchaIni:= AFechaInicio;
  sFechaNac:= AFechaNac;
  sMunicipioNac:= AMunicipioNac;
  sProvinciaNac:= AProvinciaNac;
  sPaisNac:= APaisNac;
  sNacionalidad:= ANacionalidad;
  sMadre:= AMadre;
  sPadre:= APadre;
  sSexo:= ASexo;

  sTelefono:= ATelefono;
  sDomicilio:= ADomicilio;
  sLocalidad:= ALocalidad;
  sCodPostal:= ACodPostal;
  sProvincia:= AProvincia;
  sTelefonoMadre:= ATelefonoMadre;
  sTelefonoPadre:= ATelefonoPadre;
end;

procedure TQRExpedientePortada1.qrdbtxtlugar_nac_ad1Print(sender: TObject;
  var Value: String);
begin
  Value:= sProvinciaNac;
end;

procedure TQRExpedientePortada1.qrdbtxtlugar_nac_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sMunicipioNac;
end;

procedure TQRExpedientePortada1.qrdbtxtapellido1_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sPaisNac;
end;

procedure TQRExpedientePortada1.qrdbtxtnombre_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sNacionalidad;
end;

procedure TQRExpedientePortada1.qrdbtxtapellido1_ad1Print(sender: TObject;
  var Value: String);
begin
  Value:= sMadre;
end;

procedure TQRExpedientePortada1.qrdbtxtapellido1_ad2Print(sender: TObject;
  var Value: String);
begin
  Value:= sPadre;
end;

procedure TQRExpedientePortada1.qrbndDetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if sSexo = 'H' then
  begin
    //Hombre
    imgSI.Left:= 601;
    imgNo.Left:= 641;
  end
  else
  begin
    //Mujer
    imgNo.Left:= 601;
    imgSI.Left:= 641;
  end;
end;

procedure TQRExpedientePortada1.QRDBText1Print(sender: TObject;
  var Value: string);
  var
  iAnyo, iMes, iDia: Word;
begin
  decodeDate(strtodate(sFEchaIni), iAnyo, iMes, iDia);
  Value:= LongMonthNames[iMes];
end;

procedure TQRExpedientePortada1.QRDBText2Print(sender: TObject;
  var Value: string);
  var
  iAnyo, iMes, iDia: Word;
begin
  decodeDate(strtodate(sFEchaIni), iAnyo, iMes, iDia);
  Value:= IntToStr(iAnyo);
end;

procedure TQRExpedientePortada1.qrdbtxt2Print(sender: TObject;
  var Value: String);
begin
  Value:= SCodCentro;
end;

procedure TQRExpedientePortada1.qrdbtxt5Print(sender: TObject;
  var Value: String);
begin
 Value:= SDesCentro;
end;

procedure TQRExpedientePortada1.qrdbtxt4Print(sender: TObject;
  var Value: String);
  var
  iAnyo, iMes, iDia: Word;
begin
  decodeDate(strtodate(sFEchaIni), iAnyo, iMes, iDia);
  Value:= IntToStr(iDia);
end;

procedure TQRExpedientePortada1.qrdbtxtNombre6Print(sender: TObject;
  var Value: String);
begin
  Value:= sDomicilio;
end;

procedure TQRExpedientePortada1.qrdbtxtNombre8Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
end;

procedure TQRExpedientePortada1.qrdbtxtNombre7Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
end;

procedure TQRExpedientePortada1.qrdbtxtNombre1Print(sender: TObject;
  var Value: String);
begin
  Value:= sTelefono;
end;

procedure TQRExpedientePortada1.qrdbtxtNombre5Print(sender: TObject;
  var Value: String);
begin
  Value:= sLocalidad;
end;

procedure TQRExpedientePortada1.qrdbtxtNombre2Print(sender: TObject;
  var Value: String);
begin
  Value:= sCodPostal;
end;

procedure TQRExpedientePortada1.qrdbtxtNombrePrint(sender: TObject;
  var Value: String);
begin
  Value:= sProvincia;
end;

procedure TQRExpedientePortada1.qrdbtxtNombre3Print(sender: TObject;
  var Value: String);
begin
    Value:= sTelefonoMadre;
end;

procedure TQRExpedientePortada1.qrdbtxtNombre4Print(sender: TObject;
  var Value: String);
begin
  Value:= sTelefonoPadre;
end;

procedure TQRExpedientePortada1.qrdbtxtfecha_nac_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sFechaNac;
end;

procedure TQRExpedientePortada1.qrsbdtl1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if ( qrsbdtl1.DataSet.FieldByName('imprimir').AsString = 'N' ) and
     ( qrsbdtl1.DataSet.FieldByName('cod_clase').AsString = '99' )then
  begin
    qrdbtxtcod_centro.Enabled:= False;
    qrdbtxtdes_centro.Enabled:= False;
    qrdbtxtdes_centro1.Enabled:= False;
    qrdbtxtdes_centro2.Enabled:= False;
    qrdbtxtcod_clase.Enabled:= False;
    qrdbtxtcod_clase1.Enabled:= False;
  end
  else
  begin
    qrdbtxtcod_centro.Enabled:= True;
    qrdbtxtdes_centro.Enabled:= True;
    qrdbtxtdes_centro1.Enabled:= True;
    qrdbtxtdes_centro2.Enabled:= True;
    qrdbtxtcod_clase.Enabled:= True;
    qrdbtxtcod_clase1.Enabled:= True;
  end;
end;

end.
