object frmCadastroEnderecos: TfrmCadastroEnderecos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Cadastro de Endere'#231'os'
  ClientHeight = 460
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
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 705
    Height = 460
    Align = alClient
    TabOrder = 0
    object pgc1: TPageControl
      Left = 1
      Top = 1
      Width = 703
      Height = 458
      ActivePage = tbsProdutoEndereco
      Align = alClient
      TabOrder = 0
      object tbsEndereco: TTabSheet
        Caption = 'Cadastro Endere'#231'o'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 8
          Top = 27
          Width = 42
          Height = 13
          Caption = 'Dep'#243'sito'
        end
        object Label2: TLabel
          Left = 80
          Top = 27
          Width = 15
          Height = 13
          Caption = 'Ala'
        end
        object Label3: TLabel
          Left = 150
          Top = 27
          Width = 19
          Height = 13
          Caption = 'Rua'
        end
        object Label4: TLabel
          Left = 226
          Top = 27
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object btnAdicionar: TButton
          Left = 609
          Top = 44
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 0
          OnClick = btnAdicionarClick
        end
        object edtAla: TEdit
          Left = 80
          Top = 46
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object edtComplemento: TEdit
          Left = 226
          Top = 46
          Width = 177
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 2
        end
        object edtRua: TEdit
          Left = 150
          Top = 46
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object btnConfirmar: TButton
          Left = 528
          Top = 391
          Width = 75
          Height = 25
          Caption = 'Confirmar'
          TabOrder = 4
          OnClick = btnConfirmarClick
        end
        object btn2: TButton
          Left = 609
          Top = 391
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 5
        end
        object dbgrdEndereco: TDBGrid
          Left = 3
          Top = 75
          Width = 681
          Height = 302
          DataSource = dsEndereco
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 6
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object edtCodDeposito: TEdit
          Left = 8
          Top = 46
          Width = 57
          Height = 21
          TabOrder = 7
        end
      end
      object tbsProdutoEndereco: TTabSheet
        Caption = 'Cadastro Produto Endereco'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label5: TLabel
          Left = 16
          Top = 64
          Width = 64
          Height = 13
          Caption = 'C'#243'd. Produto'
        end
        object Label6: TLabel
          Left = 199
          Top = 64
          Width = 38
          Height = 13
          Caption = 'Produto'
        end
        object Label7: TLabel
          Left = 12
          Top = 123
          Width = 42
          Height = 13
          Caption = 'Dep'#243'sito'
        end
        object Label8: TLabel
          Left = 80
          Top = 123
          Width = 15
          Height = 13
          Caption = 'Ala'
        end
        object Label9: TLabel
          Left = 150
          Top = 123
          Width = 19
          Height = 13
          Caption = 'Rua'
        end
        object Label10: TLabel
          Left = 226
          Top = 123
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object Label11: TLabel
          Left = 417
          Top = 123
          Width = 32
          Height = 13
          Caption = 'Ordem'
        end
        object edtCodBarrasProduto: TEdit
          Left = 12
          Top = 83
          Width = 165
          Height = 21
          TabOrder = 0
          OnExit = edtCodBarrasProdutoExit
        end
        object edtNomeProduto: TEdit
          Left = 199
          Top = 83
          Width = 306
          Height = 21
          Enabled = False
          TabOrder = 1
        end
        object rgTipo: TRadioGroup
          Left = 16
          Top = 8
          Width = 129
          Height = 50
          Caption = 'Tipo'
          ItemIndex = 0
          Items.Strings = (
            'C'#243'digo Produto'
            'C'#243'digo Barras')
          TabOrder = 8
        end
        object edtComplementoProdEndereco: TEdit
          Left = 226
          Top = 142
          Width = 177
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 5
        end
        object edtRuaProdEndereco: TEdit
          Left = 150
          Top = 142
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 4
        end
        object edtAlaProdEndereco: TEdit
          Left = 80
          Top = 142
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          TabOrder = 3
        end
        object edtCodDepositoProdEndereco: TEdit
          Left = 8
          Top = 142
          Width = 57
          Height = 21
          TabOrder = 2
        end
        object btnAdd: TButton
          Left = 609
          Top = 140
          Width = 75
          Height = 25
          Caption = 'Adicionar'
          TabOrder = 7
          OnClick = btnAddClick
        end
        object dbgrdProdutoEndereco: TDBGrid
          Left = 3
          Top = 184
          Width = 681
          Height = 233
          DataSource = dsProdutoEndereco
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 9
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object edtOrdem: TEdit
          Left = 417
          Top = 142
          Width = 58
          Height = 21
          TabOrder = 6
        end
      end
    end
  end
  object cdsEndereco: TClientDataSet
    PersistDataPacket.Data = {
      DE0000009619E0BD010000001800000008000000000003000000DE000A63645F
      70726F6475746F04000100000000000A6E6D5F70726F6475746F010049000000
      01000557494454480200020014000B63645F6465706F7369746F040001000000
      000003616C610100490000000100055749445448020002001400037275610100
      4900000001000557494454480200020014000B636F6D706C656D656E746F0100
      4900000001000557494454480200020014000B6E6D5F656E64657265636F0100
      490000000100055749445448020002001400056F7264656D0400010000000000
      0000}
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
      end
      item
        Name = 'ordem'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 88
    Top = 336
    object intgrfldEnderecocd_deposito: TIntegerField
      DisplayLabel = 'Deposito'
      DisplayWidth = 10
      FieldName = 'cd_deposito'
    end
    object cdsEnderecoala: TStringField
      DisplayLabel = 'Ala'
      DisplayWidth = 10
      FieldName = 'ala'
    end
    object cdsEnderecorua: TStringField
      DisplayLabel = 'Rua'
      DisplayWidth = 9
      FieldName = 'rua'
    end
    object cdsEnderecocomplemento: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 27
      FieldName = 'complemento'
    end
    object cdsEndereconm_endereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'nm_endereco'
    end
    object intgrfldEnderecoordem: TIntegerField
      DisplayLabel = 'Ordem'
      DisplayWidth = 17
      FieldName = 'ordem'
    end
  end
  object dsEndereco: TDataSource
    DataSet = cdsEndereco
    Left = 24
    Top = 336
  end
  object dsProdutoEndereco: TDataSource
    DataSet = cdsProdutoEndereco
    Left = 213
    Top = 337
  end
  object cdsProdutoEndereco: TClientDataSet
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
    Left = 333
    Top = 337
    object intgrfldProdutoEnderecocd_produto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsProdutoEndereconm_produto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'nm_produto'
      Calculated = True
    end
    object intgrfldProdutoEnderecocd_deposito: TIntegerField
      DisplayLabel = 'Deposito'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'cd_deposito'
      Calculated = True
    end
    object cdsProdutoEnderecoala: TStringField
      DisplayLabel = 'Ala'
      DisplayWidth = 10
      FieldName = 'ala'
    end
    object cdsProdutoEnderecorua: TStringField
      DisplayLabel = 'Rua'
      DisplayWidth = 10
      FieldName = 'rua'
    end
    object cdsProdutoEnderecocomplemento: TStringField
      DisplayLabel = 'Complemento'
      DisplayWidth = 14
      FieldName = 'complemento'
    end
    object cdsProdutoEndereconm_endereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 17
      FieldName = 'nm_endereco'
    end
    object intgrfldProdutoEnderecoordem: TIntegerField
      DisplayLabel = 'Ordem'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ordem'
      Calculated = True
    end
  end
end
