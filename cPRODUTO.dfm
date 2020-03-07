object frmCadProduto: TfrmCadProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Produto'
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
      Left = 20
      Top = 152
      Width = 91
      Height = 13
      Caption = 'Unidade de Medida'
    end
    object Label4: TLabel
      Left = 183
      Top = 152
      Width = 96
      Height = 13
      Caption = 'Fator de Convers'#227'o'
    end
    object Label5: TLabel
      Left = 356
      Top = 152
      Width = 59
      Height = 13
      Caption = 'Peso Liquido'
    end
    object Label6: TLabel
      Left = 492
      Top = 152
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
      TabOrder = 1
    end
    object ckPRODUTOATIVO: TCheckBox
      Left = 280
      Top = 39
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 2
    end
    object edtPRODUTOUN_MEDIDA: TEdit
      Left = 117
      Top = 149
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object edtPRODUTOFATOR_CONVERSAO: TEdit
      Left = 285
      Top = 149
      Width = 57
      Height = 21
      NumbersOnly = True
      TabOrder = 4
    end
    object edtPRODUTOPESO_LIQUIDO: TEdit
      Left = 421
      Top = 149
      Width = 52
      Height = 21
      NumbersOnly = True
      TabOrder = 5
    end
    object edtPRODUTOPESO_BRUTO: TEdit
      Left = 550
      Top = 149
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
    object btnPRODUTOCADASTRAR: TButton
      Left = 204
      Top = 344
      Width = 101
      Height = 41
      Caption = 'Cadastrar'
      TabOrder = 8
      OnClick = btnPRODUTOCADASTRARClick
    end
    object btnPRODUTOCANCELAR: TButton
      Left = 320
      Top = 344
      Width = 95
      Height = 41
      Caption = 'Fechar'
      TabOrder = 9
      OnClick = btnPRODUTOCANCELARClick
    end
  end
  object sqlInsertProduto: TSQLQuery
    Params = <>
    Left = 24
    Top = 80
  end
  object comandosql: TFDCommand
    Connection = fConexao.conexao
    CommandText.Strings = (
      
        'insert into produto(cd_produto,fl_ativo,desc_produto,un_medida,f' +
        'ator_conversao,peso_liquido,peso_bruto,observacao)'
      
        '  values (:cd_produto,:fl_ativo,:desc_produto,:un_medida,:fator_' +
        'conversao,:peso_liquido,:peso_bruto, :observacao);')
    ParamData = <
      item
        Name = 'CD_PRODUTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FL_ATIVO'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DESC_PRODUTO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'UN_MEDIDA'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FATOR_CONVERSAO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PESO_LIQUIDO'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PESO_BRUTO'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    Left = 648
    Top = 176
  end
  object comandoSelect: TFDQuery
    Connection = fConexao.conexao
    SQL.Strings = (
      'select cd_produto from produto where cd_produto = :cd_produto;')
    Left = 648
    Top = 272
    ParamData = <
      item
        Name = 'CD_PRODUTO'
        ParamType = ptInput
      end>
  end
end
