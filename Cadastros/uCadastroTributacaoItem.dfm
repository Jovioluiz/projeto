object frmCadastraTributacaoItem: TfrmCadastraTributacaoItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Tributa'#231#227'o'
  ClientHeight = 205
  ClientWidth = 556
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 16
    Width = 537
    Height = 161
    ActivePage = TabSheetICMS
    TabOrder = 0
    object TabSheetICMS: TTabSheet
      Caption = 'ICMS'
      object Label1: TLabel
        Left = 11
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o'
      end
      object Label2: TLabel
        Left = 11
        Top = 48
        Width = 113
        Height = 13
        Caption = 'Nome Grupo Tributa'#231#227'o'
      end
      object Label3: TLabel
        Left = 11
        Top = 80
        Width = 67
        Height = 13
        Caption = 'Aliquota ICMS'
      end
      object edtCdGrupoTributacaoICMS: TEdit
        Left = 136
        Top = 13
        Width = 73
        Height = 21
        TabOrder = 0
        OnExit = edtCdGrupoTributacaoICMSExit
      end
      object edtNomeGrupoTributacaoICMS: TEdit
        Left = 136
        Top = 45
        Width = 337
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtAliqICMS: TEdit
        Left = 136
        Top = 72
        Width = 73
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheetIPI: TTabSheet
      Caption = 'IPI'
      ImageIndex = 1
      object Label6: TLabel
        Left = 15
        Top = 80
        Width = 56
        Height = 13
        Caption = 'Aliquota IPI'
      end
      object Label7: TLabel
        Left = 15
        Top = 48
        Width = 113
        Height = 13
        Caption = 'Nome Grupo Tributa'#231#227'o'
      end
      object Label8: TLabel
        Left = 15
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o'
      end
      object edtAliqIPI: TEdit
        Left = 140
        Top = 72
        Width = 73
        Height = 21
        TabOrder = 2
      end
      object edtNomeGrupoTributacaoIPI: TEdit
        Left = 140
        Top = 45
        Width = 337
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtCdGrupoTributacaoIPI: TEdit
        Left = 140
        Top = 13
        Width = 73
        Height = 21
        TabOrder = 0
        OnExit = edtCdGrupoTributacaoIPIExit
      end
    end
    object TabSheetISS: TTabSheet
      Caption = 'ISS'
      ImageIndex = 2
      object Label9: TLabel
        Left = 11
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o'
      end
      object Label10: TLabel
        Left = 11
        Top = 48
        Width = 113
        Height = 13
        Caption = 'Nome Grupo Tributa'#231#227'o'
      end
      object Label11: TLabel
        Left = 11
        Top = 80
        Width = 58
        Height = 13
        Caption = 'Aliquota ISS'
      end
      object edtCdGrupoTributacaoISS: TEdit
        Left = 136
        Top = 13
        Width = 73
        Height = 21
        TabOrder = 0
        OnExit = edtCdGrupoTributacaoISSExit
      end
      object edtNomeGrupoTributacaoISS: TEdit
        Left = 136
        Top = 45
        Width = 337
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtAliqISS: TEdit
        Left = 136
        Top = 72
        Width = 73
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheetPISCOFINS: TTabSheet
      Caption = 'PIS/COFINS'
      ImageIndex = 3
      object Label4: TLabel
        Left = 11
        Top = 16
        Width = 83
        Height = 13
        Caption = 'Grupo Tributa'#231#227'o'
      end
      object Label5: TLabel
        Left = 11
        Top = 48
        Width = 113
        Height = 13
        Caption = 'Nome Grupo Tributa'#231#227'o'
      end
      object Label12: TLabel
        Left = 11
        Top = 80
        Width = 100
        Height = 13
        Caption = 'Aliquota PIS/COFINS'
      end
      object edtCdGrupoTributacaoPISCOFINS: TEdit
        Left = 136
        Top = 13
        Width = 73
        Height = 21
        TabOrder = 0
        OnExit = edtCdGrupoTributacaoPISCOFINSExit
      end
      object edtNomeGrupoTributacaoPISCOFINS: TEdit
        Left = 136
        Top = 45
        Width = 337
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtAliqPISCOFINS: TEdit
        Left = 136
        Top = 72
        Width = 73
        Height = 21
        TabOrder = 2
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 183
    Width = 556
    Height = 22
    AutoHint = True
    Panels = <>
    SimplePanel = True
  end
  object comandoSQL: TFDQuery
    Connection = dm.conexaoBanco
    Left = 468
    Top = 48
  end
  object comandoselect: TFDQuery
    Connection = dm.conexaoBanco
    Left = 464
    Top = 112
  end
end
