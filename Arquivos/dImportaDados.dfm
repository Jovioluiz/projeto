object dmImportaDados: TdmImportaDados
  OldCreateOrder = False
  Height = 231
  Width = 267
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 32
    Top = 24
  end
  object dsClientes: TDataSource
    DataSet = cdsClientes
    Left = 32
    Top = 88
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      C40000009619E0BD010000001800000007000000000003000000C40003736571
      04000100000000000A63645F70726F6475746F01004900000001000557494454
      480200020014000C646573635F70726F6475746F010049000000010005574944
      544802000200140009756E5F6D65646964610100490000000100055749445448
      0200020014000F6661746F725F636F6E76657273616F04000100000000000C70
      65736F5F6C69717569646F08000400000000000A7065736F5F627275746F0800
      0400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'seq'
        DataType = ftInteger
      end
      item
        Name = 'cd_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'desc_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'fator_conversao'
        DataType = ftInteger
      end
      item
        Name = 'peso_liquido'
        DataType = ftFloat
      end
      item
        Name = 'peso_bruto'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 96
    Top = 24
  end
  object cdsClientes: TClientDataSet
    PersistDataPacket.Data = {
      0D0100009619E0BD01000000180000000A0000000000030000000D0103736571
      04000100000000000A63645F636C69656E746504000100000000000A6E6D5F63
      6C69656E746501004900000001000557494454480200020014000974705F7065
      73736F6102000300000000000763656C756C6172010049000000010005574944
      544802000200140005656D61696C010049000000010005574944544802000200
      14000874656C65666F6E65010049000000010005574944544802000200140008
      6370665F636E706A01004900000001000557494454480200020014000572675F
      696501004900000001000557494454480200020014001064745F6E6173635F66
      756E646163616F04000600000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'seq'
        DataType = ftInteger
      end
      item
        Name = 'cd_cliente'
        DataType = ftInteger
      end
      item
        Name = 'nm_cliente'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'tp_pessoa'
        DataType = ftBoolean
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'email'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cpf_cnpj'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'rg_ie'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'dt_nasc_fundacao'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 96
    Top = 88
  end
end
