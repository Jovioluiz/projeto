object frmConsultaProdutos: TfrmConsultaProdutos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta de Produtos'
  ClientHeight = 746
  ClientWidth = 1198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1198
    Height = 746
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 581
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
      Top = 58
      Width = 89
      Height = 26
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
      Top = 100
      Width = 721
      Height = 475
      DataSource = dsConsultaProduto
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = dbGridProdutoCellClick
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
      Top = 726
      Width = 1196
      Height = 19
      AutoHint = True
      Panels = <>
    end
    object edtPesquisa: TEdit
      Left = 16
      Top = 58
      Width = 881
      Height = 26
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dbGridUltimasEntradas: TDBGrid
      Left = 16
      Top = 603
      Width = 593
      Height = 120
      DataSource = dsUltimaEntradas
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 8
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object dbgriPrecos: TDBGrid
      Left = 760
      Top = 102
      Width = 425
      Height = 275
      DataSource = dsPrecos
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 9
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsConsultaProduto: TDataSource
    DataSet = cdsConsultaProduto
    Left = 224
    Top = 248
  end
  object cdsConsultaProduto: TClientDataSet
    PersistDataPacket.Data = {
      980000009619E0BD01000000180000000500000000000300000098000A63645F
      70726F6475746F04000100000000000C646573635F70726F6475746F01004900
      0000010005574944544802000200140009756E5F6D6564696461010049000000
      01000557494454480200020014000F6661746F725F636F6E76657273616F0400
      0100000000000B7174645F6573746F71756508000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_produto'
        DataType = ftInteger
      end
      item
        Name = 'desc_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'fator_conversao'
        DataType = ftInteger
      end
      item
        Name = 'qtd_estoque'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 104
    Top = 248
    object intgrfldConsultaProdutocd_produto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsConsultaProdutodesc_produto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 30
      FieldName = 'desc_produto'
    end
    object cdsConsultaProdutoun_medida: TStringField
      DisplayLabel = 'UN Medida'
      DisplayWidth = 9
      FieldName = 'un_medida'
    end
    object intgrfldConsultaProdutofator_conversao: TIntegerField
      DisplayLabel = 'Fator Conversao'
      DisplayWidth = 13
      FieldName = 'fator_conversao'
    end
    object cdsConsultaProdutoqtd_estoque: TFloatField
      DisplayLabel = 'Qtdade Estoque'
      DisplayWidth = 14
      FieldName = 'qtd_estoque'
    end
  end
  object dsUltimaEntradas: TDataSource
    DataSet = cdsUltimasEntradas
    Left = 168
    Top = 648
  end
  object cdsUltimasEntradas: TClientDataSet
    PersistDataPacket.Data = {
      A80000009619E0BD010000001800000006000000000003000000A8000B646374
      6F5F6E756D65726F04000100000000000A666F726E656365646F720100490000
      0001000557494454480200020014000D64745F6C616E63616D656E746F040006
      000000000009756E5F6D65646964610100490000000100055749445448020002
      0014000B766C5F756E69746172696F08000400000000000A7175616E74696461
      646508000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'dcto_numero'
        DataType = ftInteger
      end
      item
        Name = 'fornecedor'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'dt_lancamento'
        DataType = ftDate
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'vl_unitario'
        DataType = ftFloat
      end
      item
        Name = 'quantidade'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 648
    object intgrfldUltimasEntradasdcto_numero: TIntegerField
      DisplayLabel = 'N'#250'mero'
      DisplayWidth = 10
      FieldName = 'dcto_numero'
    end
    object cdsUltimasEntradasfornecedor: TStringField
      DisplayLabel = 'Fornecedor'
      DisplayWidth = 33
      FieldName = 'fornecedor'
    end
    object cdsUltimasEntradasdt_lancamento: TDateField
      DisplayLabel = 'Data Lan'#231'amento'
      DisplayWidth = 15
      FieldName = 'dt_lancamento'
    end
    object cdsUltimasEntradasun_medida: TStringField
      DisplayLabel = 'Un. Medida'
      DisplayWidth = 11
      FieldName = 'un_medida'
    end
    object cdsUltimasEntradasvl_unitario: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      DisplayWidth = 11
      FieldName = 'vl_unitario'
    end
    object cdsUltimasEntradasquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      DisplayWidth = 10
      FieldName = 'quantidade'
    end
  end
  object dsPrecos: TDataSource
    DataSet = cdsPrecos
    Left = 864
    Top = 240
  end
  object cdsPrecos: TClientDataSet
    PersistDataPacket.Data = {
      8A0000009619E0BD0100000018000000040000000000030000008A000963645F
      746162656C610400010000000000096E6D5F746162656C610100490000000100
      0557494454480200020014000576616C6F720800040000000100075355425459
      50450200490006004D6F6E65790009756E5F6D65646964610100490000000100
      0557494454480200020014000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 920
    Top = 240
    object intgrfldPrecoscd_tabela: TIntegerField
      DisplayLabel = 'Tabela'
      DisplayWidth = 7
      FieldName = 'cd_tabela'
    end
    object cdsPrecosnm_tabela: TStringField
      DisplayLabel = 'Desc. Tabela'
      DisplayWidth = 35
      FieldName = 'nm_tabela'
    end
    object cdsPrecosvalor: TCurrencyField
      DisplayLabel = 'Valor'
      DisplayWidth = 10
      FieldName = 'valor'
    end
    object cdsPrecosun_medida: TStringField
      DisplayLabel = 'Un. Medida'
      DisplayWidth = 10
      FieldName = 'un_medida'
    end
  end
end
