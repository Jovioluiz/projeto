object cadFormaPagamento: TcadFormaPagamento
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro Forma Pagamento'
  ClientHeight = 318
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object tpCadFormaPgto: TPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 329
    Align = alTop
    BorderStyle = bsSingle
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 51
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object edtCTA_FORMA_PGTOCODIGO: TEdit
      Left = 64
      Top = 13
      Width = 81
      Height = 21
      TabOrder = 0
      OnExit = edtCTA_FORMA_PGTOCODIGOExit
    end
    object edtCTA_FORMA_PGTODESCRICAO: TEdit
      Left = 64
      Top = 48
      Width = 361
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object edtCTA_FORMA_PGTOFL_ATIVO: TCheckBox
      Left = 168
      Top = 16
      Width = 97
      Height = 26
      Caption = 'Ativo'
      TabOrder = 2
    end
    object edtCTA_FORMA_PGTOCLASSIFICACAO: TRadioGroup
      Left = 8
      Top = 120
      Width = 137
      Height = 89
      Caption = 'Classifica'#231#227'o'
      Items.Strings = (
        'Dinheiro      '
        'Cheque         '
        'Cart'#227'o Debito'
        'Cart'#227'o Cr'#233'dito')
      TabOrder = 3
    end
  end
  object btnSalvar: TButton
    Left = 118
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 1
    OnClick = btnSalvarClick
  end
  object btnFechar: TButton
    Left = 216
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = btnFecharClick
  end
  object sqlInsertFormaPgto: TFDQuery
    Connection = fConexao.conexao
    Left = 384
    Top = 80
  end
end
