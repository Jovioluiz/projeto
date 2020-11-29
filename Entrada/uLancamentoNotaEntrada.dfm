object frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Lan'#231'amento Nota Entrada'
  ClientHeight = 720
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 720
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 216
      Top = 85
      Width = 38
      Height = 13
      Caption = 'N'#186' Nota'
    end
    object Label2: TLabel
      Left = 47
      Top = 90
      Width = 24
      Height = 13
      Caption = 'S'#233'rie'
    end
    object Label3: TLabel
      Left = 24
      Top = 16
      Width = 47
      Height = 13
      Caption = 'Opera'#231#227'o'
    end
    object Label4: TLabel
      Left = 456
      Top = 16
      Width = 34
      Height = 13
      Caption = 'Modelo'
    end
    object Label5: TLabel
      Left = 16
      Top = 53
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
    end
    object Label6: TLabel
      Left = 426
      Top = 53
      Width = 64
      Height = 13
      Caption = 'Data Emiss'#227'o'
    end
    object Label7: TLabel
      Left = 402
      Top = 85
      Width = 88
      Height = 13
      Caption = 'Data Recebimento'
    end
    object Label8: TLabel
      Left = 24
      Top = 160
      Width = 40
      Height = 13
      Caption = 'Servi'#231'os'
    end
    object Label9: TLabel
      Left = 120
      Top = 160
      Width = 43
      Height = 13
      Caption = 'Produtos'
    end
    object Label10: TLabel
      Left = 216
      Top = 160
      Width = 51
      Height = 13
      Caption = 'Base ICMS'
    end
    object Label12: TLabel
      Left = 316
      Top = 160
      Width = 52
      Height = 13
      Caption = 'Valor ICMS'
    end
    object Label13: TLabel
      Left = 412
      Top = 160
      Width = 26
      Height = 13
      Caption = 'Frete'
    end
    object Label14: TLabel
      Left = 508
      Top = 160
      Width = 14
      Height = 13
      Caption = 'IPI'
    end
    object Label15: TLabel
      Left = 606
      Top = 160
      Width = 16
      Height = 13
      Caption = 'ISS'
    end
    object Label16: TLabel
      Left = 24
      Top = 232
      Width = 45
      Height = 13
      Caption = 'Desconto'
    end
    object Label17: TLabel
      Left = 120
      Top = 232
      Width = 48
      Height = 13
      Caption = 'Acr'#233'scimo'
    end
    object Label18: TLabel
      Left = 316
      Top = 232
      Width = 29
      Height = 13
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 619
      Top = 53
      Width = 84
      Height = 13
      Caption = 'Data Lan'#231'amento'
    end
    object Label20: TLabel
      Left = 24
      Top = 320
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label21: TLabel
      Left = 103
      Top = 320
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label22: TLabel
      Left = 392
      Top = 312
      Width = 54
      Height = 13
      Caption = 'Un. Medida'
    end
    object Label23: TLabel
      Left = 456
      Top = 312
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label24: TLabel
      Left = 532
      Top = 312
      Width = 26
      Height = 13
      Caption = 'Fator'
    end
    object Label25: TLabel
      Left = 656
      Top = 312
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label26: TLabel
      Left = 726
      Top = 312
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label27: TLabel
      Left = 520
      Top = 342
      Width = 6
      Height = 13
      Caption = 'X'
    end
    object Label28: TLabel
      Left = 596
      Top = 312
      Width = 49
      Height = 13
      Caption = 'Qtd. Total'
    end
    object Label29: TLabel
      Left = 208
      Top = 232
      Width = 82
      Height = 13
      Caption = 'Outras Despesas'
    end
    object edtNroNota: TEdit
      Left = 260
      Top = 82
      Width = 129
      Height = 21
      TabOrder = 4
      OnExit = edtNroNotaExit
    end
    object edtSerie: TEdit
      Left = 77
      Top = 82
      Width = 52
      Height = 21
      TabOrder = 3
      OnExit = edtSerieExit
    end
    object edtCdFornecedor: TEdit
      Left = 77
      Top = 50
      Width = 52
      Height = 21
      TabOrder = 2
      OnChange = edtCdFornecedorChange
      OnExit = edtCdFornecedorExit
    end
    object edtOperacao: TEdit
      Left = 77
      Top = 13
      Width = 52
      Height = 21
      TabOrder = 0
      OnChange = edtOperacaoChange
      OnExit = edtOperacaoExit
    end
    object edtModelo: TEdit
      Left = 510
      Top = 13
      Width = 44
      Height = 21
      TabOrder = 1
      OnChange = edtModeloChange
      OnExit = edtModeloExit
    end
    object edtNomeOperacao: TEdit
      Left = 144
      Top = 13
      Width = 245
      Height = 21
      Enabled = False
      TabOrder = 8
    end
    object edtNomeFornecedor: TEdit
      Left = 144
      Top = 50
      Width = 245
      Height = 21
      Enabled = False
      TabOrder = 9
    end
    object edtNomeModelo: TEdit
      Left = 560
      Top = 13
      Width = 249
      Height = 21
      Enabled = False
      TabOrder = 10
    end
    object edtDataEmissao: TDateTimePicker
      Left = 510
      Top = 50
      Width = 100
      Height = 21
      Date = 43905.000000000000000000
      Time = 0.811114513890061100
      TabOrder = 5
    end
    object edtDataRecebimento: TDateTimePicker
      Left = 510
      Top = 77
      Width = 100
      Height = 21
      Date = 43905.000000000000000000
      Time = 0.811114641204767400
      TabOrder = 6
    end
    object edtVlServico: TEdit
      Left = 24
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 11
      Text = '0,00'
      OnExit = edtVlServicoExit
    end
    object edtVlProduto: TEdit
      Left = 120
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 12
      Text = '0,00'
      OnExit = edtVlProdutoExit
    end
    object edtBaseIcms: TEdit
      Left = 216
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 13
      Text = '0,00'
    end
    object edtValorIcms: TEdit
      Left = 316
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 14
      Text = '0,00'
    end
    object edtValorFrete: TEdit
      Left = 412
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 15
      Text = '0,00'
      OnExit = edtValorFreteExit
    end
    object edtValorIPI: TEdit
      Left = 508
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 16
      Text = '0,00'
      OnExit = edtValorIPIExit
    end
    object edtValorISS: TEdit
      Left = 606
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 17
      Text = '0,00'
    end
    object edtValorDesconto: TEdit
      Left = 24
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 18
      Text = '0,00'
      OnExit = edtValorDescontoExit
    end
    object edtValorAcrescimo: TEdit
      Left = 120
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 19
      Text = '0,00'
      OnExit = edtValorAcrescimoExit
    end
    object edtValorTotalNota: TEdit
      Left = 316
      Top = 251
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 21
      Text = '0,00'
    end
    object edtCodProduto: TEdit
      Left = 24
      Top = 339
      Width = 73
      Height = 21
      TabOrder = 22
      OnChange = edtCodProdutoChange
      OnEnter = edtCodProdutoEnter
      OnExit = edtCodProdutoExit
    end
    object edtDescricaoProduto: TEdit
      Left = 103
      Top = 339
      Width = 269
      Height = 21
      Enabled = False
      TabOrder = 23
    end
    object edtUnMedida: TEdit
      Left = 395
      Top = 339
      Width = 51
      Height = 21
      TabOrder = 24
    end
    object edtQuantidade: TEdit
      Left = 456
      Top = 339
      Width = 56
      Height = 21
      TabOrder = 25
      OnChange = edtQuantidadeChange
      OnExit = edtQuantidadeExit
    end
    object edtFatorConversao: TEdit
      Left = 532
      Top = 339
      Width = 51
      Height = 21
      Enabled = False
      TabOrder = 26
    end
    object edtValorUnitario: TEdit
      Left = 656
      Top = 339
      Width = 64
      Height = 21
      TabOrder = 28
      OnChange = edtValorUnitarioChange
    end
    object edtValorTotalProduto: TEdit
      Left = 726
      Top = 339
      Width = 67
      Height = 21
      TabOrder = 29
    end
    object edtQuantidadeTotalProduto: TEdit
      Left = 596
      Top = 339
      Width = 51
      Height = 21
      Enabled = False
      TabOrder = 27
    end
    object edtDataLancamento: TDateTimePicker
      Left = 709
      Top = 53
      Width = 100
      Height = 21
      Date = 43907.000000000000000000
      Time = 0.811114780095522300
      TabOrder = 7
    end
    object edtValorOutrasDespesas: TEdit
      Left = 208
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 20
      Text = '0,00'
      OnExit = edtValorOutrasDespesasExit
    end
    object btnAddItens: TButton
      Left = 799
      Top = 337
      Width = 42
      Height = 26
      Caption = '+'
      TabOrder = 30
      OnClick = btnAddItensClick
    end
    object DBGridProdutos: TDBGrid
      Left = 24
      Top = 409
      Width = 817
      Height = 265
      DataSource = dsEntrada
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 31
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGridProdutosDblClick
      OnKeyDown = DBGridProdutosKeyDown
    end
    object btnConfirmar: TButton
      Left = 632
      Top = 680
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 32
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 726
      Top = 680
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 33
      OnClick = btnCancelarClick
    end
  end
  object sqlCabecalho: TFDQuery
    Connection = dm.conexaoBanco
    Left = 112
    Top = 8
  end
  object dsEntrada: TDataSource
    DataSet = cdsEntrada
    Left = 184
    Top = 472
  end
  object cdsEntrada: TClientDataSet
    PersistDataPacket.Data = {
      F90200009619E0BD010000001800000015000000000003000000F9020C736571
      5F6974656D5F6E666904000100000000000A63645F70726F6475746F04000100
      000000000964657363726963616F010049000000010005574944544802000200
      140009756E5F6D65646964610100490000000100055749445448020002001400
      0B7174645F6573746F71756508000400000000000F6661746F725F636F6E7665
      7273616F0800040000000000097174645F746F74616C08000400000000000B76
      6C5F756E69746172696F08000400000001000753554254595045020049000600
      4D6F6E65790008766C5F746F74616C0800040000000100075355425459504502
      00490006004D6F6E6579000C69636D735F766C5F626173650800040000000100
      07535542545950450200490006004D6F6E6579000C69636D735F70635F616C69
      71080004000000010007535542545950450200490006004D6F6E6579000A6963
      6D735F76616C6F72080004000000010007535542545950450200490006004D6F
      6E6579000B6970695F766C5F6261736508000400000001000753554254595045
      0200490006004D6F6E6579000B6970695F70635F616C69710800040000000100
      07535542545950450200490006004D6F6E657900096970695F76616C6F720800
      04000000010007535542545950450200490006004D6F6E657900127069735F63
      6F66696E735F766C5F6261736508000400000001000753554254595045020049
      0006004D6F6E657900127069735F636F66696E735F70635F616C697108000400
      0000010007535542545950450200490006004D6F6E657900107069735F636F66
      696E735F76616C6F72080004000000010007535542545950450200490006004D
      6F6E6579000B6973735F766C5F62617365080004000000010007535542545950
      450200490006004D6F6E6579000B6973735F70635F616C697108000400000001
      0007535542545950450200490006004D6F6E657900096973735F76616C6F7208
      0004000000010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 472
    object cdsEntradaseq_item_nfi: TIntegerField
      DisplayLabel = 'Seq'
      DisplayWidth = 4
      FieldName = 'seq_item_nfi'
    end
    object cdsEntradacd_produto: TIntegerField
      DisplayLabel = 'C'#243'd Produto'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsEntradadescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 29
      FieldName = 'descricao'
    end
    object cdsEntradaun_medida: TStringField
      DisplayLabel = 'UN Medida'
      DisplayWidth = 9
      FieldName = 'un_medida'
    end
    object cdsEntradaqtd_estoque: TFloatField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 10
      FieldName = 'qtd_estoque'
    end
    object cdsEntradafator_conversao: TFloatField
      DisplayLabel = 'Fator Convers'#227'o'
      DisplayWidth = 13
      FieldName = 'fator_conversao'
    end
    object cdsEntradaqtd_total: TFloatField
      DisplayLabel = 'Qtd Total'
      DisplayWidth = 10
      FieldName = 'qtd_total'
    end
    object cdsEntradavl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 10
      FieldName = 'vl_unitario'
    end
    object cdsEntradavl_total: TCurrencyField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 10
      FieldName = 'vl_total'
    end
    object cdsEntradaicms_vl_base: TCurrencyField
      DisplayLabel = 'Vl Base ICMS'
      DisplayWidth = 10
      FieldName = 'icms_vl_base'
    end
    object cdsEntradaicms_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq ICMS'
      DisplayWidth = 10
      FieldName = 'icms_pc_aliq'
    end
    object cdsEntradaicms_valor: TCurrencyField
      DisplayLabel = 'Vl ICMS'
      DisplayWidth = 10
      FieldName = 'icms_valor'
    end
    object cdsEntradaipi_vl_base: TCurrencyField
      DisplayLabel = 'Vl Base IPI'
      DisplayWidth = 10
      FieldName = 'ipi_vl_base'
    end
    object cdsEntradaipi_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. IPI'
      DisplayWidth = 7
      FieldName = 'ipi_pc_aliq'
    end
    object cdsEntradaipi_valor: TCurrencyField
      DisplayLabel = 'Vl IPI'
      DisplayWidth = 8
      FieldName = 'ipi_valor'
    end
    object cdsEntradapis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'Vl Base PIS/COFINS'
      DisplayWidth = 15
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsEntradapis_cofins_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq PIS/COFINS'
      DisplayWidth = 14
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsEntradapis_cofins_valor: TCurrencyField
      DisplayLabel = 'Vl PIS/COFINS'
      DisplayWidth = 12
      FieldName = 'pis_cofins_valor'
    end
    object cdsEntradaiss_vl_base: TCurrencyField
      DisplayLabel = 'Vl Base ISS'
      DisplayWidth = 10
      FieldName = 'iss_vl_base'
      Visible = False
    end
    object cdsEntradaiss_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq ISS'
      DisplayWidth = 6
      FieldName = 'iss_pc_aliq'
      Visible = False
    end
    object cdsEntradaiss_valor: TCurrencyField
      DisplayLabel = 'Vl ISS'
      DisplayWidth = 10
      FieldName = 'iss_valor'
      Visible = False
    end
  end
  object sqlIdGeral: TFDQuery
    Connection = dm.conexaoBanco
    Left = 352
    Top = 472
  end
  object sqlInsert: TFDQuery
    Connection = dm.conexaoBanco
    Left = 424
    Top = 472
  end
  object sqlInsertiNfi: TFDQuery
    Connection = dm.conexaoBanco
    Left = 600
    Top = 480
  end
end
