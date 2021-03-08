object dmConsultaProduto: TdmConsultaProduto
  OldCreateOrder = False
  Height = 225
  Width = 388
  object dsUltimaEntrada: TDataSource
    DataSet = cdsUltimasEntradas
    Left = 40
    Top = 24
  end
  object cdsUltimasEntradas: TClientDataSet
    PersistDataPacket.Data = {
      BC0000009619E0BD010000001800000006000000000003000000BC000B646374
      6F5F6E756D65726F04000100000000000A666F726E656365646F720100490000
      000100055749445448020002001E000D64745F6C616E63616D656E746F040006
      00000000000A7175616E74696461646508000400000000000B766C5F756E6974
      6172696F080004000000010007535542545950450200490006004D6F6E657900
      09756E5F6D65646964610100490000000100055749445448020002000A000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 24
    object cdsUltimasEntradasnota: TIntegerField
      DisplayLabel = 'Nota'
      FieldName = 'dcto_numero'
    end
    object cdsUltimasEntradasfornecedor: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'fornecedor'
      Size = 30
    end
    object cdsUltimasEntradasdataLancamento: TDateField
      DisplayLabel = 'Data Lancamento'
      FieldName = 'dt_lancamento'
    end
    object cdsUltimasEntradasquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsUltimasEntradasvalor_unitario: TCurrencyField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'vl_unitario'
    end
    object cdsUltimasEntradasun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Size = 10
    end
  end
  object dsConsultaProduto: TDataSource
    DataSet = cdsConsultaProduto
    Left = 40
    Top = 88
  end
  object cdsConsultaProduto: TClientDataSet
    PersistDataPacket.Data = {
      A00000009619E0BD010000001800000005000000000003000000A0000A63645F
      70726F6475746F01004900000001000557494454480200020014000C64657363
      5F70726F6475746F010049000000010005574944544802000200640009756E5F
      6D656469646101004900000001000557494454480200020014000F6661746F72
      5F636F6E76657273616F04000100000000000769645F6974656D080001000000
      00000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'desc_produto'
        DataType = ftString
        Size = 100
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
        Name = 'id_item'
        DataType = ftLargeint
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 88
    object cdsConsultaProdutocd_produto: TStringField
      DisplayLabel = 'C'#243'd Produto'
      FieldName = 'cd_produto'
    end
    object cdsConsultaProdutodesc_produto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'desc_produto'
      Size = 50
    end
    object cdsConsultaProdutoun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
    end
    object cdsConsultaProdutofator_conversao: TIntegerField
      DisplayLabel = 'Fator Convers'#227'o'
      FieldName = 'fator_conversao'
    end
    object cdsConsultaProdutoid_item: TLargeintField
      FieldName = 'id_item'
    end
  end
  object dsPrecos: TDataSource
    DataSet = cdsPrecos
    Left = 232
    Top = 24
  end
  object cdsPrecos: TClientDataSet
    PersistDataPacket.Data = {
      8A0000009619E0BD0100000018000000040000000000030000008A000963645F
      746162656C610400010000000000096E6D5F746162656C610100490000000100
      0557494454480200020064000576616C6F720800040000000100075355425459
      50450200490006004D6F6E65790009756E5F6D65646964610100490000000100
      0557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_tabela'
        DataType = ftInteger
      end
      item
        Name = 'nm_tabela'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'valor'
        DataType = ftCurrency
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 288
    Top = 32
    object cdsPrecoscd_tabela: TIntegerField
      DisplayLabel = 'C'#243'd Tabela'
      FieldName = 'cd_tabela'
    end
    object cdsPrecosnm_tabela: TStringField
      DisplayLabel = 'Nome Tabela'
      FieldName = 'nm_tabela'
      Size = 50
    end
    object cdsPrecosvalor: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
    end
    object cdsPrecosun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
    end
  end
  object dsEstoque: TDataSource
    DataSet = cdsEstoque
    Left = 232
    Top = 96
  end
  object cdsEstoque: TClientDataSet
    PersistDataPacket.Data = {
      5B0000009619E0BD0100000018000000030000000000030000005B000B6E6D5F
      656E64657265636F0100490000000100055749445448020002001400056F7264
      656D04000100000000000A71745F6573746F71756508000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nm_endereco'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ordem'
        DataType = ftInteger
      end
      item
        Name = 'qt_estoque'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 296
    Top = 96
    object cdsEstoquenm_endereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'nm_endereco'
    end
    object cdsEstoqueordem: TIntegerField
      DisplayLabel = 'Ordem'
      FieldName = 'ordem'
    end
    object cdsEstoqueqt_estoque: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'qt_estoque'
    end
  end
end
