object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 461
  Width = 575
  object conexaoBanco: TFDConnection
    Params.Strings = (
      'Server='
      'Port='
      'DriverID=PG')
    Transaction = transacao
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
    Left = 208
    Top = 16
  end
  object sqlCliente: TFDQuery
    Connection = conexaoBanco
    Left = 16
    Top = 136
  end
  object transacao: TFDTransaction
    Connection = conexaoBanco
    Left = 272
    Top = 16
  end
  object queryControleAcesso: TFDQuery
    Connection = conexaoBanco
    SQL.Strings = (
      'select'
      #9'*'
      'from'
      #9'acoes_sistema a'
      #9'join usuario_acao ua on '
      #9'a.cd_acao = ua.cd_acao ')
    Left = 232
    Top = 80
    object queryControleAcessocd_acao: TIntegerField
      DisplayLabel = 'C'#243'd. A'#231#227'o'
      FieldName = 'cd_acao'
      Origin = 'cd_acao'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryControleAcessonm_acao: TWideStringField
      DisplayLabel = 'Nome A'#231#227'o'
      DisplayWidth = 30
      FieldName = 'nm_acao'
      Origin = 'nm_acao'
      Size = 50
    end
    object queryControleAcessonm_formulario: TWideStringField
      FieldName = 'nm_formulario'
      Origin = 'nm_formulario'
      Visible = False
      Size = 50
    end
    object queryControleAcessodt_atz: TSQLTimeStampField
      FieldName = 'dt_atz'
      Origin = 'dt_atz'
      Visible = False
    end
    object queryControleAcessocd_usuario: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'cd_usuario'
      Origin = 'cd_usuario'
      Visible = False
    end
    object queryControleAcessocd_acao_1: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'cd_acao_1'
      Origin = 'cd_acao'
      Visible = False
    end
    object queryControleAcessofl_permite_acesso: TBooleanField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Permite Acesso'
      FieldName = 'fl_permite_acesso'
      Origin = 'fl_permite_acesso'
    end
    object queryControleAcessodt_atz_1: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'dt_atz_1'
      Origin = 'dt_atz'
      Visible = False
    end
    object queryControleAcessofl_permite_edicao: TBooleanField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Permite Edi'#231#227'o'
      FieldName = 'fl_permite_edicao'
      Origin = 'fl_permite_edicao'
    end
  end
  object tbControleAcesso: TFDTable
    Connection = conexaoBanco
    UpdateOptions.UpdateTableName = 'usuario_acao'
    TableName = 'usuario_acao'
    Left = 232
    Top = 128
  end
  object dsControleAcesso: TDataSource
    DataSet = cdsControleAcesso
    Left = 232
    Top = 176
  end
  object query: TFDQuery
    Connection = conexaoBanco
    SQL.Strings = (
      'select id_usuario, login from login_usuario')
    Left = 16
    Top = 200
  end
  object tbCodBarraProduto: TFDTable
    Connection = conexaoBanco
    UpdateOptions.UpdateTableName = 'produto_cod_barras'
    TableName = 'produto_cod_barras'
    Left = 104
    Top = 136
  end
  object queryCodBarraProduto: TFDQuery
    Connection = conexaoBanco
    Left = 104
    Top = 80
  end
  object dsCodBarraProduto: TDataSource
    DataSet = queryCodBarraProduto
    Left = 104
    Top = 184
  end
  object sqlPedidoVenda: TFDQuery
    Connection = conexaoBanco
    SQL.Strings = (
      'select'
      '    pv.nr_pedido,'
      '    pvi.cd_produto,'
      '    p.desc_produto,'
      '    c.cd_cliente, '
      '    c.nome,'
      '    cfp.cd_forma_pag,'
      '    cfp.nm_forma_pag,'
      '    ccp.cd_cond_pag,'
      '    ccp.nm_cond_pag,'
      '    pvi.qtd_venda, '
      '    pvi.un_medida,'
      '    pvi.vl_unitario, '
      '    pvi.vl_total_item,'
      '    pv.vl_total'
      'from'
      '    pedido_venda pv'
      'join pedido_venda_item pvi on'
      '    pv.id_geral = pvi.id_pedido_venda'
      'join cliente c on'
      '    pv.cd_cliente = c.cd_cliente'
      'join produto p on'
      '    p.cd_produto = pvi.cd_produto'
      'join cta_forma_pagamento cfp on'
      '    pv.cd_forma_pag = cfp.cd_forma_pag'
      'join cta_cond_pagamento ccp on'
      '    cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento')
    Left = 24
    Top = 264
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
    Left = 328
    Top = 176
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
