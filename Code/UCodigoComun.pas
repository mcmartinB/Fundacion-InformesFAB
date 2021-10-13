unit UCodigoComun;

interface

var
  iNumPages: array [0..7] of Integer;
  iNumPage: Integer;


procedure LimpiaNumPaginas;
function GetMateria( const AArea, ADEscripcion: string ): string;
function GetNota( const ANota: real ): string;
function GetNotaEx( const ANota: real; var ASpain, AValenciano: string ): string;
function GetMedia( const ANota1, ANota2, ANota3: real;  var AMedia: real ): string;
function StrEvaluacion( const AEvaluacion: Integer ): string;

implementation

uses
  SysUtils, bMath;

function GetMateria( const AArea, ADEscripcion: string ): string;
begin
  if AArea = '00010' then
    Result:= 'CMN' //Conocimiento del medio y naturales
  else
  if AArea = '00015' then
    Result:= 'CN'  //Ciencias naturales
  else
  if AArea = '00016' then
    Result:= 'CS'  //Ciencias sociales
  else
  if AArea = '00017' then                 // Añadido 09/01/2019
    Result:= 'CS'  //Ciencias sociales
  else
  if AArea = '00020' then
    Result:= 'EA'  //Educacion artistica
  else
  if AArea = '00030' then
    Result:= 'EF'  //Educacion fisica
  else
  if AArea = '00040' then
    Result:= 'LCL' //lengua castellana y literatura
  else
  if AArea = '00050' then
    Result:= 'VLL' //valenciano, lengua y literatura
  else
  if AArea = '00060' then
    Result:= 'IN'  //Ingles
  else
  if AArea = '00070' then
    Result:= 'M'   //
  else
  if AArea = '00080' then
    Result:= 'REL'
  else
  if AArea = '00086' then
    Result:= 'CV'
  else
  if AArea = '00085' then
    Result:= 'EPC' //Educacion para la ciudadania
  else
  if AArea = '00160' then             // Añadido 09/01/2019
    Result:= 'REL'
  else
    raise Exception.Create( 'Asignatura desconocida "' + AArea + '" ' + ADEscripcion );
end;


function GetNota( const ANota: real ): string;
begin
  if ANota = -1 then
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
    if ANota < 0 then
      raise Exception.Create( 'La nota no puede ser menos de 0 para ' )
    (*
      raise Exception.Create(sAlumno +
                           'La nota no puede ser menos de 0 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    *)
    else
    if ANota > 10 then
      raise Exception.Create( 'La nota no puede ser mayor de 10 ')
    (*
      raise Exception.Create(sAlumno +
                           'La nota no puede ser mayor de 10 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    *)
    else
    if ANota < 5 then
      Result:= 'IN'
    else
    if ANota < 6 then
      Result:= 'SU'
    else
    if ANota < 7 then
      Result:= 'BI'
    else
    if ANota < 9 then
      Result:= 'NT'
    else
      Result:= 'SB';

  end;
end;

function GetNotaEx( const ANota: real; var ASpain, AValenciano: string ): string;
begin
  if ANota = -1 then
  begin
    Result:= '';
    ASpain:= '';
    AValenciano:= '';
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
    if ANota < 0 then
      raise Exception.Create( 'La nota no puede ser menos de 0 para ' )
    (*
      raise Exception.Create(sAlumno +
                           'La nota no puede ser menos de 0 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    *)
    else
    if ANota > 10 then
      raise Exception.Create( 'La nota no puede ser mayor de 10 ')
    (*
      raise Exception.Create(sAlumno +
                           'La nota no puede ser mayor de 10 para ' +
                           sDesEvalua +
                           ' de la asignatura "' +
                           qryEvaluacion.fieldByName('AREA_CC').AsString +
                           '" ' +
                           qryEvaluacion.fieldByName('DESCRIPCION_AR').AsString)
    *)
    else
    if ANota < 5 then
    begin
      Result:= 'IN';
      ASpain:= 'Insuficiente';
      AValenciano:= 'Insuficient';
    end
    else
    if ANota < 6 then
    begin
      Result:= 'SU';
      ASpain:= 'Suficiente';
      AValenciano:= 'Suficient';
    end
    else
    if ANota < 7 then
    begin
      Result:= 'BI';
      ASpain:= 'Bien';
      AValenciano:= 'Bé';
    end
    else
    if ANota < 9 then
    begin
      Result:= 'NT';
      ASpain:= 'Notable';
      AValenciano:= 'Notable';
    end
    else
    begin
      Result:= 'SB';
      ASpain:= 'Sobresaliente';
      AValenciano:= 'Excel·lent';
    end;

  end;
end;

function GetMedia( const ANota1, ANota2, ANota3: real;  var AMedia: real ): string;
begin
  AMedia:= bRoundTo(  ( ANota1 + ANota2 + ANota3 ) / 3, 1 );
  Result:= GetNota( AMedia );
end;

function StrEvaluacion( const AEvaluacion: Integer ): string;
begin
  if AEvaluacion = 1 then
    result:= 'EVALUACION1_AN'
  else
  if AEvaluacion = 2 then
    result:= 'EVALUACION2_AN'
  else
  if AEvaluacion = 3 then
    result:= 'EVALUACION3_AN'
  else
  if AEvaluacion = 0 then
    result:= 'EVALUACIONF_AN'
  else
    raise Exception.Create('Número de evaluación desconocida.');
end;

procedure LimpiaNumPaginas;
var
  iAux: Integer;
begin
  iAux:= 0;
  while  iAux <= 7 do
  begin
    iNumPages[ iAux ]:= 0;
    iAux:= iAux + 1;
  end;
end;

end.
