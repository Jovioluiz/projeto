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
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 24
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 88
  end
end
