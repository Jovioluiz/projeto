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
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\1.1-Projeto Engenha' +
      'ria\lib\libpq.dll'
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
      'select *from login_usuario')
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
  object dsRelPedidoVenda: TfrxDBDataset
    UserName = 'dsRelPedidoVenda'
    CloseDataSource = False
    DataSet = sqlPedidoVenda
    BCDToCurrency = False
    Left = 232
    Top = 208
  end
  object reportPedidoVenda: TfrxReport
    Version = '6.6.15'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43951.790468807900000000
    ReportOptions.LastChange = 43951.813394849500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 136
    Top = 200
    Datasets = <
      item
        DataSet = dsRelPedidoVenda
        DataSetName = 'dsRelPedidoVenda'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Left = 219.212740000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Visualiza'#231#227'o Pedido de Venda')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 457.323130000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        DataSet = dsRelPedidoVenda
        DataSetName = 'dsRelPedidoVenda'
        RowCount = 0
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 98.267780000000000000
          Top = 68.031540000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Cliente')
          ParentFont = False
        end
        object dsRelPedidoVendacd_cliente: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 173.858380000000000000
          Top = 68.031540000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'cd_cliente'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."cd_cliente"]')
          ParentFont = False
        end
        object dsRelPedidoVendanome: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 268.346630000000000000
          Top = 68.031540000000000000
          Width = 359.055350000000000000
          Height = 18.897650000000000000
          DataField = 'nome'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."nome"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 188.976500000000000000
          Top = 11.338590000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Pedido')
          ParentFont = False
        end
        object dsRelPedidoVendanr_pedido: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 279.685220000000000000
          Top = 11.338590000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'nr_pedido'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."nr_pedido"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 34.015770000000000000
          Top = 105.826840000000000000
          Width = 120.944960000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Forma Pagamento')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 139.842610000000000000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Condi'#231#227'o Pagamento')
          ParentFont = False
        end
        object dsRelPedidoVendacd_forma_pag_1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 173.858380000000000000
          Top = 105.826840000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'cd_forma_pag'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."cd_forma_pag"]')
          ParentFont = False
        end
        object dsRelPedidoVendanm_forma_pag: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 268.346630000000000000
          Top = 105.826840000000000000
          Width = 241.889920000000000000
          Height = 18.897650000000000000
          DataField = 'nm_forma_pag'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."nm_forma_pag"]')
          ParentFont = False
        end
        object dsRelPedidoVendacd_cond_pag: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 173.858380000000000000
          Top = 143.622140000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'cd_cond_pag'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."cd_cond_pag"]')
          ParentFont = False
        end
        object dsRelPedidoVendanm_cond_pag: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 268.346630000000000000
          Top = 143.622140000000000000
          Width = 245.669450000000000000
          Height = 18.897650000000000000
          DataField = 'nm_cond_pag'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."nm_cond_pag"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 215.433210000000000000
          Top = 200.315090000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Itens do Pedido')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 238.110390000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Top = 238.110390000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Top = 238.110390000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Quantidade')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 359.055350000000000000
          Top = 238.110390000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'UN Medida')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 438.425480000000000000
          Top = 238.110390000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Valor Unit'#225'rio')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Top = 238.110390000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Sub-Total')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 608.504330000000000000
          Top = 238.110390000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Total')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 294.803340000000000000
          Width = 706.772110000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 253.228510000000000000
          Height = 41.574830000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 264.567100000000000000
          Top = 253.228510000000000000
          Height = 41.574830000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = 355.275820000000000000
          Top = 253.228510000000000000
          Height = 41.574830000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line5: TfrxLineView
          AllowVectorExport = True
          Left = 434.645950000000000000
          Top = 249.448980000000000000
          Height = 45.354360000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line6: TfrxLineView
          AllowVectorExport = True
          Left = 532.913730000000000000
          Top = 253.228510000000000000
          Height = 41.574830000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line8: TfrxLineView
          AllowVectorExport = True
          Top = 257.008040000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object Line7: TfrxLineView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Top = 257.008040000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
        object dsRelPedidoVendacd_produto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Top = 268.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'cd_produto'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."cd_produto"]')
          ParentFont = False
        end
        object dsRelPedidoVendadesc_produto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 79.370130000000000000
          Top = 268.346630000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          DataField = 'desc_produto'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."desc_produto"]')
          ParentFont = False
        end
        object dsRelPedidoVendaqtd_venda: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 268.346630000000000000
          Top = 268.346630000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'qtd_venda'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."qtd_venda"]')
          ParentFont = False
        end
        object dsRelPedidoVendaun_medida: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 362.834880000000000000
          Top = 268.346630000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'un_medida'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."un_medida"]')
          ParentFont = False
        end
        object dsRelPedidoVendavl_unitario: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 442.205010000000000000
          Top = 268.346630000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'vl_unitario'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."vl_unitario"]')
          ParentFont = False
        end
        object dsRelPedidoVendavl_total_item: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 540.472790000000000000
          Top = 268.346630000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'vl_total_item'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."vl_total_item"]')
          ParentFont = False
        end
        object dsRelPedidoVendavl_total: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 612.283860000000000000
          Top = 268.346630000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'vl_total'
          DataSet = dsRelPedidoVenda
          DataSetName = 'dsRelPedidoVenda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsRelPedidoVenda."vl_total"]')
          ParentFont = False
        end
        object Line9: TfrxLineView
          AllowVectorExport = True
          Left = 706.772110000000000000
          Top = 257.008040000000000000
          Height = 37.795300000000000000
          Color = clBlack
          Frame.Typ = [ftLeft]
        end
      end
    end
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
    Left = 104
    Top = 288
  end
end
