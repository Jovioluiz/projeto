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
  PixelsPerInch = 96
  TextHeight = 13
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
  object rgEditaClientePV: TRadioGroup
    Left = 24
    Top = 40
    Width = 201
    Height = 65
    Caption = 'Alterar Cliente Pedido de Venda'
    Items.Strings = (
      'Sim'
      'N'#227'o')
    TabOrder = 2
  end
  object FDQuery1: TFDQuery
    Left = 488
    Top = 80
  end
end
