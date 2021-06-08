object frmControleAcesso: TfrmControleAcesso
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Controle de Acesso'
  ClientHeight = 421
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 9
    Top = 16
    Width = 48
    Height = 18
    Caption = 'Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 9
    Top = 64
    Width = 67
    Height = 18
    Caption = 'C'#243'd. A'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnAdd: TSpeedButton
    Left = 351
    Top = 65
    Width = 34
    Height = 22
    Caption = '+'
    OnClick = btnAddClick
  end
  object Label2: TLabel
    Left = 35
    Top = 92
    Width = 41
    Height = 18
    Caption = 'Edi'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtUsuario: TEdit
    Left = 82
    Top = 17
    Width = 73
    Height = 21
    TabOrder = 0
    OnChange = edtUsuarioChange
    OnExit = edtUsuarioExit
  end
  object edtNomeUsuario: TEdit
    Left = 176
    Top = 17
    Width = 161
    Height = 21
    Enabled = False
    TabOrder = 3
    OnExit = edtUsuarioExit
  end
  object dbGridAcoes: TDBGrid
    Left = 9
    Top = 128
    Width = 472
    Height = 273
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbGridAcoesDblClick
    OnKeyDown = dbGridAcoesKeyDown
  end
  object edtCdAcao: TEdit
    Left = 82
    Top = 65
    Width = 73
    Height = 21
    TabOrder = 1
    OnChange = edtCdAcaoChange
  end
  object edtNomeAcao: TEdit
    Left = 176
    Top = 65
    Width = 161
    Height = 21
    Enabled = False
    TabOrder = 4
    OnExit = edtUsuarioExit
  end
  object cbEdicao: TComboBox
    Left = 82
    Top = 92
    Width = 73
    Height = 21
    TabOrder = 2
    Items.Strings = (
      'Sim'
      'N'#227'o')
  end
  object query: TFDQuery
    Connection = dm.conexaoBanco
    Left = 456
    Top = 8
  end
end
