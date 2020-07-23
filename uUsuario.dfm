object frmUsuario: TfrmUsuario
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro Usu'#225'rio'
  ClientHeight = 212
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 38
    Top = 88
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label2: TLabel
    Left = 44
    Top = 136
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label3: TLabel
    Left = 24
    Top = 40
    Width = 50
    Height = 13
    Caption = 'ID Usu'#225'rio'
  end
  object edtIdUsuario: TEdit
    Left = 120
    Top = 37
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = edtIdUsuarioChange
    OnExit = edtIdUsuarioExit
  end
  object edtNomeUsuario: TEdit
    Left = 120
    Top = 85
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtSenhaUsuario: TMaskEdit
    Left = 120
    Top = 133
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
    Text = ''
  end
  object query: TFDQuery
    Connection = dm.FDConnection1
    Left = 376
    Top = 56
  end
  object sql: TFDQuery
    Connection = dm.FDConnection1
    Left = 376
    Top = 120
  end
end
