object DMResultados: TDMResultados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 731
  Top = 286
  Height = 485
  Width = 762
  object qryEvaluacion: TQuery
    DatabaseName = 'Database'
    Left = 70
    Top = 65
  end
  object dsEvaluacion: TDataSource
    AutoEdit = False
    DataSet = qryEvaluacion
    Left = 234
    Top = 89
  end
  object kmtResultados: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 38
    Top = 235
  end
  object qryPromocion: TQuery
    DatabaseName = 'Database'
    Left = 70
    Top = 65
  end
  object kmtTotales: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '4.08b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 126
    Top = 235
  end
end
