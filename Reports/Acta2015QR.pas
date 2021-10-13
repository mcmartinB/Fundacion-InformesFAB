unit Acta2015QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRActa2015 = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
    qrbndPortada: TQRBand;
    qrbndSummaryBand1: TQRBand;
    qrdbtxtNombre: TQRDBText;
    qrdbtxtCMN: TQRDBText;
    qrdbtxtEA: TQRDBText;
    qrdbtxtCLL: TQRDBText;
    qrdbtxtEF: TQRDBText;
    qrdbtxtIN: TQRDBText;
    qrdbtxtVLL: TQRDBText;
    qrdbtxtREL: TQRDBText;
    qrdbtxtM: TQRDBText;
    qrlbl3: TQRLabel;
    qrlbl4: TQRLabel;
    qrlbl5: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl10: TQRLabel;
    qrlbl11: TQRLabel;
    qrlbl12: TQRLabel;
    qrlbl13: TQRLabel;
    qrlbl14: TQRLabel;
    qrlbl15: TQRLabel;
    qrlbl16: TQRLabel;
    qrlbl17: TQRLabel;
    qrlbl18: TQRLabel;
    qrlbl19: TQRLabel;
    qrlbl21: TQRLabel;
    qrlbl22: TQRLabel;
    qrlbl23: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl25: TQRLabel;
    qrlbl27: TQRLabel;
    qrlbl28: TQRLabel;
    qrlbl29: TQRLabel;
    qrlbl30: TQRLabel;
    qrlbl31: TQRLabel;
    qrlbl32: TQRLabel;
    qrimgLogoGeneralitat: TQRImage;
    qrlbl1: TQRLabel;
    qrlblTitulo1: TQRLabel;
    qrlbl34: TQRLabel;
    qrlbl35: TQRLabel;
    qrlbl36: TQRLabel;
    qrlbl37: TQRLabel;
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
    qrshp1: TQRShape;
    qrlbl52: TQRLabel;
    qrlbl53: TQRLabel;
    qrlbl54: TQRLabel;
    qrlbl55: TQRLabel;
    qrlbl56: TQRLabel;
    qrlbl57: TQRLabel;
    qrlbl58: TQRLabel;
    qrlbl59: TQRLabel;
    qrlbl60: TQRLabel;
    qrimg1: TQRImage;
    qrimg2: TQRImage;
    qrshp2: TQRShape;
    qrlblClase: TQRLabel;
    qrlblAny: TQRLabel;
    qrlblFecha: TQRLabel;
    qrlbl64: TQRLabel;
    qrlbl65: TQRLabel;
    qrlbl66: TQRLabel;
    qrsysdt1: TQRSysData;
    qrshp3: TQRShape;
    qrlbl61: TQRLabel;
    qrshp4: TQRShape;
    qrshp6: TQRShape;
    qrshp7: TQRShape;
    qrshp8: TQRShape;
    qrshp10: TQRShape;
    qrshp11: TQRShape;
    qrshp12: TQRShape;
    qrshp13: TQRShape;
    qrshp14: TQRShape;
    qrshp15: TQRShape;
    qrshp16: TQRShape;
    qrshp17: TQRShape;
    qrshp18: TQRShape;
    qrshp19: TQRShape;
    qrshp20: TQRShape;
    qrshp21: TQRShape;
    qrshp22: TQRShape;
    qrshp5: TQRShape;
    qrshp23: TQRShape;
    qrshp24: TQRShape;
    qrshp25: TQRShape;
    qrshp26: TQRShape;
    qrshp27: TQRShape;
    qrshp29: TQRShape;
    qrshp30: TQRShape;
    qrshp31: TQRShape;
    qrshp32: TQRShape;
    qrshp33: TQRShape;
    qrshp34: TQRShape;
    qrshp35: TQRShape;
    qrshp36: TQRShape;
    qrshp37: TQRShape;
    qrshp38: TQRShape;
    qrshpDP2: TQRShape;
    qrshp40: TQRShape;
    qrshp41: TQRShape;
    qrlbl67: TQRLabel;
    qrlbl68: TQRLabel;
    qrlbl69: TQRLabel;
    qrshp42: TQRShape;
    qrshp43: TQRShape;
    bndcChildBand1: TQRChildBand;
    bndcChildBand2: TQRChildBand;
    qrshp44: TQRShape;
    qrshp45: TQRShape;
    qrlbl110: TQRLabel;
    qrshp50: TQRShape;
    qrlbl111: TQRLabel;
    qrshp51: TQRShape;
    qrlbl112: TQRLabel;
    qrshp52: TQRShape;
    qrlblDP: TQRLabel;
    qrdbtxtVLL1: TQRDBText;
    qrlbl20: TQRLabel;
    qrlbl26: TQRLabel;
    qrshp57: TQRShape;
    qrshp58: TQRShape;
    qrshp59: TQRShape;
    qrshp60: TQRShape;
    qrshpDP: TQRShape;
    qrshpDP1: TQRShape;
    qrchldbndChildBand1: TQRChildBand;
    qrlbl101: TQRLabel;
    qrlbl102: TQRLabel;
    qrlbl103: TQRLabel;
    qrlbl104: TQRLabel;
    qrlbl105: TQRLabel;
    qrlbl106: TQRLabel;
    qrlbl107: TQRLabel;
    qrlbl108: TQRLabel;
    qrlbl109: TQRLabel;
    qrlbl100: TQRLabel;
    qrshp49: TQRShape;
    qrshp46: TQRShape;
    qrshp47: TQRShape;
    qrlbl2: TQRLabel;
    qrlblTitulo2: TQRLabel;
    qrlbl83: TQRLabel;
    qrlbl71: TQRLabel;
    qrlbl72: TQRLabel;
    qrlbl73: TQRLabel;
    qrlbl74: TQRLabel;
    qrlbl75: TQRLabel;
    qrlbl76: TQRLabel;
    qrlbl77: TQRLabel;
    qrlbl78: TQRLabel;
    qrlbl79: TQRLabel;
    qrlbl86: TQRLabel;
    qrlbl87: TQRLabel;
    QRLabel1: TQRLabel;
    qrlbl80: TQRLabel;
    qrlbl81: TQRLabel;
    qrlbl82: TQRLabel;
    qrshp48: TQRShape;
    qrlbl90: TQRLabel;
    qrlbl91: TQRLabel;
    qrlbl92: TQRLabel;
    qrlbl93: TQRLabel;
    qrlbl94: TQRLabel;
    qrlbl95: TQRLabel;
    qrlbl97: TQRLabel;
    qrlbl98: TQRLabel;
    qrlbl99: TQRLabel;
    qrlbl62: TQRLabel;
    qrlbl63: TQRLabel;
    qrlbl84: TQRLabel;
    qrlbl85: TQRLabel;
    qrlbl88: TQRLabel;
    qrlbl89: TQRLabel;
    qrlbl113: TQRLabel;
    qrlbl114: TQRLabel;
    qrlbl115: TQRLabel;
    qrlbl116: TQRLabel;
    qrlbl117: TQRLabel;
    qrlbl118: TQRLabel;
    qrlbl119: TQRLabel;
    qrlbl120: TQRLabel;
    qrlbl121: TQRLabel;
    qrlbl122: TQRLabel;
    qrshp9: TQRShape;
    qrlbl123: TQRLabel;
    qrdbtxtDP: TQRDBText;
    qrshpEstadisticas5: TQRShape;
    qrlblEstadisticas2: TQRLabel;
    qrlblEstadisticas3: TQRLabel;
    qrlblEstadisticas4: TQRLabel;
    qrlblEstadisticas9: TQRLabel;
    qrshpEstadisticas1: TQRShape;
    qrshpEstadisticas4: TQRShape;
    qrlblEstadisticas5: TQRLabel;
    qrlblEstadisticas6: TQRLabel;
    qrlblEstadisticas10: TQRLabel;
    qrlblEstadisticas11: TQRLabel;
    qrlblEstadisticas8: TQRLabel;
    qrlblEstadisticas7: TQRLabel;
    qrshpEstadisticas3: TQRShape;
    qrshpEstadisticas2: TQRShape;
    qrlblEstadisticas1: TQRLabel;
    qrlblNumAlu1: TQRLabel;
    qrlblNumAlu2: TQRLabel;
    procedure PrintClase(sender: TObject; var Value: String);
    procedure PrintAnyo(sender: TObject; var Value: String);
    procedure PrintFecha(sender: TObject; var Value: String);
    procedure PrintDirector(sender: TObject; var Value: String);
    procedure PrintTitulo(sender: TObject; var Value: String);
    procedure PrintTutor(sender: TObject; var Value: String);
    procedure PrintLocalidad(sender: TObject; var Value: String);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private

  public
    iTrimestre, iALumnos, iPromocionan: Integer;
    sClase, sAnyo, sDirector, sTutor: string;
    dFecha: TDateTime;
  end;

implementation

{$R *.DFM}

uses
   UDMActas;

procedure TQRActa2015.PrintTitulo(sender: TObject; var Value: String);
begin
 //
end;

procedure TQRActa2015.PrintLocalidad(sender: TObject; var Value: String);
begin
  Value:= 'El Campello, ' + FormatDateTime('dd" de "mmmm" de "yyyy', dFecha )+ '.';
end;

procedure TQRActa2015.PrintClase(sender: TObject; var Value: String);
begin
  Value:= sClase;
end;

procedure TQRActa2015.PrintAnyo(sender: TObject; var Value: String);
begin
  Value:= sAnyo;
end;

procedure TQRActa2015.PrintFecha(sender: TObject; var Value: String);
begin
  Value:= FormatDateTime('dd/mm/yyyy', dFecha );
end;

procedure TQRActa2015.PrintDirector(sender: TObject; var Value: String);
begin
  Value:= sDirector;
end;

procedure TQRActa2015.PrintTutor(sender: TObject; var Value: String);
begin
  Value:= sTutor;
end;


procedure TQRActa2015.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  qrlblDP.Enabled:= ( iTrimestre = 0 );
  qrshpDP.Enabled:= ( iTrimestre = 0 );
  qrshpDP1.Enabled:= ( iTrimestre = 0 );
  qrshpDP2.Enabled:= ( iTrimestre = 0 );
  qrdbtxtDP.Enabled:= ( iTrimestre = 0 );

  qrlblEstadisticas1.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas2.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas3.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas4.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas5.Enabled:= ( iTrimestre = 0 ); 
  qrlblEstadisticas6.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas7.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas8.Enabled:= ( iTrimestre = 0 );
  //qrlblEstadisticas9.Enabled:= ( iTrimestre = 0 ); //Numero de alumnos
  qrlblEstadisticas10.Enabled:= ( iTrimestre = 0 );
  qrlblEstadisticas11.Enabled:= ( iTrimestre = 0 );
  qrshpEstadisticas1.Enabled:= ( iTrimestre = 0 );
  qrshpEstadisticas2.Enabled:= ( iTrimestre = 0 );
  qrshpEstadisticas3.Enabled:= ( iTrimestre = 0 );
  qrshpEstadisticas4.Enabled:= ( iTrimestre = 0 );
  //qrshpEstadisticas5.Enabled:= ( iTrimestre = 0 ); //Linea separadora

  qrlblNumAlu1.Top:= qrlblEstadisticas3.Top;
  qrlblNumAlu2.Top:= qrlblEstadisticas3.Top;
  qrlblNumAlu1.Enabled:= ( iTrimestre <> 0 );
  qrlblNumAlu2.Enabled:= ( iTrimestre <> 0 );

  qrlblEstadisticas9.Caption:= IntToStr( iALumnos );
  if iTrimestre <> 0 then
  begin
    qrlblEstadisticas9.Top:= qrlblEstadisticas3.Top;
    qrlblEstadisticas9.Alignment:= taLeftJustify;
  end
  else
  begin
    qrlblEstadisticas9.Top:= qrlblEstadisticas10.Top;
    qrlblEstadisticas9.Alignment:= taCenter;
    qrlblEstadisticas10.Caption:= IntToStr( iPromocionan );
    qrlblEstadisticas11.Caption:= IntToStr ( iALumnos - iPromocionan );
  end;

  qrbndSummaryBand1.Height:= 130;
  bndcChildBand2.Height:= 30;
end;

end.
