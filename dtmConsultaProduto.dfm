object dmConsultaProduto: TdmConsultaProduto
  OldCreateOrder = False
  Height = 225
  Width = 388
  object queryUltEntradaProduto: TFDQuery
    Connection = dm.FDConnection1
    SQL.Strings = (
      '')
    Left = 128
    Top = 40
  end
  object dsUltimaEntrada: TDataSource
    DataSet = queryUltEntradaProduto
    Left = 32
    Top = 32
  end
end
