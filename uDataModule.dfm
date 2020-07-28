object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 461
  Width = 575
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Port=5433'
      'Database=trabalho_engenharia'
      'Password=postgres'
      'Server=localhost'
      'DriverID=PG')
    Connected = True
    Left = 40
    Top = 32
  end
  object driver: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\AProjeto\trunk\lib\' +
      'libpq.dll'
    Left = 120
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 208
    Top = 32
  end
  object tbClientes: TFDTable
    IndexFieldNames = 'cd_cliente'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'cliente'
    SchemaName = 'public'
    TableName = 'cliente'
    Left = 24
    Top = 128
    object tbClientescd_cliente: TIntegerField
      FieldName = 'cd_cliente'
      Origin = 'cd_cliente'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tbClientesnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 45
    end
    object tbClientestp_pessoa: TWideStringField
      FieldName = 'tp_pessoa'
      Origin = 'tp_pessoa'
      Size = 10
    end
    object tbClientesfl_ativo: TBooleanField
      FieldName = 'fl_ativo'
      Origin = 'fl_ativo'
    end
    object tbClientestelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 45
    end
    object tbClientescelular: TWideStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 45
    end
    object tbClientesemail: TWideStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 45
    end
    object tbClientescpf_cnpj: TWideStringField
      FieldName = 'cpf_cnpj'
      Origin = 'cpf_cnpj'
      Size = 15
    end
    object tbClientesrg_ie: TWideStringField
      FieldName = 'rg_ie'
      Origin = 'rg_ie'
      Size = 45
    end
    object tbClientesdt_nasc_fundacao: TDateField
      FieldName = 'dt_nasc_fundacao'
      Origin = 'dt_nasc_fundacao'
    end
    object tbClientesfl_fornecedor: TBooleanField
      FieldName = 'fl_fornecedor'
      Origin = 'fl_fornecedor'
    end
    object tbClientesdt_atz: TSQLTimeStampField
      FieldName = 'dt_atz'
      Origin = 'dt_atz'
    end
  end
  object DataSource1: TDataSource
    DataSet = tbClientes
    Left = 144
    Top = 128
  end
  object sqlCliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select *from cliente')
    Left = 80
    Top = 128
  end
  object sqlPedidoVenda: TFDQuery
    Connection = FDConnection1
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
    Left = 40
    Top = 200
  end
  object tbProdutos: TFDTable
    IndexFieldNames = 'cd_produto'
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'produto'
    TableName = 'produto'
    Left = 32
    Top = 280
    object tbProdutoscd_produto: TIntegerField
      FieldName = 'cd_produto'
      Origin = 'cd_produto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object tbProdutosfl_ativo: TBooleanField
      FieldName = 'fl_ativo'
      Origin = 'fl_ativo'
    end
    object tbProdutosdesc_produto: TWideStringField
      FieldName = 'desc_produto'
      Origin = 'desc_produto'
      Size = 50
    end
    object tbProdutosun_medida: TWideStringField
      FieldName = 'un_medida'
      Origin = 'un_medida'
      Size = 5
    end
    object tbProdutosfator_conversao: TBCDField
      FieldName = 'fator_conversao'
      Origin = 'fator_conversao'
      Precision = 12
    end
    object tbProdutospeso_liquido: TBCDField
      FieldName = 'peso_liquido'
      Origin = 'peso_liquido'
      Precision = 10
    end
    object tbProdutospeso_bruto: TBCDField
      FieldName = 'peso_bruto'
      Origin = 'peso_bruto'
      Precision = 10
    end
    object tbProdutosobservacao: TWideMemoField
      FieldName = 'observacao'
      Origin = 'observacao'
      BlobType = ftWideMemo
    end
    object tbProdutosdt_atz: TSQLTimeStampField
      FieldName = 'dt_atz'
      Origin = 'dt_atz'
    end
    object tbProdutosqtd_estoque: TBCDField
      FieldName = 'qtd_estoque'
      Origin = 'qtd_estoque'
      Precision = 12
    end
    object tbProdutostipo_cod_barras: TWideStringField
      FieldName = 'tipo_cod_barras'
      Origin = 'tipo_cod_barras'
      Size = 1
    end
    object tbProdutoscodigo_barras: TWideStringField
      FieldName = 'codigo_barras'
      Origin = 'codigo_barras'
      Size = 15
    end
    object tbProdutosimagem: TWideStringField
      FieldName = 'imagem'
      Origin = 'imagem'
      Size = 8190
    end
  end
  object dsProduto: TDataSource
    DataSet = tbProdutos
    Left = 96
    Top = 280
  end
  object transacao: TFDTransaction
    Connection = FDConnection1
    Left = 296
    Top = 32
  end
  object queryControleAcesso: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select'
      #9'*'
      'from'
      #9'acoes_sistema a'
      #9'join usuario_acao ua on '
      #9'a.cd_acao = ua.cd_acao ')
    Left = 504
    Top = 32
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
  end
  object tbControleAcesso: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'usuario_acao'
    TableName = 'usuario_acao'
    Left = 504
    Top = 96
  end
  object dsControleAcesso: TDataSource
    DataSet = queryControleAcesso
    Left = 504
    Top = 160
  end
  object query: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select id_usuario, login from login_usuario')
    Left = 384
    Top = 32
  end
end
