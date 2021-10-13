unit HistorialPortada1QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TQRHistorialPortada1 = class(TQuickRep)
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
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    procedure qrdbtxtlugar_nac_ad1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtfecha_nac_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtlugar_nac_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtapellido1_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtnombre_adPrint(sender: TObject; var Value: String);
    procedure qrdbtxtapellido1_ad1Print(sender: TObject;
      var Value: String);
    procedure qrdbtxtapellido1_ad2Print(sender: TObject;
      var Value: String);
    procedure qrbndDetailBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrlbl24Print(sender: TObject; var Value: String);
  private
    sFecha, sMunicipio, sProvincia, sPais, sNacionalidad, sMadre, sPadre, sSexo: string;
  public
    procedure LoadData( const AFecha, AMunicipio, AProvincia, APais, ANacionalidad, AMadre, APadre, ASexo: string );
  end;

var
  QRHistorialPortada1: TQRHistorialPortada1;

implementation

{$R *.DFM}

uses
   ExpedienteDM, UCodigoComun;


procedure TQRHistorialPortada1.LoadData( const AFecha, AMunicipio, AProvincia, APais, ANacionalidad, AMadre, APadre, ASexo: string );
begin
  sFecha:= AFecha;
  sMunicipio:= AMunicipio;
  sProvincia:= AProvincia;
  sPais:= APais;
  sNacionalidad:= ANacionalidad;
  sMadre:= AMadre;
  sPadre:= APadre;
  sSexo:= ASexo;
end;

procedure TQRHistorialPortada1.qrdbtxtlugar_nac_ad1Print(sender: TObject;
  var Value: String);
begin
  Value:= sProvincia;
end;

procedure TQRHistorialPortada1.qrdbtxtfecha_nac_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sFecha;
end;

procedure TQRHistorialPortada1.qrdbtxtlugar_nac_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sMunicipio;
end;

procedure TQRHistorialPortada1.qrdbtxtapellido1_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sPais;
end;

procedure TQRHistorialPortada1.qrdbtxtnombre_adPrint(sender: TObject;
  var Value: String);
begin
  Value:= sNacionalidad;
end;

procedure TQRHistorialPortada1.qrdbtxtapellido1_ad1Print(sender: TObject;
  var Value: String);
begin
  Value:= sMadre;
end;

procedure TQRHistorialPortada1.qrdbtxtapellido1_ad2Print(sender: TObject;
  var Value: String);
begin
  Value:= sPadre;
end;

procedure TQRHistorialPortada1.qrbndDetailBand1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if sSexo = 'H' then
  begin
    //Hombre
    imgSI.Left:= 601;
    imgNo.Left:= 640;
  end
  else
  begin
    //Mujer
    imgNo.Left:= 601;
    imgSI.Left:= 640;
  end;
end;

procedure TQRHistorialPortada1.qrlbl24Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
  //Value:= IntToStr( UCodigoComun.iNumPages[ UCodigoComun.iNumPage] );
  //UCodigoComun.iNumPage:= UCodigoComun.iNumPage+ 1;
end;

end.
