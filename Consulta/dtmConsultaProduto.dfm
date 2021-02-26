object dmConsultaProduto: TdmConsultaProduto
  OldCreateOrder = False
  Height = 225
  Width = 388
  object query: TFDQuery
    Connection = dm.conexaoBanco
    SQL.Strings = (
      '')
    Left = 24
    Top = 168
  end
  object dsUltimaEntrada: TDataSource
    DataSet = cdsUltimasEntradas
    Left = 40
    Top = 24
  end
  object cdsUltimasEntradas: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
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
  object DataSetProvider1: TDataSetProvider
    DataSet = query
    Left = 88
    Top = 168
  end
  object dsConsultaProduto: TDataSource
    DataSet = cdsConsultaProduto
    Left = 40
    Top = 88
  end
  object cdsConsultaProduto: TClientDataSet
    PersistDataPacket.Data = {
      B40000009619E0BD010000001800000006000000000003000000B4000A63645F
      70726F6475746F01004900000001000557494454480200020014000C64657363
      5F70726F6475746F010049000000010005574944544802000200640009756E5F
      6D656469646101004900000001000557494454480200020014000F6661746F72
      5F636F6E76657273616F04000100000000000B7174645F6573746F7175650800
      0400000000000769645F6974656D08000100000000000000}
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
        Name = 'qtd_estoque'
        DataType = ftFloat
      end
      item
        Name = 'id_item'
        DataType = ftLargeint
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 96
  end
end
