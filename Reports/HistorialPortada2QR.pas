unit HistorialPortada2QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TQRHistorialPortada2 = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrdbtxtlibro_escolaridad_ad: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrshp2: TQRShape;
    qrdbtxtapellido1_ad4: TQRDBText;
    qrshp1: TQRShape;
    qrdbtxtapellido1_ad3: TQRDBText;
    qrshpPrimerApellido: TQRShape;
    qrdbtxtPrimerApellido: TQRDBText;
    qrshp3: TQRShape;
    qrlbl11: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrshpDatosPersonales: TQRShape;
    qrlblDatosPersonales2: TQRLabel;
    qrlblDatosPersonales: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrdbtxt2: TQRDBText;
    qrshp4: TQRShape;
    qrlbl14: TQRLabel;
    qrdbtxt3: TQRDBText;
    qrshp5: TQRShape;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrdbtxt4: TQRDBText;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrdbtxt5: TQRDBText;
    qrshp8: TQRShape;
    qrshp9: TQRShape;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrshp10: TQRShape;
    qrlbl27: TQRLabel;
    qrshp11: TQRShape;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrshp12: TQRShape;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrshp13: TQRShape;
    qrshp18: TQRShape;
    qrlbl5: TQRLabel;
    qrlbl38: TQRLabel;
    qrshp19: TQRShape;
    qrlbl39: TQRLabel;
    qrshp20: TQRShape;
    qrlbl40: TQRLabel;
    qrlbl41: TQRLabel;
    qrlbl42: TQRLabel;
    qrshp21: TQRShape;
    qrlbl43: TQRLabel;
    qrlbl44: TQRLabel;
    qrshp22: TQRShape;
    qrshp23: TQRShape;
    qrshp24: TQRShape;
    qrshp25: TQRShape;
    qrshp26: TQRShape;
    qrlbl45: TQRLabel;
    qrlbl46: TQRLabel;
    qrlbl47: TQRLabel;
    qrlbl48: TQRLabel;
    qrlbl49: TQRLabel;
    qrshp27: TQRShape;
    qrshp28: TQRShape;
    qrshp29: TQRShape;
    qrshp30: TQRShape;
    qrlbl50: TQRLabel;
    qrlbl51: TQRLabel;
    qrlbl52: TQRLabel;
    qrlbl53: TQRLabel;
    qrlbl54: TQRLabel;
    qrshp57: TQRShape;
    qrshp58: TQRShape;
    qrshp59: TQRShape;
    qrshp60: TQRShape;
    qrshp61: TQRShape;
    qrshp62: TQRShape;
    qrbndPageHeaderBand1: TQRBand;
    imgLogoGeneralitat: TQRImage;
    imgEscudo: TQRImage;
    qrbndPageFooterBand1: TQRBand;
    qrlbl24: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    qrdbtxtdes_curso: TQRDBText;
    qrdbtxtcod_centro: TQRDBText;
    qrdbtxtdes_centro: TQRDBText;
    qrshp17: TQRShape;
    qrdbtxtetapa: TQRDBText;
    qrshp16: TQRShape;
    qrshp15: TQRShape;
    qrshp14: TQRShape;
    qrbndPieSubdetalle: TQRBand;
    qrshp51: TQRShape;
    qrlbl4: TQRLabel;
    qrlbl33: TQRLabel;
    qrshp52: TQRShape;
    qrlblPrimerApellido: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    procedure qrlbl24Print(sender: TObject; var Value: String);
    procedure qrdbtxtlibro_escolaridad_adPrint(sender: TObject;
      var Value: String);
    procedure qrdbtxt2Print(sender: TObject; var Value: String);
    procedure qrdbtxt5Print(sender: TObject; var Value: String);
    procedure qrdbtxt3Print(sender: TObject; var Value: String);
    procedure qrdbtxt4Print(sender: TObject; var Value: String);
    procedure qrdbtxtdes_cursoPrint(sender: TObject; var Value: String);
    procedure qrdbtxtcod_centroPrint(sender: TObject; var Value: String);
    procedure qrdbtxtdes_centroPrint(sender: TObject; var Value: String);
    procedure qrdbtxtetapaPrint(sender: TObject; var Value: String);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    sFechaInicio, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro: string;
  public
    procedure LoadData( const AFechaInicio, ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string );
  end;

var
  QRHistorialPortada2: TQRHistorialPortada2;

implementation

{$R *.DFM}

uses
   ExpedienteDM, UCodigoComun;

procedure TQRHistorialPortada2.LoadData( const AFechaInicio, ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string );
begin
  sFechaInicio:= AFechaInicio;
  sCodCentro:= ACodCentro;
  sNomCentro:= ANomCentro;
  sPoblacionCentro:= APoblacionCentro;
  sProvinciaCentro:= AProvinciaCentro;
end;

procedure TQRHistorialPortada2.qrlbl24Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
  //Value:= IntToStr( UCodigoComun.iNumPages[ UCodigoComun.iNumPage] );
  //UCodigoComun.iNumPage:= UCodigoComun.iNumPage+ 1;
end;

procedure TQRHistorialPortada2.qrdbtxtlibro_escolaridad_adPrint(
  sender: TObject; var Value: String);
begin
  Value:= sFechaInicio;
end;

procedure TQRHistorialPortada2.qrdbtxt2Print(sender: TObject;
  var Value: String);
begin
  Value:= sCodCentro;
end;

procedure TQRHistorialPortada2.qrdbtxt5Print(sender: TObject;
  var Value: String);
begin
  Value:= sNomCentro;
end;

procedure TQRHistorialPortada2.qrdbtxt3Print(sender: TObject;
  var Value: String);
begin
  Value:= sPoblacionCentro;
end;

procedure TQRHistorialPortada2.qrdbtxt4Print(sender: TObject;
  var Value: String);
begin
  Value:= sProvinciaCentro;
end;

procedure TQRHistorialPortada2.qrdbtxtdes_cursoPrint(sender: TObject;
  var Value: String);
begin
  if QRSubDetail1.DataSet.FieldByName('imprimir').AsString = 'N' then
    Value:= '';
end;

procedure TQRHistorialPortada2.qrdbtxtcod_centroPrint(sender: TObject;
  var Value: String);
begin
  if QRSubDetail1.DataSet.FieldByName('imprimir').AsString = 'N' then
    Value:= '';
end;

procedure TQRHistorialPortada2.qrdbtxtdes_centroPrint(sender: TObject;
  var Value: String);
begin
  if QRSubDetail1.DataSet.FieldByName('imprimir').AsString = 'N' then
    Value:= '';
end;

procedure TQRHistorialPortada2.qrdbtxtetapaPrint(sender: TObject;
  var Value: String);
begin
  if QRSubDetail1.DataSet.FieldByName('imprimir').AsString = 'N' then
    Value:= '';
end;

procedure TQRHistorialPortada2.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand:= ( QRSubDetail1.DataSet.FieldByName('primaria').AsInteger = 1 );
  if PrintBand then
  begin
    if ( QRSubDetail1.DataSet.FieldByName('imprimir').AsString = 'N' ) and
       ( QRSubDetail1.DataSet.FieldByName('cod_clase').AsString = '99' )then
    begin
      qrdbtxtdes_curso.Enabled:= False;
      qrdbtxtcod_centro.Enabled:= False;
      qrdbtxtdes_centro.Enabled:= False;
      qrdbtxtetapa.Enabled:= False;
    end
    else
    begin
      qrdbtxtdes_curso.Enabled:= True;
      qrdbtxtcod_centro.Enabled:= True;
      qrdbtxtdes_centro.Enabled:= True;
      qrdbtxtetapa.Enabled:= True;
    end;
  end;
end;

end.
