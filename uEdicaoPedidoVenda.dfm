object frm_Edicao_Pedido_Venda: Tfrm_Edicao_Pedido_Venda
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
    object btnAdicionarItem: TSpeedButton
      Left = 801
      Top = 259
      Width = 63
      Height = 25
      Caption = 'Adicionar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = btnAdicionarItemClick
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
      ReadOnly = True
      TabOrder = 1
    end
    object edtCdCondPgto: TEdit
      Left = 550
      Top = 147
      Width = 87
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtNomeCondPgto: TEdit
      Left = 643
      Top = 147
      Width = 268
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object dbGridProdutos: TDBGrid
      Left = 86
      Top = 304
      Width = 825
      Height = 281
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 14
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
          FieldName = 'Aliq ICMS'
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
    object edtVlDescTotalPedido: TEdit
      Left = 131
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 10
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 221
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 11
    end
    object edtVlTotalPedido: TEdit
      Left = 309
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 13
    end
    object btnCancelar: TButton
      Left = 816
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Cancelar'
      TabOrder = 12
      OnClick = btnCancelarClick
    end
    object edtDataEmissao: TMaskEdit
      Left = 844
      Top = 24
      Width = 67
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 15
      Text = '  /  /    '
    end
    object edtCdProduto: TEdit
      Left = 86
      Top = 203
      Width = 65
      Height = 21
      TabOrder = 3
      OnChange = edtCdProdutoChange
    end
    object edtNomeProduto: TEdit
      Left = 189
      Top = 203
      Width = 329
      Height = 21
      Enabled = False
      TabOrder = 16
    end
    object edtQtdade: TEdit
      Left = 550
      Top = 203
      Width = 65
      Height = 21
      TabOrder = 4
    end
    object edtTabelaPreco: TEdit
      Left = 86
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 6
      OnChange = edtTabelaPrecoChange
    end
    object edtDescTabPreco: TEdit
      Left = 189
      Top = 259
      Width = 329
      Height = 21
      Enabled = False
      TabOrder = 17
    end
    object edtVlUnitario: TEdit
      Left = 550
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object edtVlDesconto: TEdit
      Left = 644
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 8
    end
    object edtVlTotal: TEdit
      Left = 724
      Top = 259
      Width = 65
      Height = 21
      TabOrder = 9
    end
    object edtUnMedida: TComboBox
      Left = 643
      Top = 203
      Width = 66
      Height = 21
      TabOrder = 5
    end
  end
  object edtNrPedido: TEdit
    Left = 191
    Top = 31
    Width = 105
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object edtCdCliente: TEdit
    Left = 88
    Top = 87
    Width = 65
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object edtNomeCliente: TEdit
    Left = 191
    Top = 87
    Width = 329
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object edtCidadeCliente: TEdit
    Left = 552
    Top = 87
    Width = 361
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object edtNomeFormaPgto: TEdit
    Left = 191
    Top = 149
    Width = 329
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object edtFl_orcamento: TCheckBox
    Left = 344
    Top = 33
    Width = 73
    Height = 17
    Caption = 'Or'#231'amento'
    TabOrder = 6
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
    Left = 432
    Top = 416
  end
  object DataSource2: TDataSource
    DataSet = ClientDataSet1
    Left = 552
    Top = 416
  end
end
