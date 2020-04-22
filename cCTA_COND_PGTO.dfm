object frmCadCondPgto: TfrmCadCondPgto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro Condi'#231#227'o Pagamento'
  ClientHeight = 328
  ClientWidth = 475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object tpCondPgto: TPanel
    Left = 0
    Top = 0
    Width = 475
    Height = 328
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 70
      Height = 13
      Caption = 'C'#243'd. Condi'#231#227'o'
    end
    object Label2: TLabel
      Left = 8
      Top = 113
      Width = 81
      Height = 13
      Caption = 'C'#243'd. Forma Pgto'
    end
    object Label3: TLabel
      Left = 8
      Top = 67
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label4: TLabel
      Left = 8
      Top = 176
      Width = 80
      Height = 13
      Caption = 'N'#250'mero Parcelas'
    end
    object Label5: TLabel
      Left = 221
      Top = 176
      Width = 85
      Height = 13
      Caption = 'Vl. Minimo Parcela'
    end
    object edtCTACONDPGTOCD_COND: TEdit
      Left = 96
      Top = 21
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object edtCTACONDPGTODESCRICAO: TEdit
      Left = 96
      Top = 64
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object edtCTACONDPGTOCD_CTA_FORMA_PGTO: TEdit
      Left = 96
      Top = 110
      Width = 65
      Height = 21
      TabOrder = 3
      OnChange = edtCTACONDPGTOCD_CTA_FORMA_PGTOChange
    end
    object edtCTACONDPGTO_DESC_CTA_FORMA_PGTO: TEdit
      Left = 167
      Top = 110
      Width = 274
      Height = 21
      Enabled = False
      TabOrder = 4
    end
    object edtCTACONDPGTONR_PARCELAS: TEdit
      Left = 94
      Top = 173
      Width = 67
      Height = 21
      NumbersOnly = True
      TabOrder = 5
    end
    object edtCTACONDPGTOVL_MINIMO: TEdit
      Left = 320
      Top = 173
      Width = 81
      Height = 21
      TabOrder = 6
    end
    object btnSalvar: TButton
      Left = 128
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 7
      OnClick = btnSalvarClick
    end
    object btnFechar: TButton
      Left = 231
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Fechar'
      TabOrder = 8
      OnClick = btnFecharClick
    end
    object edtCTACONDPGTOFL_ATIVO: TCheckBox
      Left = 192
      Top = 23
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 1
    end
  end
  object sqlInsertCondPgto: TFDQuery
    Connection = frmConexao.conexao
    Left = 352
    Top = 240
  end
  object selectCDPGTO: TFDQuery
    Connection = frmConexao.conexao
    Left = 424
    Top = 208
  end
end
