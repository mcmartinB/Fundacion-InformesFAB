object DMMain: TDMMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 641
  Top = 308
  Height = 535
  Width = 666
  object Database: TDatabase
    DatabaseName = 'Database'
    SessionName = 'Default'
    Left = 27
    Top = 29
  end
  object qryCursos: TQuery
    AfterOpen = qryCursosAfterOpen
    BeforeClose = qryCursosBeforeClose
    DatabaseName = 'Database'
    Left = 33
    Top = 161
  end
  object dsCursos: TDataSource
    AutoEdit = False
    DataSet = qryCursos
    Left = 112
    Top = 162
  end
  object qryClases: TQuery
    DatabaseName = 'Database'
    DataSource = dsCursos
    Left = 181
    Top = 161
  end
  object dsClases: TDataSource
    AutoEdit = False
    DataSet = qryClases
    Left = 260
    Top = 162
  end
  object qryAlumnos: TQuery
    DatabaseName = 'Database'
    DataSource = dsClases
    Left = 341
    Top = 161
  end
  object dsAlumnos: TDataSource
    AutoEdit = False
    DataSet = qryAlumnos
    Left = 412
    Top = 162
  end
  object qryTutor: TQuery
    DatabaseName = 'Database'
    Left = 197
    Top = 305
  end
  object qryCurso: TQuery
    DatabaseName = 'Database'
    Left = 33
    Top = 305
  end
  object qryClase: TQuery
    DatabaseName = 'Database'
    Left = 109
    Top = 305
  end
  object qryAux: TQuery
    DatabaseName = 'Database'
    Left = 102
    Top = 33
  end
end
