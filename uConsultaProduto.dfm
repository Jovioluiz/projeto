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
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1045
    Height = 633
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 448
      Width = 96
      Height = 16
      Caption = #218'ltimas Entradas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
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
      Width = 67
      Height = 17
      Caption = 'Ativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtEstoque: TCheckBox
      Left = 272
      Top = 32
      Width = 97
      Height = 17
      Hint = 'Filtra produtos com estoque'
      Caption = 'Com Estoque'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object dbGridProduto: TDBGrid
      Left = 24
      Top = 150
      Width = 1001
      Height = 275
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbGridProdutoCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'Codigo'
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edtDescricao: TCheckBox
      Left = 96
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Descri'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 613
      Width = 1043
      Height = 19
      AutoHint = True
      Panels = <>
    end
    object edtPesquisa: TEdit
      Left = 24
      Top = 72
      Width = 873
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object dbGridUltimasEntradas: TDBGrid
      Left = 24
      Top = 487
      Width = 665
      Height = 120
      DataSource = DataSourceUltEntradas
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Nota'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fornecedor'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Data Lan'#231'amento'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Unit'#225'rio'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Un Medida'
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = sqlConsulta
    Left = 264
    Top = 248
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Codigo'
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    StoreDefs = True
    Left = 344
    Top = 248
  end
  object sqlConsulta: TFDQuery
    Connection = frmConexao.conexao
    SQL.Strings = (
      ''
      '')
    Left = 416
    Top = 248
  end
  object DataSourceUltEntradas: TDataSource
    DataSet = sqlUltEntrada
    Left = 72
    Top = 536
  end
  object ClientDataSetUltEntradas: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 200
    Top = 536
  end
  object sqlUltEntrada: TFDQuery
    Connection = frmConexao.conexao
    Left = 312
    Top = 536
  end
end
