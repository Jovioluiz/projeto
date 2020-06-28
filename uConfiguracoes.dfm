object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es Sistema'
  ClientHeight = 316
  ClientWidth = 627
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 40
    Width = 148
    Height = 13
    Caption = 'Altera Cliente Pedido de Venda'
  end
  object btnSalvar: TButton
    Left = 440
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = btnSalvarClick
  end
  object Button2: TButton
    Left = 521
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
  end
  object cbConfigAlteraCliPv: TComboBox
    Left = 178
    Top = 37
    Width = 71
    Height = 21
    TabOrder = 2
    Items.Strings = (
      'Sim'
      'N'#227'o')
  end
  object FDQuery1: TFDQuery
    Connection = frmConexao.conexao
    Left = 488
    Top = 80
  end
end
