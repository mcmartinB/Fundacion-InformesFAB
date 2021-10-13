unit UDMMain;

interface

uses
  SysUtils, Classes, DB, DBTables, kbmMemTable;

type
  TDMMain = class(TDataModule)
    Database: TDatabase;
    qryCursos: TQuery;
    dsCursos: TDataSource;
    qryClases: TQuery;
    dsClases: TDataSource;
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

  public
    { Public declarations }
    function  AbrirBaseDeDatos: boolean;
    function  AbrirBD( const ALogin: Boolean ): boolean;
    procedure CerrarBD;

    function DesCurso( const ACodCurso: string ): string;
    function DesClase( const ACodClase: string ): string;
    function NombreTutor( const ACodCurso, ACodClase: string ): string;

    procedure ActivarCV( const ACurso: string );
    procedure DesActivarCV( const ACurso: string );
    function  EstaActivoCV( const ACurso: string ): Boolean;
  end;


var
  DMMain: TDMMain;  


implementation

{$R *.dfm}

uses IniFiles, Variants, QuickRpt, Dialogs, UCodigoComun;

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
  //qryAlumnos.SQL.Add('select n_matricula_ad, trim(nombre_ad) || '' '' || trim(apellido1_ad)  || '' '' || trim(apellido1_Ad) alumno');
  qryAlumnos.SQL.Add('select n_matricula_ad, trim(nvl(apellido1_ad,''''))  || '' '' || trim(nvl(apellido2_Ad,'''')) || '', '' ||   trim(nvl(nombre_ad,'''')) alumno');
  qryAlumnos.SQL.Add('from nof_alumno_mat join nof_alumno_datos on n_matricula_at = n_matricula_ad ');
  qryAlumnos.SQL.Add('where curso_at = :CURSO_CC ');
  qryAlumnos.SQL.Add('and clase_at = :CLASE_CC ');
  //qryAlumnos.SQL.Add('order by n_matricula_ad ');
  qryAlumnos.SQL.Add('order by alumno ');


  qryTutor.SQL.Clear;
  qryTutor.SQL.Add(' select nombre_tt tutor ');
  qryTutor.SQL.Add(' from NOF_CLASES_CURSO JOIN nof_tutor on tutor_cc = codigo_tt ');
  qryTutor.SQL.Add(' where CURSO_CC = :CURSO_CC ');
  qryTutor.SQL.Add('  and  CLASE_CC = :CLASE_CC ');
  qryTutor.SQL.Add(' group by nombre_tt ');

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
    Database.Connected:= False;
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

function  TDMMain.AbrirBaseDeDatos: boolean;
begin
  Result:= AbrirBD( False );
end;

end.
