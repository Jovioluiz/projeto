object frmCadastraTributacaoItem: TfrmCadastraTributacaoItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Tributa'#231#227'o'
  ClientHeight = 250
  ClientWidth = 549
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 16
    Width = 537
    Height = 161
    ActivePage = TabSheetIPI
    TabOrder = 2
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
    Top = 228
    Width = 549
    Height = 22
    AutoHint = True
    Panels = <>
    SimplePanel = True
  end
  object btnSalvar: TButton
    Left = 146
    Top = 197
    Width = 75
    Height = 25
    Hint = 'Salvar Registro'
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 320
    Top = 197
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 1
    OnClick = btnCancelarClick
  end
  object btnLimpar: TButton
    Left = 231
    Top = 197
    Width = 75
    Height = 25
    Caption = 'Limpar'
    TabOrder = 4
    OnClick = btnLimparClick
  end
  object comandoSQL: TFDQuery
    Connection = frmConexao.conexao
    Left = 60
    Top = 184
  end
  object comandoselect: TFDQuery
    Connection = frmConexao.conexao
    Left = 424
    Top = 184
  end
end
