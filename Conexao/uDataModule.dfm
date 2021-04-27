object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 181
  Width = 317
  object conexaoBanco: TFDConnection
    Params.Strings = (
      'Server='
      'Port='
      'DriverID=PG')
    Left = 32
    Top = 16
  end
  object driver: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\AProjeto\trunk\lib\' +
      'libpq.dll'
    Left = 104
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrHourGlass
    Left = 208
    Top = 16
  end
  object dsControleAcesso: TDataSource
    DataSet = cdsControleAcesso
    Left = 96
    Top = 96
  end
  object query: TFDQuery
    Connection = conexaoBanco
    SQL.Strings = (
      'select id_usuario, login from login_usuario')
    Left = 24
    Top = 88
  end
  object cdsControleAcesso: TClientDataSet
    PersistDataPacket.Data = {
      8D0000009619E0BD0100000018000000050000000000030000008D000A63645F
      7573756172696F04000100000000000763645F6163616F040001000000000007
      6E6D5F6163616F010049000000010005574944544802000200140011666C5F70
      65726D6974655F61636573736F020003000000000011666C5F7065726D697465
      5F65646963616F02000300000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 96
    object cdsControleAcessocd_usuario: TIntegerField
      DisplayLabel = 'C'#243'd Usu'#225'rio'
      FieldName = 'cd_usuario'
    end
    object cdsControleAcessocd_acao: TIntegerField
      DisplayLabel = 'C'#243'd. A'#231#227'o'
      FieldName = 'cd_acao'
    end
    object cdsControleAcessonm_acao: TStringField
      DisplayLabel = 'Nome A'#231#227'o'
      FieldName = 'nm_acao'
    end
    object cdsControleAcessofl_permite_acesso: TBooleanField
      DisplayLabel = 'Permite Acesso'
      FieldName = 'fl_permite_acesso'
    end
    object cdsControleAcessofl_permite_edicao: TBooleanField
      DisplayLabel = 'Permite Edi'#231#227'o'
      FieldName = 'fl_permite_edicao'
    end
  end
end
