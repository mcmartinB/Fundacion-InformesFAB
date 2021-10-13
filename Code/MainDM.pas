unit MainDM;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMMain = class(TDataModule)
    Database: TDatabase;
    qryEvaluacion: TQuery;
    dsEvaluacion: TDataSource;
    qryCursos: TQuery;
    dsCursos: TDataSource;
    qryClases: TQuery;
    dsClases: TDataSource;
    kmtResultados: TkbmMemTable;
    qryAlumnos: TQuery;
    dsAlumnos: TDataSource;
    qryTutor: TQuery;
    qryCurso: TQuery;
    qryClase: TQuery;
    qryAux: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure qryCursosAfterOpen(DataSet: TDataSet);
    procedure qryCursosBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
    iEvalua: integer;
    sCampoEvalua, sDesEvalua: string;
    sAlumno: string;

    procedure PutEvaluacion;
    procedure AbrirTemporal;
    procedure MontarTabla;
    procedure OrdenarTabla;
    function  ExisteAlumno: Boolean;
    procedure ModificaAlumno;
    procedure AltaAlumno;
    function  GetMateria: string;
    function  GetNota: string;

    procedure ImprimirActa2015ConCV( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string );
    procedure ImprimirActa2015( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string );

  public
    { Public declarations }
    function  AbrirBD( const ALogin: Boolean ): boolean;
    procedure CerrarBD;
    function  ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                            const ACurso,  AClase, ADirector, ATutor: string ): Boolean;

    function DesCurso( const ACodCurso: string ): string;
    function DesClase( const ACodClase: string ): string;
    function NombreTutor( const ACodCurso, ACodClase: string ): string;
    function TituloActa( const ACodClase: string; const AEvaluacion: integer ): string;

    procedure ActivarCV( const ACurso: string );
    procedure DesActivarCV( const ACurso: string );
    function  EstaActivoCV( const ACurso: string ): Boolean;
  end;


implementation

{$R *.dfm}

uses IniFiles, Variants, QuickRpt, Dialogs,
     Acta2015QR, ActaConCV2015QR;

procedure TDMMain.DataModuleDestroy(Sender: TObject);
begin
  CerrarBD;
end;

procedure TDMMain.DataModuleCreate(Sender: TObject);
var
  IniFile: TIniFile;
  sAux: string;
begin
  sAux:= GetCurrentDir + '\InformesFundacion.ini';

  if FileExists( sAux ) then
  begin
    Database.Params.Clear;
    IniFile:= TIniFile.Create( sAux );
    sAux:= IniFile.ReadString( 'BDDATA', 'ALIAS', 'vfundacion' );
    Database.AliasName:= sAux;
    sAux:= IniFile.ReadString( 'BDDATA', 'USER', 'informix' );
    Database.Params.Values['USER NAME']:= sAux;
    sAux:= IniFile.ReadString( 'BDDATA', 'PASS', 'informix' );
    Database.Params.Values['PASSWORD']:= sAux;
    IniFile.Free;
  end;

  qryCursos.SQL.Clear;
  qryCursos.SQL.Add('SELECT CODIGO_CU, DESCRIPCION_CU ');
  qryCursos.SQL.Add('FROM NOF_CURSOS ');
  qryCursos.SQL.Add('ORDER BY CODIGO_CU DESC');

  qryCurso.SQL.Clear;
  qryCurso.SQL.Add('SELECT * ');
  qryCurso.SQL.Add('FROM NOF_CURSOS ');
  qryCurso.SQL.Add('WHERE CODIGO_CU = :CODIGO_CU');

  qryClases.SQL.Clear;
  qryClases.SQL.Add('SELECT CURSO_CC, CLASE_CC, DESCRIPCION_CL ');
  qryClases.SQL.Add('FROM NOF_CLASES_CURSO JOIN NOF_CLASES ON CLASE_CC = CODIGO_CL');
  qryClases.SQL.Add('WHERE CURSO_CC = :CODIGO_CU ');
  qryClases.SQL.Add('GROUP BY CURSO_CC, CLASE_CC, DESCRIPCION_CL ');
  qryClases.SQL.Add('ORDER BY CURSO_CC, CLASE_CC ');

  qryClase.SQL.Clear;
  qryClase.SQL.Add('select * ');
  qryClase.SQL.Add('from NOF_CLASES ');
  qryClase.SQL.Add('where codigo_cl = :codigo_cl ');

  qryAlumnos.SQL.Clear;
  qryAlumnos.SQL.Add('select n_matricula_ad, trim(nombre_ad) || '' '' || trim(apellido1_ad)  || '' '' || trim(apellido1_Ad) ');
  qryAlumnos.SQL.Add('from nof_alumno_mat join nof_alumno_datos on n_matricula_at = n_matricula_ad ');
  qryAlumnos.SQL.Add('where curso_at = :CURSO_CC ');
  qryAlumnos.SQL.Add('and clase_at = :CLASE_CC ');
  qryAlumnos.SQL.Add('order by n_matricula_ad ');

  qryTutor.SQL.Clear;
  qryTutor.SQL.Add(' select nombre_tt tutor ');
  qryTutor.SQL.Add(' from NOF_CLASES_CURSO JOIN nof_tutor on tutor_cc = codigo_tt ');
  qryTutor.SQL.Add(' where CURSO_CC = :CURSO_CC ');
  qryTutor.SQL.Add('  and  CLASE_CC = :CLASE_CC ');
  qryTutor.SQL.Add(' group by nombre_tt ');

  qryEvaluacion.SQL.Clear;
  qryEvaluacion.SQL.Add('SELECT N_MATRICULA_AN, ');
  qryEvaluacion.SQL.Add('       TRIM(NVL(APELLIDO1_AD,'''')) || '' '' || TRIM(NVL(APELLIDO2_AD,'''')) || '', '' || TRIM(NVL(NOMBRE_AD,'''')) NOMBRE_ALUMNO, ');
  qryEvaluacion.SQL.Add('       AREA_CC, DESCRIPCION_AR, ');
  qryEvaluacion.SQL.Add('       EVALUACION1_AN, EVALUACION2_AN, EVALUACION3_AN, EVALUACIONF_AN, PROMOCIONA_AN ');
  qryEvaluacion.SQL.Add('FROM NOF_CLASES_CURSO ');
  qryEvaluacion.SQL.Add('     JOIN NOF_AREAS ON AREA_CC = CODIGO_AR ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_NOTAS ON CURSO_AN = CURSO_CC AND CLASE_AN = CLASE_CC AND AREA_AN = AREA_CC ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_DATOS ON N_MATRICULA_AN = N_MATRICULA_AD ');
  qryEvaluacion.SQL.Add('WHERE CURSO_CC = :curso ');
  qryEvaluacion.SQL.Add('AND CLASE_CC = :clase ');
  qryEvaluacion.SQL.Add('AND TIPO_VALOR_AR = ''N'' ');
  qryEvaluacion.SQL.Add('AND TIPO_AR = ''A'' ');
  qryEvaluacion.SQL.Add('ORDER BY NOMBRE_ALUMNO, AREA_CC ');


  kmtResultados.FieldDefs.Clear;
  kmtResultados.FieldDefs.Add('matricula', ftInteger, 0, False);
  kmtResultados.FieldDefs.Add('nombre', ftString, 150, False);
  kmtResultados.FieldDefs.Add('DP', ftString, 1, False); //Promociona
  kmtResultados.FieldDefs.Add('CN', ftString, 2, False);
  kmtResultados.FieldDefs.Add('CS', ftString, 2, False);
  kmtResultados.FieldDefs.Add('CMN', ftString, 2, False);
  kmtResultados.FieldDefs.Add('EA', ftString, 2, False);
  kmtResultados.FieldDefs.Add('EF', ftString, 2, False);
  kmtResultados.FieldDefs.Add('LCL', ftString, 2, False);
  kmtResultados.FieldDefs.Add('VLL', ftString, 2, False);
  kmtResultados.FieldDefs.Add('IN', ftString, 2, False);
  kmtResultados.FieldDefs.Add('M', ftString, 2, False);
  kmtResultados.FieldDefs.Add('REL', ftString, 2, False);
  kmtResultados.FieldDefs.Add('CV', ftString, 2, False);

  kmtResultados.IndexFieldNames:= 'matricula';
  kmtResultados.CreateTable;

end;

function TDMMain.AbrirBD( const ALogin: Boolean ): boolean;
begin
  Database.LoginPrompt:= ALogin;
  try
    Database.Connected:= True;
    qryCursos.Open;
    Result:= True;
  except
    on e:Exception do
    begin
      ShowMessage( e.Message + #13 + #10 + Database.Params.Text );
      Result:= False;
    end;
  end;
end;

procedure TDMMain.qryCursosAfterOpen(DataSet: TDataSet);
begin
  qryClases.Open;
  qryAlumnos.Open;
end;

procedure TDMMain.qryCursosBeforeClose(DataSet: TDataSet);
begin
  qryAlumnos.Close;
  qryClases.Close;
end;

procedure TDMMain.CerrarBD;
begin
  if Database.Connected then
  begin
    kmtResultados.Close;
    qryCursos.Close;
    Database.Connected:= False;
  end;
end;

procedure TDMMain.AbrirTemporal;
begin
  if kmtResultados.Active then
    kmtResultados.Close;
  kmtResultados.Open;
end;


procedure TDMMain.OrdenarTabla;
begin
  kmtResultados.SortFields:= 'nombre';
  kmtResultados.Sort([]);
end;


function  TDMMain.ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                        const ACurso,  AClase, ADirector, ATutor: string ): Boolean;
var
  bFlag: Boolean;
begin
  qryEvaluacion.ParamByName('curso').AsString:= ACurso;
  qryEvaluacion.ParamByName('clase').AsString:= AClase;
  qryEvaluacion.Open;
  try
    if not qryEvaluacion.IsEmpty then
    begin
      iEvalua:= AEvaluacion;
      sDesEvalua:= ADesEvalua;

      AbrirTemporal;
      MontarTabla;
      OrdenarTabla;
      if  AClase = '05' then
      begin
        bFlag:= EstaActivoCV( ACurso );
        if not bFlag then
          ActivarCV( ACurso );
        ImprimirActa2015ConCV ( AEvaluacion, AFecha, ACurso,  AClase, ADirector, ATutor );
        if not bFlag then
          DesActivarCV( ACurso );
      end
      else
       ImprimirActa2015( AEvaluacion, AFecha, ACurso,  AClase, ADirector, ATutor );
      result:= True;
    end
    else
    begin
      result:= False;
    end;
  finally
    qryEvaluacion.Close;
  end;
end;


procedure TDMMain.ImprimirActa2015( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string );
var
  QRActa2015: TQRActa2015;
begin
  QRActa2015:= TQRActa2015.Create( Self );
  try
    QRActa2015.iTrimestre:= AEvaluacion;
    QRActa2015.sClase:= DesCLase( AClase );
    QRActa2015.sAnyo:= DesCurso( ACurso );
    QRActa2015.qrlblTitulo1.Caption:= TituloActa( AClase, AEvaluacion );
    QRActa2015.qrlblTitulo2.Caption:= QRActa2015.qrlblTitulo1.Caption;
    QRActa2015.sDirector:= ADirector;
    QRActa2015.sTutor:= ATutor;
    QRActa2015.dFecha:= AFecha;

    QRActa2015.PreviewModal;
  finally
    FreeAndNil( QRActa2015 );
  end;
end;

procedure TDMMain.ImprimirActa2015ConCV( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string );
var
  QRActaConCV2015: TQRActaConCV2015;
begin
  QRActaConCV2015:= TQRActaConCV2015.Create( Self );
  try
    QRActaConCV2015.iTrimestre:= AEvaluacion;
    QRActaConCV2015.sClase:= DesCLase( AClase );
    QRActaConCV2015.sAnyo:= DesCurso( ACurso );
    QRActaConCV2015.qrlblTitulo1.Caption:= TituloActa( AClase, AEvaluacion );
    QRActaConCV2015.qrlblTitulo2.Caption:= QRActaConCV2015.qrlblTitulo1.Caption;
    QRActaConCV2015.sDirector:= ADirector;
    QRActaConCV2015.sTutor:= ATutor;
    QRActaConCV2015.dFecha:= AFecha;

    QRActaConCV2015.PreviewModal;
  finally
    FreeAndNil( QRActaConCV2015 );
  end;
end;


procedure TDMMain.PutEvaluacion;
begin
  if iEvalua = 1 then
    sCampoEvalua:= 'EVALUACION1_AN'
  else
  if iEvalua = 2 then
    sCampoEvalua:= 'EVALUACION2_AN'
  else
  if iEvalua = 3 then
    sCampoEvalua:= 'EVALUACION3_AN'
  else
  if iEvalua = 0 then
    sCampoEvalua:= 'EVALUACIONF_AN'
  else
    raise Exception.Create('Número de evaluación desconocida.');
end;

procedure TDMMain.MontarTabla;
begin
  PutEvaluacion;
  qryEvaluacion.First;
  while not qryEvaluacion.Eof do
  begin
    if ExisteAlumno then
      ModificaAlumno
    else
      AltaAlumno;
    qryEvaluacion.Next;
  end;
end;

function TDMMain.ExisteAlumno: Boolean;
begin
  sAlumno:= '[' + qryEvaluacion.fieldByName('N_MATRICULA_AN').AsString + '] ' +
            qryEvaluacion.fieldByName('NOMBRE_ALUMNO').AsString + #13 + #10;

  Result:= kmtResultados.Locate('matricula', qryEvaluacion.fieldByName('N_MATRICULA_AN').AsInteger, [] );
end;

procedure TDMMain.ModificaAlumno;
var
  sMateria, sNota: string;
begin
  sMateria:= GetMateria;
  sNota:= GetNota;

  kmtResultados.Edit;
  kmtResultados.FieldByName(sMateria).AsString:= sNota;
  kmtResultados.Post;
end;

procedure TDMMain.AltaAlumno;
var
  sMateria, sNota: string;
begin
  sMateria:= GetMateria;
  sNota:= GetNota;

  kmtResultados.Insert;
  kmtResultados.FieldByName('matricula').AsInteger:= qryEvaluacion.fieldByName('N_MATRICULA_AN').AsInteger;
  kmtResultados.FieldByName('nombre').AsString:= qryEvaluacion.fieldByName('NOMBRE_ALUMNO').AsString;
  if kmtResultados.FieldByName(sMateria).AsString <> '' then
  begin
    kmtResultados.Cancel;
    raise Exception.Create(sAlumno + 'No se pueden tener mas de dos notas para una asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString);
  end;
  kmtResultados.FieldByName(sMateria).AsString:= sNota;
  kmtResultados.Post;


end;

function TDMMain.GetMateria: string;
begin
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00010' then
    Result:= 'CMN' //Conocimiento del medio y naturales
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00015' then
    Result:= 'CN'  //Ciencias naturales
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00016' then
    Result:= 'CS'  //Ciencias sociales
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00020' then
    Result:= 'EA'  //Educacion artistica
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00030' then
    Result:= 'EF'  //Educacion fisica
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00040' then
    Result:= 'LCL' //lengua castellana y literatura
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00050' then
    Result:= 'VLL' //valenciano, lengua y literatura
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00060' then
    Result:= 'IN'  //Ingles
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00070' then
    Result:= 'M'   //
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00080' then
    Result:= 'REL'
  else
  if qryEvaluacion.fieldByName('AREA_CC').AsString = '00086' then
    Result:= 'CV'
  else
    raise Exception.Create(sAlumno + 'Asignatura desconocida "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString);
end;

function TDMMain.GetNota: string;
var
  rNota: Real;
begin
  if VarIsNull( qryEvaluacion.fieldByName(sCampoEvalua).Value ) then
  begin
    Result:= '';
    { TODO 1 -oPepe Brotons -cControl Errores : Controlar que no existan alumnos sin nota !}
    (*
    raise Exception.Create(sAlumno + 'Falta la nota para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString);
    *)
  end
  else
  begin
    rNota:=qryEvaluacion.fieldByName(sCampoEvalua).AsFloat;
    if rNota < 0 then
      raise Exception.Create(sAlumno +
                           'La nota no puede ser menos de 0 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    else
    if rNota > 10 then
      raise Exception.Create(sAlumno +
                           'La nota no puede ser mayor de 10 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    else
    if rNota < 5 then
      Result:= 'IN'
    else
    if rNota < 6 then
      Result:= 'SU'
    else
    if rNota < 7 then
      Result:= 'BI'
    else
    if rNota < 9 then
      Result:= 'NT'
    else
      Result:= 'SB';

  end;
end;

function TDMMain.NombreTutor( const ACodCurso, ACodClase: string ): string;
begin
  qryTutor.ParamByName('CURSO_CC').AsString:= ACodCurso;
  qryTutor.ParamByName('CLASE_CC').AsString:= ACodClase;
  qryTutor.Open;
  if not qryTutor.IsEmpty then
  begin
    Result:= qryTutor.FieldByName('tutor').AsString;
  end
  else
  begin
    Result:= '';
  end;
  qryTutor.Close;
end;

function TDMMain.DesCurso( const ACodCurso: string ): string;
begin
  qryCurso.ParamByName('CODIGO_CU').AsString:= ACodCurso;
  qryCurso.Open;
  if not qryCurso.IsEmpty then
  begin
    Result:= qryCurso.FieldByName('DESCRIPCION_CU').AsString;
  end
  else
  begin
    Result:= '';
  end;
  qryCurso.Close;
end;

function TDMMain.DesClase( const ACodClase: string ): string;
begin
  qryClase.ParamByName('codigo_cl').AsString:= ACodClase;
  qryClase.Open;
  if not qryClase.IsEmpty then
  begin
    Result:= qryClase.FieldByName('descripcion_cl').AsString;
  end
  else
  begin
    Result:= '';
  end;
  qryClase.Close;
end;

function TDMMain.TituloActa( const ACodClase: string; const AEvaluacion: integer ): string;
var
  sCas, sVal: string;
begin
  if AEvaluacion = 1 then
  begin
    sCas:= 'PRIMERA';
    sVal:= 'PRIMERA';
  end
  else
  if AEvaluacion = 2 then
  begin
    sCas:= 'SEGUNDA';
    sVal:= 'SEGONA';
  end
  else
  if AEvaluacion = 3 then
  begin
    sCas:= 'TERCERA';
    sVal:= 'TERCERA';
  end
  else
  if AEvaluacion = 0 then
  begin
    sCas:= 'FINAL';
    sVal:= 'FINAL';
  end
  else
  begin
    sCas:= '';
    sVal:= '';
  end;

  if ACodClase = '01' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL PRIMER CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL PRIMER CURSO'
  else
  if ACodClase = '02' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL SEGON CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL SEGUNDO CURSO'
  else
  if ACodClase = '03' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL TERCER CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL TERCER CURSO'
  else
  if ACodClase = '04' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL QUART CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL CUARTO CURSO'
  else
  if ACodClase = '05' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL QUINT CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL QUINTO CURSO'
  else
  if ACodClase = '06' then
    result:= 'ACTA D''AVALUACIÓ ' + sVal + ' DEL SEXT CURS  / ACTA DE EVALUACIÓN ' + sCas + ' DEL SEXTO CURSO';

end;

procedure TDMMain.ActivarCV( const ACurso: string );
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('insert into nof_clases_curso ');
  qryAux.SQL.Add('select first 1 curso_cc, clase_cc, tutor_cc, ''00086'', 0, ');
  qryAux.SQL.Add('       ( select max( serial_cc ) + 1 from nof_clases_curso ) ');
  qryAux.SQL.Add('from nof_clases_curso ');
  qryAux.SQL.Add('where curso_cc = :curso and clase_cc = ''05'' ');
  qryAux.ParamByName('curso').AsString:= ACurso;
  qryAux.ExecSQL;
end;

procedure TDMMain.DesActivarCV( const ACurso: string );
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('delete from nof_clases_curso where curso_cc = :curso and clase_cc = ''05'' and area_cc = ''00086'' ');
  qryAux.ParamByName('curso').AsString:= ACurso;
  qryAux.ExecSQL;
end;

function TDMMain.EstaActivoCV( const ACurso: string ): Boolean;
begin
  qryAux.SQL.Clear;
  qryAux.SQL.Add('select * ');
  qryAux.SQL.Add('from nof_clases_curso ');
  qryAux.SQL.Add('where curso_cc = :curso and clase_cc = ''05'' and area_cc = ''00086'' ');
  qryAux.ParamByName('curso').AsString:= ACurso;
  qryAux.Open;
  result:= not qryAux.IsEmpty;
  qryAux.Close;
end;

end.
