object frmVisualizaPedidoVenda: TfrmVisualizaPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Visualiza'#231#227'o de Pedido de Venda'
  ClientHeight = 673
  ClientWidth = 1026
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010100001000400280100001600000028000000100000002000
    000001000400000000008000000000000000000000001000000000000000B1B1
    B100FFFFFF003434340044444400F5F5F500B0B0B000FEFEFE002F2F2F003131
    310033333300EBEBEB0000000000000000000000000000000000000000001111
    1111111111111111111111111111111111119111111111111111991111111111
    1111991111111111111191111111119996119991111119999999999111117991
    9999999411111111118999991111111115912999991111119999113999991111
    A111111109991111111111111111111111111111111111111111111111110000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1026
    Height = 673
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 2
    object Label1: TLabel
      Left = 131
      Top = 32
      Width = 72
      Height = 13
      Caption = 'N'#250'mero Pedido'
    end
    object Label2: TLabel
      Left = 131
      Top = 66
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label3: TLabel
      Left = 231
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Nome Completo'
    end
    object Label4: TLabel
      Left = 575
      Top = 66
      Width = 50
      Height = 13
      Caption = 'Cidade/UF'
    end
    object Label5: TLabel
      Left = 131
      Top = 136
      Width = 87
      Height = 13
      Caption = 'Forma Pagamento'
    end
    object Label6: TLabel
      Left = 575
      Top = 136
      Width = 86
      Height = 13
      Caption = 'Cond. Pagamento'
    end
    object Label16: TLabel
      Left = 131
      Top = 560
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label17: TLabel
      Left = 213
      Top = 562
      Width = 64
      Height = 13
      Caption = 'Acr'#233'scimo R$'
    end
    object Label18: TLabel
      Left = 301
      Top = 562
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object lblStatus: TJvBehaviorLabel
      Left = 22
      Top = 622
      Width = 148
      Height = 23
      Caption = 'Pedido Cancelado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtCdFormaPgto: TEdit
      Left = 131
      Top = 155
      Width = 87
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtCdCondPgto: TEdit
      Left = 574
      Top = 155
      Width = 87
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtNomeCondPgto: TEdit
      Left = 672
      Top = 155
      Width = 236
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object dbGridProdutos: TDBGrid
      Left = 128
      Top = 216
      Width = 873
      Height = 321
      DataSource = dsProdutos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbGridProdutosDrawColumnCell
    end
    object edtVlDescTotalPedido: TEdit
      Left = 131
      Top = 581
      Width = 61
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 213
      Top = 581
      Width = 61
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtVlTotalPedido: TEdit
      Left = 301
      Top = 581
      Width = 61
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 5
    end
    object btnCancelar: TButton
      Left = 906
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = btnCancelarClick
    end
    object btnImprimir: TButton
      Left = 22
      Top = 85
      Width = 81
      Height = 36
      Caption = 'Imprimir'
      TabOrder = 8
      OnClick = btnImprimirClick
    end
    object btnSalvar: TButton
      Left = 22
      Top = 127
      Width = 81
      Height = 34
      Caption = 'Salvar'
      TabOrder = 9
      OnClick = btnSalvarClick
    end
  end
  object edtNrPedido: TEdit
    Left = 233
    Top = 31
    Width = 105
    Height = 21
    TabOrder = 0
    OnExit = edtNrPedidoExit
  end
  object edtCdCliente: TEdit
    Left = 133
    Top = 87
    Width = 87
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 1
  end
  object edtNomeCliente: TEdit
    Left = 233
    Top = 87
    Width = 329
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object edtCidadeCliente: TEdit
    Left = 577
    Top = 87
    Width = 329
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object edtNomeFormaPgto: TEdit
    Left = 233
    Top = 157
    Width = 329
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object edtFl_orcamento: TCheckBox
    Left = 384
    Top = 33
    Width = 73
    Height = 17
    Caption = 'Or'#231'amento'
    Enabled = False
    TabOrder = 6
  end
  object btnEditarPedido: TButton
    Left = 24
    Top = 48
    Width = 81
    Height = 36
    Caption = 'Editar Pedido'
    TabOrder = 7
    OnClick = btnEditarPedidoClick
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      8A0200009619E0BD0100000018000000110000000000030000008A020A63645F
      70726F6475746F04000100000000000C646573635F70726F6475746F01004900
      00000100055749445448020002001400097174645F76656E6461080004000000
      00000F63645F746162656C615F707265636F040001000000000009756E5F6D65
      6469646101004900000001000557494454480200020014000B766C5F756E6974
      6172696F080004000000010007535542545950450200490006004D6F6E657900
      0B766C5F646573636F6E746F0800040000000100075355425459504502004900
      06004D6F6E6579000D766C5F746F74616C5F6974656D08000400000001000753
      5542545950450200490006004D6F6E6579000C69636D735F766C5F6261736508
      0004000000010007535542545950450200490006004D6F6E6579000C69636D73
      5F70635F616C6971080004000000010007535542545950450200490006004D6F
      6E6579000A69636D735F76616C6F720800040000000100075355425459504502
      00490006004D6F6E6579000B6970695F766C5F62617365080004000000010007
      535542545950450200490006004D6F6E6579000B6970695F70635F616C697108
      0004000000010007535542545950450200490006004D6F6E657900096970695F
      76616C6F72080004000000010007535542545950450200490006004D6F6E6579
      00127069735F636F66696E735F766C5F62617365080004000000010007535542
      545950450200490006004D6F6E657900127069735F636F66696E735F70635F61
      6C6971080004000000010007535542545950450200490006004D6F6E65790010
      7069735F636F66696E735F76616C6F7208000400000001000753554254595045
      0200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 352
    object cdsProdutoscd_produto: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'cd_produto'
    end
    object cdsProdutosdesc_produto: TStringField
      DisplayLabel = 'Desc. Produto'
      FieldName = 'desc_produto'
    end
    object cdsProdutosqtd_venda: TFloatField
      DisplayLabel = 'Qtd Venda'
      FieldName = 'qtd_venda'
    end
    object cdsProdutoscd_tabela_preco: TIntegerField
      DisplayLabel = 'Tabela Preco'
      FieldName = 'cd_tabela_preco'
    end
    object cdsProdutosun_medida: TStringField
      DisplayLabel = 'Un Medida'
      FieldName = 'un_medida'
    end
    object cdsProdutosvl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
    end
    object cdsProdutosvl_desconto: TCurrencyField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'vl_desconto'
    end
    object cdsProdutosvl_total_item: TCurrencyField
      DisplayLabel = 'Valor Total Item'
      FieldName = 'vl_total_item'
    end
    object cdsProdutosicms_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base ICMS'
      FieldName = 'icms_vl_base'
    end
    object cdsProdutosicms_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. ICMS'
      FieldName = 'icms_pc_aliq'
    end
    object cdsProdutosicms_valor: TCurrencyField
      DisplayLabel = 'Valor ICMS'
      FieldName = 'icms_valor'
    end
    object cdsProdutosipi_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base IPI'
      FieldName = 'ipi_vl_base'
    end
    object cdsProdutosipi_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. IPI'
      FieldName = 'ipi_pc_aliq'
    end
    object cdsProdutosipi_valor: TCurrencyField
      DisplayLabel = 'Valor IPI'
      FieldName = 'ipi_valor'
    end
    object cdsProdutospis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base PIS/COFINS'
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsProdutospis_cofins_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. PIS/COFINS'
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsProdutospis_cofins_valor: TCurrencyField
      DisplayLabel = 'Valor PIS/COFINS'
      FieldName = 'pis_cofins_valor'
    end
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 248
    Top = 352
  end
  object frxRelatorio: TfrxReport
    Version = '6.2.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44149.832557638900000000
    ReportOptions.LastChange = 44149.892193865740000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 472
    Top = 576
    Datasets = <
      item
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
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
      object ReportTitle1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 83.149660000000000000
          Width = 230.551330000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Impress'#227'o do Pedido de Venda Nr. ')
          ParentFont = False
        end
        object dsPedidonr_pedido1: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 321.260050000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'nr_pedido'
          DataSet = frxdsPedido
          DataSetName = 'dsPedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsPedido."nr_pedido"]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 120.944960000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        RowCount = 0
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 45.354360000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Forma Pagamento:')
        end
        object dsPedidonm_forma_pag: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 170.078850000000000000
          Top = 45.354360000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataField = 'nm_forma_pag'
          DataSet = frxdsPedido
          DataSetName = 'dsPedido'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsPedido."nm_forma_pag"]')
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 86.929190000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Condi'#231#227'o Pagamento:')
        end
        object dsPedidonm_cond_pag: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 170.078850000000000000
          Top = 86.929190000000000000
          Width = 192.756030000000000000
          Height = 18.897650000000000000
          DataField = 'nm_cond_pag'
          DataSet = frxdsPedido
          DataSetName = 'dsPedido'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsPedido."nm_cond_pag"]')
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 86.929190000000000000
          Top = 11.338590000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Cliente:')
        end
        object dsPedidonome: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 170.078850000000000000
          Top = 11.338590000000000000
          Width = 188.976500000000000000
          Height = 18.897650000000000000
          DataField = 'nome'
          DataSet = frxdsPedido
          DataSetName = 'dsPedido'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsPedido."nome"]')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 404.409710000000000000
          Top = 11.338590000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Situa'#231#227'o:')
        end
        object dsPedidocancelado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 495.118430000000000000
          Top = 11.338590000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataField = 'cancelado'
          DataSet = frxdsPedido
          DataSetName = 'dsPedido'
          Frame.Typ = []
          Memo.UTF8W = (
            '[dsPedido."cancelado"]')
        end
      end
      object dsPedidocd_produto: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 15.118120000000000000
        Top = 351.496290000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'cd_produto'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."cd_produto"]')
      end
      object dsPedidodesc_produto: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 128.504020000000000000
        Top = 351.496290000000000000
        Width = 139.842610000000000000
        Height = 18.897650000000000000
        DataField = 'desc_produto'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."desc_produto"]')
      end
      object dsPedidoqtd_venda: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 283.464750000000000000
        Top = 347.716760000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'qtd_venda'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."qtd_venda"]')
      end
      object dsPedidoun_medida: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 377.953000000000000000
        Top = 347.716760000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'un_medida'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."un_medida"]')
      end
      object dsPedidovl_unitario: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 483.779840000000000000
        Top = 347.716760000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'vl_unitario'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."vl_unitario"]')
      end
      object dsPedidototal_item: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 578.268090000000000000
        Top = 351.496290000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'total_item'
        DataSet = frxdsPedido
        DataSetName = 'dsPedido'
        Frame.Typ = []
        Memo.UTF8W = (
          '[dsPedido."total_item"]')
      end
      object Memo12: TfrxMemoView
        AllowVectorExport = True
        Left = 582.047620000000000000
        Top = 430.866420000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'Valor Total')
      end
      object Memo10: TfrxMemoView
        AllowVectorExport = True
        Left = 487.559370000000000000
        Top = 430.866420000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'Valor Unit'#225'rio')
      end
      object Memo11: TfrxMemoView
        AllowVectorExport = True
        Left = 381.732530000000000000
        Top = 430.866420000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'UN Medida')
      end
      object Memo9: TfrxMemoView
        AllowVectorExport = True
        Left = 287.244280000000000000
        Top = 430.866420000000000000
        Width = 86.929190000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'Quantidade')
      end
      object Memo8: TfrxMemoView
        AllowVectorExport = True
        Left = 128.504020000000000000
        Top = 430.866420000000000000
        Width = 139.842610000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'Descri'#231#227'o')
      end
      object Memo7: TfrxMemoView
        AllowVectorExport = True
        Left = 15.118120000000000000
        Top = 430.866420000000000000
        Width = 102.047310000000000000
        Height = 18.897650000000000000
        Frame.Typ = []
        Memo.UTF8W = (
          'C'#243'd. Produto')
      end
    end
  end
  object frxdsPedido: TfrxDBDataset
    UserName = 'dsPedido'
    CloseDataSource = False
    DataSet = qry
    BCDToCurrency = False
    Left = 528
    Top = 576
  end
  object qry: TFDQuery
    Connection = frmConexao.conexao
    SQL.Strings = (
      'select'
      '    pv.nr_pedido,'
      '    pvi.cd_produto,'
      '    p.desc_produto,'
      '    c.cd_cliente,'
      '    c.nome,'
      '    cfp.cd_forma_pag,'
      '    cfp.nm_forma_pag,'
      '    ccp.cd_cond_pag,'
      '    ccp.nm_cond_pag,'
      '    case when pv.fl_cancelado = '#39'S'#39' then'
      '        '#39'CANCELADO'#39
      '    when pv.fl_cancelado = '#39'N'#39' then '
      '        '#39'N'#195'O CANCELADO'#39
      '    end as cancelado,'
      '    pvi.qtd_venda,'
      '    pvi.un_medida,'
      '    pvi.vl_unitario,'
      '    sum(pvi.vl_unitario * pvi.qtd_venda) as total_item,'
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
      '    cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento'
      'where'
      '    pv.nr_pedido = nr_pedido'
      'group by'
      '    pv.nr_pedido,'
      '    pvi.cd_produto,'
      '    p.desc_produto,'
      '    c.cd_cliente,'
      '    c.nome,'
      '    cfp.cd_forma_pag,'
      '    cfp.nm_forma_pag,'
      '    ccp.cd_cond_pag,'
      '    ccp.nm_cond_pag,'
      '    pv.fl_cancelado,'
      '    pvi.qtd_venda,'
      '    pvi.un_medida,'
      '    pvi.vl_unitario,'
      '    pv.vl_total'
      'order by'
      '    pv.nr_pedido')
    Left = 512
    Top = 376
  end
end
