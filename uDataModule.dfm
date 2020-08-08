object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 461
  Width = 575
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=postgres'
      'Database=trabalho_engenharia'
      'Password=postgres'
      'Server=localhost'
      'Port=5433'
      'DriverID=PG')
    Left = 32
    Top = 16
  end
  object driver: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\AProjeto\trunk\lib\' +
      'libpq.dll'
    Left = 88
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 16
  end
  object sqlCliente: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select *from cliente')
    Left = 16
    Top = 136
    object sqlClientecd_cliente: TIntegerField
      FieldName = 'cd_cliente'
      Origin = 'cd_cliente'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object sqlClientenome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 45
    end
    object sqlClientetp_pessoa: TWideStringField
      FieldName = 'tp_pessoa'
      Origin = 'tp_pessoa'
      Size = 10
    end
    object sqlClientefl_ativo: TBooleanField
      FieldName = 'fl_ativo'
      Origin = 'fl_ativo'
    end
    object sqlClientetelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 45
    end
    object sqlClientecelular: TWideStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 45
    end
    object sqlClienteemail: TWideStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 45
    end
    object sqlClientecpf_cnpj: TWideStringField
      FieldName = 'cpf_cnpj'
      Origin = 'cpf_cnpj'
      Size = 15
    end
    object sqlClienterg_ie: TWideStringField
      FieldName = 'rg_ie'
      Origin = 'rg_ie'
      Size = 45
    end
    object sqlClientedt_nasc_fundacao: TDateField
      FieldName = 'dt_nasc_fundacao'
      Origin = 'dt_nasc_fundacao'
    end
    object sqlClientefl_fornecedor: TBooleanField
      FieldName = 'fl_fornecedor'
      Origin = 'fl_fornecedor'
    end
    object sqlClientedt_atz: TSQLTimeStampField
      FieldName = 'dt_atz'
      Origin = 'dt_atz'
    end
    object sqlClienteendereco_logradouro: TStringField
      FieldName = 'endereco_logradouro'
      Size = 50
    end
    object sqlClientebairro_descricao: TStringField
      FieldName = 'bairro_descricao'
      Size = 50
    end
    object sqlClientenm_cidade: TStringField
      FieldName = 'nm_cidade'
      Size = 50
    end
    object sqlClienteuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
  object transacao: TFDTransaction
    Connection = FDConnection1
    Left = 216
    Top = 8
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
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'usuario_acao'
    TableName = 'usuario_acao'
    Left = 232
    Top = 128
  end
  object dsControleAcesso: TDataSource
    DataSet = queryControleAcesso
    Left = 232
    Top = 176
  end
  object query: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select id_usuario, login from login_usuario')
    Left = 16
    Top = 200
  end
  object tbCodBarraProduto: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'produto_cod_barras'
    TableName = 'produto_cod_barras'
    Left = 104
    Top = 136
  end
  object queryCodBarraProduto: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produto_cod_barras')
    Left = 104
    Top = 80
    object queryCodBarraProdutocd_produto: TIntegerField
      DisplayLabel = 'C'#243'd Produto'
      FieldName = 'cd_produto'
      Origin = 'cd_produto'
      Visible = False
    end
    object queryCodBarraProdutoun_medida: TWideStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Origin = 'un_medida'
      Size = 10
    end
    object queryCodBarraProdutotipo_cod_barras: TSmallintField
      DisplayLabel = 'Tipo C'#243'd Barras'
      FieldName = 'tipo_cod_barras'
      Origin = 'tipo_cod_barras'
    end
    object queryCodBarraProdutocodigo_barras: TWideStringField
      DisplayLabel = 'C'#243'digo Barras'
      FieldName = 'codigo_barras'
      Origin = 'codigo_barras'
    end
    object queryCodBarraProdutodt_atz: TSQLTimeStampField
      FieldName = 'dt_atz'
      Origin = 'dt_atz'
      Visible = False
    end
  end
  object dsCodBarraProduto: TDataSource
    DataSet = queryCodBarraProduto
    Left = 104
    Top = 184
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
    Left = 16
    Top = 264
  end
end
