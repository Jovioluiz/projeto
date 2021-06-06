object dmWMS: TdmWMS
  OldCreateOrder = False
  Height = 147
  Width = 201
  object dsEndereco: TDataSource
    DataSet = cdsEndereco
    Left = 24
    Top = 16
  end
  object dsEnderecoProduto: TDataSource
    DataSet = cdsEnderecoProduto
    Left = 112
    Top = 16
  end
  object cdsEndereco: TClientDataSet
    PersistDataPacket.Data = {
      AC0000009619E0BD010000001800000006000000000003000000AC000B63645F
      6465706F7369746F040001000000000003616C61010049000000010005574944
      5448020002001400037275610100490000000100055749445448020002001400
      0B636F6D706C656D656E746F0100490000000100055749445448020002001400
      0B6E6D5F656E64657265636F0100490000000100055749445448020002001400
      056F7264656D04000100000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 72
    object cdsEnderecocd_deposito: TIntegerField
      FieldName = 'cd_deposito'
    end
    object cdsEnderecoala: TStringField
      FieldName = 'ala'
    end
    object cdsEnderecorua: TStringField
      FieldName = 'rua'
    end
    object cdsEnderecocomplemento: TStringField
      FieldName = 'complemento'
    end
    object cdsEndereconm_endereco: TStringField
      FieldName = 'nm_endereco'
    end
    object cdsEnderecoordem: TIntegerField
      FieldName = 'ordem'
    end
  end
  object cdsEnderecoProduto: TClientDataSet
    PersistDataPacket.Data = {
      EA0000009619E0BD010000001800000008000000000003000000EA000A63645F
      70726F6475746F01004900000001000557494454480200020014000A6E6D5F70
      726F6475746F01004900000001000557494454480200020014000B63645F6465
      706F7369746F040001000000000003616C610100490000000100055749445448
      0200020014000372756101004900000001000557494454480200020014000B63
      6F6D706C656D656E746F01004900000001000557494454480200020014000B6E
      6D5F656E64657265636F0100490000000100055749445448020002001400056F
      7264656D04000100000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_produto'
        DataType = ftString
        Size = 20
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
    Left = 120
    Top = 64
  end
end
