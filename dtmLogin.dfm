object dmLogin: TdmLogin
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 175
  Width = 291
  object fConexao: TFDConnection
    Params.Strings = (
      'Database=trabalho_engenharia'
      'User_Name=postgres'
      'Password=postgres'
      'Port=5433'
      'DriverID=PG')
    Left = 32
    Top = 32
  end
  object driver: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\AProjeto\trunk\lib\' +
      'libpq.dll'
    Left = 96
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 176
    Top = 32
  end
  object queryLogin: TFDQuery
    Connection = fConexao
    Left = 40
    Top = 104
  end
  object dsLogin: TDataSource
    DataSet = queryLogin
    Left = 104
    Top = 104
  end
end
