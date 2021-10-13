unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls, nbEdits,
  nbCombos, QuickRpt;

type
  TFMain = class(TForm)
    pgcMain: TPageControl;
    tsActas: TTabSheet;
    pnlBody: TPanel;
    dbgrdCursos: TDBGrid;
    dbgrdClases: TDBGrid;
    txtCursos: TStaticText;
    txtCLASES: TStaticText;
    tsExpediente: TTabSheet;
    tsHistorial: TTabSheet;
    tsResultados: TTabSheet;
    lblDirector: TLabel;
    edtDirector: TEdit;
    lblTutor: TLabel;
    edtTutor: TEdit;
    lbl8: TLabel;
    edtCodCentro: TEdit;
    lbl9: TLabel;
    edtNomCentro: TEdit;
    lbl10: TLabel;
    edtPoblacionCentro: TEdit;
    lbl11: TLabel;
    edtProvinciaCentro: TEdit;
    lbl14: TLabel;
    edtSecretario: TEdit;
    lbl2: TLabel;
    lblFecha: TLabel;
    cbbEvaluacion: TComboBox;
    dtpFecha: TDateTimePicker;
    lblCV: TLabel;
    btnActivarCV: TButton;
    btnDesActivarCV: TButton;
    btnImprimir: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btnCerrar: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgrdClasesCellClick(Column: TColumn);
    procedure dbgrdCursosCellClick(Column: TColumn);
    procedure btnActivarCVClick(Sender: TObject);
    procedure btnDesActivarCVClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgcMainChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro, sDirector, sSecretario: string;

    procedure PonTutor;
    procedure ActivarCV;

    function DatosHistorialExpediente: Boolean;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;


implementation

{$R *.dfm}

uses
  UDMMain, UDMActas, ExpedienteF, UDMResultados, UFNotas;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DMMain:= TDMMain.Create( self );
  ActivarCV;
  dtpFecha.DateTime:= Now;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMMain.CerrarBD;
  FreeAndNil( DMMain );
end;

procedure TFMain.btnCerrarClick(Sender: TObject);
begin
  Close;
end;


procedure TFMain.dbgrdClasesCellClick(Column: TColumn);
begin
  PonTutor;
  ActivarCV;
end;

procedure TFMain.dbgrdCursosCellClick(Column: TColumn);
begin
  PonTutor;
end;

procedure TFMain.PonTutor;
begin
  edtTutor.Text:= DMMain.NombreTutor( DMMain.qryClases.FieldByname('CURSO_CC').AsString, DMMain.qryClases.FieldByname('CLASE_CC').AsString );
end;


procedure TFMain.ActivarCV;
begin
  if DMMain.qryClases.Active then
  begin
    btnActivarCV.Enabled:= ( DMMain.qryClases.FieldByname('CLASE_CC').AsString = '05' ) and
                           not DMMain.EstaActivoCV( DMMain.qryClases.FieldByname('CURSO_CC').AsString );
    btnDesActivarCV.Enabled:= ( DMMain.qryClases.FieldByname('CLASE_CC').AsString = '05' ) and
                           DMMain.EstaActivoCV( DMMain.qryClases.FieldByname('CURSO_CC').AsString );
  end
  else
  begin
    btnActivarCV.Enabled:= False;
    btnDesActivarCV.Enabled:= False;
  end;
  btnDesActivarCV.Visible:= btnDesActivarCV.Enabled;
  btnActivarCV.Visible:= not btnDesActivarCV.Visible;
end;

procedure TFMain.btnActivarCVClick(Sender: TObject);
begin
  DMMain.ActivarCV( DMMain.qryClases.FieldByname('CURSO_CC').AsString );
  ActivarCV;
end;

procedure TFMain.btnDesActivarCVClick(Sender: TObject);
begin
  DMMain.DesActivarCV( DMMain.qryClases.FieldByname('CURSO_CC').AsString );
  ActivarCV;
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  if not DMMain.AbrirBaseDeDatos then
    Close;
  pgcMain.ActivePage:= tsActas;
end;

procedure TFMain.pgcMainChange(Sender: TObject);
begin
  if pgcMain.ActivePage = tsActas then
  begin
    Caption:= '   INFORMES ACADÉMICOS COLEGIO FUNDACIÓN ANTONIO BONNY - ACTAS';
    cbbEvaluacion.Enabled:= True;
    lblFecha.Caption:= 'Fecha Evaluación ';
  end
  else
  if pgcMain.ActivePage = tsHistorial then
  begin
    Caption:= '   INFORMES ACADÉMICOS COLEGIO FUNDACIÓN ANTONIO BONNY - HISTORIAL';
    cbbEvaluacion.Enabled:= False;
    lblFecha.Caption:= 'Fecha Promoción ';
  end
  else
  if pgcMain.ActivePage = tsExpediente then
  begin
    Caption:= '   INFORMES ACADÉMICOS COLEGIO FUNDACIÓN ANTONIO BONNY - EXPEDIENTE';
    cbbEvaluacion.Enabled:= False;
    lblFecha.Caption:= 'Fecha Promoción ';
  end
  else
  if pgcMain.ActivePage = tsResultados then
  begin
    Caption:= '   INFORMES ACADÉMICOS COLEGIO FUNDACIÓN ANTONIO BONNY - RESULTADO';
    cbbEvaluacion.Enabled:= False;
    lblFecha.Caption:= 'Fecha Evaluación ';
  end;  //
end;

function TFMain.DatosHistorialExpediente: Boolean;
begin
  //
  sCodCentro:= edtCodCentro.Text;
  sNomCentro:= edtNomCentro.Text;
  sPoblacionCentro:= edtPoblacionCentro.Text;
  sProvinciaCentro:= edtProvinciaCentro.Text;
  sDirector:= edtDirector.Text;
  sSecretario:= edtSecretario.Text;
  if sSecretario = '' then
  begin
    ShowMessage('Falta el nombre del secretario/a.');
    Result:= False;
  end
  else
  begin
    Result:= True;
  end;
end;


procedure TFMain.btnImprimirClick(Sender: TObject);
var
  sAux: string;
begin
  if pgcMain.ActivePage = tsActas then
  begin
    if not UDMActas.ImprimirActa( cbbEvaluacion.ItemIndex, cbbEvaluacion.Text, dtpFecha.Date,
                              DMMain.qryClases.FieldByname('CURSO_CC').AsString,
                              DMMain.qryClases.FieldByname('CLASE_CC').AsString,
                              edtDirector.Text, edtTutor.Text ) then
      ShowMessage('Acta sin datos.');
  end
  else
  if pgcMain.ActivePage = tsHistorial then
  begin
    if DatosHistorialExpediente then
      ExpedienteF.ImprimirExpediente( False, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro, sDirector, sSecretario,
                                    DMMain.qryClases.FieldByname('CURSO_CC').AsString, DMMain.qryClases.FieldByname('CLASE_CC').AsString );
  end
  else
  if pgcMain.ActivePage = tsExpediente then
  begin
    if DatosHistorialExpediente then
      ExpedienteF.ImprimirExpediente( True, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro, sDirector, sSecretario,
                                    DMMain.qryClases.FieldByname('CURSO_CC').AsString,  DMMain.qryClases.FieldByname('CLASE_CC').AsString );
  end
  else
  if pgcMain.ActivePage = tsResultados then
  begin
    if UFNotas.GetNotas( sAux ) then
      if not UDMResultados.ImprimirResultados( dtpFecha.Date, DMMain.qryClases.FieldByname('CURSO_CC').AsString, edtDirector.Text, sAux ) then
        ShowMessage( 'Curso sin datos evaluacion final.');
  end;
end;

end.

