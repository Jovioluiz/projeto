object frmEdicaoPedidoVenda: TfrmEdicaoPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edi'#231#227'o do Pedido Venda'
  ClientHeight = 683
  ClientWidth = 961
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 961
    Height = 683
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 86
      Top = 32
      Width = 72
      Height = 13
      Caption = 'N'#250'mero Pedido'
    end
    object Label2: TLabel
      Left = 86
      Top = 66
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object Label3: TLabel
      Left = 189
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Nome Completo'
    end
    object Label4: TLabel
      Left = 550
      Top = 66
      Width = 50
      Height = 13
      Caption = 'Cidade/UF'
    end
    object Label5: TLabel
      Left = 86
      Top = 128
      Width = 87
      Height = 13
      Caption = 'Forma Pagamento'
    end
    object Label6: TLabel
      Left = 551
      Top = 128
      Width = 86
      Height = 13
      Caption = 'Cond. Pagamento'
    end
    object Label16: TLabel
      Left = 131
      Top = 608
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label17: TLabel
      Left = 221
      Top = 608
      Width = 64
      Height = 13
      Caption = 'Acr'#233'scimo R$'
    end
    object Label18: TLabel
      Left = 309
      Top = 608
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label7: TLabel
      Left = 760
      Top = 27
      Width = 64
      Height = 13
      Caption = 'Data Emiss'#227'o'
    end
    object Label8: TLabel
      Left = 86
      Top = 184
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label9: TLabel
      Left = 189
      Top = 184
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label10: TLabel
      Left = 550
      Top = 184
      Width = 36
      Height = 13
      Caption = 'Qtdade'
    end
    object Label11: TLabel
      Left = 634
      Top = 184
      Width = 41
      Height = 13
      Caption = 'UN Med.'
    end
    object Label12: TLabel
      Left = 86
      Top = 240
      Width = 62
      Height = 13
      Caption = 'Tabela Pre'#231'o'
    end
    object Label13: TLabel
      Left = 189
      Top = 240
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label14: TLabel
      Left = 551
      Top = 240
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label15: TLabel
      Left = 643
      Top = 240
      Width = 45
      Height = 13
      Caption = 'Desconto'
    end
    object Label19: TLabel
      Left = 724
      Top = 240
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object btnConfirmar: TSpeedButton
      Left = 715
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Confirmar'
      OnClick = btnConfirmarClick
    end
    object edtCdFormaPgto: TEdit
      Left = 86
      Top = 147
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      OnChange = edtCdFormaPgtoChange
      OnExit = edtCdFormaPgtoExit
    end
    object edtCdCondPgto: TEdit
      Left = 550
      Top = 147
      Width = 65
      Height = 21
      NumbersOnly = True
      TabOrder = 4
      OnChange = edtCdCondPgtoChange
      OnExit = edtCdCondPgtoExit
    end
    object edtNomeCondPgto: TEdit
      Left = 643
      Top = 147
      Width = 268
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 15
    end
    object edtVlDescTotalPedido: TEdit
      Left = 131
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 13
      OnExit = edtVlDescTotalPedidoExit
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 221
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 14
      OnExit = edtVlAcrescimoTotalPedidoExit
    end
    object edtVlTotalPedido: TEdit
      Left = 309
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 16
    end
    object btnCancelar: TButton
      Left = 816
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Cancelar'
      TabOrder = 17
      OnClick = btnCancelarClick
    end
    object edtDataEmissao: TMaskEdit
      Left = 844
      Top = 24
      Width = 67
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 18
      Text = '  /  /    '
    end
    object edtCdProduto: TEdit
      Left = 86
      Top = 203
      Width = 65
      Height = 21
      TabOrder = 5
      OnChange = edtCdProdutoChange
      OnExit = edtCdProdutoExit
    end
    object edtNomeProduto: TEdit
      Left = 189
      Top = 203
      Width = 329
      Height = 21
      Enabled = False
      TabOrder = 19
    end
    object edtQtdade: TEdit
      Left = 550
      Top = 203
      Width = 65
      Height = 21
      TabOrder = 6
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
    object edtTabelaPreco: TEdit
      Left = 86
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 8
      OnChange = edtTabelaPrecoChange
      OnExit = edtTabelaPrecoExit
    end
    object edtDescTabPreco: TEdit
      Left = 189
      Top = 259
      Width = 329
      Height = 21
      Enabled = False
      TabOrder = 20
    end
    object edtVlUnitario: TEdit
      Left = 550
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object edtVlDesconto: TEdit
      Left = 644
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 10
      OnExit = edtVlDescontoExit
    end
    object edtVlTotal: TEdit
      Left = 724
      Top = 259
      Width = 65
      Height = 21
      Enabled = False
      TabOrder = 11
    end
    object edtUnMedida: TComboBox
      Left = 643
      Top = 203
      Width = 66
      Height = 21
      TabOrder = 7
    end
    object edtCdCliente: TEdit
      Left = 88
      Top = 87
      Width = 65
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtCidadeCliente: TEdit
      Left = 552
      Top = 87
      Width = 361
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 21
    end
    object edtFl_orcamento: TCheckBox
      Left = 344
      Top = 33
      Width = 73
      Height = 17
      Caption = 'Or'#231'amento'
      TabOrder = 1
    end
    object edtNomeCliente: TEdit
      Left = 191
      Top = 87
      Width = 329
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 22
    end
    object edtNomeFormaPgto: TEdit
      Left = 191
      Top = 149
      Width = 329
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 23
    end
    object edtNrPedido: TEdit
      Left = 191
      Top = 31
      Width = 105
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object btnAdicionarItem: TButton
      Left = 806
      Top = 257
      Width = 63
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 12
      OnClick = btnAdicionarItemClick
    end
  end
  object dbGridProdutos: TDBGrid
    Left = 86
    Top = 304
    Width = 825
    Height = 281
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbGridProdutosDblClick
  end
  object cdsItens: TClientDataSet
    PersistDataPacket.Data = {
      4B0200009619E0BD0100000018000000110000000000030000004B020A63645F
      70726F6475746F04000100000000000964657363726963616F01004900000001
      00055749445448020002001400097174645F76656E6461080004000000000009
      756E5F6D656469646101004900000001000557494454480200020014000B766C
      5F756E69746172696F080004000000010007535542545950450200490006004D
      6F6E6579000B766C5F646573636F6E746F080004000000010007535542545950
      450200490006004D6F6E6579000D766C5F746F74616C5F6974656D0800040000
      00010007535542545950450200490006004D6F6E6579000C69636D735F766C5F
      62617365080004000000010007535542545950450200490006004D6F6E657900
      0C69636D735F70635F616C697108000400000000000A69636D735F76616C6F72
      080004000000010007535542545950450200490006004D6F6E6579000B697069
      5F766C5F62617365080004000000010007535542545950450200490006004D6F
      6E6579000B6970695F70635F616C69710800040000000000096970695F76616C
      6F72080004000000010007535542545950450200490006004D6F6E6579001270
      69735F636F66696E735F766C5F62617365080004000000010007535542545950
      450200490006004D6F6E657900127069735F636F66696E735F70635F616C6971
      0800040000000000107069735F636F66696E735F76616C6F7208000400000001
      0007535542545950450200490006004D6F6E6579000F63645F746162656C615F
      707265636F04000100000000000000}
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
        DataType = ftFloat
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
        DataType = ftFloat
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
        DataType = ftFloat
      end
      item
        Name = 'pis_cofins_valor'
        DataType = ftCurrency
      end
      item
        Name = 'cd_tabela_preco'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 328
    Top = 416
    object intgrfldItenscd_produto: TIntegerField
      DisplayLabel = 'C'#243'd Produto'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsItensdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 25
      FieldName = 'descricao'
    end
    object cdsItensqtd_venda: TFloatField
      DisplayLabel = 'Qtde Venda'
      DisplayWidth = 10
      FieldName = 'qtd_venda'
    end
    object cdsItensun_medida: TStringField
      DisplayLabel = 'UN Medida'
      DisplayWidth = 8
      FieldName = 'un_medida'
    end
    object intgrfldItenscd_tabela_preco: TIntegerField
      DisplayLabel = 'Tabela Pre'#231'o'
      FieldName = 'cd_tabela_preco'
    end
    object cdsItensvl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 10
      FieldName = 'vl_unitario'
    end
    object cdsItensvl_desconto: TCurrencyField
      DisplayLabel = 'Desconto'
      DisplayWidth = 7
      FieldName = 'vl_desconto'
    end
    object cdsItensvl_total_item: TCurrencyField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 9
      FieldName = 'vl_total_item'
    end
    object cdsItensicms_vl_base: TCurrencyField
      DisplayLabel = 'Vlr Base ICMS'
      DisplayWidth = 11
      FieldName = 'icms_vl_base'
    end
    object cdsItensicms_pc_aliq: TFloatField
      DisplayLabel = 'Aliq ICMS'
      DisplayWidth = 7
      FieldName = 'icms_pc_aliq'
    end
    object cdsItensicms_valor: TCurrencyField
      DisplayLabel = 'Valor ICMS'
      DisplayWidth = 8
      FieldName = 'icms_valor'
    end
    object cdsItensipi_vl_base: TCurrencyField
      DisplayLabel = 'Vlr IPI Base'
      DisplayWidth = 10
      FieldName = 'ipi_vl_base'
    end
    object cdsItensipi_pc_aliq: TFloatField
      DisplayLabel = 'Aliq IPI'
      DisplayWidth = 6
      FieldName = 'ipi_pc_aliq'
    end
    object cdsItensipi_valor: TCurrencyField
      DisplayLabel = 'Valor IPI'
      DisplayWidth = 7
      FieldName = 'ipi_valor'
    end
    object cdsItenspis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'Vlr PIS/COFINS Base'
      DisplayWidth = 16
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsItenspis_cofins_pc_aliq: TFloatField
      DisplayLabel = 'Aliq PIS/COFINS'
      DisplayWidth = 13
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsItenspis_cofins_valor: TCurrencyField
      DisplayLabel = 'Vlr PIS/COFINS'
      DisplayWidth = 12
      FieldName = 'pis_cofins_valor'
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 248
    Top = 416
  end
  object query: TFDQuery
    Connection = frmConexao.conexao
    Left = 864
    Top = 184
  end
end
