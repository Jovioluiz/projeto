object frmConsultaProdutos: TfrmConsultaProdutos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Produtos'
  ClientHeight = 633
  ClientWidth = 1045
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1045
    Height = 633
    Align = alClient
    TabOrder = 0
    object edtPesquisa: TEdit
      Left = 24
      Top = 72
      Width = 889
      Height = 31
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnPesquisar: TButton
      Left = 928
      Top = 72
      Width = 89
      Height = 31
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
    object edtAtivo: TCheckBox
      Left = 199
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 2
    end
    object edtEstoque: TCheckBox
      Left = 272
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Com Estoque'
      TabOrder = 3
    end
    object dbGridProduto: TDBGrid
      Left = 24
      Top = 144
      Width = 1001
      Height = 473
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'C'#243'digo'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descri'#231#227'o'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Un. medida'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fator Convers'#227'o'
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtdade Estoque'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C'#243'digo de Barras'
          Width = 130
          Visible = True
        end>
    end
    object edtCodigo: TCheckBox
      Left = 24
      Top = 32
      Width = 97
      Height = 17
      Caption = 'C'#243'digo'
      TabOrder = 5
    end
    object edtDescricao: TCheckBox
      Left = 96
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Descri'#231#227'o'
      TabOrder = 6
    end
  end
  object DataSource1: TDataSource
    DataSet = sqlConsulta
    Left = 264
    Top = 376
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 376
  end
  object sqlConsulta: TFDQuery
    Connection = frmConexao.conexao
    Left = 424
    Top = 368
  end
end
