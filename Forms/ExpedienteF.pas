unit ExpedienteF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QuickRpt, StdCtrls, Grids, DBGrids, DB, ExtCtrls, ComCtrls,
  nbEdits, nbCombos;

type
  TFExpediente = class(TForm)
    btnImprimir: TButton;
    btnCerrar: TButton;
    edtApellido1: TEdit;
    edtApellido2: TEdit;
    edtNombre: TEdit;
    edtMunicipioNac: TEdit;
    edtProvinciaNac: TEdit;
    edtPaisNac: TEdit;
    edtNacionalidad: TEdit;
    edtTutor2: TEdit;
    edtTutor1: TEdit;
    lblAlumno: TLabel;
    lblNacionalidad: TLabel;
    lblPadre: TLabel;
    cbbPadre: TComboBox;
    edtFechaNacimiento: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl12: TLabel;
    dtpAltaCentro: TnbDBCalendarCombo;
    dbgrdAlumnos: TDBGrid;
    CQRExpediente: TQRCompositeReport;
    chkPortada: TCheckBox;
    chkTercero: TCheckBox;
    chkCuarto: TCheckBox;
    chkPrimero: TCheckBox;
    chkQuinto: TCheckBox;
    chkSegundo: TCheckBox;
    chkSexto: TCheckBox;
    lblDirector: TLabel;
    lbl14: TLabel;
    edtDirectorPrimero: TEdit;
    edtSecretarioPrimero: TEdit;
    lblPrimero: TLabel;
    lblsegundo: TLabel;
    lbltercero: TLabel;
    lblcuarto: TLabel;
    lblquinto: TLabel;
    lblsexto: TLabel;
    dtpPromoPrimero: TnbDBCalendarCombo;
    dtpPromoSegundo: TnbDBCalendarCombo;
    dtpPromoTercero: TnbDBCalendarCombo;
    dtpPromoCuarto: TnbDBCalendarCombo;
    dtpPromoQuinto: TnbDBCalendarCombo;
    dtpPromoSexto: TnbDBCalendarCombo;
    lbl15: TLabel;
    dtpVBPrimero: TnbDBCalendarCombo;
    bvl2: TBevel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtDirectorSegundo: TEdit;
    edtSecretarioSegundo: TEdit;
    lbl5: TLabel;
    lbl8: TLabel;
    edtDirectorTercero: TEdit;
    edtSecretarioTercero: TEdit;
    lbl9: TLabel;
    lbl10: TLabel;
    edtDirectorCuarto: TEdit;
    edtSecretarioCuarto: TEdit;
    lbl11: TLabel;
    lbl13: TLabel;
    edtDirectorQuinto: TEdit;
    edtSecretarioQuinto: TEdit;
    lbl16: TLabel;
    lbl17: TLabel;
    edtDirectorSexto: TEdit;
    edtSecretarioSexto: TEdit;
    bvl1: TBevel;
    lbl18: TLabel;
    dtpVBSegundo: TnbDBCalendarCombo;
    lbl19: TLabel;
    dtpVBTercero: TnbDBCalendarCombo;
    lbl20: TLabel;
    dtpVBCuarto: TnbDBCalendarCombo;
    lbl21: TLabel;
    dtpVBQuinto: TnbDBCalendarCombo;
    lbl22: TLabel;
    dtpVBSexto: TnbDBCalendarCombo;
    bvl3: TBevel;
    bvl4: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bvl5: TBevel;
    bvl6: TBevel;
    chkHistorial: TCheckBox;
    chkExpediente: TCheckBox;
    lbl23: TLabel;
    edttelefono: TEdit;
    lbl24: TLabel;
    edttelefonoTUTOR1: TEdit;
    lbl25: TLabel;
    edttelefonoTUTOR2: TEdit;
    lblDomicilio: TLabel;
    edtDomicilio: TEdit;
    lbl27: TLabel;
    edtCodPostal: TEdit;
    lbl28: TLabel;
    edtProvincia: TEdit;
    lbl26: TLabel;
    edtLocalidad: TEdit;
    dtpAltaPrimaria: TnbDBCalendarCombo;
    lbl29: TLabel;
    edtTutorPrimero: TEdit;
    lbl30: TLabel;
    edtTutorSegundo: TEdit;
    lbl31: TLabel;
    edtTutorTercero: TEdit;
    lbl32: TLabel;
    edtTutorCuarto: TEdit;
    lbl33: TLabel;
    edtTutorQuinto: TEdit;
    lbl34: TLabel;
    edtTutorSexto: TEdit;
    lbl35: TLabel;
    procedure CQRExpedienteAddReports(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure cbbPadreChange(Sender: TObject);
    procedure dbgrdAlumnosCellClick(Column: TColumn);
    procedure chkPrimeroClick(Sender: TObject);
    procedure chkSegundoClick(Sender: TObject);
    procedure chkTerceroClick(Sender: TObject);
    procedure chkCuartoClick(Sender: TObject);
    procedure chkQuintoClick(Sender: TObject);
    procedure chkSextoClick(Sender: TObject);
    procedure DatosCursosAlumno;
  private
    { Private declarations }
    bExpediente: Boolean;
    bP, bC1, bC2, bC3, bC4, bC5, bC6: boolean;
    sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro, sFechaAltaCentro, sFechaAltaPrimaria: string;
    sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor: string;
    sAlumno, sNacioEl, sMunicipioNac, sProvinciaNac, sPaisNac, sNacionalidad, sMadre, sPadre, sSexo: string;
    sTelefono, sTelefonoMadre, sTelefonoPadre, sDomicilio, sLocalidad, sCodPostal, sProvincia: string;


    bFlag: boolean;

    procedure CrearReports;
    procedure DestruirReports;
    procedure CargarReports;

    procedure GetDatosAlumno;
    procedure MarcaHojasAImprimir;
    function  ValidaData: boolean;
    procedure LoadDataP1;
    procedure LoadDataP2;
    procedure LoadDataC1;
    procedure LoadDataC2;
    procedure LoadDataC3;
    procedure LoadDataC4;
    procedure LoadDataC5;
    procedure LoadDataC6;
  public
    { Public declarations }


    procedure CargaParametros( const AExpediente: Boolean;
                          const ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string;
                          const ADirector, ASecretario, ACurso, AClase: string );
    procedure ImprimirExpediente;
  end;

  procedure ImprimirExpediente( const AExpediente: Boolean;
                          const ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string;
                          const ADirector, ASecretario,  ACurso, AClase: string );



implementation

{$R *.dfm}

uses
  ExpedienteDM,  ExpedientePortada1QR, ExpedientePortada2QR, ExpedientePrimeroQR,
  ExpedienteSegundoQR, ExpedienteTerceroQR, ExpedienteCuartoQR, ExpedienteQuintoQR,
  ExpedienteSextoQR, HistorialPortada1QR, HistorialPortada2QR, HistorialPrimeroQR,
  HistorialSegundoQR, HistorialTerceroQR, HistorialCuartoQR, HistorialQuintoQR,
  HistorialSextoQR, UCodigoComun, UDMMain, DateUtils;

var
  FExpediente: TFExpediente;

procedure ImprimirExpediente(  const AExpediente: Boolean;
                          const ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string;
                          const ADirector, ASecretario, ACurso, AClase: string );
begin
  Application.CreateForm( TDMExpediente, DMExpediente);
  try
    Application.CreateForm( TFExpediente, FExpediente);
    try
      FExpediente.CargaParametros( AExpediente, ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro, ADirector, ASecretario, ACurso, AClase );
      FExpediente.GetDatosAlumno;
      FExpediente.ShowModal;
    finally
      FreeAndNil( FExpediente );
    end;
    DMExpediente.CerrarDatos;
  finally
    FreeAndNil( DMExpediente );
  end;
end;

function GetCurso( const ACurso: integer ): string;
begin
  if ACurso > 9 then
    Result:= IntToStr( ACurso )
  else
    Result:= '0' + IntToStr( ACurso );
end;

procedure TFExpediente.CargaParametros( const AExpediente: Boolean;
                          const ACodCentro, ANomCentro, APoblacionCentro, AProvinciaCentro: string;
                          const ADirector, ASecretario, ACurso, AClase: string );
begin
  chkExpediente.Checked:= AExpediente;
  chkHistorial.Checked:= not AExpediente;

  chkPortada.Checked:= False;
  chkPrimero.Checked:= AClase = '01';
  chkSegundo.Checked:= AClase = '02';
  chkTercero.Checked:= AClase = '03';
  chkCuarto.Checked:= AClase = '04';
  chkQuinto.Checked:= AClase = '05';
  chkSexto.Checked:= AClase = '06';

  sCodCentro:= ACodCentro;
  sNomCentro:= ANomCentro;
  sPoblacionCentro:= APoblacionCentro;
  sProvinciaCentro:= AProvinciaCentro;

  sDirector:= ADirector;
  sSecretario:= ASecretario;

  edtDirectorPrimero.Text:= sDirector;
  edtSecretarioPrimero.Text:= sSecretario;
  edtDirectorSegundo.Text:= sDirector;
  edtSecretarioSegundo.Text:= sSecretario;
  edtDirectorTercero.Text:= sDirector;
  edtSecretarioTercero.Text:= sSecretario;
  edtDirectorCuarto.Text:= sDirector;
  edtSecretarioCuarto.Text:= sSecretario;
  edtDirectorQuinto.Text:= sDirector;
  edtSecretarioQuinto.Text:= sSecretario;
  edtDirectorSexto.Text:= sDirector;
  edtSecretarioSexto.Text:= sSecretario;
end;

procedure TFExpediente.MarcaHojasAImprimir;
begin
  bP:= chkPortada.Checked ;
  bC1:= chkPrimero.Checked;
  bC2:= chkSegundo.Checked;
  bC3:= chkTercero.Checked;
  bC4:= chkCuarto.Checked;
  bC5:= chkQuinto.Checked;
  bC6:= chkSexto.Checked;
end;

procedure TFExpediente.FormCreate(Sender: TObject);
begin
  bFlag:= False;
  dtpAltaCentro.Text:= '';
  dtpAltaPrimaria.Text:= '';
end;


procedure TFExpediente.CrearReports;
begin
  if bExpediente then
  begin
    if bP then
    begin
      Application.CreateForm( TQRExpedientePortada1, QRExpedientePortada1 );
      LoadDataP1;
      QRExpedientePortada1.LoadData( sFechaAltaCentro, sCodCentro, sNomCentro, sNacioEl, sMunicipioNac, sProvinciaNac, sPaisNac, sNacionalidad, sSexo,
                                     sMadre, sTelefonoMadre, sPadre, sTelefonoPadre, sTelefono, sDomicilio, sLocalidad, sCodPostal, sProvincia );
      Application.CreateForm( TQRExpedientePortada2, QRExpedientePortada2 );
      LoadDataP2;
      QRExpedientePortada2.LoadData( sFechaAltaCentro, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro,
                                     sDirector, sSecretario );
    end;
    if bC1 then
    begin
      Application.CreateForm( TQRExpedientePrimero, QRExpedientePrimero );
      LoadDataC1;
      QRExpedientePrimero.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end;
    if bC2 then
    begin
      Application.CreateForm( TQRExpedienteSegundo, QRExpedienteSegundo );
      LoadDataC2;
      QRExpedienteSegundo.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end;
    if bC3 then
    begin
      Application.CreateForm( TQRExpedienteTercero, QRExpedienteTercero );
      LoadDataC3;
      QRExpedienteTercero.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end;
    if bC4 then
    begin
      Application.CreateForm( TQRExpedienteCuarto, QRExpedienteCuarto );
      LoadDataC4;
      QRExpedienteCuarto.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end;
    if bC5 then
    begin
      Application.CreateForm( TQRExpedienteQuinto, QRExpedienteQuinto );
      LoadDataC5;
      QRExpedienteQuinto.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end;
    if bC6 then
    begin
      Application.CreateForm( TQRExpedienteSexto, QRExpedienteSexto );
      LoadDataC6;
      QRExpedienteSexto.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario, sTutor );
    end
  end
  else
  begin
    if bP then
    begin
      Application.CreateForm( TQRHistorialPortada1, QRHistorialPortada1 );
      LoadDataP1;
      QRHistorialPortada1.LoadData( sNacioEl, sMunicipioNac, sProvinciaNac, sPaisNac, sNacionalidad, sMadre, sPadre, sSexo );

      Application.CreateForm( TQRHistorialPortada2, QRHistorialPortada2 );
      LoadDataP2;
      QRHistorialPortada2.LoadData( sFechaAltaPrimaria, sCodCentro, sNomCentro, sPoblacionCentro, sProvinciaCentro );
    end;
    if bC1 then
    begin
      Application.CreateForm( TQRHistorialPrimero, QRHistorialPrimero );
      LoadDataC1;
      QRHistorialPrimero.LoadData( sFechaPromocion, sFechaVisto  );
    end;
    if bC2 then
    begin
      Application.CreateForm( TQRHistorialSegundo, QRHistorialSegundo );
      LoadDataC2;
      QRHistorialSegundo.LoadData( sFechaPromocion, sFechaVisto  );
    end;
    if bC3 then
    begin
      Application.CreateForm( TQRHistorialTercero, QRHistorialTercero );
      LoadDataC3;
      QRHistorialTercero.LoadData( sFechaPromocion, sFechaVisto );
    end;
    if bC4 then
    begin
      Application.CreateForm( TQRHistorialCuarto, QRHistorialCuarto );
      LoadDataC4;
      QRHistorialCuarto.LoadData( sFechaPromocion, sFechaVisto );
    end;
    if bC5 then
    begin
      Application.CreateForm( TQRHistorialQuinto, QRHistorialQuinto );
      LoadDataC5;
      QRHistorialQuinto.LoadData( sFechaPromocion, sFechaVisto );
    end;
    if bC6 then
    begin
      Application.CreateForm( TQRHistorialSexto, QRHistorialSexto );
      LoadDataC6;
      QRHistorialSexto.LoadData( sFechaPromocion, sFechaVisto, sDirector, sSecretario );
    end;
  end;
end;

procedure TFExpediente.DestruirReports;
begin
  if bExpediente then
  begin
    if bP then
    begin
      FreeAndNil( QRExpedientePortada1 );
      FreeAndNil( QRExpedientePortada2 );
    end;
    if bC1 then
      FreeAndNil( QRExpedientePrimero );
    if bC2 then
      FreeAndNil( QRExpedienteSegundo );
    if bC3 then
      FreeAndNil( QRExpedienteTercero );
    if bC4 then
      FreeAndNil( QRExpedienteCuarto );
    if bC5 then
      FreeAndNil( QRExpedienteQuinto );
    if bC6 then
      FreeAndNil( QRExpedienteSexto );
  end
  else
  begin
    if bP then
    begin
      FreeAndNil( QRHistorialPortada1 );
      FreeAndNil( QRHistorialPortada2 );
    end;
    if bC1 then
      FreeAndNil( QRHistorialPrimero );
    if bC2 then
      FreeAndNil( QRHistorialSegundo );
    if bC3 then
      FreeAndNil( QRHistorialTercero );
    if bC4 then
      FreeAndNil( QRHistorialCuarto );
    if bC5 then
      FreeAndNil( QRHistorialQuinto );
    if bC6 then
      FreeAndNil( QRHistorialSexto );
  end;
end;

procedure TFExpediente.CargarReports;
begin
  if bExpediente then
  begin
    if bP then
    begin
      CQRExpediente.Reports.Add(QRExpedientePortada1);
      CQRExpediente.Reports.Add(QRExpedientePortada2);
    end;
    if bC1 then
    begin
      CQRExpediente.Reports.Add(QRExpedientePrimero);
    end;
    if bC2 then
    begin
      CQRExpediente.Reports.Add(QRExpedienteSegundo);
    end;
    if bC3 then
    begin
      CQRExpediente.Reports.Add(QRExpedienteTercero);
    end;
    if bC4 then
    begin
      CQRExpediente.Reports.Add(QRExpedienteCuarto);
    end;
    if bC5 then
    begin
      CQRExpediente.Reports.Add(QRExpedienteQuinto);
    end;
    if bC6 then
    begin
      CQRExpediente.Reports.Add(QRExpedienteSexto);
    end;
  end
  else
  begin
    UCodigoComun.LimpiaNumPaginas;
    UCodigoComun.iNumPage:= 0;

    if bP then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 1;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialPortada1);

      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 2;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialPortada2);
    end;
    if bC1 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 3;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialPrimero);
    end;
    if bC2 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 4;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialSegundo);
    end;
    if bC3 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 5;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialTercero);
    end;
    if bC4 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 6;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialCuarto);
    end;
    if bC5 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 7;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialQuinto);
    end;
    if bC6 then
    begin
      UCodigoComun.iNumPages[UCodigoComun.iNumPage]:= 8;
      UCodigoComun.iNumPage:= UCodigoComun.iNumPage + 1;
      CQRExpediente.Reports.Add(QRHistorialSexto);
    end;
    UCodigoComun.iNumPage:= 0;
  end;
end;

procedure TFExpediente.CQRExpedienteAddReports(Sender: TObject);
begin
  CQRExpediente.Reports.Clear;
  CargarReports;
end;


procedure TFExpediente.btnImprimirClick(Sender: TObject);
begin
  if not bFlag then
  begin
     bFlag:= True;
     try
       if ValidaData then
       begin
         MarcaHojasAImprimir;
         if chkExpediente.Checked then
         begin
           bExpediente:= True;
           ImprimirExpediente;
         end;
         if chkHistorial.Checked then
         begin
           bExpediente:= False;
           ImprimirExpediente;
         end;
       end;
     finally
       bFlag:= False;
     end;
  end;
end;


procedure TFExpediente.btnCerrarClick(Sender: TObject);
begin
  if not bFlag then
  begin
     Close;
  end;
end;

procedure TFExpediente.ImprimirExpediente;
begin
  CrearReports;
  try
    CQRExpediente.Preview;
  finally
    DestruirReports;
  end;
end;


procedure TFExpediente.cbbPadreChange(Sender: TObject);
begin
  if cbbPadre.ItemIndex = 0 then
  begin
    lblPadre.Caption:= 'Padre/Tutor';
  end
  else
  begin
    lblPadre.Caption:= 'Madre/Tutora';
  end;
end;

procedure TFExpediente.GetDatosAlumno;
begin
  sAlumno:= DMMain.qryAlumnos.FieldByname('n_matricula_ad').AsString;
  if DMExpediente.DatosExpediente( sAlumno ) then
  begin
    edtNombre.Text:=  DMExpediente.qryDatosAlumno.FieldByName('nombre_Ad').AsString;
    edtApellido1.Text:=  DMExpediente.qryDatosAlumno.FieldByName('apellido1_ad').AsString;
    edtApellido2.Text:=  DMExpediente.qryDatosAlumno.FieldByName('apellido2_ad').AsString;
    edtFechaNacimiento.Text:=  DMExpediente.qryDatosAlumno.FieldByName('fecha_nac_ad').AsString;
    edtMunicipioNac.Text:=  DMExpediente.qryDatosAlumno.FieldByName('lugar_nac_ad').AsString;
    sSexo:= DMExpediente.qryDatosAlumno.FieldByName('sexo_ad').AsString;
    edtProvinciaNac.Text:=  DMExpediente.qryDatosAlumno.FieldByName('provincia_nac_ad').AsString;
    edtPaisNac.Text:=  DMExpediente.qryDatosAlumno.FieldByName('nom_pais').AsString;
    //NACIONALIDAD
    if edtPaisNac.Text = 'ESPAÑA' then
     edtNacionalidad.Text:= 'ESPAÑOLA'
    else
      edtNacionalidad.Text:= '';
    edtTutor1.Text:=  DMExpediente.qryDatosAlumno.FieldByName('tutor1').AsString;
    edtTutor2.Text:=  DMExpediente.qryDatosAlumno.FieldByName('tutor2').AsString;
    cbbPadre.ItemIndex:= DMExpediente.qryDatosAlumno.FieldByName('oper1_es_masculino_af').AsInteger;

    if not DMExpediente.qryDatosAlumno.FieldByName('fecha_alta_ad').IsNull then
      dtpAltaCentro.Text:= DMExpediente.qryDatosAlumno.FieldByName('fecha_alta_ad').AsString;
    if not DMExpediente.qryDatosAlumno.FieldByName('fecha_inicio_primaria').IsNull then
      dtpAltaPrimaria.Text:= DMExpediente.qryDatosAlumno.FieldByName('fecha_inicio_primaria').AsString;

    edttelefono.Text:= DMExpediente.qryDatosAlumno.FieldByName('telefono').AsString;
    edttelefonoTUTOR1.Text:= DMExpediente.qryDatosAlumno.FieldByName('telefono_tutor1').AsString;
    edttelefonoTUTOR2.Text:= DMExpediente.qryDatosAlumno.FieldByName('telefono_tutor2').AsString;
    edtDomicilio.Text:= DMExpediente.qryDatosAlumno.FieldByName('domicilio').AsString;
    edtCodPostal.Text:= DMExpediente.qryDatosAlumno.FieldByName('cod_postal').AsString;
    edtLocalidad.Text:= DMExpediente.qryDatosAlumno.FieldByName('localidad').AsString;
    edtProvincia.Text:= DMExpediente.qryDatosAlumno.FieldByName('provincia').AsString;

    (*
  sFechaVisto:= AFechaExpediente;
  sFechaPromocion:= AFechaExpediente;
  dtpFechaAltaPrimaria.Text:= AFechaExpediente;
  dtpFechaAltaCentro2.AsDate:= IncYear( StrToDate(AFechaExpediente) , - iAux  );
  *)


    with DMExpediente.qryCursos do
    begin
      if DMExpediente.qryCursos.Active then
        DMExpediente.qryCursos.Close;
      DMExpediente.qryCursos.ParamByName('matricula').AsString:= sAlumno;
      DMExpediente.qryCursos.Open;
      if not DMExpediente.qryCursos.IsEmpty then
      begin
        DatosCursosAlumno;
      end;
      DMExpediente.qryCursos.Close;
    end;
  end
  else
  begin
    ShowMessage( 'Alumno no valido');
  end;
end;

procedure TFExpediente.DatosCursosAlumno;
begin
  //Nos pasamos infantil
   if DMExpediente.qryCursos.FieldByName('clase_at').AsString = '07' then
     DMExpediente.qryCursos.Next;
   if DMExpediente.qryCursos.FieldByName('clase_at').AsString = '08' then
     DMExpediente.qryCursos.Next;
   if DMExpediente.qryCursos.FieldByName('clase_at').AsString = '09' then
     DMExpediente.qryCursos.Next;

  //Primero
  dtpPromoPrimero.Text:= '';
  dtpVBPrimero.Text:= '';
  edtTutorPrimero.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '01'  ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoPrimero.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBPrimero.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorPrimero.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;

  //Segundo
  dtpPromoSegundo.Text:= '';
  dtpVBSegundo.Text:= '';
  edtTutorSegundo.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '02' ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoSegundo.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBSegundo.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorSegundo.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;

  //tercero
  dtpPromoTercero.Text:= '';
  dtpVBTercero.Text:= '';
  edtTutorTercero.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '03' ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoTercero.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBTercero.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorTercero.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;

  //Cuarto
  dtpPromoCuarto.Text:= '';
  dtpVBCuarto.Text:= '';
  edtTutorCuarto.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '04' ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoCuarto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBCuarto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorCuarto.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;

  //Quinto
  dtpPromoQuinto.Text:= '';
  dtpVBQuinto.Text:= '';
  edtTutorQuinto.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '05' ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoQuinto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBQuinto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorQuinto.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;

  //Sexto
  dtpPromoSexto.Text:= '';
  dtpVBSexto.Text:= '';
  edtTutorSexto.Text:= '';
  while ( DMExpediente.qryCursos.FieldByName('clase_at').AsString = '06' ) and ( not DMExpediente.qryCursos.Eof ) do
  begin
    dtpPromoSexto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    dtpVBSexto.AsDate:= DMExpediente.qryCursos.FieldByName('fec_fin_mat_cu').AsDateTime;
    edtTutorSexto.Text:= DMExpediente.qryCursos.FieldByName('nombre_tt').AsString;
    DMExpediente.qryCursos.Next;
  end;
end;

function TFExpediente.ValidaData: boolean;
begin
  Result:= True;
  if chkPortada.Checked then
  begin
    if ( cbbPadre.ItemIndex = -1  ) then
    begin
      ShowMessage('Seleccione si el operario 1 es el padre o la madre del alumno/a');
      Result:= False;
    end
    else
    if ( dtpAltaCentro.Text = ''  ) and ( chkExpediente.Checked or chkHistorial.Checked )then
    begin
      ShowMessage('Falta la fecha de alta en el centro.');
      Result:= False;
    end;
  end;
end;

procedure TFExpediente.dbgrdAlumnosCellClick(Column: TColumn);
begin
  GetDatosAlumno;
end;


procedure TFExpediente.chkPrimeroClick(Sender: TObject);
begin
  dtpPromoPrimero.Enabled:= chkPrimero.Checked;
  dtpVBPrimero.Enabled:= chkPrimero.Checked;
  edtDirectorPrimero.Enabled:= chkPrimero.Checked;
  edtSecretarioPrimero.Enabled:= chkPrimero.Checked;
  edtTutorPrimero.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.chkSegundoClick(Sender: TObject);
begin
  dtpPromoSegundo.Enabled:= chkSegundo.Checked;
  dtpVBSegundo.Enabled:= chkSegundo.Checked;
  edtDirectorSegundo.Enabled:= chkSegundo.Checked;
  edtSecretarioSegundo.Enabled:= chkSegundo.Checked;
  edtTutorSegundo.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.chkTerceroClick(Sender: TObject);
begin
  dtpPromoTercero.Enabled:= chkTercero.Checked;
  dtpVBTercero.Enabled:= chkTercero.Checked;
  edtDirectorTercero.Enabled:= chkTercero.Checked;
  edtSecretarioTercero.Enabled:= chkTercero.Checked;
  edtTutorTercero.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.chkCuartoClick(Sender: TObject);
begin
  dtpPromoCuarto.Enabled:= chkCuarto.Checked;
  dtpVBCuarto.Enabled:= chkCuarto.Checked;
  edtDirectorCuarto.Enabled:= chkCuarto.Checked;
  edtSecretarioCuarto.Enabled:= chkCuarto.Checked;
  edtTutorCuarto.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.chkQuintoClick(Sender: TObject);
begin
  dtpPromoQuinto.Enabled:= chkQuinto.Checked;
  dtpVBQuinto.Enabled:= chkQuinto.Checked;
  edtDirectorQuinto.Enabled:= chkQuinto.Checked;
  edtSecretarioQuinto.Enabled:= chkQuinto.Checked;
  edtTutorQuinto.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.chkSextoClick(Sender: TObject);
begin
  dtpPromoSexto.Enabled:= chkSexto.Checked;
  dtpVBSexto.Enabled:= chkSexto.Checked;
  edtDirectorSexto.Enabled:= chkSexto.Checked;
  edtSecretarioSexto.Enabled:= chkSexto.Checked;
  edtTutorSexto.Enabled:= chkPrimero.Checked;
end;

procedure TFExpediente.LoadDataP1;
begin
  sNacioEl:= edtFechaNacimiento.Text;
  sMunicipioNac:= edtMunicipioNac.Text;
  sProvinciaNac:= edtProvinciaNac.Text;
  sPaisNac:= edtPaisNac.Text;
  sNacionalidad:= edtNacionalidad.Text;
  if cbbPadre.ItemIndex = 0   then
  begin
    sMadre:=  edtTutor1.Text;
    sPadre:= edtTutor2.Text;
    sTelefonoMadre:=edttelefonoTUTOR1.Text;
    sTelefonoPadre:=edttelefonoTUTOR2.Text;
  end
  else
  begin
    sMadre:=  edtTutor2.Text;
    sPadre:= edtTutor1.Text;
    sTelefonoMadre:=edttelefonoTUTOR2.Text;
    sTelefonoPadre:=edttelefonoTUTOR1.Text;
  end;
  sFechaAltaCentro:= dtpAltaCentro.Text;
  sFechaAltaPrimaria:= dtpAltaPrimaria.Text;

  sTelefono:=edttelefono.Text;
  sDomicilio:=edtDomicilio.Text;
  sLocalidad:=edtCodPostal.Text;
  sCodPostal:=edtLocalidad.Text;
  sProvincia:=edtProvincia.Text;

  //sCodCentro:= ACodCentro;
  //sNomCentro:= ANomCentro;
  //sPoblacionCentro:= APoblacionCentro;
  //sProvinciaCentro:= AProvinciaCentro;
end;

procedure TFExpediente.LoadDataP2;
begin
  //sCodCentro:= ACodCentro;
  //sNomCentro:= ANomCentro;
  //sPoblacionCentro:= APoblacionCentro;
  //sProvinciaCentro:= AProvinciaCentro;
  sFechaAltaCentro:= dtpAltaCentro.Text;
  sFechaAltaPrimaria:= dtpAltaPrimaria.Text;
end;

procedure TFExpediente.LoadDataC1;
begin
  sFechaPromocion:= dtpPromoPrimero.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro )  + '", "dd" de "mmmm" de "yyyy', dtpVBPrimero.AsDate ) );
  sDirector:= edtDirectorPrimero.Text;
  sSecretario:= edtSecretarioPrimero.Text;
  sTutor:= edtTutorPrimero.Text;
end;

procedure TFExpediente.LoadDataC2;
begin
  sFechaPromocion:= dtpPromoSegundo.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro )  + '", "dd" de "mmmm" de "yyyy', dtpVBSegundo.AsDate ) );
  sDirector:= edtDirectorSegundo.Text;
  sSecretario:= edtSecretarioSegundo.Text;
  sTutor:= edtTutorSegundo.Text;
end;

procedure TFExpediente.LoadDataC3;
begin
  sFechaPromocion:= dtpPromoTercero.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro )  + '", "dd" de "mmmm" de "yyyy', dtpVBTercero.AsDate ) );
  sDirector:= edtDirectorTercero.Text;
  sSecretario:= edtSecretarioTercero.Text;
  sTutor:= edtTutorTercero.Text;
end;

procedure TFExpediente.LoadDataC4;
begin
  sFechaPromocion:= dtpPromoCuarto.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro )  + '", "dd" de "mmmm" de "yyyy', dtpVBCuarto.AsDate ) );
  sDirector:= edtDirectorCuarto.Text;
  sSecretario:= edtSecretarioCuarto.Text;
  sTutor:= edtTutorCuarto.Text;
end;

procedure TFExpediente.LoadDataC5;
begin
  sFechaPromocion:= dtpPromoQuinto.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro ) + '", "dd" de "mmmm" de "yyyy', dtpVBQuinto.AsDate ) );
  sDirector:= edtDirectorQuinto.Text;
  sSecretario:= edtSecretarioQuinto.Text;
  sTutor:= edtTutorQuinto.Text;
end;

procedure TFExpediente.LoadDataC6;
begin
  sFechaPromocion:= dtpPromoSexto.Text;
  sFechaVisto:= UpperCase( FormatDateTime( QuotedStr( sPoblacionCentro ) + '", "dd" de "mmmm" de "yyyy', dtpVBSexto.AsDate ) );
  sDirector:= edtDirectorSexto.Text;
  sSecretario:= edtSecretarioSexto.Text;
  sTutor:= edtTutorSexto.Text;
end;

end.

