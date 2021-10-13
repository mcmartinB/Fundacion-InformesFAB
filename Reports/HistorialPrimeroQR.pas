unit HistorialPrimeroQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, dxGDIPlusClasses;

type
  TQRHistorialPrimero = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrbndColumnHeaderBand1: TQRBand;
    qrbndPageHeaderBand1: TQRBand;
    qrshp2: TQRShape;
    qrdbtxtapellido1_ad4: TQRDBText;
    qrshp1: TQRShape;
    qrdbtxtapellido1_ad3: TQRDBText;
    qrshpPrimerApellido: TQRShape;
    qrdbtxtPrimerApellido: TQRDBText;
    qrshp3: TQRShape;
    qrlbl11: TQRLabel;
    qrdbtxt1: TQRDBText;
    qrshp9: TQRShape;
    qrlbl25: TQRLabel;
    qrlbl26: TQRLabel;
    qrshp10: TQRShape;
    qrlbl27: TQRLabel;
    qrshp11: TQRShape;
    qrlbl29: TQRLabel;
    qrshp12: TQRShape;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrshp14: TQRShape;
    qrshp15: TQRShape;
    qrshp16: TQRShape;
    qrshp31: TQRShape;
    qrshp32: TQRShape;
    qrshp33: TQRShape;
    qrshp35: TQRShape;
    qrshp36: TQRShape;
    qrshp37: TQRShape;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl20: TQRLabel;
    imgLogoGeneralitat: TQRImage;
    imgEscudo: TQRImage;
    qrchldbndPie: TQRChildBand;
    qrdbtxtcs: TQRDBText;
    qrdbtxtcn: TQRDBText;
    qrdbtxtlcl: TQRDBText;
    qrshp49: TQRShape;
    qrshp48: TQRShape;
    qrshp47: TQRShape;
    qrshp45: TQRShape;
    qrshp44: TQRShape;
    qrshp43: TQRShape;
    qrshp41: TQRShape;
    qrshp40: TQRShape;
    qrshp39: TQRShape;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl28: TQRLabel;
    qrshp4: TQRShape;
    qrshp5: TQRShape;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrshp8: TQRShape;
    qrshp13: TQRShape;
    qrshp17: TQRShape;
    qrshp18: TQRShape;
    qrshp19: TQRShape;
    qrlbl30: TQRLabel;
    qrlbl33: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    qrlbl37: TQRLabel;
    qrshp20: TQRShape;
    qrlbl38: TQRLabel;
    qrlbl39: TQRLabel;
    qrlbl40: TQRLabel;
    qrlbl41: TQRLabel;
    qrlbl42: TQRLabel;
    qrlbl43: TQRLabel;
    qrlbl44: TQRLabel;
    qrlbl45: TQRLabel;
    qrlbl46: TQRLabel;
    qrlbl47: TQRLabel;
    qrlbl48: TQRLabel;
    qrlbl49: TQRLabel;
    qrlbl50: TQRLabel;
    qrlbl51: TQRLabel;
    qrlbl52: TQRLabel;
    qrlbl53: TQRLabel;
    qrdbtxtea: TQRDBText;
    qrdbtxtef: TQRDBText;
    qrdbtxtin: TQRDBText;
    qrdbtxtm: TQRDBText;
    qrdbtxtvll: TQRDBText;
    qrdbtxtrel: TQRDBText;
    qrbndPageFooterBand1: TQRBand;
    qrlbl24: TQRLabel;
    qrlblFechaPromESO: TQRLabel;
    qrdbtxtlcl1: TQRDBText;
    qrdbtxtlcl2: TQRDBText;
    qrdbtxtcs1: TQRDBText;
    qrdbtxtea1: TQRDBText;
    qrdbtxtef1: TQRDBText;
    qrdbtxtin1: TQRDBText;
    qrdbtxtm1: TQRDBText;
    qrdbtxtvll1: TQRDBText;
    qrdbtxtlcl3: TQRDBText;
    qrlblPrimerApellido: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    procedure qrlbl24Print(sender: TObject; var Value: String);
    procedure qrlblFechaPromESOPrint(sender: TObject; var Value: String);
    procedure PonNotaSpain(sender: TObject; var Value: String);
    procedure PonNotaValenciano(sender: TObject; var Value: String);
  private
    sFechaPromocion, sFechaHistorial: string;

  public
    procedure LoadData( const AFechaPromocion, AFechaHistorial: string );

  end;

var
  QRHistorialPrimero: TQRHistorialPrimero;

implementation

{$R *.DFM}

uses
   ExpedienteDM, UCodigoComun;

//Value:= 'El Campello, ' + FormatDateTime('dd" de "mmmm" de "yyyy', dFecha )+ '.';

procedure TQRHistorialPrimero.qrlbl24Print(sender: TObject;
  var Value: String);
begin
  Value:= '';
  //Value:= IntToStr( UCodigoComun.iNumPages[ UCodigoComun.iNumPage] );
  //UCodigoComun.iNumPage:= UCodigoComun.iNumPage+ 1;
end;

procedure TQRHistorialPrimero.LoadData( const AFechaPromocion, AFechaHistorial: string );
begin
  sFechaPromocion:= AFechaPromocion;
end;


procedure TQRHistorialPrimero.qrlblFechaPromESOPrint(sender: TObject;
  var Value: String);
begin
  //
    Value:=  sFechaPromocion;
end;


procedure TQRHistorialPrimero.PonNotaValenciano(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByname(TQRDBText( sender ).DataField).AsFloat <> -1 then
    Value:= DataSet.FieldByname('sv'+TQRDBText( sender ).DataField).AsString +  ': '  + Value
  else
    Value:= '';
end;

procedure TQRHistorialPrimero.PonNotaSpain(sender: TObject; var Value: String);
begin
  if DataSet.FieldByname(TQRDBText( sender ).DataField).AsFloat <> -1 then
    Value:= DataSet.FieldByname('se'+TQRDBText( sender ).DataField).AsString +  ': '  + Value
  else
    Value:= '';
end;


end.
