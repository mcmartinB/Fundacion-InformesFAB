unit ExpedienteQuintoQR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQRExpedienteQuinto = class(TQuickRep)
    qrbndDetailBand1: TQRBand;
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
    qrshp22: TQRShape;
    qrshp23: TQRShape;
    qrshp24: TQRShape;
    qrlbl54: TQRLabel;
    qrlbl55: TQRLabel;
    qrdbtxtea1: TQRDBText;
    qrlblFechaPromESO: TQRLabel;
    QRLabel: TQRLabel;
    qrdbtxt4: TQRDBText;
    qrdbtxt3: TQRDBText;
    qrdbtxt2: TQRDBText;
    qrdbtxt10: TQRDBText;
    qrdbtxt9: TQRDBText;
    qrdbtxt8: TQRDBText;
    qrdbtxt7: TQRDBText;
    qrdbtxt6: TQRDBText;
    qrdbtxt5: TQRDBText;
    qrdbtxtea2: TQRDBText;
    qrlbl8: TQRLabel;
    qrlbl9: TQRLabel;
    qrlbl1: TQRLabel;
    qrlbl2: TQRLabel;
    qrlbl10: TQRLabel;
    qrlblPrimerApellido: TQRLabel;
    qrlbl24: TQRLabel;
    qrlbl65: TQRLabel;
    qrlbl56: TQRLabel;
    qrlbl7: TQRLabel;
    qrlbl64: TQRLabel;
    qrlbl57: TQRLabel;
    qrlbl62: TQRLabel;
    qrlbl63: TQRLabel;
    qrlbl58: TQRLabel;
    qrlbl60: TQRLabel;
    qrlbl3: TQRLabel;
    qrlbl6: TQRLabel;
    qrlbl59: TQRLabel;
    qrlbl61: TQRLabel;
    procedure qrlblFechaPromESOPrint(sender: TObject; var Value: String);
    procedure PonNOta(sender: TObject; var Value: String);
    procedure qrlbl61Print(sender: TObject; var Value: String);
    procedure qrlbl60Print(sender: TObject; var Value: String);
    procedure QRLabelPrint(sender: TObject; var Value: String);
    procedure PonNOtaValenciano(sender: TObject; var Value: String);
    procedure qrlbl6Print(sender: TObject; var Value: String);
  private
    sFechaPromocion, sFechaHistorial, sDirector, sSecretario, sTutor: string;

  public
    procedure LoadData( const AFechaPromocion, AFechaHistorial, ADirector, ASecretario, ATutor: string );

  end;

var
  QRExpedienteQuinto: TQRExpedienteQuinto;

implementation

{$R *.DFM}

uses
   ExpedienteDM;

procedure TQRExpedienteQuinto.LoadData( const AFechaPromocion, AFechaHistorial, ADirector, ASecretario, ATutor: string );
begin
  sFechaPromocion:= AFechaPromocion;
  sFechaHistorial:= AFechaHistorial;
  sDirector:= ADirector;
  sSecretario:= ASecretario;
  sTutor:= ATutor;
end;

procedure TQRExpedienteQuinto.qrlblFechaPromESOPrint(sender: TObject;
  var Value: String);
begin
  //
    Value:=  sFechaPromocion;
end;

procedure TQRExpedienteQuinto.PonNOta(sender: TObject; var Value: String);
begin
  if DataSet.FieldByname(TQRDBText( sender ).DataField).AsFloat <> -1 then
    Value:= DataSet.FieldByname('se'+TQRDBText( sender ).DataField).AsString +  ' '  + Value
  else
    Value:= '';
end;


procedure TQRExpedienteQuinto.qrlbl61Print(sender: TObject;
  var Value: String);
begin
  Value:=  sSecretario;
end;

procedure TQRExpedienteQuinto.qrlbl60Print(sender: TObject;
  var Value: String);
begin
  Value:=  sDirector;
end;

procedure TQRExpedienteQuinto.QRLabelPrint(sender: TObject;
  var Value: String);
begin
  Value:=  sFechaHistorial;
end;

procedure TQRExpedienteQuinto.PonNOtaValenciano(sender: TObject;
  var Value: String);
begin
  if DataSet.FieldByname(TQRDBText( sender ).DataField).AsFloat <> -1 then
    Value:= DataSet.FieldByname('sv'+TQRDBText( sender ).DataField).AsString +  ': '  + Value
  else
    Value:= '';
end;

procedure TQRExpedienteQuinto.qrlbl6Print(sender: TObject;
  var Value: String);
begin
  Value:=  sTutor;
end;

end.
