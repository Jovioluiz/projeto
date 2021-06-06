object dmProdutosTabelaPreco: TdmProdutosTabelaPreco
  OldCreateOrder = False
  Height = 150
  Width = 215
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 48
    Top = 48
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      980000009619E0BD01000000180000000400000000000300000098000A63645F
      70726F6475746F01004900000001000557494454480200020014000A6E6D5F70
      726F6475746F01004900000001000557494454480200020014000576616C6F72
      080004000000010007535542545950450200490006004D6F6E65790009756E5F
      6D65646964610100490000000100055749445448020002000A000000}
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
        Name = 'valor'
        DataType = ftCurrency
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 48
    object cdsProdutoscd_produto: TStringField
      DisplayLabel = 'C'#243'd Produto'
      FieldName = 'cd_produto'
    end
    object cdsProdutosnm_produto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'nm_produto'
    end
    object cdsProdutosvalor: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object cdsProdutosun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Size = 10
    end
  end
end
