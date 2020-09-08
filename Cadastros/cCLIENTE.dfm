object frmCadCliente: TfrmCadCliente
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Cliente'
  ClientHeight = 390
  ClientWidth = 849
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
  object tpCadCliente: TPanel
    Left = 0
    Top = 0
    Width = 849
    Height = 390
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 92
      Top = 24
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 34
      Top = 56
      Width = 91
      Height = 13
      Caption = 'Nome/Raz'#227'o Social'
    end
    object Label3: TLabel
      Left = 544
      Top = 96
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object Label4: TLabel
      Left = 317
      Top = 96
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object lblCLIENTECPF_CNPJ: TLabel
      Left = 106
      Top = 96
      Width = 19
      Height = 13
      Caption = 'CPF'
    end
    object Label11: TLabel
      Left = 553
      Top = 128
      Width = 33
      Height = 13
      Caption = 'Celular'
    end
    object lblCLIENTEIE_RG: TLabel
      Left = 111
      Top = 128
      Width = 14
      Height = 13
      Caption = 'RG'
    end
    object lblCLIENTEDTNASCIMENTO: TLabel
      Left = 264
      Top = 128
      Width = 81
      Height = 13
      Caption = 'Data Nascimento'
    end
    object edtCLIENTENM_CLIENTE: TEdit
      Left = 131
      Top = 53
      Width = 390
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
    end
    object gbENDERECO: TGroupBox
      Left = 1
      Top = 212
      Width = 847
      Height = 177
      Align = alBottom
      Caption = 'Endere'#231'o'
      TabOrder = 11
      object Label6: TLabel
        Left = 41
        Top = 56
        Width = 52
        Height = 13
        Caption = 'logradouro'
      end
      object Label7: TLabel
        Left = 420
        Top = 56
        Width = 37
        Height = 13
        Caption = 'Numero'
      end
      object Label8: TLabel
        Left = 65
        Top = 96
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label9: TLabel
        Left = 60
        Top = 144
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label10: TLabel
        Left = 424
        Top = 96
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object Label5: TLabel
        Left = 74
        Top = 24
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object edtCLIENTEENDERECO_BAIRRO: TEdit
        Left = 115
        Top = 96
        Width = 273
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object edtCLIENTEENDERECO_CIDADE: TEdit
        Left = 114
        Top = 139
        Width = 274
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object edtCLIENTEENDERECO_NUMERO: TEdit
        Left = 480
        Top = 56
        Width = 73
        Height = 21
        TabOrder = 4
      end
      object edtEstado: TEdit
        Left = 480
        Top = 96
        Width = 73
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 6
      end
      object edtCep: TEdit
        Left = 114
        Top = 20
        Width = 95
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnExit = edtCepExit
      end
      object edtCLIENTEENDERECO_LOGRADOURO: TEdit
        Left = 114
        Top = 60
        Width = 273
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object cbbEstado: TComboBox
        Left = 480
        Top = 96
        Width = 73
        Height = 21
        TabOrder = 5
      end
    end
    object edtCLIENTETP_PESSOA: TRadioGroup
      Left = 544
      Top = 16
      Width = 283
      Height = 53
      Caption = 'Tipo de Pessoa'
      Columns = 2
      Items.Strings = (
        'Pessoa Fisica     '
        'Pessoa Juridica')
      TabOrder = 3
      OnClick = edtCLIENTETP_PESSOAClick
    end
    object edtCLIENTECELULAR: TMaskEdit
      Left = 605
      Top = 120
      Width = 106
      Height = 21
      EditMask = '!\(99\)00000-0000;0;_'
      MaxLength = 14
      TabOrder = 10
      Text = ''
      OnExit = edtCLIENTECELULARExit
    end
    object edtCLIENTEEMAIL: TEdit
      Left = 351
      Top = 93
      Width = 170
      Height = 21
      TabOrder = 7
    end
    object edtCLIENTECPF_CNPJ: TMaskEdit
      Left = 131
      Top = 93
      Width = 112
      Height = 21
      TabOrder = 5
      Text = ''
    end
    object edtCLIENTERG: TEdit
      Left = 131
      Top = 125
      Width = 112
      Height = 21
      TabOrder = 6
    end
    object edtCLIENTEDATANASCIMENTO: TMaskEdit
      Left = 351
      Top = 125
      Width = 66
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
    end
    object edtCLIENTEFL_FORNECEDOR: TCheckBox
      Left = 368
      Top = 23
      Width = 97
      Height = 17
      Caption = 'Fornecedor'
      TabOrder = 2
    end
    object edtCLIENTEFL_ATIVO: TCheckBox
      Left = 272
      Top = 24
      Width = 90
      Height = 17
      Caption = 'Ativo'
      TabOrder = 1
    end
    object edtCLIENTEcd_cliente: TEdit
      Left = 131
      Top = 21
      Width = 121
      Height = 21
      TabOrder = 0
      OnExit = edtCLIENTEcd_clienteExit
      OnKeyDown = edtCLIENTEcd_clienteKeyDown
    end
    object edtCLIENTEFONE: TMaskEdit
      Left = 605
      Top = 93
      Width = 102
      Height = 21
      EditMask = '!\(99\)0000-0000;0;_'
      MaxLength = 13
      TabOrder = 9
      Text = ''
      OnExit = edtCLIENTECELULARExit
    end
  end
end
