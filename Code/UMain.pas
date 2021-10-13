unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, ComCtrls;

type
  TFMain = class(TForm)
    pnlIzq: TPanel;
    btnActaClase: TButton;
    pnlTop: TPanel;
    btnCerrar: TButton;
    pnlBody: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    dbgrdCursos: TDBGrid;
    dbgrdClases: TDBGrid;
    dtpFecha: TDateTimePicker;
    cbbEvaluacion: TComboBox;
    dbgrdAlumnos: TDBGrid;
    btnAbrir: TButton;
    txtCursos: TStaticText;
    txtCLASES: TStaticText;
    txt1: TStaticText;
    lblDirector: TLabel;
    lblTutor: TLabel;
    edtDirector: TEdit;
    edtTutor: TEdit;
    btnDesActivarCV: TButton;
    btnActivarCV: TButton;
    lblCV: TLabel;
    btnExpediente: TButton;
    btnImprirPortada: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnActaClaseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAbrirClick(Sender: TObject);
    procedure dbgrdClasesCellClick(Column: TColumn);
    procedure dbgrdCursosCellClick(Column: TColumn);
    procedure btnActivarCVClick(Sender: TObject);
    procedure btnDesActivarCVClick(Sender: TObject);
    procedure btnExpedienteClick(Sender: TObject);
  private
    { Private declarations }
    procedure HabiliarBotones;
    procedure PonTutor;
    procedure ActivarCV;
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
  MainDM, HistorialF;

var
  DMMain: TDMMain;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DMMain:= TDMMain.Create( self );
  dtpFecha.DateTime:= Now;
  ActivarCV;
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


procedure TFMain.btnAbrirClick(Sender: TObject);
begin
  if DMMain.AbrirBD( False ) then
  begin
    HabiliarBotones;
  end;
end;


procedure TFMain.HabiliarBotones;
begin
  btnAbrir.Enabled:= False;
  btnActaClase.Enabled:= True;
  btnExpediente.Enabled:= True;
  btnImprirPortada.Enabled:= True;
  pnlBody.Enabled:= True;
end;

procedure TFMain.btnActaClaseClick(Sender: TObject);
begin
  if not DMMain.ImprimirActa( cbbEvaluacion.ItemIndex, cbbEvaluacion.Text, dtpFecha.Date,
                              DMMain.qryClases.FieldByname('CURSO_CC').AsString,
                              DMMain.qryClases.FieldByname('CLASE_CC').AsString,
                              edtDirector.Text, edtTutor.Text ) then
      ShowMessage('Acta sin datos.');
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

procedure TFMain.btnExpedienteClick(Sender: TObject);
begin
  HistorialF.ImprimirHistorial( DMMain.qryAlumnos.FieldByname('n_matricula_ad').AsString );
end;

end.

