object frmConexao: TfrmConexao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Conex'#227'o'
  ClientHeight = 243
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 42
    Top = 17
    Width = 48
    Height = 16
    Caption = 'Servidor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 47
    Top = 133
    Width = 43
    Height = 16
    Caption = 'Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 54
    Top = 168
    Width = 36
    Height = 16
    Caption = 'Senha'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 60
    Top = 95
    Width = 30
    Height = 16
    Caption = 'Porta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 56
    Top = 59
    Width = 34
    Height = 16
    Caption = 'Banco'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtServidor: TEdit
    Left = 96
    Top = 12
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtBanco: TEdit
    Left = 96
    Top = 54
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object edtPorta: TEdit
    Left = 96
    Top = 94
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtUsuario: TEdit
    Left = 96
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object btnTestar: TButton
    Left = 54
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Testar'
    TabOrder = 4
    OnClick = btnTestarClick
  end
  object btnSalvar: TButton
    Left = 142
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 5
    OnClick = btnSalvarClick
  end
  object edtSenha: TMaskEdit
    Left = 96
    Top = 167
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 6
    Text = ''
  end
end
