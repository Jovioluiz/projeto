object frmcadTabelaPreco: TfrmcadTabelaPreco
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro Tabela Pre'#231'o'
  ClientHeight = 548
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 548
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 58
      Height = 13
      Caption = 'Cod. Tabela'
    end
    object Label2: TLabel
      Left = 8
      Top = 72
      Width = 62
      Height = 13
      Caption = 'Nome Tabela'
    end
    object Label3: TLabel
      Left = 8
      Top = 120
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label4: TLabel
      Left = 224
      Top = 120
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object edtFl_ativo: TCheckBox
      Left = 232
      Top = 31
      Width = 49
      Height = 17
      Caption = 'Ativo'
      TabOrder = 1
    end
    object edtCodTabela: TEdit
      Left = 80
      Top = 29
      Width = 105
      Height = 21
      TabOrder = 0
      OnExit = edtCodTabelaExit
    end
    object edtNomeTabela: TEdit
      Left = 80
      Top = 69
      Width = 440
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object edtDtInicial: TMaskEdit
      Left = 80
      Top = 117
      Width = 65
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
    end
    object edtDtFinal: TMaskEdit
      Left = 288
      Top = 117
      Width = 65
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
    end
    object DBGridProduto: TDBGrid
      Left = 8
      Top = 240
      Width = 512
      Height = 289
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = DBGridProdutoKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'Produto'
          ReadOnly = True
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome Produto'
          ReadOnly = True
          Width = 222
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          ReadOnly = True
          Width = 98
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UN Medida'
          ReadOnly = True
          Width = 78
          Visible = True
        end>
    end
    object btnAdicionarProduto: TButton
      Left = 8
      Top = 201
      Width = 113
      Height = 25
      Caption = 'Adicionar Produto'
      TabOrder = 6
      OnClick = btnAdicionarProdutoClick
    end
  end
  object sqlTabelaPreco: TFDQuery
    Connection = dm.conexaoBanco
    Left = 464
    Top = 112
  end
  object sqlTabelaPrecoProduto: TFDQuery
    Connection = dm.conexaoBanco
    Left = 456
    Top = 392
  end
  object DataSource1: TDataSource
    DataSet = sqlTabelaPrecoProduto
    Left = 456
    Top = 328
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 456
    Top = 448
  end
end
