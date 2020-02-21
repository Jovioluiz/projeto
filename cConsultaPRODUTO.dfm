object fConsultaProduto: TfConsultaProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consulta Produtos'
  ClientHeight = 428
  ClientWidth = 718
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
  object tpCadProduto: TPanel
    Left = 0
    Top = 0
    Width = 718
    Height = 428
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 73
      Top = 40
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 60
      Top = 80
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label3: TLabel
      Left = 15
      Top = 128
      Width = 91
      Height = 13
      Caption = 'Unidade de Medida'
    end
    object Label4: TLabel
      Left = 178
      Top = 128
      Width = 96
      Height = 13
      Caption = 'Fator de Convers'#227'o'
    end
    object Label5: TLabel
      Left = 351
      Top = 128
      Width = 59
      Height = 13
      Caption = 'Peso Liquido'
    end
    object Label6: TLabel
      Left = 487
      Top = 128
      Width = 52
      Height = 13
      Caption = 'Peso Bruto'
    end
    object Label7: TLabel
      Left = 20
      Top = 208
      Width = 58
      Height = 13
      Caption = 'Observa'#231#227'o'
    end
    object Label8: TLabel
      Left = 39
      Top = 168
      Width = 67
      Height = 13
      Caption = 'Estoque Atual'
    end
    object edtPRODUTOCD_PRODUTO: TEdit
      Left = 112
      Top = 37
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = edtPRODUTOCD_PRODUTOExit
    end
    object edtPRODUTODESCRICAO: TEdit
      Left = 112
      Top = 77
      Width = 497
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object ckPRODUTOATIVO: TCheckBox
      Left = 280
      Top = 39
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 1
    end
    object edtPRODUTOUN_MEDIDA: TEdit
      Left = 112
      Top = 125
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object edtPRODUTOFATOR_CONVERSAO: TEdit
      Left = 280
      Top = 125
      Width = 57
      Height = 21
      NumbersOnly = True
      TabOrder = 4
    end
    object edtPRODUTOPESO_LIQUIDO: TEdit
      Left = 416
      Top = 125
      Width = 52
      Height = 21
      NumbersOnly = True
      TabOrder = 5
    end
    object edtPRODUTOPESO_BRUTO: TEdit
      Left = 545
      Top = 125
      Width = 57
      Height = 21
      NumbersOnly = True
      TabOrder = 6
    end
    object memoObservacao: TMemo
      Left = 20
      Top = 227
      Width = 587
      Height = 89
      CharCase = ecUpperCase
      Lines.Strings = (
        '')
      TabOrder = 7
    end
    object btnPRODUTOCANCELAR: TButton
      Left = 171
      Top = 344
      Width = 95
      Height = 41
      Caption = 'Fechar'
      TabOrder = 9
      OnClick = btnPRODUTOCANCELARClick
    end
    object btnEditar: TButton
      Left = 272
      Top = 344
      Width = 103
      Height = 41
      Caption = 'Editar'
      TabOrder = 8
      OnClick = btnEditarClick
    end
    object btnGravar: TButton
      Left = 381
      Top = 344
      Width = 108
      Height = 41
      Caption = 'Gravar Altera'#231#245'es'
      TabOrder = 10
      OnClick = btnGravarClick
    end
    object edtQtdEstoque: TEdit
      Left = 112
      Top = 165
      Width = 49
      Height = 21
      TabOrder = 11
    end
  end
  object comandoSelect: TFDQuery
    Connection = fConexao.conexao
    SQL.Strings = (
      '')
    Left = 648
    Top = 272
  end
  object sqlUpdate: TFDQuery
    Connection = fConexao.conexao
    Left = 608
    Top = 336
  end
end
