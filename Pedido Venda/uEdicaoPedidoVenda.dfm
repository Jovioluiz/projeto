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
    end
    object edtCdFormaPgto: TEdit
      Left = 86
      Top = 147
      Width = 65
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edtCdCondPgto: TEdit
      Left = 550
      Top = 147
      Width = 87
      Height = 21
      ReadOnly = True
      TabOrder = 4
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
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbGridProdutosDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'C'#243'd. Produto'
        ReadOnly = True
        Title.Color = clWhite
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descri'#231#227'o'
        ReadOnly = True
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Qtdade'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UN Medida'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tabela Pre'#231'o'
        ReadOnly = True
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Unit'#225'rio'
        ReadOnly = True
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Desconto'
        ReadOnly = True
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Total'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Base ICMS '
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Aliq ICMS'
        Width = 53
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor ICMS'
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Base IPI'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Aliq IPI'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor IPI'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Base PIS/COFINS'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Aliq PIS/COFINS'
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor PIS/COFINS'
        Width = 91
        Visible = True
      end>
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 416
  end
  object DataSource1: TDataSource
    DataSet = sqlCarregaPedidoVenda
    Left = 248
    Top = 416
  end
  object sqlCarregaPedidoVenda: TFDQuery
    Connection = frmConexao.conexao
    SQL.Strings = (
      'select'
      #9'pv.nr_pedido,'
      #9'pv.fl_orcamento,'
      #9'pv.cd_cliente,'
      #9'c.nome,'
      #9'e.cidade,'
      #9'e.uf,'
      #9'pv.cd_forma_pag,'
      #9'cfp.nm_forma_pag,'
      #9'pv.cd_cond_pag,'
      #9'ccp.nm_cond_pag,'
      #9'pvi.cd_produto,'
      #9'p.desc_produto,'
      #9'pvi.qtd_venda,'
      #9'pvi.cd_tabela_preco,'
      #9'p.un_medida,'
      #9'pvi.vl_unitario,'
      #9'pvi.vl_desconto,'
      #9'pvi.vl_total_item,'
      #9'pvi.vl_total_item as icms_vl_base,'
      #9'pvi.icms_pc_aliq,'
      #9'((pvi.vl_total_item * pvi.icms_pc_aliq) / 100) as icms_valor,'
      #9'pvi.vl_total_item as ipi_vl_base,'
      #9'pvi.ipi_pc_aliq,'
      #9'((pvi.vl_total_item * pvi.ipi_pc_aliq) / 100) as ipi_valor,'
      #9'pvi.vl_total_item as pis_cofins_vl_base,'
      #9'pvi.pis_cofins_pc_aliq,'
      
        #9'((pvi.vl_total_item * pvi.pis_cofins_pc_aliq) / 100) as pis_cof' +
        'ins_valor,'
      #9'pvi.vl_total_item,'
      #9'pv.vl_desconto_pedido,'
      #9'pv.vl_acrescimo,'
      #9'pv.vl_total'
      'from'
      #9'pedido_venda pv'
      'join pedido_venda_item pvi on'
      #9'pv.id_geral = pvi.id_pedido_venda'
      'join cta_forma_pagamento cfp on'
      #9'pv.cd_forma_pag = cfp.cd_forma_pag'
      'join cta_cond_pagamento ccp on'
      #9'cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento'
      'join cliente c on'
      #9'pv.cd_cliente = c.cd_cliente'
      'join endereco_cliente e on'
      #9'c.cd_cliente = e.cd_cliente'
      'join produto p on'
      #9'pvi.cd_produto = p.cd_produto')
    Left = 432
    Top = 416
  end
  object query: TFDQuery
    Connection = frmConexao.conexao
    Left = 864
    Top = 184
  end
end
