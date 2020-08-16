object frmCadProduto: TfrmCadProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Produto'
  ClientHeight = 595
  ClientWidth = 723
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
  object Label1: TLabel
    Left = 69
    Top = 16
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object Label2: TLabel
    Left = 34
    Top = 56
    Width = 68
    Height = 13
    Caption = 'Nome Produto'
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 96
    Width = 721
    Height = 482
    ActivePage = TabSheetCadastroProduto
    TabOrder = 3
    object TabSheetCadastroProduto: TTabSheet
      Caption = 'Produto'
      object Label3: TLabel
        Left = 3
        Top = 40
        Width = 76
        Height = 13
        Caption = 'Unidade Medida'
      end
      object Label4: TLabel
        Left = 172
        Top = 40
        Width = 81
        Height = 13
        Caption = 'Fator Convers'#227'o'
      end
      object Label5: TLabel
        Left = 358
        Top = 40
        Width = 52
        Height = 13
        Caption = 'Peso Bruto'
      end
      object Label6: TLabel
        Left = 510
        Top = 40
        Width = 59
        Height = 13
        Caption = 'Peso Liquido'
      end
      object Label7: TLabel
        Left = 3
        Top = 80
        Width = 58
        Height = 13
        Caption = 'Observa'#231#227'o'
      end
      object Label8: TLabel
        Left = 3
        Top = 232
        Width = 104
        Height = 14
        Caption = 'C'#243'digo de Barras'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 3
        Top = 264
        Width = 105
        Height = 13
        Caption = 'Tipo C'#243'digo de Barras'
      end
      object imagem: TImage
        Left = 424
        Top = 207
        Width = 277
        Height = 244
        OnMouseDown = imagemMouseDown
      end
      object Label13: TLabel
        Left = 424
        Top = 188
        Width = 38
        Height = 13
        Caption = 'Imagem'
      end
      object Label14: TLabel
        Left = 129
        Top = 264
        Width = 39
        Height = 13
        Caption = 'Unidade'
      end
      object Label15: TLabel
        Left = 200
        Top = 264
        Width = 82
        Height = 13
        Caption = 'C'#243'digo de Barras'
      end
      object edtPRODUTOUN_MEDIDA: TEdit
        Left = 85
        Top = 37
        Width = 65
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtPRODUTOFATOR_CONVERSAO: TEdit
        Left = 272
        Top = 37
        Width = 65
        Height = 21
        TabOrder = 1
      end
      object edtPRODUTOPESO_BRUTO: TEdit
        Left = 424
        Top = 37
        Width = 65
        Height = 21
        TabOrder = 2
      end
      object edtPRODUTOPESO_LIQUIDO: TEdit
        Left = 584
        Top = 37
        Width = 65
        Height = 21
        TabOrder = 3
      end
      object memoObservacao: TMemo
        Left = 3
        Top = 99
        Width = 698
        Height = 71
        CharCase = ecUpperCase
        TabOrder = 4
      end
      object DBGridCodigoBarras: TDBGrid
        Left = 3
        Top = 331
        Width = 407
        Height = 120
        DataSource = dm.dsCodBarraProduto
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = DBGridCodigoBarrasKeyDown
      end
      object edtCodigoBarras: TEdit
        Left = 200
        Top = 291
        Width = 165
        Height = 21
        TabOrder = 5
      end
      object btnAddCodBarras: TButton
        Left = 371
        Top = 289
        Width = 34
        Height = 25
        Caption = '+'
        TabOrder = 6
        OnClick = btnAddCodBarrasClick
      end
      object Button1: TButton
        Left = 480
        Top = 232
        Width = 1
        Height = 17
        Caption = 'Button1'
        TabOrder = 8
      end
      object btnCarregarImagem: TButton
        Left = 600
        Top = 176
        Width = 96
        Height = 25
        Caption = 'Carregar Imagem'
        TabOrder = 9
        OnClick = btnCarregarImagemClick
      end
      object cbTipoCodBarras: TComboBox
        Left = 3
        Top = 291
        Width = 105
        Height = 21
        TabOrder = 10
        Items.Strings = (
          'Interno'
          'GTIN'
          'Outro')
      end
      object edtUnCodBarras: TEdit
        Left = 129
        Top = 291
        Width = 65
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 11
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Tributa'#231#227'o'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label10: TLabel
        Left = 49
        Top = 24
        Width = 111
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o ICMS'
      end
      object Label11: TLabel
        Left = 60
        Top = 64
        Width = 100
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o IPI'
      end
      object Label12: TLabel
        Left = 16
        Top = 104
        Width = 144
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o PIS/COFINS'
      end
      object edtProdutoGrupoTributacaoICMS: TEdit
        Left = 176
        Top = 21
        Width = 49
        Height = 21
        TabOrder = 0
        OnChange = edtProdutoGrupoTributacaoICMSChange
      end
      object edtProdutoGrupoTributacaoIPI: TEdit
        Left = 176
        Top = 61
        Width = 49
        Height = 21
        TabOrder = 1
        OnChange = edtProdutoGrupoTributacaoIPIChange
      end
      object edtProdutoGrupoTributacaoPISCOFINS: TEdit
        Left = 176
        Top = 101
        Width = 49
        Height = 21
        TabOrder = 2
        OnChange = edtProdutoGrupoTributacaoPISCOFINSChange
      end
      object edtProdutoNomeGrupoTributacaoICMS: TEdit
        Left = 248
        Top = 21
        Width = 305
        Height = 21
        TabOrder = 3
      end
      object edtProdutoNomeGrupoTributacaoIPI: TEdit
        Left = 248
        Top = 61
        Width = 305
        Height = 21
        TabOrder = 4
      end
      object edtProdutoNomeGrupoTributacaoPISCOFINS: TEdit
        Left = 248
        Top = 101
        Width = 305
        Height = 21
        TabOrder = 5
      end
    end
  end
  object edtPRODUTOCD_PRODUTO: TEdit
    Left = 119
    Top = 13
    Width = 66
    Height = 21
    Hint = 'C'#243'digo do Produto'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnExit = edtPRODUTOCD_PRODUTOExit
  end
  object edtPRODUTODESCRICAO: TEdit
    Left = 119
    Top = 53
    Width = 586
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
  end
  object ckPRODUTOATIVO: TCheckBox
    Left = 224
    Top = 15
    Width = 97
    Height = 17
    Hint = 'Define se o item est'#225' ativo'
    Caption = 'Ativo'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object comandoSelect: TFDQuery
    Connection = frmConexao.conexao
    SQL.Strings = (
      'select cd_produto from produto where cd_produto = :cd_produto;')
    Left = 648
    Top = 80
    ParamData = <
      item
        Name = 'CD_PRODUTO'
        ParamType = ptInput
      end>
  end
  object comandosql: TFDQuery
    Connection = frmConexao.conexao
    Left = 568
    Top = 80
  end
  object sqltributacao: TFDQuery
    Connection = frmConexao.conexao
    Left = 648
    Top = 144
  end
  object sqlVerificaTributacao: TFDQuery
    Connection = frmConexao.conexao
    Left = 644
    Top = 208
  end
  object OpenDialog1: TOpenDialog
    Left = 444
    Top = 376
  end
end
