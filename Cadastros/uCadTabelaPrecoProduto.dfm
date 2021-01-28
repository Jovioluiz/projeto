object frmCadTabelaPrecoProduto: TfrmCadTabelaPrecoProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro Produto Tabela Pre'#231'o'
  ClientHeight = 266
  ClientWidth = 506
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 506
    Height = 266
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 64
      Width = 64
      Height = 13
      Caption = 'Cod. Produto'
    end
    object Label2: TLabel
      Left = 24
      Top = 136
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object Label3: TLabel
      Left = 24
      Top = 104
      Width = 51
      Height = 13
      Caption = 'UN Medida'
    end
    object Label5: TLabel
      Left = 24
      Top = 32
      Width = 58
      Height = 13
      Caption = 'Cod. Tabela'
    end
    object edtCodProduto: TEdit
      Left = 110
      Top = 61
      Width = 83
      Height = 21
      TabOrder = 1
      OnChange = edtCodProdutoChange
      OnExit = edtCodProdutoExit
    end
    object edtValor: TEdit
      Left = 110
      Top = 133
      Width = 83
      Height = 21
      TabOrder = 2
    end
    object edtUNMedida: TEdit
      Left = 110
      Top = 101
      Width = 83
      Height = 21
      Enabled = False
      TabOrder = 3
    end
    object edtNomeProduto: TEdit
      Left = 214
      Top = 61
      Width = 259
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object edtCodTabela: TEdit
      Left = 110
      Top = 29
      Width = 83
      Height = 21
      TabOrder = 0
      OnChange = edtCodTabelaChange
    end
    object edtNomeTabela: TEdit
      Left = 214
      Top = 29
      Width = 259
      Height = 21
      Enabled = False
      TabOrder = 5
    end
  end
  object sqlTabelaPrecoProduto: TFDQuery
    Connection = dm.conexaoBanco
    Left = 424
    Top = 104
  end
  object sql: TFDQuery
    Connection = dm.conexaoBanco
    Left = 424
    Top = 176
  end
end
