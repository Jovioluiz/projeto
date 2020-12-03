object frmGravaArquivo: TfrmGravaArquivo
  Left = 0
  Top = 0
  Caption = 'Gravar Arquivo'
  ClientHeight = 299
  ClientWidth = 635
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
  object btnPedidoVenda: TButton
    Left = 391
    Top = 48
    Width = 73
    Height = 25
    Caption = 'Gravar'
    TabOrder = 0
    OnClick = btnPedidoVendaClick
  end
  object edtDataIni: TDateTimePicker
    Left = 134
    Top = 8
    Width = 81
    Height = 21
    Date = 44066.000000000000000000
    Time = 0.881014872684318100
    TabOrder = 2
  end
  object edtDataFim: TDateTimePicker
    Left = 232
    Top = 8
    Width = 81
    Height = 21
    Date = 44066.000000000000000000
    Time = 0.881014872684318100
    TabOrder = 1
  end
end
