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
  object lbl1: TLabel
    Left = 24
    Top = 96
    Width = 243
    Height = 13
    Caption = 'Permite Lan'#231'ar Produto v'#225'rias vezes pedido venda'
  end
  object btnSalvar: TButton
    Left = 463
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = btnSalvarClick
  end
  object Button2: TButton
    Left = 544
    Top = 250
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object cbConfigAlteraCliPv: TComboBox
    Left = 24
    Top = 59
    Width = 71
    Height = 21
    Hint = 'Permite Alterar Cliente na Edi'#231#227'o do Pedido de Venda'
    TabOrder = 2
    Items.Strings = (
      'Sim'
      'N'#227'o')
  end
  object cbbLancaItemPedido: TComboBox
    Left = 24
    Top = 115
    Width = 71
    Height = 21
    Hint = 'Permite lan'#231'ar o produto mais de uma vez no pedido de venda.'
    TabOrder = 3
    Items.Strings = (
      'Sim'
      'N'#227'o')
  end
  object status: TStatusBar
    Left = 0
    Top = 297
    Width = 627
    Height = 19
    Hint = 'StatusBar1.Panels[1].Text := Application.Hint;'
    AutoHint = True
    Panels = <
      item
        Width = 50
      end>
    ParentShowHint = False
    ShowHint = True
    ExplicitLeft = 520
    ExplicitTop = 304
    ExplicitWidth = 0
  end
  object FDQuery1: TFDQuery
    Connection = frmConexao.conexao
    Left = 488
    Top = 80
  end
end
