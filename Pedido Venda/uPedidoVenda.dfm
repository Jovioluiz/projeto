object frmPedidoVenda: TfrmPedidoVenda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
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
      Top = 111
      Width = 87
      Height = 13
      Caption = 'Forma Pagamento'
    end
    object Label6: TLabel
      Left = 494
      Top = 111
      Width = 86
      Height = 13
      Caption = 'Cond. Pagamento'
    end
    object Label7: TLabel
      Left = 26
      Top = 182
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label8: TLabel
      Left = 117
      Top = 182
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label9: TLabel
      Left = 573
      Top = 182
      Width = 36
      Height = 13
      Caption = 'Qtdade'
    end
    object Label10: TLabel
      Left = 661
      Top = 182
      Width = 41
      Height = 13
      Caption = 'UN Med.'
    end
    object Label11: TLabel
      Left = 25
      Top = 228
      Width = 62
      Height = 13
      Caption = 'Tabela Pre'#231'o'
    end
    object Label12: TLabel
      Left = 118
      Top = 228
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label13: TLabel
      Left = 574
      Top = 228
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label14: TLabel
      Left = 722
      Top = 228
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label15: TLabel
      Left = 651
      Top = 228
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label16: TLabel
      Left = 26
      Top = 565
      Width = 61
      Height = 13
      Caption = 'Desconto R$'
    end
    object Label17: TLabel
      Left = 117
      Top = 565
      Width = 64
      Height = 13
      Caption = 'Acr'#233'scimo R$'
    end
    object Label18: TLabel
      Left = 203
      Top = 565
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
      Top = 130
      Width = 87
      Height = 21
      TabOrder = 1
      OnChange = edtCdFormaPgtoChange
      OnExit = edtCdFormaPgtoExit
    end
    object edtCdCondPgto: TEdit
      Left = 494
      Top = 130
      Width = 87
      Height = 21
      TabOrder = 2
      OnChange = edtCdCondPgtoChange
      OnExit = edtCdCondPgtoExit
    end
    object edtNomeCondPgto: TEdit
      Left = 587
      Top = 130
      Width = 236
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object edtCdProduto: TEdit
      Left = 24
      Top = 201
      Width = 87
      Height = 21
      TabOrder = 3
      OnChange = edtCdProdutoChange
      OnEnter = edtCdProdutoEnter
      OnExit = edtCdProdutoExit
    end
    object edtDescProduto: TEdit
      Left = 117
      Top = 201
      Width = 444
      Height = 21
      Enabled = False
      TabOrder = 16
    end
    object edtQtdade: TEdit
      Left = 573
      Top = 201
      Width = 65
      Height = 21
      TabOrder = 4
      Text = '0'
      OnChange = edtQtdadeChange
      OnExit = edtQtdadeExit
    end
    object edtUnMedida: TComboBox
      Left = 662
      Top = 201
      Width = 65
      Height = 21
      TabOrder = 5
    end
    object edtCdtabelaPreco: TEdit
      Left = 25
      Top = 247
      Width = 87
      Height = 21
      TabOrder = 6
      OnChange = edtCdtabelaPrecoChange
      OnExit = edtCdtabelaPrecoExit
    end
    object edtVlUnitario: TEdit
      Left = 574
      Top = 247
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object edtVlTotal: TEdit
      Left = 722
      Top = 247
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object btnAdicionar: TButton
      Left = 793
      Top = 245
      Width = 63
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 10
      OnClick = btnAdicionarClick
    end
    object dbGridProdutos: TDBGrid
      Left = 26
      Top = 288
      Width = 831
      Height = 271
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
      OnTitleClick = dbGridProdutosTitleClick
    end
    object edtVlDescontoItem: TEdit
      Left = 651
      Top = 247
      Width = 65
      Height = 21
      TabOrder = 8
      OnExit = edtVlDescontoItemExit
    end
    object edtVlDescTotalPedido: TEdit
      Left = 24
      Top = 584
      Width = 61
      Height = 21
      TabOrder = 11
      Text = '0,00'
      OnExit = edtVlDescTotalPedidoExit
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 117
      Top = 584
      Width = 61
      Height = 21
      TabOrder = 12
      Text = '0,00'
      OnExit = edtVlAcrescimoTotalPedidoExit
    end
    object edtVlTotalPedido: TEdit
      Left = 203
      Top = 584
      Width = 61
      Height = 21
      TabOrder = 13
      Text = '0,00'
    end
    object btnConfirmarPedido: TButton
      Left = 661
      Top = 579
      Width = 95
      Height = 32
      Caption = 'Confirmar'
      TabOrder = 14
      OnClick = btnConfirmarPedidoClick
    end
    object btnCancelar: TButton
      Left = 762
      Top = 579
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
    Top = 132
    Width = 329
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtDescTabelaPreco: TEdit
    Left = 120
    Top = 249
    Width = 443
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object edtFl_orcamento: TCheckBox
    Left = 239
    Top = 33
    Width = 73
    Height = 17
    Caption = 'Or'#231'amento'
    TabOrder = 7
  end
  object document: TXMLDocument
    Left = 544
    Top = 520
  end
end
