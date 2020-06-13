object frmConsultaProdutos: TfrmConsultaProdutos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Produtos'
  ClientHeight = 821
  ClientWidth = 1208
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
    Width = 1208
    Height = 821
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 653
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
      Left = 16
      Top = 150
      Width = 721
      Height = 475
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
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fator Convers'#227'o'
          Width = 85
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Qtdade Estoque'
          Width = 81
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
      Top = 801
      Width = 1206
      Height = 19
      AutoHint = True
      Panels = <>
    end
    object edtPesquisa: TEdit
      Left = 16
      Top = 72
      Width = 881
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object dbGridUltimasEntradas: TDBGrid
      Left = 16
      Top = 675
      Width = 593
      Height = 120
      DataSource = DataSourceUltEntradas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
          Width = 90
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
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Un Medida'
          Visible = True
        end>
    end
    object dbgriPrecos: TDBGrid
      Left = 760
      Top = 150
      Width = 425
      Height = 275
      DataSource = dsPrecos
      TabOrder = 9
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Tabela'
          ReadOnly = True
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Desc. Tabela'
          ReadOnly = True
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor'
          ReadOnly = True
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Un. Medida'
          ReadOnly = True
          Width = 57
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
    Left = 104
    Top = 728
  end
  object ClientDataSetUltEntradas: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 248
    Top = 728
  end
  object sqlUltEntrada: TFDQuery
    Connection = frmConexao.conexao
    Left = 336
    Top = 720
  end
  object dsPrecos: TDataSource
    DataSet = sqlPrecos
    Left = 864
    Top = 240
  end
  object cdPrecos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 944
    Top = 240
  end
  object sqlPrecos: TFDQuery
    Connection = frmConexao.conexao
    Left = 992
    Top = 240
  end
end
