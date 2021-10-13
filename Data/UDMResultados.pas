unit UDMResultados;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMResultados = class(TDataModule)
    qryEvaluacion: TQuery;
    dsEvaluacion: TDataSource;
    kmtResultados: TkbmMemTable;
    qryPromocion: TQuery;
    kmtTotales: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

    procedure ImprimirResultado( const AFecha: TDateTime; const ACurso, ADirector, ANotas: string );

    procedure MontarTabla;
    procedure AltaClase;
    function  NuevaClase( var AAlumnos: Integer ): boolean;

    procedure AbrirTemporal;
    procedure OrdenarTabla;
    procedure TotalizarTabla;
    procedure InicializarTotales;

  public
    { Public declarations }

    function  ImprimirResultados( const AFecha: TDateTime; const ACurso,  ADirector, ANotas: string ): Boolean;
  end;

function  ImprimirResultados( const AFecha: TDateTime; const ACurso,  ADirector, ANotas: string ): Boolean;

var
  DMResultados: TDMResultados;

implementation

{$R *.dfm}

uses
  Forms, UMain, UCodigoComun, UDMMain, ResultadosQR, Variants;

function  ImprimirResultados( const AFecha: TDateTime; const ACurso,  ADirector, ANotas: string ): Boolean;
begin
  Application.CreateForm(TDMResultados, DMResultados);
  try
    Result:= DMResultados.ImprimirResultados( AFecha, ACurso,  ADirector, ANotas );
  finally
    FreeAndNil( DMResultados );
  end;
end;

procedure TDMResultados.DataModuleCreate(Sender: TObject);
begin

  qryPromocion.SQL.Clear;
  qryPromocion.SQL.Add('SELECT curso_at, clase_at, ');
  qryPromocion.SQL.Add('       sum(case when promociona_at = ''N'' then 1 else 0 end ) NP, ');
  qryPromocion.SQL.Add('       sum(case when promociona_at = ''S'' then 1 else 0 end ) P ');
  qryPromocion.SQL.Add('FROM nof_alumno_mat join nof_alumno_datos on n_matricula_at = n_matricula_ad ');
  qryPromocion.SQL.Add('WHERE CURSO_AT = :curso and clase_at in (''01'',''02'',''03'',''04'',''05'',''06'') ');
  //Que tengan nota final
  qryPromocion.SQL.Add('and exists( ');
  qryPromocion.SQL.Add('  select * ');
  qryPromocion.SQL.Add('  from NOF_ALUMNO_NOTAS ');
  qryPromocion.SQL.Add('  where CURSO_AN = CURSO_AT AND CLASE_AN = CLASE_AT and n_matricula_at = n_matricula_an ');
  qryPromocion.SQL.Add('    and evaluacionf_an is not null ) ');
  qryPromocion.SQL.Add('group by curso_at, clase_at ');
  qryPromocion.SQL.Add('order by curso_at, clase_at ');

  qryEvaluacion.SQL.Clear;
  qryEvaluacion.SQL.Add('SELECT curso_cc curso, clase_cc clase, area_cc area, count(*) alumnos, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an < 5 then 1 else 0 end ) supendido, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an >= 5 and evaluacionf_an < 6 then 1 else 0 end ) suficiente, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an >= 6 and evaluacionf_an < 7 then 1 else 0 end ) bien, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an >= 7 and evaluacionf_an < 9 then 1 else 0 end ) notable, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an >= 9 then 1 else 0 end ) sobresaliente, ');
  qryEvaluacion.SQL.Add('       sum(case when evaluacionf_an is null then 1 else 0 end ) FALTA ');
  qryEvaluacion.SQL.Add('FROM NOF_CLASES_CURSO ');
  qryEvaluacion.SQL.Add('     JOIN NOF_AREAS ON AREA_CC = CODIGO_AR ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_NOTAS ON CURSO_AN = CURSO_CC AND CLASE_AN = CLASE_CC AND AREA_AN = AREA_CC ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_DATOS ON N_MATRICULA_AN = N_MATRICULA_AD ');
  qryEvaluacion.SQL.Add('WHERE CURSO_CC = :curso ');
  qryEvaluacion.SQL.Add('AND CLASE_CC = :clase ');
  qryEvaluacion.SQL.Add('  AND TIPO_VALOR_AR = ''N'' ');
  qryEvaluacion.SQL.Add('  AND TIPO_AR = ''A'' ');
  qryEvaluacion.SQL.Add('group by curso_cc, clase_cc, area_cc ');
  qryEvaluacion.SQL.Add('order by curso_cc, clase_cc, area_cc ');


  kmtResultados.FieldDefs.Clear;
  kmtResultados.FieldDefs.Add('curso', ftString, 2, False);
  kmtResultados.FieldDefs.Add('clase', ftString, 2, False);
  kmtResultados.FieldDefs.Add('grupo', ftString, 2, False);

  kmtResultados.FieldDefs.Add('alumnos', ftInteger, 0, False); //Promociona
  kmtResultados.FieldDefs.Add('P', ftInteger, 0, False); //Promociona
  kmtResultados.FieldDefs.Add('NP', ftInteger, 0, False); //Promociona
  kmtResultados.FieldDefs.Add('AP', ftInteger, 0, False); //Promociona
  kmtResultados.FieldDefs.Add('ANP', ftInteger, 0, False); //Promociona

  kmtResultados.FieldDefs.Add('CN_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CN_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CN_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CN_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CN_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('CS_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CS_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CS_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CS_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CS_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('CMN_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CMN_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CMN_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CMN_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CMN_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('EA_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EA_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EA_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EA_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EA_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('EF_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EF_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EF_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EF_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('EF_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('LCL_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('LCL_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('LCL_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('LCL_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('LCL_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('VLL_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('VLL_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('VLL_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('VLL_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('VLL_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('IN_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('IN_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('IN_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('IN_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('IN_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('M_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('M_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('M_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('M_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('M_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('REL_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('REL_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('REL_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('REL_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('REL_SB', ftInteger, 0 , False);

  kmtResultados.FieldDefs.Add('CV_IN', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CV_SU', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CV_BI', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CV_NT', ftInteger, 0 , False);
  kmtResultados.FieldDefs.Add('CV_SB', ftInteger, 0 , False);

  kmtResultados.IndexFieldNames:= 'curso;clase';
  kmtResultados.CreateTable;

  kmtTotales.FieldDefs.Clear;
  kmtTotales.FieldDefs.Add('curso', ftString, 2, False);

  kmtTotales.FieldDefs.Add('alumnos', ftInteger, 0, False); //Promociona
  kmtTotales.FieldDefs.Add('P', ftInteger, 0, False); //Promociona
  kmtTotales.FieldDefs.Add('NP', ftInteger, 0, False); //Promociona
  kmtTotales.FieldDefs.Add('AP', ftInteger, 0, False); //Promociona
  kmtTotales.FieldDefs.Add('ANP', ftInteger, 0, False); //Promociona

  kmtTotales.FieldDefs.Add('CN_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CN_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CN_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CN_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CN_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('CS_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CS_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CS_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CS_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CS_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('CMN_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CMN_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CMN_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CMN_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CMN_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('EA_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EA_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EA_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EA_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EA_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('EF_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EF_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EF_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EF_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('EF_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('LCL_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('LCL_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('LCL_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('LCL_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('LCL_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('VLL_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('VLL_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('VLL_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('VLL_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('VLL_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('IN_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('IN_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('IN_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('IN_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('IN_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('M_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('M_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('M_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('M_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('M_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('REL_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('REL_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('REL_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('REL_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('REL_SB', ftInteger, 0 , False);

  kmtTotales.FieldDefs.Add('CV_IN', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CV_SU', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CV_BI', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CV_NT', ftInteger, 0 , False);
  kmtTotales.FieldDefs.Add('CV_SB', ftInteger, 0 , False);

  kmtTotales.IndexFieldNames:= 'curso';
  kmtTotales.CreateTable;
end;

function  TDMResultados.ImprimirResultados( const AFecha: TDateTime; const ACurso,  ADirector, ANotas: string ): Boolean;
begin
  qryPromocion.ParamByName('curso').AsString:= ACurso;
  qryPromocion.Open;
  try
    if not qryPromocion.IsEmpty then
    begin
      AbrirTemporal;
      MontarTabla;
      OrdenarTabla;
      TotalizarTabla;
      ImprimirResultado ( AFecha, ACurso,  ADirector, ANotas );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  finally
    qryPromocion.Close;
  end;
end;


procedure TDMResultados.ImprimirResultado( const AFecha: TDateTime; const ACurso,  ADirector, ANotas: string );
var
  QRResultados: TQRResultados;
begin
  QRResultados:= TQRResultados.Create( Self );
  try
    QRResultados.sAnyo:= DMMain.DesCurso( ACurso );
    QRResultados.sDirector:= ADirector;
    QRResultados.dFecha:= AFecha;
    QRResultados.qrmNotas.Lines.Add( ANotas );

    QRResultados.PreviewModal;
  finally
    FreeAndNil( QRResultados );
  end;
end;

procedure TDMResultados.MontarTabla;
begin
  qryPromocion.First;
  while not qryPromocion.Eof do
  begin
    qryEvaluacion.ParamByName('curso').AsString:= qryPromocion.FieldByName('curso_at').AsString;
    qryEvaluacion.ParamByName('clase').AsString:= qryPromocion.FieldByName('clase_at').AsString;
    qryEvaluacion.Open;
    try
      AltaClase;
    finally
      qryEvaluacion.Close;
    end;
    qryPromocion.Next;
  end;
end;


function TDMResultados.NuevaClase( var AAlumnos: Integer ): boolean;
var
  iAux: Integer;
begin
  kmtResultados.Insert;

  if not ( ( qryPromocion.fieldByName('curso_at').AsString = '08' ) and
           ( ( qryPromocion.fieldByName('clase_at').AsString = '02' )  or
           ( qryPromocion.fieldByName('clase_at').AsString = '04' )  or
           ( qryPromocion.fieldByName('clase_at').AsString = '06' ) ) ) then
  begin
    kmtResultados.FieldByName('curso').AsString:= qryPromocion.FieldByName('curso_at').AsString;
    kmtResultados.FieldByName('clase').AsString:= qryPromocion.FieldByName('clase_at').AsString;
    kmtResultados.FieldByName('grupo').AsString:= 'A';

    kmtResultados.FieldByName('alumnos').AsInteger:= qryPromocion.FieldByName('NP').AsInteger + qryPromocion.FieldByName('P').AsInteger;
    kmtResultados.FieldByName('P').AsInteger:= qryPromocion.FieldByName('P').AsInteger;
    kmtResultados.FieldByName('NP').AsInteger:= qryPromocion.FieldByName('NP').AsInteger;
    kmtResultados.FieldByName('AP').AsInteger:= -1;
    kmtResultados.FieldByName('ANP').AsInteger:= -1;
    iAux:= 0;
    Result:= True;
  end
  else
  begin
    kmtResultados.FieldByName('curso').AsString:= qryPromocion.FieldByName('curso_at').AsString;
    kmtResultados.FieldByName('clase').AsString:= qryPromocion.FieldByName('clase_at').AsString;
    kmtResultados.FieldByName('grupo').AsString:= '...';

    iAux:= -1;
    kmtResultados.FieldByName('alumnos').AsInteger:= iAux;
    kmtResultados.FieldByName('P').AsInteger:= iAux;
    kmtResultados.FieldByName('NP').AsInteger:= iAux;
    Result:= False;
  end;

  kmtResultados.FieldByName('CN_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('CN_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('CN_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('CN_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('CN_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('CS_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('CS_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('CS_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('CS_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('CS_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('CMN_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('CMN_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('CMN_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('CMN_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('CMN_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('EA_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('EA_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('EA_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('EA_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('EA_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('EF_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('EF_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('EF_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('EF_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('EF_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('LCL_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('LCL_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('LCL_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('LCL_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('LCL_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('VLL_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('VLL_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('VLL_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('VLL_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('VLL_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('IN_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('IN_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('IN_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('IN_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('IN_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('M_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('M_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('M_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('M_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('M_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('REL_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('REL_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('REL_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('REL_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('REL_SB').AsInteger:= iAux;

  kmtResultados.FieldByName('CV_IN').AsInteger:= iAux;
  kmtResultados.FieldByName('CV_SU').AsInteger:= iAux;
  kmtResultados.FieldByName('CV_BI').AsInteger:= iAux;
  kmtResultados.FieldByName('CV_NT').AsInteger:= iAux;
  kmtResultados.FieldByName('CV_SB').AsInteger:= iAux;
end;

procedure TDMResultados.AltaClase;
var
  sMateria, sNota: string;
  iAlumnos: Integer;
begin
  if NuevaClase( iAlumnos ) then
  begin
    while not qryEvaluacion.Eof do
    begin
      sMateria:= GetMateria( qryEvaluacion.fieldByName('AREA').AsString, '' );
      kmtResultados.FieldByName(sMateria + '_IN').AsInteger:= qryEvaluacion.fieldByName('supendido').AsInteger;
      kmtResultados.FieldByName(sMateria + '_SU').AsInteger:= qryEvaluacion.fieldByName('suficiente').AsInteger;
      kmtResultados.FieldByName(sMateria + '_BI').AsInteger:= qryEvaluacion.fieldByName('bien').AsInteger;
      kmtResultados.FieldByName(sMateria + '_NT').AsInteger:= qryEvaluacion.fieldByName('notable').AsInteger;
      kmtResultados.FieldByName(sMateria + '_SB').AsInteger:= qryEvaluacion.fieldByName('sobresaliente').AsInteger;
      (*
      iAux:= qryEvaluacion.fieldByName('supendido').AsInteger + qryEvaluacion.fieldByName('suficiente').AsInteger +
             qryEvaluacion.fieldByName('bien').AsInteger + qryEvaluacion.fieldByName('notable').AsInteger +
             qryEvaluacion.fieldByName('sobresaliente').AsInteger;
      *)
      qryEvaluacion.Next;
    end;
  end;
  kmtResultados.Post;
end;

procedure TDMResultados.AbrirTemporal;
begin
  if kmtResultados.Active then
    kmtResultados.Close;
  kmtResultados.Open;
  if kmtTotales.Active then
    kmtTotales.Close;
  kmtTotales.Open;
end;


procedure TDMResultados.OrdenarTabla;
begin
  kmtResultados.SortFields:= 'curso;clase';
  kmtResultados.Sort([]);
end;

procedure TDMResultados.InicializarTotales;
begin
    kmtTotales.Insert;
    kmtTotales.FieldByName('curso').AsString:= kmtResultados.FieldByName('curso').AsString;

    kmtTotales.FieldByName('alumnos').AsInteger:=0;
    kmtTotales.FieldByName('P').AsInteger:= 0;
    kmtTotales.FieldByName('NP').AsInteger:= 0;
    kmtTotales.FieldByName('P').AsInteger:= -1;
    kmtTotales.FieldByName('NP').AsInteger:= -1;

    kmtTotales.FieldByName('CN_IN').AsInteger:= 0;
    kmtTotales.FieldByName('CN_SU').AsInteger:= 0;
    kmtTotales.FieldByName('CN_BI').AsInteger:= 0;
    kmtTotales.FieldByName('CN_NT').AsInteger:= 0;
    kmtTotales.FieldByName('CN_SB').AsInteger:= 0;

    kmtTotales.FieldByName('CS_IN').AsInteger:= 0;
    kmtTotales.FieldByName('CS_SU').AsInteger:= 0;
    kmtTotales.FieldByName('CS_BI').AsInteger:= 0;
    kmtTotales.FieldByName('CS_NT').AsInteger:= 0;
    kmtTotales.FieldByName('CS_SB').AsInteger:= 0;

    kmtTotales.FieldByName('CMN_IN').AsInteger:= 0;
    kmtTotales.FieldByName('CMN_SU').AsInteger:= 0;
    kmtTotales.FieldByName('CMN_BI').AsInteger:= 0;
    kmtTotales.FieldByName('CMN_NT').AsInteger:= 0;
    kmtTotales.FieldByName('CMN_SB').AsInteger:= 0;

    kmtTotales.FieldByName('EA_IN').AsInteger:= 0;
    kmtTotales.FieldByName('EA_SU').AsInteger:= 0;
    kmtTotales.FieldByName('EA_BI').AsInteger:= 0;
    kmtTotales.FieldByName('EA_NT').AsInteger:= 0;
    kmtTotales.FieldByName('EA_SB').AsInteger:= 0;

    kmtTotales.FieldByName('EF_IN').AsInteger:= 0;
    kmtTotales.FieldByName('EF_SU').AsInteger:= 0;
    kmtTotales.FieldByName('EF_BI').AsInteger:= 0;
    kmtTotales.FieldByName('EF_NT').AsInteger:= 0;
    kmtTotales.FieldByName('EF_SB').AsInteger:= 0;

    kmtTotales.FieldByName('LCL_IN').AsInteger:= 0;
    kmtTotales.FieldByName('LCL_SU').AsInteger:= 0;
    kmtTotales.FieldByName('LCL_BI').AsInteger:= 0;
    kmtTotales.FieldByName('LCL_NT').AsInteger:= 0;
    kmtTotales.FieldByName('LCL_SB').AsInteger:= 0;

    kmtTotales.FieldByName('VLL_IN').AsInteger:= 0;
    kmtTotales.FieldByName('VLL_SU').AsInteger:= 0;
    kmtTotales.FieldByName('VLL_BI').AsInteger:= 0;
    kmtTotales.FieldByName('VLL_NT').AsInteger:= 0;
    kmtTotales.FieldByName('VLL_SB').AsInteger:= 0;

    kmtTotales.FieldByName('IN_IN').AsInteger:= 0;
    kmtTotales.FieldByName('IN_SU').AsInteger:= 0;
    kmtTotales.FieldByName('IN_BI').AsInteger:= 0;
    kmtTotales.FieldByName('IN_NT').AsInteger:= 0;
    kmtTotales.FieldByName('IN_SB').AsInteger:= 0;

    kmtTotales.FieldByName('M_IN').AsInteger:= 0;
    kmtTotales.FieldByName('M_SU').AsInteger:= 0;
    kmtTotales.FieldByName('M_BI').AsInteger:= 0;
    kmtTotales.FieldByName('M_NT').AsInteger:= 0;
    kmtTotales.FieldByName('M_SB').AsInteger:= 0;

    kmtTotales.FieldByName('REL_IN').AsInteger:= 0;
    kmtTotales.FieldByName('REL_SU').AsInteger:= 0;
    kmtTotales.FieldByName('REL_BI').AsInteger:= 0;
    kmtTotales.FieldByName('REL_NT').AsInteger:= 0;
    kmtTotales.FieldByName('REL_SB').AsInteger:= 0;

    kmtTotales.FieldByName('CV_IN').AsInteger:= 0;
    kmtTotales.FieldByName('CV_SU').AsInteger:= 0;
    kmtTotales.FieldByName('CV_BI').AsInteger:= 0;
    kmtTotales.FieldByName('CV_NT').AsInteger:= 0;
    kmtTotales.FieldByName('CV_SB').AsInteger:= 0;

    kmtTotales.Post;
end;

procedure TDMResultados.TotalizarTabla;
begin
  InicializarTotales;
  kmtResultados.First;
  while not kmtResultados.Eof do
  begin

    kmtTotales.Edit;
    if kmtResultados.FieldByName('alumnos').AsInteger > 0 then
    begin
      kmtTotales.FieldByName('alumnos').AsInteger:= kmtTotales.FieldByName('alumnos').AsInteger + kmtResultados.FieldByName('alumnos').AsInteger;
      kmtTotales.FieldByName('P').AsInteger:= kmtTotales.FieldByName('P').AsInteger + kmtResultados.FieldByName('P').AsInteger;
      kmtTotales.FieldByName('NP').AsInteger:= kmtTotales.FieldByName('NP').AsInteger + kmtResultados.FieldByName('NP').AsInteger;

      kmtTotales.FieldByName('CN_IN').AsInteger:= kmtTotales.FieldByName('CN_IN').AsInteger + kmtResultados.FieldByName('CN_IN').AsInteger;
      kmtTotales.FieldByName('CN_SU').AsInteger:= kmtTotales.FieldByName('CN_SU').AsInteger + kmtResultados.FieldByName('CN_SU').AsInteger;
      kmtTotales.FieldByName('CN_BI').AsInteger:= kmtTotales.FieldByName('CN_BI').AsInteger + kmtResultados.FieldByName('CN_BI').AsInteger;
      kmtTotales.FieldByName('CN_NT').AsInteger:= kmtTotales.FieldByName('CN_NT').AsInteger + kmtResultados.FieldByName('CN_NT').AsInteger;
      kmtTotales.FieldByName('CN_SB').AsInteger:= kmtTotales.FieldByName('CN_SB').AsInteger + kmtResultados.FieldByName('CN_SB').AsInteger;

      kmtTotales.FieldByName('CS_IN').AsInteger:= kmtTotales.FieldByName('CS_IN').AsInteger + kmtResultados.FieldByName('CS_IN').AsInteger;
      kmtTotales.FieldByName('CS_SU').AsInteger:= kmtTotales.FieldByName('CS_SU').AsInteger + kmtResultados.FieldByName('CS_SU').AsInteger;
      kmtTotales.FieldByName('CS_BI').AsInteger:= kmtTotales.FieldByName('CS_BI').AsInteger + kmtResultados.FieldByName('CS_BI').AsInteger;
      kmtTotales.FieldByName('CS_NT').AsInteger:= kmtTotales.FieldByName('CS_NT').AsInteger + kmtResultados.FieldByName('CS_NT').AsInteger;
      kmtTotales.FieldByName('CS_SB').AsInteger:= kmtTotales.FieldByName('CS_SB').AsInteger + kmtResultados.FieldByName('CS_SB').AsInteger;

      kmtTotales.FieldByName('CMN_IN').AsInteger:= kmtTotales.FieldByName('CMN_IN').AsInteger + kmtResultados.FieldByName('CMN_IN').AsInteger;
      kmtTotales.FieldByName('CMN_SU').AsInteger:= kmtTotales.FieldByName('CMN_SU').AsInteger + kmtResultados.FieldByName('CMN_SU').AsInteger;
      kmtTotales.FieldByName('CMN_BI').AsInteger:= kmtTotales.FieldByName('CMN_BI').AsInteger + kmtResultados.FieldByName('CMN_BI').AsInteger;
      kmtTotales.FieldByName('CMN_NT').AsInteger:= kmtTotales.FieldByName('CMN_NT').AsInteger + kmtResultados.FieldByName('CMN_NT').AsInteger;
      kmtTotales.FieldByName('CMN_SB').AsInteger:= kmtTotales.FieldByName('CMN_SB').AsInteger + kmtResultados.FieldByName('CMN_SB').AsInteger;

      kmtTotales.FieldByName('EA_IN').AsInteger:= kmtTotales.FieldByName('EA_IN').AsInteger + kmtResultados.FieldByName('EA_IN').AsInteger;
      kmtTotales.FieldByName('EA_SU').AsInteger:= kmtTotales.FieldByName('EA_SU').AsInteger + kmtResultados.FieldByName('EA_SU').AsInteger;
      kmtTotales.FieldByName('EA_BI').AsInteger:= kmtTotales.FieldByName('EA_BI').AsInteger + kmtResultados.FieldByName('EA_BI').AsInteger;
      kmtTotales.FieldByName('EA_NT').AsInteger:= kmtTotales.FieldByName('EA_NT').AsInteger + kmtResultados.FieldByName('EA_NT').AsInteger;
      kmtTotales.FieldByName('EA_SB').AsInteger:= kmtTotales.FieldByName('EA_SB').AsInteger + kmtResultados.FieldByName('EA_SB').AsInteger;

      kmtTotales.FieldByName('EF_IN').AsInteger:= kmtTotales.FieldByName('EF_IN').AsInteger + kmtResultados.FieldByName('EF_IN').AsInteger;
      kmtTotales.FieldByName('EF_SU').AsInteger:= kmtTotales.FieldByName('EF_SU').AsInteger + kmtResultados.FieldByName('EF_SU').AsInteger;
      kmtTotales.FieldByName('EF_BI').AsInteger:= kmtTotales.FieldByName('EF_BI').AsInteger + kmtResultados.FieldByName('EF_BI').AsInteger;
      kmtTotales.FieldByName('EF_NT').AsInteger:= kmtTotales.FieldByName('EF_NT').AsInteger + kmtResultados.FieldByName('EF_NT').AsInteger;
      kmtTotales.FieldByName('EF_SB').AsInteger:= kmtTotales.FieldByName('EF_SB').AsInteger + kmtResultados.FieldByName('EF_SB').AsInteger;

      kmtTotales.FieldByName('LCL_IN').AsInteger:= kmtTotales.FieldByName('LCL_IN').AsInteger + kmtResultados.FieldByName('LCL_IN').AsInteger;
      kmtTotales.FieldByName('LCL_SU').AsInteger:= kmtTotales.FieldByName('LCL_SU').AsInteger + kmtResultados.FieldByName('LCL_SU').AsInteger;
      kmtTotales.FieldByName('LCL_BI').AsInteger:= kmtTotales.FieldByName('LCL_BI').AsInteger + kmtResultados.FieldByName('LCL_BI').AsInteger;
      kmtTotales.FieldByName('LCL_NT').AsInteger:= kmtTotales.FieldByName('LCL_NT').AsInteger + kmtResultados.FieldByName('LCL_NT').AsInteger;
      kmtTotales.FieldByName('LCL_SB').AsInteger:= kmtTotales.FieldByName('LCL_SB').AsInteger + kmtResultados.FieldByName('LCL_SB').AsInteger;

      kmtTotales.FieldByName('VLL_IN').AsInteger:= kmtTotales.FieldByName('VLL_IN').AsInteger + kmtResultados.FieldByName('VLL_IN').AsInteger;
      kmtTotales.FieldByName('VLL_SU').AsInteger:= kmtTotales.FieldByName('VLL_SU').AsInteger + kmtResultados.FieldByName('VLL_SU').AsInteger;
      kmtTotales.FieldByName('VLL_BI').AsInteger:= kmtTotales.FieldByName('VLL_BI').AsInteger + kmtResultados.FieldByName('VLL_BI').AsInteger;
      kmtTotales.FieldByName('VLL_NT').AsInteger:= kmtTotales.FieldByName('VLL_NT').AsInteger + kmtResultados.FieldByName('VLL_NT').AsInteger;
      kmtTotales.FieldByName('VLL_SB').AsInteger:= kmtTotales.FieldByName('VLL_SB').AsInteger + kmtResultados.FieldByName('VLL_SB').AsInteger;

      kmtTotales.FieldByName('IN_IN').AsInteger:= kmtTotales.FieldByName('IN_IN').AsInteger + kmtResultados.FieldByName('IN_IN').AsInteger;
      kmtTotales.FieldByName('IN_SU').AsInteger:= kmtTotales.FieldByName('IN_SU').AsInteger + kmtResultados.FieldByName('IN_SU').AsInteger;
      kmtTotales.FieldByName('IN_BI').AsInteger:= kmtTotales.FieldByName('IN_BI').AsInteger + kmtResultados.FieldByName('IN_BI').AsInteger;
      kmtTotales.FieldByName('IN_NT').AsInteger:= kmtTotales.FieldByName('IN_NT').AsInteger + kmtResultados.FieldByName('IN_NT').AsInteger;
      kmtTotales.FieldByName('IN_SB').AsInteger:= kmtTotales.FieldByName('IN_SB').AsInteger + kmtResultados.FieldByName('IN_SB').AsInteger;

      kmtTotales.FieldByName('M_IN').AsInteger:= kmtTotales.FieldByName('M_IN').AsInteger + kmtResultados.FieldByName('M_IN').AsInteger;
      kmtTotales.FieldByName('M_SU').AsInteger:= kmtTotales.FieldByName('M_SU').AsInteger + kmtResultados.FieldByName('M_SU').AsInteger;
      kmtTotales.FieldByName('M_BI').AsInteger:= kmtTotales.FieldByName('M_BI').AsInteger + kmtResultados.FieldByName('M_BI').AsInteger;
      kmtTotales.FieldByName('M_NT').AsInteger:= kmtTotales.FieldByName('M_NT').AsInteger + kmtResultados.FieldByName('M_NT').AsInteger;
      kmtTotales.FieldByName('M_SB').AsInteger:= kmtTotales.FieldByName('M_SB').AsInteger + kmtResultados.FieldByName('M_SB').AsInteger;

      kmtTotales.FieldByName('REL_IN').AsInteger:= kmtTotales.FieldByName('REL_IN').AsInteger + kmtResultados.FieldByName('REL_IN').AsInteger;
      kmtTotales.FieldByName('REL_SU').AsInteger:= kmtTotales.FieldByName('REL_SU').AsInteger + kmtResultados.FieldByName('REL_SU').AsInteger;
      kmtTotales.FieldByName('REL_BI').AsInteger:= kmtTotales.FieldByName('REL_BI').AsInteger + kmtResultados.FieldByName('REL_BI').AsInteger;
      kmtTotales.FieldByName('REL_NT').AsInteger:= kmtTotales.FieldByName('REL_NT').AsInteger + kmtResultados.FieldByName('REL_NT').AsInteger;
      kmtTotales.FieldByName('REL_SB').AsInteger:= kmtTotales.FieldByName('REL_SB').AsInteger + kmtResultados.FieldByName('REL_SB').AsInteger;

      kmtTotales.FieldByName('CV_IN').AsInteger:= kmtTotales.FieldByName('CV_IN').AsInteger + kmtResultados.FieldByName('CV_IN').AsInteger;
      kmtTotales.FieldByName('CV_SU').AsInteger:= kmtTotales.FieldByName('CV_SU').AsInteger + kmtResultados.FieldByName('CV_SU').AsInteger;
      kmtTotales.FieldByName('CV_BI').AsInteger:= kmtTotales.FieldByName('CV_BI').AsInteger + kmtResultados.FieldByName('CV_BI').AsInteger;
      kmtTotales.FieldByName('CV_NT').AsInteger:= kmtTotales.FieldByName('CV_NT').AsInteger + kmtResultados.FieldByName('CV_NT').AsInteger;
      kmtTotales.FieldByName('CV_SB').AsInteger:= kmtTotales.FieldByName('CV_SB').AsInteger + kmtResultados.FieldByName('CV_SB').AsInteger;

      kmtTotales.Post;
    end;

    kmtResultados.Next;
  end;
  kmtResultados.First;
end;

end.
