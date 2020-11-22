object dmConsultaProduto: TdmConsultaProduto
  OldCreateOrder = False
  Height = 225
  Width = 388
  object query: TFDQuery
    Connection = dm.conexaoBanco
    SQL.Strings = (
      '')
    Left = 72
    Top = 104
  end
  object dsUltimaEntrada: TDataSource
    DataSet = cdsUltEntrada
    Left = 40
    Top = 24
  end
  object cdsUltEntrada: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 128
    Top = 24
    object cdsUltEntradanota: TIntegerField
      DisplayLabel = 'Nota'
      FieldName = 'dcto_numero'
    end
    object cdsUltEntradafornecedor: TStringField
      DisplayLabel = 'Fornecedor'
      FieldName = 'fornecedor'
      Size = 30
    end
    object cdsUltEntradadataLancamento: TDateField
      DisplayLabel = 'Data Lancamento'
      FieldName = 'dt_lancamento'
    end
    object cdsUltEntradaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object cdsUltEntradavalor_unitario: TCurrencyField
      DisplayLabel = 'Valor Unitario'
      FieldName = 'vl_unitario'
    end
    object cdsUltEntradaun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Size = 10
    end
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = query
    Left = 168
    Top = 104
  end
end
