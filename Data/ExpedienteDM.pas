unit ExpedienteDM;

interface

uses
  SysUtils, Classes, DB, DBTables, QuickRpt, kbmMemTable;

type
  TDMExpediente = class(TDataModule)
    qryDatosAlumno: TQuery;
    qryCursos: TQuery;
    kmtCursos: TkbmMemTable;
    kmtResultados: TkbmMemTable;
    qryNotas: TQuery;
    kmtPrimero: TkbmMemTable;
    kmtSegundo: TkbmMemTable;
    kmtTercero: TkbmMemTable;
    kmtCuarto: TkbmMemTable;
    kmtQuinto: TkbmMemTable;
    kmtSexto: TkbmMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    sALumno: string;
    bC1, bC2, bC3, bC4, bC5, bC6: boolean;
    procedure MakeTablaNotas( var ATabla: TkbmMemTable );
    procedure TablaCursos( const AInfantil: Boolean );
    procedure CompletaCursos( const APrimaria, AInfantil: integer );
    procedure NotasCursos;
    procedure RellenaTablaNotas;


  public
    { Public declarations }
    procedure CerrarDatos;
    function  DatosExpediente( const AAlumno: string ): Boolean;
    function  DesCursoClase( const AAlumno, Clase: string ): string;

    function  IsPrimero: Boolean;
    function  IsSegundo: Boolean;
    function  IsTercero: Boolean;
    function  IsCuarto: Boolean;
    function  IsQuinto: Boolean;
    function  IsSexto: Boolean;
  end;


var
  DMExpediente: TDMExpediente;


implementation

{$R *.dfm}

uses
  UDMMain, Variants, UCodigoComun;


procedure TDMExpediente.DataModuleCreate(Sender: TObject);
begin
  qryDatosAlumno.sql.Clear;
  qryDatosAlumno.sql.Add(' select n_matricula_ad, libro_escolaridad_ad, ');
  qryDatosAlumno.sql.Add('        nombre_Ad, apellido1_ad, apellido2_ad, ');
  qryDatosAlumno.sql.Add('        sexo_ad, fecha_nac_ad, lugar_nac_ad, pais_nac_ad, ');
  qryDatosAlumno.sql.Add('        NOF_PAISES.descripcion_p nom_pais, oper1_es_masculino_af, ');
  qryDatosAlumno.sql.Add('        Trim( nvl(nombre_ope_af,'''') ) || '' '' || Trim( nvl(apellido1_ope_af,'''') ) || '' '' || Trim( nvl(apellido2_ope_af,'''') ) tutor1, ');
  qryDatosAlumno.sql.Add('        Trim( nvl(nombre_cony_af,'''') ) || '' '' || Trim( nvl(apellido1_cony_af,'''' ) ) || '' '' || Trim( nvl(apellido2_cony_af,'''') ) tutor2, ');
  qryDatosAlumno.sql.Add('        domicilio_ad domicilio, cp_ad cod_postal, localidad_ad localidad, NOF_PROVINCIAS.descripcion_p provincia, ');
  qryDatosAlumno.sql.Add('        telefono1_ad telefono, telefono2_ad telefono_tutor1, telefono3_ad telefono_tutor2, ');

  qryDatosAlumno.sql.Add('        ( select min(fec_ini_mat_cu)  ');
  qryDatosAlumno.sql.Add('          from nof_cursos ');
  qryDatosAlumno.sql.Add('          where codigo_cu = ( select min(curso_at) ');
  qryDatosAlumno.sql.Add('                              from nof_alumno_mat ');
  qryDatosAlumno.sql.Add('                              where n_matricula_at = N_MATRICULA_AD ');
  qryDatosAlumno.sql.Add('                                and clase_at = ''01'' )  ) fecha_inicio_primaria, ');

  qryDatosAlumno.sql.Add('        ( select min(fec_ini_mat_cu)  ');
  qryDatosAlumno.sql.Add('          from nof_cursos ');
  qryDatosAlumno.sql.Add('          where codigo_cu = ( select min(curso_at) ');
  qryDatosAlumno.sql.Add('                              from nof_alumno_mat ');
  qryDatosAlumno.sql.Add('                              where n_matricula_at = N_MATRICULA_AD )  ) fecha_alta_ad, ');

  qryDatosAlumno.sql.Add('        * ');
  qryDatosAlumno.sql.Add(' FROM NOF_ALUMNO_DATOS ');
  qryDatosAlumno.sql.Add('      LEFT JOIN NOF_PAISES ON PAIS_P = PAIS_NAC_AD ');
  qryDatosAlumno.sql.Add('      LEFT JOIN NOF_PROVINCIAS ON PROVINCIA_P = SUBSTR(CP_AD,1,2) ');
  qryDatosAlumno.sql.Add('      LEFT JOIN NOF_ALUMNO_FAM ON NIF_OPE_AD = NIF_OPE_AF ');
  qryDatosAlumno.sql.Add(' WHERE N_MATRICULA_AD = :matricula ');

  qryCursos.SQL.Clear;
  qryCursos.sql.Add(' select n_matricula_at, curso_at, clase_at, descripcion_cl, descripcion_cu, promociona_at, fec_ini_mat_cu, fec_fin_mat_cu, nombre_tt ');
  qryCursos.sql.Add('  from nof_alumno_mat ');
  qryCursos.sql.Add('       join nof_cursos on codigo_cu = curso_at ');
  qryCursos.sql.Add('       join nof_clases on codigo_cl = clase_at ');
  qryCursos.sql.Add('       left join nof_tutor_clases on clase_tc = clase_at and curso_tc = curso_at ');
  qryCursos.sql.Add('       left join nof_tutor on codigo_tt = tutor_tc ');
  qryCursos.sql.Add('  where n_matricula_at = :matricula ');
  qryCursos.sql.Add('  and ( clase_at = ''09'' or clase_at= ''08'' or clase_at= ''07'' or ');
  qryCursos.sql.Add('        clase_at = ''06'' or clase_at= ''05'' or clase_at= ''04'' or ');
  qryCursos.sql.Add('        clase_at = ''03'' or clase_at= ''02'' or clase_at= ''01'' ) ');
  qryCursos.sql.Add('  order by 1,2,3 ');

  qryNotas.SQL.Clear;
  qryNotas.sql.Add(' select ');
  qryNotas.sql.Add('   area_an, descripcion_ar, nvl( evaluacionf_an,-1) EVALUACIONF_AN, promociona_an, ');
  qryNotas.sql.Add('   nvl( evaluacion1_an,-1) EVALUACION1_AN, nvl( evaluacion2_an,-1) EVALUACION2_AN, nvl( evaluacion3_an,-1) EVALUACION3_AN ');
  qryNotas.sql.Add(' from nof_alumno_notas ');
  qryNotas.sql.Add('      join nof_areas on codigo_ar = area_an ');
  qryNotas.sql.Add(' where n_matricula_an = :matricula ');
  qryNotas.sql.Add(' and clase_an = :clase ');
  qryNotas.sql.Add(' and curso_an = :curso ');
  qryNotas.sql.Add(' and tipo_ar = ''A'' ');
  qryNotas.sql.Add(' and tipo_valor_ar = ''N'' ');

  kmtCursos.FieldDefs.Clear;
  kmtCursos.FieldDefs.Add('matricula', ftInteger, 0, False);
  kmtCursos.FieldDefs.Add('cod_clase', ftString, 2, False);
  kmtCursos.FieldDefs.Add('cod_curso', ftString, 2, False);
  kmtCursos.FieldDefs.Add('des_clase', ftString, 30, False);
  kmtCursos.FieldDefs.Add('des_curso', ftString, 30, False);
  kmtCursos.FieldDefs.Add('etapa', ftString, 15, False);
  kmtCursos.FieldDefs.Add('primaria', ftInteger, 0, False);
  kmtCursos.FieldDefs.Add('promociona', ftString, 1, False);
  kmtCursos.FieldDefs.Add('cod_centro', ftString, 10, False);
  kmtCursos.FieldDefs.Add('des_centro', ftString, 50, False);
  kmtCursos.FieldDefs.Add('localidad_centro', ftString, 50, False);
  kmtCursos.FieldDefs.Add('provincia_centro', ftString, 50, False);
  kmtCursos.FieldDefs.Add('imprimir', ftString, 1, False);
  kmtCursos.IndexFieldNames:= 'matricula;cod_clase;cod_curso';
  kmtCursos.CreateTable;

  MakeTablaNotas( kmtResultados );
  MakeTablaNotas( kmtPrimero );
  MakeTablaNotas( kmtSegundo );
  MakeTablaNotas( kmtTercero );
  MakeTablaNotas( kmtCuarto );
  MakeTablaNotas( kmtQuinto );
  MakeTablaNotas( kmtSexto );

end;


procedure TDMExpediente.MakeTablaNotas( var ATabla: TkbmMemTable );
begin
  ATabla.FieldDefs.Clear;
  ATabla.FieldDefs.Add('matricula', ftInteger, 0, False);
  ATabla.FieldDefs.Add('clase', ftString, 2, False);
  ATabla.FieldDefs.Add('curso', ftString, 2, False);
  ATabla.FieldDefs.Add('DP', ftFloat, 0, False); //Promociona
  ATabla.FieldDefs.Add('CN', ftFloat, 0, False);
  ATabla.FieldDefs.Add('CS', ftFloat, 0, False);
  ATabla.FieldDefs.Add('CMN', ftFloat, 0, False);
  ATabla.FieldDefs.Add('EA', ftFloat, 0, False);
  ATabla.FieldDefs.Add('EF', ftFloat, 0, False);
  ATabla.FieldDefs.Add('LCL', ftFloat, 0, False);
  ATabla.FieldDefs.Add('VLL', ftFloat, 0, False);
  ATabla.FieldDefs.Add('IN', ftFloat, 0, False);
  ATabla.FieldDefs.Add('M', ftFloat, 0, False);
  ATabla.FieldDefs.Add('REL', ftFloat, 0, False);
  ATabla.FieldDefs.Add('CV', ftFloat, 0, False);
  ATabla.FieldDefs.Add('EPC', ftFloat, 0, False);

  ATabla.FieldDefs.Add('sDP', ftString, 2, False); //Promociona

  //texto en español
  ATabla.FieldDefs.Add('seCN', ftString, 20, False);
  ATabla.FieldDefs.Add('seCS', ftString, 20, False);
  ATabla.FieldDefs.Add('seCMN', ftString, 20, False);
  ATabla.FieldDefs.Add('seEA', ftString, 20, False);
  ATabla.FieldDefs.Add('seEF', ftString, 20, False);
  ATabla.FieldDefs.Add('seLCL', ftString, 20, False);
  ATabla.FieldDefs.Add('seVLL', ftString, 20, False);
  ATabla.FieldDefs.Add('seIN', ftString, 20, False);
  ATabla.FieldDefs.Add('seM', ftString, 20, False);
  ATabla.FieldDefs.Add('seREL', ftString, 20, False);
  ATabla.FieldDefs.Add('seCV', ftString, 20, False);
  ATabla.FieldDefs.Add('seEPC', ftString, 20, False);

 //texto en valenciano
  ATabla.FieldDefs.Add('svCN', ftString, 20, False);
  ATabla.FieldDefs.Add('svCS', ftString, 20, False);
  ATabla.FieldDefs.Add('svCMN', ftString, 20, False);
  ATabla.FieldDefs.Add('svEA', ftString, 20, False);
  ATabla.FieldDefs.Add('svEF', ftString, 20, False);
  ATabla.FieldDefs.Add('svLCL', ftString, 20, False);
  ATabla.FieldDefs.Add('svVLL', ftString, 20, False);
  ATabla.FieldDefs.Add('svIN', ftString, 20, False);
  ATabla.FieldDefs.Add('svM', ftString, 20, False);
  ATabla.FieldDefs.Add('svREL', ftString, 20, False);
  ATabla.FieldDefs.Add('svCV', ftString, 20, False);
  ATabla.FieldDefs.Add('svEPC', ftString, 20, False);
  ATabla.IndexFieldNames:= 'matricula;clase;curso';
  ATabla.CreateTable;
end;

procedure TDMExpediente.CerrarDatos;
begin
  qryDatosAlumno.Close;
  kmtCursos.Close;
  kmtResultados.Close;

  kmtPrimero.Close;
  kmtSegundo.Close;
  kmtTercero.Close;
  kmtCuarto.Close;
  kmtQuinto.Close;
  kmtSexto.Close;
end;

function  TDMExpediente.DatosExpediente( const AAlumno: string ): Boolean;
begin
  sALumno:= AAlumno;
  if qryDatosAlumno.Active then
    CerrarDatos;

  qryDatosAlumno.ParamByName('matricula').AsString:= AAlumno;
  qryDatosAlumno.Open;
  if not qryDatosAlumno.IsEmpty then
  begin
    TablaCursos( True );
    NotasCursos;
    RellenaTablaNotas;
    result:= True;
  end
  else
  begin
    result:= False;
  end;
end;

procedure TDMExpediente.RellenaTablaNotas;
var
  kmtAux: TkbmMemTable;
begin
  kmtResultados.First;
  while not kmtResultados.Eof do
  begin
    kmtAux:= nil;

    if kmtResultados.FieldByName('clase').AsString = '01' then
      kmtAux:= kmtPrimero;
    if kmtResultados.FieldByName('clase').AsString = '02' then
      kmtAux:= kmtSegundo;
    if kmtResultados.FieldByName('clase').AsString = '03' then
      kmtAux:= kmtTercero;
    if kmtResultados.FieldByName('clase').AsString = '04' then
      kmtAux:= kmtCuarto;
    if kmtResultados.FieldByName('clase').AsString = '05' then
      kmtAux:= kmtQuinto;
    if kmtResultados.FieldByName('clase').AsString = '06' then
      kmtAux:= kmtSexto;

    if kmtAux <> nil then
    begin
      kmtAux.Open;
      kmtAux.Insert;
      kmtAux.FieldByName('matricula').AsString:= kmtResultados.FieldByName('matricula').AsString;
      kmtAux.FieldByName('clase').AsString:= kmtResultados.FieldByName('clase').AsString;
      kmtAux.FieldByName('curso').AsString:= kmtResultados.FieldByName('curso').AsString;
      kmtAux.FieldByName('DP').AsFloat:= kmtResultados.FieldByName('DP').AsFloat;
      kmtAux.FieldByName('CN').AsFloat:= kmtResultados.FieldByName('CN').AsFloat;
      kmtAux.FieldByName('CS').AsFloat:= kmtResultados.FieldByName('CS').AsFloat;
      kmtAux.FieldByName('CMN').AsFloat:= kmtResultados.FieldByName('CMN').AsFloat;
      kmtAux.FieldByName('EA').AsFloat:= kmtResultados.FieldByName('EA').AsFloat;
      kmtAux.FieldByName('EF').AsFloat:= kmtResultados.FieldByName('EF').AsFloat;
      kmtAux.FieldByName('LCL').AsFloat:= kmtResultados.FieldByName('LCL').AsFloat;
      kmtAux.FieldByName('VLL').AsFloat:= kmtResultados.FieldByName('VLL').AsFloat;
      kmtAux.FieldByName('IN').AsFloat:= kmtResultados.FieldByName('IN').AsFloat;
      kmtAux.FieldByName('M').AsFloat:= kmtResultados.FieldByName('M').AsFloat;
      kmtAux.FieldByName('REL').AsFloat:= kmtResultados.FieldByName('REL').AsFloat;
      kmtAux.FieldByName('CV').AsFloat:= kmtResultados.FieldByName('CV').AsFloat;
      kmtAux.FieldByName('EPC').AsFloat:= kmtResultados.FieldByName('EPC').AsFloat;

      kmtAux.FieldByName('sDP').AsString:= kmtResultados.FieldByName('sDP').AsString;
      kmtAux.FieldByName('seCN').AsString:= kmtResultados.FieldByName('seCN').AsString;
      kmtAux.FieldByName('seCS').AsString:= kmtResultados.FieldByName('seCS').AsString;
      kmtAux.FieldByName('seCMN').AsString:= kmtResultados.FieldByName('seCMN').AsString;
      kmtAux.FieldByName('seEA').AsString:= kmtResultados.FieldByName('seEA').AsString;
      kmtAux.FieldByName('seEF').AsString:= kmtResultados.FieldByName('seEF').AsString;
      kmtAux.FieldByName('seLCL').AsString:= kmtResultados.FieldByName('seLCL').AsString;
      kmtAux.FieldByName('seVLL').AsString:= kmtResultados.FieldByName('seVLL').AsString;
      kmtAux.FieldByName('seIN').AsString:= kmtResultados.FieldByName('seIN').AsString;
      kmtAux.FieldByName('seM').AsString:= kmtResultados.FieldByName('seM').AsString;
      kmtAux.FieldByName('seREL').AsString:= kmtResultados.FieldByName('seREL').AsString;
      kmtAux.FieldByName('seCV').AsString:= kmtResultados.FieldByName('seCV').AsString;
      kmtAux.FieldByName('seEPC').AsString:= kmtResultados.FieldByName('seEPC').AsString;

      kmtAux.FieldByName('sDP').AsString:= kmtResultados.FieldByName('sDP').AsString;
      kmtAux.FieldByName('svCN').AsString:= kmtResultados.FieldByName('svCN').AsString;
      kmtAux.FieldByName('svCS').AsString:= kmtResultados.FieldByName('svCS').AsString;
      kmtAux.FieldByName('svCMN').AsString:= kmtResultados.FieldByName('svCMN').AsString;
      kmtAux.FieldByName('svEA').AsString:= kmtResultados.FieldByName('svEA').AsString;
      kmtAux.FieldByName('svEF').AsString:= kmtResultados.FieldByName('svEF').AsString;
      kmtAux.FieldByName('svLCL').AsString:= kmtResultados.FieldByName('svLCL').AsString;
      kmtAux.FieldByName('svVLL').AsString:= kmtResultados.FieldByName('svVLL').AsString;
      kmtAux.FieldByName('svIN').AsString:= kmtResultados.FieldByName('svIN').AsString;
      kmtAux.FieldByName('svM').AsString:= kmtResultados.FieldByName('svM').AsString;
      kmtAux.FieldByName('svREL').AsString:= kmtResultados.FieldByName('svREL').AsString;
      kmtAux.FieldByName('svCV').AsString:= kmtResultados.FieldByName('svCV').AsString;
      kmtAux.FieldByName('svEPC').AsString:= kmtResultados.FieldByName('svEPC').AsString;
      kmtAux.Post;
    end;

    kmtResultados.Next;
  end;
  kmtResultados.First;
end;

procedure TDMExpediente.NotasCursos;
var
  sMateria, sNota, sSpain, sValenciano: string;
  rNota: Real;
begin
  bC1:= False;
  bC2:= False;
  bC3:= False;
  bC4:= False;
  bC5:= False;
  bC6:= False;

  kmtCursos.First;
  kmtResultados.Open;
  while not kmtCursos.Eof do
  begin
    if ( kmtCursos.FieldByName('primaria').AsInteger = 1 ) and
       ( kmtCursos.FieldByName('promociona').AsString = 'S' ) and
       ( kmtCursos.FieldByName('imprimir').AsString = 'S' ) then
    begin
      qryNotas.ParamByName('matricula').AsString:= kmtCursos.FieldByName('matricula').AsString;
      qryNotas.ParamByName('clase').AsString:= kmtCursos.FieldByName('cod_clase').AsString;
      qryNotas.ParamByName('curso').AsString:= kmtCursos.FieldByName('cod_curso').AsString;
      qryNotas.Open;

      if not qryNotas.IsEmpty then
      begin
        kmtResultados.Insert;

        kmtResultados.FieldByName('matricula').AsString:= kmtCursos.FieldByName('matricula').AsString;
        kmtResultados.FieldByName('clase').AsString:= kmtCursos.FieldByName('cod_clase').AsString;
        kmtResultados.FieldByName('curso').AsString:= kmtCursos.FieldByName('cod_curso').AsString;
        kmtResultados.FieldByName('DP').AsFloat:= -1;
        kmtResultados.FieldByName('CN').AsFloat:= -1;
        kmtResultados.FieldByName('CS').AsFloat:= -1;
        kmtResultados.FieldByName('CMN').AsFloat:= -1;
        kmtResultados.FieldByName('EA').AsFloat:= -1;
        kmtResultados.FieldByName('EF').AsFloat:= -1;
        kmtResultados.FieldByName('LCL').AsFloat:= -1;
        kmtResultados.FieldByName('VLL').AsFloat:= -1;
        kmtResultados.FieldByName('IN').AsFloat:= -1;
        kmtResultados.FieldByName('M').AsFloat:= -1;
        kmtResultados.FieldByName('REL').AsFloat:= -1;
        kmtResultados.FieldByName('CV').AsFloat:= -1;
        kmtResultados.FieldByName('EPC').AsFloat:= -1;

        kmtResultados.FieldByName('sDP').AsString:= '';
        kmtResultados.FieldByName('seCN').AsString:= '';
        kmtResultados.FieldByName('seCS').AsString:= '';
        kmtResultados.FieldByName('seCMN').AsString:= '';
        kmtResultados.FieldByName('seEA').AsString:= '';
        kmtResultados.FieldByName('seEF').AsString:= '';
        kmtResultados.FieldByName('seLCL').AsString:= '';
        kmtResultados.FieldByName('seVLL').AsString:= '';
        kmtResultados.FieldByName('seIN').AsString:= '';
        kmtResultados.FieldByName('seM').AsString:= '';
        kmtResultados.FieldByName('seREL').AsString:= '';
        kmtResultados.FieldByName('seCV').AsString:= '';
        kmtResultados.FieldByName('seEPC').AsString:= '';

        kmtResultados.FieldByName('sDP').AsString:= '';
        kmtResultados.FieldByName('svCN').AsString:= '';
        kmtResultados.FieldByName('svCS').AsString:= '';
        kmtResultados.FieldByName('svCMN').AsString:= '';
        kmtResultados.FieldByName('svEA').AsString:= '';
        kmtResultados.FieldByName('svEF').AsString:= '';
        kmtResultados.FieldByName('svLCL').AsString:= '';
        kmtResultados.FieldByName('svVLL').AsString:= '';
        kmtResultados.FieldByName('svIN').AsString:= '';
        kmtResultados.FieldByName('svM').AsString:= '';
        kmtResultados.FieldByName('svREL').AsString:= '';
        kmtResultados.FieldByName('svCV').AsString:= '';
        kmtResultados.FieldByName('svEPC').AsString:= '';

        while not qryNotas.Eof do
        begin
          sMateria:= GetMateria( qryNotas.fieldByName('area_an').AsString, qryNotas.fieldByName('descripcion_ar').AsString );
          //if qryNotas.fieldByName('evaluacionf_an').AsFloat <> -1 then
          begin
            rNota:= Trunc( qryNotas.fieldByName('evaluacionf_an').AsFloat );
            sNota:= GetNotaEx( qryNotas.fieldByName('evaluacionf_an').AsFloat, sSpain, sValenciano )
          end;
          (*
          else
          begin
            sNota:= GetMedia( qryNotas.fieldByName('evaluacion1_an').AsFloat,
                          qryNotas.fieldByName('evaluacion2_an').AsFloat,
                          qryNotas.fieldByName('evaluacion3_an').AsFloat, rNota );
          end;
          *)
          kmtResultados.FieldByName(sMateria).AsFloat:= rNota;
          kmtResultados.FieldByName('se'+sMateria).AsString:= sSpain;
          kmtResultados.FieldByName('sv'+sMateria).AsString:= sValenciano;
          qryNotas.Next;
        //promociona_an;
        end;
        kmtResultados.Post;

        if kmtCursos.fieldByName('cod_clase').AsString = '01' then
          bC1:= True;
        if kmtCursos.fieldByName('cod_clase').AsString = '02' then
          bC2:= True;
        if kmtCursos.fieldByName('cod_clase').AsString = '03' then
          bC3:= True;
        if kmtCursos.fieldByName('cod_clase').AsString = '04' then
          bC4:= True;
        if kmtCursos.fieldByName('cod_clase').AsString = '05' then
          bC5:= True;
        if kmtCursos.fieldByName('cod_clase').AsString = '06' then
          bC6:= True;
      end
      else
      begin
        kmtCursos.Edit;
        kmtCursos.FieldByName('imprimir').AsString:= 'N';
        kmtCursos.Post;
      end;
      kmtCursos.Next;
      qryNotas.Close;
    end
    else
    begin
      kmtCursos.Next;
    end;
  end;
  kmtCursos.First;
end;

function NumEtapa( const ACodClase: string ): string;
begin
  if ACodClase = '01' then Result:= '1º Primaria'
  else if ACodClase = '02' then Result:= '2º Primaria'
  else if ACodClase = '03' then Result:= '3º Primaria'
  else if ACodClase = '04' then Result:= '4º Primaria'
  else if ACodClase = '05' then Result:= '5º Primaria'
  else if ACodClase = '06' then Result:= '6º Primaria'
  else if ACodClase = '07' then Result:= 'Inf. 3 Años'
  else if ACodClase = '08' then Result:= 'Inf. 4 Años'
  else if ACodClase = '09' then Result:= 'Inf. 5 Años'  ;
end;

function EsPrimaria( const ACodClase: string ): Integer;
begin
  if ACodClase = '01' then Result:= 1
  else if ACodClase = '02' then Result:= 1
  else if ACodClase = '03' then Result:= 1
  else if ACodClase = '04' then Result:= 1
  else if ACodClase = '05' then Result:= 1
  else if ACodClase = '06' then Result:= 1
  else if ACodClase = '07' then Result:= 0
  else if ACodClase = '08' then Result:= 0
  else if ACodClase = '09' then Result:= 0;
end;



procedure TDMExpediente.TablaCursos( const AInfantil: Boolean );
var
  i, j: integer;
begin
  qryCursos.ParamByName('matricula').AsString:=  sAlumno;
  qryCursos.Open;
  kmtCursos.Open;
  i:= 0;
  j:= 0;
  while not qryCursos.Eof do
  begin
    if kmtCursos.Locate('matricula;cod_clase;promociona', varArrayOf([qryCursos.fieldByName('n_matricula_at').AsString,
                                                           qryCursos.fieldByName('clase_at').AsString, 'S']),[]) then
    begin
      //Si ya esta el clase es que el curso grabado no promociono
      kmtCursos.Edit;
      kmtCursos.FieldByName('promociona').AsString:= 'N';
      kmtCursos.Post;
    end;

    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= qryCursos.fieldByName('n_matricula_at').AsString;
    kmtCursos.FieldByName('cod_curso').AsString:= qryCursos.fieldByName('curso_at').AsString;
    kmtCursos.FieldByName('cod_clase').AsString:= qryCursos.fieldByName('clase_at').AsString;
    kmtCursos.FieldByName('des_clase').AsString:= qryCursos.fieldByName('descripcion_cl').AsString;
    kmtCursos.FieldByName('des_curso').AsString:= qryCursos.fieldByName('descripcion_cu').AsString;
    kmtCursos.FieldByName('etapa').AsString:= NumEtapa( qryCursos.fieldByName('clase_at').AsString );
    kmtCursos.FieldByName('primaria').AsInteger:= EsPrimaria( qryCursos.fieldByName('clase_at').AsString );
    if kmtCursos.FieldByName('primaria').AsInteger = 1 then
    begin
      i:= i + 1;
    end
    else
    begin
      j:= j + 1;
    end;

    kmtCursos.FieldByName('cod_centro').AsString:= '03003577';
    kmtCursos.FieldByName('des_centro').AsString:= 'CENTRE PRIVAT FUNDACIÓN ANTONIO BONNY';
    kmtCursos.FieldByName('localidad_centro').AsString:= 'EL CAMPELLO';
    kmtCursos.FieldByName('provincia_centro').AsString:= 'ALICANTE';

    if qryCursos.fieldByName('promociona_at').AsString = 'N' then
      kmtCursos.FieldByName('promociona').AsString:= 'N'
    else
      kmtCursos.FieldByName('promociona').AsString:= 'S';
    kmtCursos.FieldByName('imprimir').AsString:= 'S';
    kmtCursos.Post;

    qryCursos.Next;
  end;

  qryCursos.Close;
  CompletaCursos( i, j );
  kmtCursos.SortFields:= 'matricula;cod_curso;cod_clase';
  kmtCursos.Sort([]);
end;


procedure TDMExpediente.CompletaCursos( const APrimaria, AInfantil: integer );
var
  i: integer;
begin
  i:= APrimaria;
  while i < 7 do
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_curso').AsString:= '99';
    kmtCursos.FieldByName('cod_clase').AsString:= '99';
    kmtCursos.FieldByName('primaria').AsInteger:= 1;
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
    i:= i + 1;
  end;
  i:= AInfantil;
  while i < 3 do
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_curso').AsString:= '99';
    kmtCursos.FieldByName('cod_clase').AsString:= '99';
    kmtCursos.FieldByName('primaria').AsInteger:= 0;
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
    i:= i + 1;
  end;
  (*
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'01']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '01';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'02']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '02';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'03']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '03';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'04']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '03';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'05']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '05';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;cod_clase', varArrayOf([sAlumno,'06']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '06';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  if not kmtCursos.Locate('matricula;promociona', varArrayOf([sAlumno,'N']),[]) then
  begin
    kmtCursos.Insert;
    kmtCursos.FieldByName('matricula').AsString:= sAlumno;
    kmtCursos.FieldByName('cod_clase').AsString:= '99';
    kmtCursos.FieldByName('imprimir').AsString:= 'N';
    kmtCursos.Post;
  end;
  *)
end;

function  TDMExpediente.IsPrimero: Boolean;
begin
  Result:= bC1;
end;

function  TDMExpediente.IsSegundo: Boolean;
begin
  Result:= bC2;
end;

function  TDMExpediente.IsTercero: Boolean;
begin
  Result:= bC3;
end;

function  TDMExpediente.IsCuarto: Boolean;
begin
  Result:= bC4;
end;

function  TDMExpediente.IsQuinto: Boolean;
begin
  Result:= bC5;
end;

function  TDMExpediente.IsSexto: Boolean;
begin
  Result:= bC6;
end;

function TDMExpediente.DesCursoClase( const AAlumno, Clase: string ): string;
begin
  if kmtCursos.Locate('matricula;cod_clase;promociona', varArrayOf([AAlumno, Clase, 'S']),[]) then
    Result:= kmtCursos.FieldByName('des_curso').AsString
  else
    Result:=  'NO CURSADO EN ESTE CENTRO';
end;

end.


