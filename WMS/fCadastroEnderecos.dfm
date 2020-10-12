object frmCadastroEnderecos: TfrmCadastroEnderecos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Endere'#231'os'
  ClientHeight = 485
  ClientWidth = 705
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
  object JvLabel1: TJvLabel
    Left = 8
    Top = 120
    Width = 44
    Height = 13
    Caption = 'Dep'#243'sito'
    Transparent = True
  end
  object JvLabel2: TJvLabel
    Left = 80
    Top = 120
    Width = 17
    Height = 13
    Caption = 'Ala'
    Transparent = True
  end
  object JvLabel3: TJvLabel
    Left = 152
    Top = 120
    Width = 21
    Height = 13
    Caption = 'Rua'
    Transparent = True
  end
  object JvLabel4: TJvLabel
    Left = 224
    Top = 120
    Width = 67
    Height = 13
    Caption = 'Complemento'
    Transparent = True
  end
  object JvLabel5: TJvLabel
    Left = 8
    Top = 64
    Width = 40
    Height = 13
    Caption = 'Produto'
    Transparent = True
  end
  object JvLabel6: TJvLabel
    Left = 189
    Top = 64
    Width = 48
    Height = 13
    Caption = 'Descri'#231#227'o'
    Transparent = True
  end
  object edtCodDeposito: TEdit
    Left = 8
    Top = 152
    Width = 57
    Height = 21
    TabOrder = 3
  end
  object edtAla: TEdit
    Left = 80
    Top = 152
    Width = 57
    Height = 21
    TabOrder = 4
  end
  object edtRua: TEdit
    Left = 152
    Top = 152
    Width = 57
    Height = 21
    TabOrder = 5
  end
  object edtEdtComplemento: TEdit
    Left = 224
    Top = 152
    Width = 177
    Height = 21
    TabOrder = 6
  end
  object edtCodBarrasProduto: TEdit
    Left = 8
    Top = 83
    Width = 165
    Height = 21
    TabOrder = 1
    OnExit = edtCodBarrasProdutoExit
  end
  object edtNomeProduto: TEdit
    Left = 189
    Top = 83
    Width = 306
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object dbgrd1: TDBGrid
    Left = 8
    Top = 200
    Width = 681
    Height = 209
    DataSource = dsEndereco
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object rgTipo: TRadioGroup
    Left = 8
    Top = 8
    Width = 129
    Height = 50
    Caption = 'Tipo'
    ItemIndex = 0
    Items.Strings = (
      'C'#243'digo Produto'
      'C'#243'digo Barras')
    TabOrder = 0
  end
  object btnAdicionar: TButton
    Left = 420
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 7
    OnClick = btnAdicionarClick
  end
  object btn1: TButton
    Left = 526
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    TabOrder = 9
  end
  object btn2: TButton
    Left = 614
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 10
  end
  object cdsEndereco: TClientDataSet
    PersistDataPacket.Data = {
      D00000009619E0BD010000001800000007000000000003000000D0000A63645F
      70726F6475746F04000100000000000A6E6D5F70726F6475746F010049000000
      01000557494454480200020014000B63645F6465706F7369746F040001000000
      000003616C610100490000000100055749445448020002001400037275610100
      4900000001000557494454480200020014000B636F6D706C656D656E746F0100
      4900000001000557494454480200020014000B6E6D5F656E64657265636F0100
      4900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_produto'
        DataType = ftInteger
      end
      item
        Name = 'nm_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cd_deposito'
        DataType = ftInteger
      end
      item
        Name = 'ala'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'rua'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'complemento'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'nm_endereco'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 248
    Top = 264
    object intgrfldEnderecocd_produto: TIntegerField
      DisplayLabel = 'C'#243'd Produto'
      DisplayWidth = 11
      FieldName = 'cd_produto'
    end
    object cdsEndereconm_produto: TStringField
      DisplayLabel = 'Nome Produto'
      DisplayWidth = 23
      FieldName = 'nm_produto'
    end
    object intgrfldEnderecocd_deposito: TIntegerField
      DisplayLabel = 'Deposito'
      DisplayWidth = 9
      FieldName = 'cd_deposito'
    end
    object cdsEnderecoala: TStringField
      DisplayLabel = 'Ala'
      DisplayWidth = 7
      FieldName = 'ala'
    end
    object cdsEnderecorua: TStringField
      DisplayLabel = 'Rua'
      DisplayWidth = 9
      FieldName = 'rua'
    end
    object cdsEnderecocomplemento: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 21
      FieldName = 'complemento'
    end
    object cdsEndereconm_endereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'nm_endereco'
    end
  end
  object dsEndereco: TDataSource
    DataSet = cdsEndereco
    Left = 184
    Top = 264
  end
end
