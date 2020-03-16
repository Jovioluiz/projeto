object frm_Edicao_Pedido_Venda: Tfrm_Edicao_Pedido_Venda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Edi'#231#227'o do Pedido Venda'
  ClientHeight = 683
  ClientWidth = 1036
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1036
    Height = 683
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 0
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
      Left = 261
      Top = 66
      Width = 75
      Height = 13
      Caption = 'Nome Completo'
    end
    object Label4: TLabel
      Left = 672
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
      Left = 630
      Top = 136
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
    object edtCdFormaPgto: TEdit
      Left = 131
      Top = 167
      Width = 87
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtCdCondPgto: TEdit
      Left = 630
      Top = 167
      Width = 87
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtNomeCondPgto: TEdit
      Left = 765
      Top = 167
      Width = 236
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 0
    end
    object dbGridProdutos: TDBGrid
      Left = 128
      Top = 264
      Width = 873
      Height = 321
      DataSource = DataSource1
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
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
          FieldName = 'Tabela Pre'#231'o'
          ReadOnly = True
          Width = 70
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
        end>
    end
    object edtVlDescTotalPedido: TEdit
      Left = 131
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edtVlAcrescimoTotalPedido: TEdit
      Left = 221
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edtVlTotalPedido: TEdit
      Left = 309
      Top = 627
      Width = 61
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object btnCancelar: TButton
      Left = 864
      Top = 622
      Width = 95
      Height = 32
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = btnCancelarClick
    end
  end
  object edtNrPedido: TEdit
    Left = 233
    Top = 31
    Width = 105
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object edtCdCliente: TEdit
    Left = 133
    Top = 87
    Width = 87
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object edtNomeCliente: TEdit
    Left = 263
    Top = 87
    Width = 329
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object edtCidadeCliente: TEdit
    Left = 674
    Top = 87
    Width = 329
    Height = 21
    ReadOnly = True
    TabOrder = 4
  end
  object edtNomeFormaPgto: TEdit
    Left = 263
    Top = 169
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
    TabOrder = 6
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 328
    Top = 352
  end
  object DataSource1: TDataSource
    DataSet = sqlCarregaPedidoVenda
    Left = 248
    Top = 352
  end
  object sqlCarregaPedidoVenda: TFDQuery
    Connection = fConexao.conexao
    Left = 440
    Top = 352
  end
end
