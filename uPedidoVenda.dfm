object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pedido de Venda'
  ClientHeight = 673
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 869
    Height = 673
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
      Top = 240
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label8: TLabel
      Left = 117
      Top = 240
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label9: TLabel
      Left = 573
      Top = 240
      Width = 36
      Height = 13
      Caption = 'Qtdade'
    end
    object Label10: TLabel
      Left = 661
      Top = 240
      Width = 41
      Height = 13
      Caption = 'UN Med.'
    end
    object Label11: TLabel
      Left = 24
      Top = 312
      Width = 62
      Height = 13
      Caption = 'Tabela Pre'#231'o'
    end
    object Label12: TLabel
      Left = 117
      Top = 312
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label13: TLabel
      Left = 573
      Top = 312
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label14: TLabel
      Left = 721
      Top = 312
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label15: TLabel
      Left = 650
      Top = 312
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label16: TLabel
      Left = 26
      Top = 608
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label17: TLabel
      Left = 117
      Top = 608
      Width = 64
      Height = 13
      Caption = 'Acr'#233'scimo R$'
    end
    object Label18: TLabel
      Left = 213
      Top = 608
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
      Top = 259
      Width = 87
      Height = 21
      TabOrder = 3
      OnChange = edtCdProdutoChange
      OnExit = edtCdProdutoExit
    end
    object edtDescProduto: TEdit
      Left = 117
      Top = 259
      Width = 427
      Height = 21
      Enabled = False
      TabOrder = 16
    end
    object edtQtdade: TEdit
      Left = 573
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 4
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
    object edtUnMedida: TComboBox
      Left = 662
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 5
    end
    object edtCdtabelaPreco: TEdit
      Left = 24
      Top = 331
      Width = 87
      Height = 21
      TabOrder = 6
      OnChange = edtCdtabelaPrecoChange
      OnExit = edtCdtabelaPrecoExit
    end
    object edtVlUnitario: TEdit
      Left = 573
      Top = 331
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object edtVlTotal: TEdit
      Left = 721
      Top = 331
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object btnAdicionar: TButton
      Left = 792
      Top = 329
      Width = 63
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 10
      OnClick = btnAdicionarClick
    end
    object dbGridProdutos: TDBGrid
      Left = 24
      Top = 384
      Width = 831
      Height = 201
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
      Columns = <
        item
          Expanded = False
          FieldName = 'C'#243'd. Produto'
          Title.Color = clWhite
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descri'#231#227'o'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtdade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Tabela Pre'#231'o'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UN Medida'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Unit'#225'rio'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Desconto'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Total'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Base ICMS '
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Aliq ICMS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor ICMS'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Base IPI'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Aliq IPI'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor IPI'
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
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor PIS/COFINS'
          Width = 90
          Visible = True
        end>
    end
    object edtVlDescontoItem: TEdit
      Left = 650
      Top = 331
      Width = 65
      Height = 21
      TabOrder = 8
      OnExit = edtVlDescontoItemExit
    end
    object edtVlDescTotalPedido: TEdit
      Left = 26
      Top = 627
      Width = 61
      Height = 21
      TabOrder = 11
      OnExit = edtVlDescTotalPedidoExit
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 117
      Top = 627
      Width = 61
      Height = 21
      TabOrder = 12
      OnExit = edtVlAcrescimoTotalPedidoExit
    end
    object edtVlTotalPedido: TEdit
      Left = 213
      Top = 627
      Width = 61
      Height = 21
      TabOrder = 13
    end
    object btnConfirmarPedido: TButton
      Left = 562
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Confirmar'
      TabOrder = 14
      OnClick = btnConfirmarPedidoClick
    end
    object btnCancelar: TButton
      Left = 663
      Top = 622
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
    Top = 333
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
  object sqlPedidoVendaCliente: TFDQuery
    Connection = frmConexao.conexao
    Left = 600
    Top = 16
  end
  object sqlPedidoVendaFormaPgto: TFDQuery
    Connection = frmConexao.conexao
    Left = 184
    Top = 136
  end
  object sqlPedidoVendaCondPgto: TFDQuery
    Connection = frmConexao.conexao
    Left = 664
    Top = 120
  end
  object sqlPedidoVendaProduto: TFDQuery
    Connection = frmConexao.conexao
    Left = 208
    Top = 224
  end
  object sqlPedidoVendaTabPreco: TFDQuery
    Connection = frmConexao.conexao
    Left = 216
    Top = 304
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 448
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 248
    Top = 448
  end
  object sqlPedidoVendaInsert: TFDQuery
    Connection = frmConexao.conexao
    Left = 432
    Top = 448
  end
  object sqlNrPedido: TFDQuery
    Connection = frmConexao.conexao
    Left = 384
    Top = 16
  end
  object sqlIdGeral: TFDQuery
    Connection = frmConexao.conexao
    Left = 440
    Top = 16
  end
  object sqlIdGeralPVI: TFDQuery
    Connection = frmConexao.conexao
    Left = 488
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = frmConexao.conexao
    Left = 464
    Top = 200
  end
end
