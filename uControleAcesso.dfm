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
    Left = 343
    Top = 64
    Width = 34
    Height = 22
    Caption = '+'
    OnClick = btnAddClick
  end
  object edtUsuario: TEdit
    Left = 82
    Top = 17
    Width = 73
    Height = 21
    TabOrder = 0
    OnExit = edtUsuarioExit
  end
  object edtNomeUsuario: TEdit
    Left = 176
    Top = 17
    Width = 161
    Height = 21
    Enabled = False
    TabOrder = 1
    OnExit = edtUsuarioExit
  end
  object dbGridAcoes: TDBGrid
    Left = 9
    Top = 104
    Width = 472
    Height = 297
    DataSource = dm.dsControleAcesso
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = dbGridAcoesKeyDown
  end
  object edtCdAcao: TEdit
    Left = 82
    Top = 65
    Width = 73
    Height = 21
    TabOrder = 2
    OnChange = edtCdAcaoChange
  end
  object edtNomeAcao: TEdit
    Left = 176
    Top = 65
    Width = 161
    Height = 21
    Enabled = False
    TabOrder = 3
    OnExit = edtUsuarioExit
  end
  object query: TFDQuery
    Connection = dm.FDConnection1
    Left = 456
    Top = 8
  end
end
