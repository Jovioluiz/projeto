object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pedido de Venda'
  ClientHeight = 622
  ClientWidth = 869
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
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 622
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 72
      Height = 13
      Caption = 'N'#250'mero Pedido'
    end
    object Label2: TLabel
      Left = 24
      Top = 66
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label3: TLabel
      Left = 117
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Nome Completo'
    end
    object Label4: TLabel
      Left = 494
      Top = 66
      Width = 50
      Height = 13
      Caption = 'Cidade/UF'
    end
    object Label5: TLabel
      Left = 24
      Top = 136
      Width = 87
      Height = 13
      Caption = 'Forma Pagamento'
    end
    object Label6: TLabel
      Left = 494
      Top = 136
      Width = 86
      Height = 13
      Caption = 'Cond. Pagamento'
    end
    object Label7: TLabel
      Left = 26
      Top = 208
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label8: TLabel
      Left = 117
      Top = 208
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label9: TLabel
      Left = 573
      Top = 208
      Width = 36
      Height = 13
      Caption = 'Qtdade'
    end
    object Label10: TLabel
      Left = 661
      Top = 208
      Width = 41
      Height = 13
      Caption = 'UN Med.'
    end
    object Label11: TLabel
      Left = 24
      Top = 264
      Width = 62
      Height = 13
      Caption = 'Tabela Pre'#231'o'
    end
    object Label12: TLabel
      Left = 117
      Top = 264
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label13: TLabel
      Left = 573
      Top = 264
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label14: TLabel
      Left = 721
      Top = 264
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label15: TLabel
      Left = 650
      Top = 264
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label16: TLabel
      Left = 26
      Top = 544
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label17: TLabel
      Left = 117
      Top = 544
      Width = 64
      Height = 13
      Caption = 'Acr'#233'scimo R$'
    end
    object Label18: TLabel
      Left = 213
      Top = 544
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label19: TLabel
      Left = 663
      Top = 32
      Width = 64
      Height = 13
      Caption = 'Data Emiss'#227'o'
    end
    object edtCdFormaPgto: TEdit
      Left = 24
      Top = 167
      Width = 87
      Height = 21
      TabOrder = 1
      OnChange = edtCdFormaPgtoChange
      OnExit = edtCdFormaPgtoExit
    end
    object edtCdCondPgto: TEdit
      Left = 494
      Top = 167
      Width = 87
      Height = 21
      TabOrder = 2
      OnChange = edtCdCondPgtoChange
      OnExit = edtCdCondPgtoExit
    end
    object edtNomeCondPgto: TEdit
      Left = 587
      Top = 167
      Width = 236
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object edtCdProduto: TEdit
      Left = 24
      Top = 227
      Width = 87
      Height = 21
      TabOrder = 3
      OnChange = edtCdProdutoChange
      OnEnter = edtCdProdutoEnter
      OnExit = edtCdProdutoExit
    end
    object edtDescProduto: TEdit
      Left = 117
      Top = 227
      Width = 427
      Height = 21
      Enabled = False
      TabOrder = 16
    end
    object edtQtdade: TEdit
      Left = 573
      Top = 227
      Width = 65
      Height = 21
      TabOrder = 4
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
    object edtUnMedida: TComboBox
      Left = 662
      Top = 227
      Width = 65
      Height = 21
      TabOrder = 5
    end
    object edtCdtabelaPreco: TEdit
      Left = 24
      Top = 283
      Width = 87
      Height = 21
      TabOrder = 6
      OnChange = edtCdtabelaPrecoChange
      OnExit = edtCdtabelaPrecoExit
    end
    object edtVlUnitario: TEdit
      Left = 573
      Top = 283
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object edtVlTotal: TEdit
      Left = 721
      Top = 283
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object btnAdicionar: TButton
      Left = 792
      Top = 281
      Width = 63
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 10
      OnClick = btnAdicionarClick
    end
    object dbGridProdutos: TDBGrid
      Left = 26
      Top = 320
      Width = 831
      Height = 201
      DataSource = dsPedidoVenda
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 17
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbGridProdutosDrawColumnCell
      OnDblClick = dbGridProdutosDblClick
      OnKeyDown = dbGridProdutosKeyDown
    end
    object edtVlDescontoItem: TEdit
      Left = 650
      Top = 283
      Width = 65
      Height = 21
      TabOrder = 8
      OnExit = edtVlDescontoItemExit
    end
    object edtVlDescTotalPedido: TEdit
      Left = 26
      Top = 563
      Width = 61
      Height = 21
      TabOrder = 11
      Text = '0.00'
      OnExit = edtVlDescTotalPedidoExit
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 117
      Top = 563
      Width = 61
      Height = 21
      TabOrder = 12
      Text = '0.00'
      OnExit = edtVlAcrescimoTotalPedidoExit
    end
    object edtVlTotalPedido: TEdit
      Left = 213
      Top = 563
      Width = 61
      Height = 21
      TabOrder = 13
      Text = '0.00'
    end
    object btnConfirmarPedido: TButton
      Left = 661
      Top = 563
      Width = 95
      Height = 32
      Caption = 'Confirmar'
      TabOrder = 14
      OnClick = btnConfirmarPedidoClick
    end
    object btnCancelar: TButton
      Left = 762
      Top = 563
      Width = 95
      Height = 32
      Caption = 'Cancelar'
      TabOrder = 15
      OnClick = btnCancelarClick
    end
    object edtDataEmissao: TMaskEdit
      Left = 753
      Top = 29
      Width = 70
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 18
      Text = '  /  /    '
    end
  end
  object edtNrPedido: TEdit
    Left = 112
    Top = 31
    Width = 105
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtCdCliente: TEdit
    Left = 26
    Top = 87
    Width = 87
    Height = 21
    TabOrder = 0
    OnChange = edtCdClienteChange
    OnExit = edtCdClienteExit
  end
  object edtNomeCliente: TEdit
    Left = 119
    Top = 87
    Width = 329
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object edtCidadeCliente: TEdit
    Left = 496
    Top = 87
    Width = 329
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object edtNomeFormaPgto: TEdit
    Left = 119
    Top = 169
    Width = 329
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtDescTabelaPreco: TEdit
    Left = 119
    Top = 285
    Width = 427
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object edtFl_orcamento: TCheckBox
    Left = 280
    Top = 33
    Width = 73
    Height = 17
    Caption = 'Or'#231'amento'
    TabOrder = 7
  end
  object cdsPedidoVenda: TClientDataSet
    PersistDataPacket.Data = {
      930200009619E0BD01000000180000001200000000000300000093020A63645F
      70726F6475746F04000100000000000964657363726963616F01004900000001
      00055749445448020002001400097174645F76656E646108000400000000000F
      63645F746162656C615F707265636F040001000000000009756E5F6D65646964
      6101004900000001000557494454480200020014000B766C5F756E6974617269
      6F080004000000010007535542545950450200490006004D6F6E6579000B766C
      5F646573636F6E746F080004000000010007535542545950450200490006004D
      6F6E6579000D766C5F746F74616C5F6974656D08000400000001000753554254
      5950450200490006004D6F6E6579000C69636D735F766C5F6261736508000400
      0000010007535542545950450200490006004D6F6E6579000C69636D735F7063
      5F616C6971080004000000010007535542545950450200490006004D6F6E6579
      000A69636D735F76616C6F720800040000000100075355425459504502004900
      06004D6F6E6579000B6970695F766C5F62617365080004000000010007535542
      545950450200490006004D6F6E6579000B6970695F70635F616C697108000400
      0000010007535542545950450200490006004D6F6E657900096970695F76616C
      6F72080004000000010007535542545950450200490006004D6F6E6579001270
      69735F636F66696E735F766C5F62617365080004000000010007535542545950
      450200490006004D6F6E657900127069735F636F66696E735F70635F616C6971
      080004000000010007535542545950450200490006004D6F6E65790010706973
      5F636F66696E735F76616C6F7208000400000001000753554254595045020049
      0006004D6F6E6579000373657104000100000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_produto'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'qtd_venda'
        DataType = ftFloat
      end
      item
        Name = 'cd_tabela_preco'
        DataType = ftInteger
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'vl_unitario'
        DataType = ftCurrency
      end
      item
        Name = 'vl_desconto'
        DataType = ftCurrency
      end
      item
        Name = 'vl_total_item'
        DataType = ftCurrency
      end
      item
        Name = 'icms_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'icms_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'icms_valor'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_valor'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_valor'
        DataType = ftCurrency
      end
      item
        Name = 'seq'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 336
    Top = 408
    object intgrfldPedidoVendaseq: TIntegerField
      DisplayLabel = 'Seq.'
      DisplayWidth = 4
      FieldName = 'seq'
    end
    object intgrfldPedidoVendacd_produto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsPedidoVendadescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 29
      FieldName = 'descricao'
    end
    object cdsPedidoVendaqtd_venda: TFloatField
      DisplayLabel = 'Qtdade'
      DisplayWidth = 5
      FieldName = 'qtd_venda'
    end
    object intgrfldPedidoVendacd_tabela_preco: TIntegerField
      DisplayLabel = 'Tabela Preco'
      DisplayWidth = 11
      FieldName = 'cd_tabela_preco'
    end
    object cdsPedidoVendaun_medida: TStringField
      DisplayLabel = 'UN Medida'
      DisplayWidth = 8
      FieldName = 'un_medida'
    end
    object cdsPedidoVendavl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 10
      FieldName = 'vl_unitario'
    end
    object cdsPedidoVendavl_desconto: TCurrencyField
      DisplayLabel = 'Desconto'
      DisplayWidth = 7
      FieldName = 'vl_desconto'
    end
    object cdsPedidoVendavl_total_item: TCurrencyField
      DisplayLabel = 'Total Item'
      DisplayWidth = 10
      FieldName = 'vl_total_item'
    end
    object cdsPedidoVendaicms_vl_base: TCurrencyField
      DisplayLabel = 'Base ICMS'
      DisplayWidth = 10
      FieldName = 'icms_vl_base'
    end
    object cdsPedidoVendaicms_pc_aliq: TCurrencyField
      DisplayLabel = 'ICMS Aliq.'
      DisplayWidth = 8
      FieldName = 'icms_pc_aliq'
    end
    object cdsPedidoVendaicms_valor: TCurrencyField
      DisplayLabel = 'ICMS Valor'
      DisplayWidth = 10
      FieldName = 'icms_valor'
    end
    object cdsPedidoVendaipi_vl_base: TCurrencyField
      DisplayLabel = 'IPI Base'
      DisplayWidth = 7
      FieldName = 'ipi_vl_base'
    end
    object cdsPedidoVendaipi_pc_aliq: TCurrencyField
      DisplayLabel = 'IPI Aliq.'
      DisplayWidth = 6
      FieldName = 'ipi_pc_aliq'
    end
    object cdsPedidoVendaipi_valor: TCurrencyField
      DisplayLabel = 'IPI Valor'
      DisplayWidth = 7
      FieldName = 'ipi_valor'
    end
    object cdsPedidoVendapis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'PIS/COFINS Base'
      DisplayWidth = 15
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsPedidoVendapis_cofins_pc_aliq: TCurrencyField
      DisplayLabel = 'PIS/COFINS Aliq.'
      DisplayWidth = 13
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsPedidoVendapis_cofins_valor: TCurrencyField
      DisplayLabel = 'PIS/COFINS Valor'
      DisplayWidth = 14
      FieldName = 'pis_cofins_valor'
    end
  end
  object dsPedidoVenda: TDataSource
    DataSet = cdsPedidoVenda
    Left = 248
    Top = 408
  end
  object document: TXMLDocument
    Left = 536
    Top = 536
  end
end
