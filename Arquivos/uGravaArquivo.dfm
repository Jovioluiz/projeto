object frmGravaArquivo: TfrmGravaArquivo
  Left = 0
  Top = 0
  Caption = 'Gravar Arquivo'
  ClientHeight = 119
  ClientWidth = 591
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
    Left = 11
    Top = 50
    Width = 41
    Height = 13
    Caption = 'Arquivo:'
  end
  object btnCaminho: TSpeedButton
    Left = 354
    Top = 46
    Width = 26
    Height = 22
    Caption = '...'
    OnClick = btnCaminhoClick
  end
  object btnGerar: TButton
    Left = 399
    Top = 45
    Width = 73
    Height = 25
    Caption = 'Gravar'
    TabOrder = 0
    OnClick = btnGerarClick
  end
  object edtDataIni: TDateTimePicker
    Left = 58
    Top = 8
    Width = 81
    Height = 21
    Date = 44066.000000000000000000
    Time = 0.881014872684318100
    TabOrder = 2
  end
  object edtDataFim: TDateTimePicker
    Left = 157
    Top = 8
    Width = 81
    Height = 21
    Date = 44066.000000000000000000
    Time = 0.881014872684318100
    TabOrder = 1
  end
  object edtArquivo: TEdit
    Left = 58
    Top = 47
    Width = 290
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object odArquivo: TOpenTextFileDialog
    Left = 512
    Top = 8
  end
end
