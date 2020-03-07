object frmCadCliente: TfrmCadCliente
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Cliente'
  ClientHeight = 409
  ClientWidth = 848
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
  object tpCadCliente: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 409
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
    object edtCLIENTEcd_cliente: TEdit
      Left = 131
      Top = 26
      Width = 92
      Height = 21
      TabOrder = 0
      OnExit = edtCLIENTEcd_clienteExit
    end
    object edtCLIENTENM_CLIENTE: TEdit
      Left = 131
      Top = 53
      Width = 390
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object gbENDERECO: TGroupBox
      Left = 8
      Top = 190
      Width = 820
      Height = 153
      Caption = 'Endere'#231'o'
      TabOrder = 10
      object Label6: TLabel
        Left = 16
        Top = 32
        Width = 52
        Height = 13
        Caption = 'logradouro'
      end
      object Label7: TLabel
        Left = 444
        Top = 24
        Width = 37
        Height = 13
        Caption = 'Numero'
      end
      object Label8: TLabel
        Left = 40
        Top = 64
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label9: TLabel
        Left = 35
        Top = 96
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label10: TLabel
        Left = 448
        Top = 64
        Width = 33
        Height = 13
        Caption = 'Estado'
      end
      object cbESTADO: TComboBox
        Left = 505
        Top = 64
        Width = 73
        Height = 21
        TabOrder = 0
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
      end
      object edtCLIENTEENDERECO_BAIRRO: TEdit
        Left = 136
        Top = 64
        Width = 273
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtCLIENTEENDERECO_CIDADE: TEdit
        Left = 135
        Top = 99
        Width = 274
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 2
      end
      object edtCLIENTEENDERECO_NUMERO: TEdit
        Left = 505
        Top = 24
        Width = 73
        Height = 21
        TabOrder = 3
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
      TabOrder = 2
      OnClick = edtCLIENTETP_PESSOAClick
    end
    object edtCLIENTEFONE: TMaskEdit
      Left = 605
      Top = 93
      Width = 110
      Height = 21
      EditMask = '!\(99\)0000-0000;1;_'
      MaxLength = 13
      TabOrder = 8
      Text = '(  )    -    '
    end
    object edtCLIENTECELULAR: TMaskEdit
      Left = 605
      Top = 125
      Width = 118
      Height = 21
      EditMask = '!\(99\)00000-0000;1;_'
      MaxLength = 14
      TabOrder = 9
      Text = '(  )     -    '
    end
    object edtCLIENTEEMAIL: TEdit
      Left = 351
      Top = 93
      Width = 186
      Height = 21
      TabOrder = 6
    end
    object edtCLIENTEENDERECO_LOGRADOURO: TEdit
      Left = 143
      Top = 213
      Width = 273
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 11
    end
    object edtCLIENTECPF_CNPJ: TMaskEdit
      Left = 131
      Top = 93
      Width = 112
      Height = 21
      TabOrder = 4
      Text = ''
      OnExit = edtCLIENTECPF_CNPJExit
    end
    object edtCLIENTEFL_ATIVO: TCheckBox
      Left = 296
      Top = 23
      Width = 48
      Height = 17
      Caption = 'Ativo'
      TabOrder = 1
    end
    object edtCLIENTERG: TEdit
      Left = 131
      Top = 125
      Width = 119
      Height = 21
      TabOrder = 5
      OnExit = edtCLIENTERGExit
    end
    object btnSalvarCliente: TButton
      Left = 312
      Top = 349
      Width = 104
      Height = 42
      Caption = 'Salvar'
      TabOrder = 12
      OnClick = btnSalvarClienteClick
    end
    object btnCancelarCadCliente: TButton
      Left = 472
      Top = 349
      Width = 96
      Height = 42
      Caption = 'Fechar'
      TabOrder = 13
      OnClick = btnCancelarCadClienteClick
    end
    object edtCLIENTEDATANASCIMENTO: TMaskEdit
      Left = 351
      Top = 125
      Width = 66
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
    end
  end
  object sqlInsertCliente: TFDCommand
    Connection = fConexao.conexao
    CommandText.Strings = (
      
        'INSERT INTO cliente (cd_cliente, fl_ativo, nome, tp_pessoa, tele' +
        'fone,celular, email, cpf_cnpj, rg_ie, dtnascimento) '
      
        'VALUES (:cd_cliente, :fl_ativo, :nome, :tp_pessoa, :telefone, :c' +
        'elular, :email, :cpf_cnpj, :rg_ie, :dtnascimento);')
    ParamData = <
      item
        Name = 'CD_CLIENTE'
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FL_ATIVO'
        ParamType = ptInput
      end
      item
        Name = 'NOME'
        ParamType = ptInput
      end
      item
        Name = 'TP_PESSOA'
        ParamType = ptInput
      end
      item
        Name = 'TELEFONE'
        ParamType = ptInput
      end
      item
        Name = 'CELULAR'
        ParamType = ptInput
      end
      item
        Name = 'EMAIL'
        ParamType = ptInput
      end
      item
        Name = 'CPF_CNPJ'
        ParamType = ptInput
      end
      item
        Name = 'RG_IE'
        ParamType = ptInput
      end
      item
        Name = 'DTNASCIMENTO'
        ParamType = ptInput
      end>
    Left = 760
    Top = 80
  end
  object sqlInsertEndereco: TFDCommand
    Connection = fConexao.conexao
    CommandText.Strings = (
      
        'INSERT INTO endereco (cd_cliente, logradouro, num, bairro, cidad' +
        'e, uf) '
      'VALUES (:cd_cliente, :logradouro, :num, :bairro, :cidade, :uf);')
    ParamData = <
      item
        Name = 'CD_CLIENTE'
        ParamType = ptInput
      end
      item
        Name = 'LOGRADOURO'
        ParamType = ptInput
      end
      item
        Name = 'NUM'
        ParamType = ptInput
      end
      item
        Name = 'BAIRRO'
        ParamType = ptInput
      end
      item
        Name = 'CIDADE'
        ParamType = ptInput
      end
      item
        Name = 'UF'
        ParamType = ptInput
      end>
    Left = 760
    Top = 144
  end
  object FDQuery1: TFDQuery
    Connection = fConexao.conexao
    Left = 760
    Top = 230
  end
end
