object FMain: TFMain
  Left = 659
  Top = 183
  Width = 717
  Height = 699
  Caption = '   INFORMES ACAD'#201'MICOS COLEGIO FUNDACI'#211'N ANTONIO BONNY'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlIzq: TPanel
    Left = 0
    Top = 47
    Width = 145
    Height = 614
    Align = alLeft
    TabOrder = 0
    object lblCV: TLabel
      Left = 1
      Top = 137
      Width = 143
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'CULTURA VALENCIANA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnActaClase: TButton
      Left = 8
      Top = 18
      Width = 125
      Height = 25
      Caption = 'Imprimir Acta'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnActaClaseClick
    end
    object btnDesActivarCV: TButton
      Left = 0
      Top = 152
      Width = 142
      Height = 18
      Caption = 'Desactivar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      OnClick = btnDesActivarCVClick
    end
    object btnActivarCV: TButton
      Left = 1
      Top = 152
      Width = 143
      Height = 18
      Caption = 'Activar'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 2
      OnClick = btnActivarCVClick
    end
    object btnExpediente: TButton
      Left = 8
      Top = 45
      Width = 125
      Height = 25
      Caption = 'Imprimir Expediente'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnExpedienteClick
    end
    object btnImprirPortada: TButton
      Left = 8
      Top = 72
      Width = 125
      Height = 25
      Caption = 'Imprimir Expediente'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 701
    Height = 47
    Align = alTop
    TabOrder = 1
    object btnCerrar: TButton
      Left = 536
      Top = 13
      Width = 145
      Height = 25
      Caption = 'Cerrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnCerrarClick
    end
    object btnAbrir: TButton
      Left = 8
      Top = 13
      Width = 268
      Height = 25
      Caption = 'Abrir Base Datos Fundaci'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnAbrirClick
    end
  end
  object pnlBody: TPanel
    Left = 145
    Top = 47
    Width = 556
    Height = 614
    Align = alClient
    Enabled = False
    TabOrder = 2
    object lbl1: TLabel
      Left = 281
      Top = 23
      Width = 107
      Height = 13
      Caption = 'Fecha Evaluaci'#243'n '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 23
      Top = 23
      Width = 108
      Height = 13
      AutoSize = False
      Caption = 'Evaluaci'#243'n           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lblDirector: TLabel
      Left = 23
      Top = 44
      Width = 108
      Height = 13
      AutoSize = False
      Caption = 'Director Centro      '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lblTutor: TLabel
      Left = 23
      Top = 65
      Width = 108
      Height = 13
      AutoSize = False
      Caption = 'Tutor Clase           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object dbgrdCursos: TDBGrid
      Left = 23
      Top = 107
      Width = 255
      Height = 180
      DataSource = DMMain.dsCursos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgrdCursosCellClick
    end
    object dbgrdClases: TDBGrid
      Left = 281
      Top = 107
      Width = 255
      Height = 180
      DataSource = DMMain.dsClases
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = dbgrdClasesCellClick
    end
    object dtpFecha: TDateTimePicker
      Left = 391
      Top = 19
      Width = 145
      Height = 21
      Date = 42093.692827407410000000
      Time = 42093.692827407410000000
      TabOrder = 2
    end
    object cbbEvaluacion: TComboBox
      Left = 133
      Top = 19
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 3
      Text = 'TRIMESTRE 1'#186
      Items.Strings = (
        'EVALUACI'#211'N FINAL'
        'TRIMESTRE 1'#186
        'TRIMESTRE 2'#186
        'TRIMESTRE 3'#186
        '')
    end
    object dbgrdAlumnos: TDBGrid
      Left = 23
      Top = 304
      Width = 513
      Height = 290
      DataSource = DMMain.dsAlumnos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object txtCursos: TStaticText
      Left = 23
      Top = 91
      Width = 255
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'CURSOS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object txtCLASES: TStaticText
      Left = 281
      Top = 91
      Width = 255
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'CLASES'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object txt1: TStaticText
      Left = 23
      Top = 289
      Width = 513
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BorderStyle = sbsSingle
      Caption = 'ALUMNOS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object edtDirector: TEdit
      Left = 133
      Top = 40
      Width = 403
      Height = 21
      TabOrder = 8
      Text = 'CHECA MATEO, RAM'#211'N'
    end
    object edtTutor: TEdit
      Left = 133
      Top = 61
      Width = 403
      Height = 21
      TabOrder = 9
    end
  end
end
