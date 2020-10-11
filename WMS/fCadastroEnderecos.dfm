object frmCadastroEnderecos: TfrmCadastroEnderecos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Endere'#231'os'
  ClientHeight = 421
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object JvLabel1: TJvLabel
    Left = 8
    Top = 104
    Width = 44
    Height = 13
    Caption = 'Dep'#243'sito'
    Transparent = True
  end
  object JvLabel2: TJvLabel
    Left = 80
    Top = 104
    Width = 17
    Height = 13
    Caption = 'Ala'
    Transparent = True
  end
  object JvLabel3: TJvLabel
    Left = 152
    Top = 104
    Width = 21
    Height = 13
    Caption = 'Rua'
    Transparent = True
  end
  object JvLabel4: TJvLabel
    Left = 224
    Top = 104
    Width = 67
    Height = 13
    Caption = 'Complemento'
    Transparent = True
  end
  object JvLabel5: TJvLabel
    Left = 8
    Top = 32
    Width = 40
    Height = 13
    Caption = 'Produto'
    Transparent = True
  end
  object JvLabel6: TJvLabel
    Left = 143
    Top = 32
    Width = 48
    Height = 13
    Caption = 'Descri'#231#227'o'
    Transparent = True
  end
  object edtCodDeposito: TEdit
    Left = 8
    Top = 136
    Width = 57
    Height = 21
    TabOrder = 0
  end
  object edtAla: TEdit
    Left = 80
    Top = 136
    Width = 57
    Height = 21
    TabOrder = 1
  end
  object edtRua: TEdit
    Left = 152
    Top = 136
    Width = 57
    Height = 21
    TabOrder = 2
  end
  object edtEdtComplemento: TEdit
    Left = 224
    Top = 136
    Width = 57
    Height = 21
    TabOrder = 3
  end
  object edtCodProduto: TEdit
    Left = 8
    Top = 51
    Width = 129
    Height = 21
    TabOrder = 4
  end
  object edtNomeProduto: TEdit
    Left = 143
    Top = 51
    Width = 306
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object dbgrd1: TDBGrid
    Left = 8
    Top = 184
    Width = 441
    Height = 209
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
