unit UDMActas;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMActas = class(TDataModule)
    qryEvaluacion: TQuery;
    dsEvaluacion: TDataSource;
    kmtResultados: TkbmMemTable;
    qryPromociona: TQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    bDecimales: boolean;
    iAlumnos, iPromocionan: Integer;
    iEvalua: integer;
    sCampoEvalua, sDesEvalua: string;
    sAlumno: string;

    procedure ImprimirActa2015ConCV( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string;
                               const AAlumnos, APromocionan: Integer );
    procedure ImprimirActa2015( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string;
                               const AAlumnos, APromocionan: Integer );

    procedure MontarTabla;
    function  ExisteAlumno: Boolean;
    procedure ModificaAlumno;
    procedure AltaAlumno;

    procedure AbrirTemporal;
    procedure OrdenarTabla;

    function  TituloActa( const ACodClase: string; const AEvaluacion: integer ): string;
    function  GetPromociona( const ACurso, AClase: string; const AMatricula: Integer ): string;

  public
    { Public declarations }

    function  ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                            const ACurso,  AClase, ADirector, ATutor: string ): Boolean;
  end;

function  ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                        const ACurso,  AClase, ADirector, ATutor: string ): Boolean;

var
  DMActas: TDMActas;

implementation

{$R *.dfm}

uses
  Forms, UMain, UCodigoComun, UDMMain, Acta2015QR, ActaConCV2015QR;

function  ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                        const ACurso,  AClase, ADirector, ATutor: string ): Boolean;
begin
  Application.CreateForm(TDMActas, DMActas);
  try
    Result:= DMActas.ImprimirActa( AEvaluacion, ADesEvalua, AFecha, ACurso,  AClase, ADirector, ATutor );
  finally
    FreeAndNil( DMActas );
  end;
end;

procedure TDMActas.DataModuleCreate(Sender: TObject);
begin
  qryEvaluacion.SQL.Clear;
  qryEvaluacion.SQL.Add('SELECT CURSO_CC, CLASE_CC, N_MATRICULA_AN, ');
  qryEvaluacion.SQL.Add('       TRIM(NVL(APELLIDO1_AD,'''')) || '' '' || TRIM(NVL(APELLIDO2_AD,'''')) || '', '' || TRIM(NVL(NOMBRE_AD,'''')) NOMBRE_ALUMNO, ');
  qryEvaluacion.SQL.Add('       AREA_CC, DESCRIPCION_AR, ');
  qryEvaluacion.SQL.Add('       nvl(EVALUACION1_AN,-1) EVALUACION1_AN, nvl(EVALUACION2_AN,-1) EVALUACION2_AN, ');
  qryEvaluacion.SQL.Add('       nvl(EVALUACION3_AN,-1) EVALUACION3_AN, nvl(EVALUACIONF_AN,-1) EVALUACIONF_AN, PROMOCIONA_AN ');
  qryEvaluacion.SQL.Add('FROM NOF_CLASES_CURSO ');
  qryEvaluacion.SQL.Add('     JOIN NOF_AREAS ON AREA_CC = CODIGO_AR ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_NOTAS ON CURSO_AN = CURSO_CC AND CLASE_AN = CLASE_CC AND AREA_AN = AREA_CC ');
  qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_DATOS ON N_MATRICULA_AN = N_MATRICULA_AD ');
  //qryEvaluacion.SQL.Add('     JOIN NOF_ALUMNO_MAT ON CURSO_AN = CURSO_AT AND CLASE_AN = CLASE_AT and N_MATRICULA_AN = N_MATRICULA_AT ');
  qryEvaluacion.SQL.Add('WHERE CURSO_CC = :curso ');
  qryEvaluacion.SQL.Add('AND CLASE_CC = :clase ');
  qryEvaluacion.SQL.Add('AND TIPO_VALOR_AR = ''N'' ');
  qryEvaluacion.SQL.Add('AND TIPO_AR = ''A'' ');
  qryEvaluacion.SQL.Add('ORDER BY NOMBRE_ALUMNO, AREA_CC ');

  qryPromociona.SQL.Clear;
  qryPromociona.SQL.Add(' SELECT promociona_at ');
  qryPromociona.SQL.Add(' FROM NOF_ALUMNO_MAT ');
  qryPromociona.SQL.Add(' WHERE CURSO_AT = :curso ');
  qryPromociona.SQL.Add(' AND CLASE_AT = :clase ');
  qryPromociona.SQL.Add(' AND N_MATRICULA_AT = :matricula ');

  kmtResultados.FieldDefs.Clear;
  kmtResultados.FieldDefs.Add('matricula', ftInteger, 0, False);
  kmtResultados.FieldDefs.Add('nombre', ftString, 150, False);
  kmtResultados.FieldDefs.Add('clase', ftString, 2, False);
  kmtResultados.FieldDefs.Add('curso', ftString, 2, False);
  kmtResultados.FieldDefs.Add('activo',ftInteger, 0, False);
  kmtResultados.FieldDefs.Add('DP', ftString, 10, False); //Promociona
  kmtResultados.FieldDefs.Add('CN', ftString, 10, False);
  kmtResultados.FieldDefs.Add('CS', ftString, 10, False);
  kmtResultados.FieldDefs.Add('CMN', ftString, 10, False);
  kmtResultados.FieldDefs.Add('EA', ftString, 10, False);
  kmtResultados.FieldDefs.Add('EF', ftString, 10, False);
  kmtResultados.FieldDefs.Add('LCL', ftString, 10, False);
  kmtResultados.FieldDefs.Add('VLL', ftString, 10, False);
  kmtResultados.FieldDefs.Add('IN', ftString, 10, False);
  kmtResultados.FieldDefs.Add('M', ftString, 10, False);
  kmtResultados.FieldDefs.Add('REL', ftString, 10, False);
  kmtResultados.FieldDefs.Add('CV', ftString, 10, False);

  kmtResultados.IndexFieldNames:= 'matricula';
  kmtResultados.CreateTable;
end;

function  TDMActas.ImprimirActa( const AEvaluacion: Integer; const ADesEvalua: string; const AFecha: TDateTime;
                        const ACurso,  AClase, ADirector, ATutor: string ): Boolean;
var
  bFlag: Boolean;
begin
  bDecimales:= AEvaluacion <> 0;
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
        bFlag:= DMMain.EstaActivoCV( ACurso );
        if not bFlag then
          DMMain.ActivarCV( ACurso );
        ImprimirActa2015ConCV ( AEvaluacion, AFecha, ACurso,  AClase, ADirector, ATutor, iAlumnos, iPromocionan );
        if not bFlag then
          DMMain.DesActivarCV( ACurso );
      end
      else
       ImprimirActa2015( AEvaluacion, AFecha, ACurso,  AClase, ADirector, ATutor, iAlumnos, iPromocionan );
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


procedure TDMActas.ImprimirActa2015( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string;
                               const AAlumnos, APromocionan: Integer );
var
  QRActa2015: TQRActa2015;
begin
  QRActa2015:= TQRActa2015.Create( Self );
  try
    QRActa2015.iTrimestre:= AEvaluacion;
    QRActa2015.iAlumnos:= AAlumnos;
    QRActa2015.iPromocionan:= APromocionan;
    QRActa2015.sClase:= DMMain.DesCLase( AClase );
    QRActa2015.sAnyo:= DMMain.DesCurso( ACurso );
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

procedure TDMActas.ImprimirActa2015ConCV( const AEvaluacion: Integer; const AFecha: TDateTime;
                               const ACurso,  AClase, ADirector, ATutor: string;
                               const AAlumnos, APromocionan: Integer );
var
  QRActaConCV2015: TQRActaConCV2015;
begin
  QRActaConCV2015:= TQRActaConCV2015.Create( Self );
  try
    QRActaConCV2015.iTrimestre:= AEvaluacion;
    QRActaConCV2015.iAlumnos:= AAlumnos;
    QRActaConCV2015.iPromocionan:= APromocionan;
    QRActaConCV2015.sClase:= DMMain.DesCLase( AClase );
    QRActaConCV2015.sAnyo:= DMMain.DesCurso( ACurso );
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

procedure TDMActas.MontarTabla;
begin
  iAlumnos:= 0;
  iPromocionan:= 0;
  
  sCampoEvalua:= StrEvaluacion( iEvalua ) ;
  qryEvaluacion.First;
  while not qryEvaluacion.Eof do
  begin
    if ExisteAlumno then
      ModificaAlumno
    else
      AltaAlumno;
    qryEvaluacion.Next;
  end;
  kmtResultados.First;
  while not kmtResultados.Eof do
  begin
    if kmtResultados.FieldByName('activo').AsInteger = 0 then
      kmtResultados.Delete
    else
      kmtResultados.Next;
  end;
  kmtResultados.First;
end;

function TDMActas.ExisteAlumno: Boolean;
begin
  sAlumno:= '[' + qryEvaluacion.fieldByName('N_MATRICULA_AN').AsString + '] ' +
            qryEvaluacion.fieldByName('NOMBRE_ALUMNO').AsString + #13 + #10;

  Result:= kmtResultados.Locate('matricula', qryEvaluacion.fieldByName('N_MATRICULA_AN').AsInteger, [] );
end;

procedure TDMActas.ModificaAlumno;
var
  sMateria, sNota: string;
begin
  sMateria:= GetMateria( qryEvaluacion.fieldByName('AREA_CC').AsString, qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString );

  sNota:= GetNota( qryEvaluacion.fieldByName(sCampoEvalua).AsFloat );

  if bDecimales then
  begin
    if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat > -1 then
      sNota:= Trim( sNota + ':' + qryEvaluacion.fieldByName(sCampoEvalua).AsString );
  end
  else
  begin
    if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat > -1 then
      sNota:= Trim( sNota + ':' +  IntToStr( Trunc( qryEvaluacion.fieldByName(sCampoEvalua).AsFloat ) ) );
  end;

  kmtResultados.Edit;
  if kmtResultados.FieldByName('activo').AsInteger = 0 then
  begin
    if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat >= 0 then
      kmtResultados.FieldByName('activo').AsInteger:= 1;
  end;
  kmtResultados.FieldByName(sMateria).AsString:= sNota;
  kmtResultados.Post;
end;

function TDMActas.GetPromociona( const ACurso, AClase: string; const AMatricula: Integer ): string;
begin
  qryPromociona.ParamByName('curso').AsString:= ACurso;
  qryPromociona.ParamByName('clase').AsString:= AClase;
  qryPromociona.ParamByName('matricula').AsInteger:= AMatricula;
  qryPromociona.Open;
  if  qryPromociona.FieldByName('promociona_at').AsString = 'N' then
    Result:= 'N'
  else
    Result:= 'S';
  qryPromociona.Close;
end;

procedure TDMActas.AltaAlumno;
var
  sMateria, sNota: string;
begin
  sMateria:= GetMateria( qryEvaluacion.fieldByName('AREA_CC').AsString, qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString );
  sNota:= GetNota( qryEvaluacion.fieldByName(sCampoEvalua).AsFloat );
  if bDecimales then
  begin
    if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat > -1 then
      sNota:= Trim( sNota + ':' + qryEvaluacion.fieldByName(sCampoEvalua).AsString );
  end
  else
  begin
    if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat > -1 then
      sNota:= Trim( sNota + ':' +  IntToStr( Trunc( qryEvaluacion.fieldByName(sCampoEvalua).AsFloat ) ) );
  end;  

  kmtResultados.Insert;
  kmtResultados.FieldByName('matricula').AsInteger:= qryEvaluacion.fieldByName('N_MATRICULA_AN').AsInteger;
  kmtResultados.FieldByName('nombre').AsString:= qryEvaluacion.fieldByName('NOMBRE_ALUMNO').AsString;
  if qryEvaluacion.fieldByName(sCampoEvalua).AsFloat < 0 then
    kmtResultados.FieldByName('activo').AsInteger:= 0
  else
    kmtResultados.FieldByName('activo').AsInteger:= 1;

  iAlumnos:= iAlumnos  + 1;
  if iEvalua = 0 then
  begin
    //Evaluacion final
    if GetPromociona( qryEvaluacion.fieldByName('CURSO_CC').AsString,
                                 qryEvaluacion.fieldByName('CLASE_CC').AsString,
                                 qryEvaluacion.fieldByName('N_MATRICULA_AN').AsInteger ) = 'N' then
      kmtResultados.FieldByName('DP').AsString:= 'NP' //No promociona
    else
    begin
      kmtResultados.FieldByName('DP').AsString:= 'P'; //Promociona
      iPromocionan:= iPromocionan + 1;
    end;
  end
  else
  begin
    kmtResultados.FieldByName('DP').AsString:= '';
  end;


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

procedure TDMActas.AbrirTemporal;
begin
  if kmtResultados.Active then
    kmtResultados.Close;
  kmtResultados.Open;
end;


procedure TDMActas.OrdenarTabla;
begin
  kmtResultados.SortFields:= 'nombre';
  kmtResultados.Sort([]);
end;

function TDMActas.TituloActa( const ACodClase: string; const AEvaluacion: integer ): string;
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

end.
