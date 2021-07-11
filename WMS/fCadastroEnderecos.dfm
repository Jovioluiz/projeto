object frmCadastroEnderecos: TfrmCadastroEnderecos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Endere'#231'os'
  ClientHeight = 491
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 491
    Align = alClient
    TabOrder = 0
    object pgc1: TPageControl
      Left = 1
      Top = 1
      Width = 698
      Height = 489
      ActivePage = tbsEndereco
      Align = alClient
      TabOrder = 0
      object tbsEndereco: TTabSheet
        Caption = 'Cadastro Endere'#231'o'
        object Label1: TLabel
          Left = 8
          Top = 27
          Width = 42
          Height = 13
          Caption = 'Dep'#243'sito'
        end
        object Label2: TLabel
          Left = 80
          Top = 27
          Width = 15
          Height = 13
          Caption = 'Ala'
        end
        object Label3: TLabel
          Left = 150
          Top = 27
          Width = 19
          Height = 13
          Caption = 'Rua'
        end
        object Label4: TLabel
          Left = 226
          Top = 27
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object btnAdicionar: TButton
          Left = 609
          Top = 44
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 0
          OnClick = btnAdicionarClick
        end
        object edtAla: TEdit
          Left = 80
          Top = 46
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtComplemento: TEdit
          Left = 226
          Top = 46
          Width = 177
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtRua: TEdit
          Left = 150
          Top = 46
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object dbgrdEndereco: TDBGrid
          Left = 3
          Top = 75
          Width = 681
          Height = 342
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 4
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object edtCodDeposito: TEdit
          Left = 8
          Top = 46
          Width = 57
          Height = 21
          TabOrder = 5
        end
      end
      object tbsProdutoEndereco: TTabSheet
        Caption = 'Cadastro Produto Endereco'
        ImageIndex = 1
        object Label5: TLabel
          Left = 16
          Top = 64
          Width = 64
          Height = 13
          Caption = 'C'#243'd. Produto'
        end
        object Label6: TLabel
          Left = 199
          Top = 64
          Width = 38
          Height = 13
          Caption = 'Produto'
        end
        object Label7: TLabel
          Left = 12
          Top = 123
          Width = 42
          Height = 13
          Caption = 'Dep'#243'sito'
        end
        object Label8: TLabel
          Left = 80
          Top = 123
          Width = 15
          Height = 13
          Caption = 'Ala'
        end
        object Label9: TLabel
          Left = 150
          Top = 123
          Width = 19
          Height = 13
          Caption = 'Rua'
        end
        object Label10: TLabel
          Left = 226
          Top = 123
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object Label11: TLabel
          Left = 417
          Top = 123
          Width = 32
          Height = 13
          Caption = 'Ordem'
        end
        object edtCodBarrasProduto: TEdit
          Left = 12
          Top = 83
          Width = 165
          Height = 21
          TabOrder = 0
          OnExit = edtCodBarrasProdutoExit
        end
        object edtNomeProduto: TEdit
          Left = 199
          Top = 83
          Width = 306
          Height = 21
          Enabled = False
          TabOrder = 1
        end
        object rgTipo: TRadioGroup
          Left = 16
          Top = 8
          Width = 129
          Height = 50
          Caption = 'Tipo'
          ItemIndex = 0
          Items.Strings = (
            'C'#243'digo Produto'
            'C'#243'digo Barras')
          TabOrder = 8
        end
        object edtComplementoProdEndereco: TEdit
          Left = 226
          Top = 142
          Width = 177
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 5
        end
        object edtRuaProdEndereco: TEdit
          Left = 150
          Top = 142
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 4
        end
        object edtAlaProdEndereco: TEdit
          Left = 80
          Top = 142
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object edtCodDepositoProdEndereco: TEdit
          Left = 8
          Top = 142
          Width = 57
          Height = 21
          TabOrder = 2
        end
        object btnAdd: TButton
          Left = 609
          Top = 140
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 7
          OnClick = btnAddClick
        end
        object dbgrdProdutoEndereco: TDBGrid
          Left = 3
          Top = 184
          Width = 681
          Height = 233
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 9
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object edtOrdem: TEdit
          Left = 417
          Top = 142
          Width = 58
          Height = 21
          TabOrder = 6
        end
      end
    end
    object btn2: TButton
      Left = 597
      Top = 448
      Width = 92
      Height = 33
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btn2Click
    end
  end
end
