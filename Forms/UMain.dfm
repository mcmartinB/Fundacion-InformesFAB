object FMain: TFMain
  Left = 504
  Top = 272
  Caption = '   INFORMES ACAD'#201'MICOS COLEGIO FUNDACI'#211'N ANTONIO BONNY'
  ClientHeight = 525
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 740
    Height = 67
    ActivePage = tsExpediente
    Align = alTop
    MultiLine = True
    Style = tsFlatButtons
    TabOrder = 0
    TabWidth = 175
    OnChange = pgcMainChange
    object tsActas: TTabSheet
      Caption = 'Actas'
      object btnImprimir: TButton
        Left = 8
        Top = 5
        Width = 537
        Height = 25
        Caption = 'Imprimir Actas de la Clase Seleccionada.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnImprimirClick
      end
      object btn4: TButton
        Left = 556
        Top = 5
        Width = 173
        Height = 25
        Caption = 'Cerrar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnCerrarClick
      end
    end
    object tsExpediente: TTabSheet
      Caption = 'Expediente'
      ImageIndex = 1
      object btn1: TButton
        Left = 8
        Top = 5
        Width = 537
        Height = 25
        Caption = 'Imprimir Expedientes de los Alumnos.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnImprimirClick
      end
      object btnCerrar: TButton
        Left = 556
        Top = 5
        Width = 173
        Height = 25
        Caption = 'Cerrar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnCerrarClick
      end
    end
    object tsHistorial: TTabSheet
      Caption = 'Historial'
      ImageIndex = 2
      object btn2: TButton
        Left = 8
        Top = 5
        Width = 537
        Height = 25
        Caption = 'Imprimir Historiales de los Alumnos.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnImprimirClick
      end
      object btn5: TButton
        Left = 556
        Top = 5
        Width = 173
        Height = 25
        Caption = 'Cerrar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnCerrarClick
      end
    end
    object tsResultados: TTabSheet
      Caption = 'Resultados'
      ImageIndex = 3
      object btn3: TButton
        Left = 8
        Top = 5
        Width = 537
        Height = 25
        Caption = 'Imprimir Resultados del Curso.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnImprimirClick
      end
      object btn6: TButton
        Left = 556
        Top = 5
        Width = 173
        Height = 25
        Caption = 'Cerrar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnCerrarClick
      end
    end
  end
  object pnlBody: TPanel
    Left = 0
    Top = 67
    Width = 740
    Height = 458
    Align = alClient
    TabOrder = 1
    object lblDirector: TLabel
      Left = 270
      Top = 170
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Director/a Centro                                    '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lblTutor: TLabel
      Left = 270
      Top = 194
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Tutor Clase                                      '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 270
      Top = 70
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'C'#243'digo Centro                           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl9: TLabel
      Left = 270
      Top = 95
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Centro                           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl10: TLabel
      Left = 270
      Top = 120
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Poblaci'#243'n                           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl11: TLabel
      Left = 270
      Top = 145
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Provincia                           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl14: TLabel
      Left = 270
      Top = 218
      Width = 135
      Height = 13
      AutoSize = False
      Caption = 'Secretario/a                           '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object lbl2: TLabel
      Left = 270
      Top = 23
      Width = 135
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
    object lblFecha: TLabel
      Left = 270
      Top = 46
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
    object lblCV: TLabel
      Left = 562
      Top = 241
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
    object dbgrdCursos: TDBGrid
      Left = 23
      Top = 27
      Width = 225
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
      Left = 23
      Top = 225
      Width = 225
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
    object txtCursos: TStaticText
      Left = 23
      Top = 11
      Width = 225
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
      TabOrder = 2
    end
    object txtCLASES: TStaticText
      Left = 23
      Top = 209
      Width = 225
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
      TabOrder = 3
    end
    object edtDirector: TEdit
      Left = 407
      Top = 166
      Width = 300
      Height = 21
      TabOrder = 4
      Text = 'CHECA MATEO, RAM'#211'N'
    end
    object edtTutor: TEdit
      Left = 407
      Top = 190
      Width = 300
      Height = 21
      TabOrder = 5
    end
    object edtCodCentro: TEdit
      Left = 411
      Top = 64
      Width = 300
      Height = 21
      TabOrder = 6
      Text = '03003577'
    end
    object edtNomCentro: TEdit
      Left = 407
      Top = 91
      Width = 300
      Height = 21
      TabOrder = 7
      Text = 'CENTRE PRIVAT FUNDACI'#211'N ANTONIO BONNY'
    end
    object edtPoblacionCentro: TEdit
      Left = 407
      Top = 116
      Width = 300
      Height = 21
      TabOrder = 8
      Text = 'EL CAMPELLO'
    end
    object edtProvinciaCentro: TEdit
      Left = 407
      Top = 141
      Width = 300
      Height = 21
      TabOrder = 9
      Text = 'ALICANTE'
    end
    object edtSecretario: TEdit
      Left = 407
      Top = 214
      Width = 300
      Height = 21
      TabOrder = 10
    end
    object cbbEvaluacion: TComboBox
      Left = 407
      Top = 19
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 1
      TabOrder = 11
      Text = 'TRIMESTRE 1'#186
      Items.Strings = (
        'EVALUACI'#211'N FINAL'
        'TRIMESTRE 1'#186
        'TRIMESTRE 2'#186
        'TRIMESTRE 3'#186
        '')
    end
    object dtpFecha: TDateTimePicker
      Left = 407
      Top = 42
      Width = 145
      Height = 21
      Date = 42093.692827407410000000
      Time = 42093.692827407410000000
      TabOrder = 12
    end
    object btnDesActivarCV: TButton
      Left = 562
      Top = 253
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
      TabOrder = 14
      OnClick = btnDesActivarCVClick
    end
    object btnActivarCV: TButton
      Left = 562
      Top = 253
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
      TabOrder = 13
      OnClick = btnActivarCVClick
    end
  end
end
