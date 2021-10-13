object FNotas: TFNotas
  Left = 339
  Top = 261
  Width = 755
  Height = 410
  ActiveControl = mmoNotas
  Caption = 'OBSERVACIONES SOBRE LOS RESULTADOS AC'#193'DEMICOS'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 739
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnAceptar: TButton
      Left = 5
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Aceptar'
      TabOrder = 0
      OnClick = btnAceptarClick
    end
    object btnCancelar: TButton
      Left = 85
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object mmoNotas: TMemo
    Left = 0
    Top = 41
    Width = 739
    Height = 331
    Align = alClient
    TabOrder = 1
    WantTabs = True
  end
end
