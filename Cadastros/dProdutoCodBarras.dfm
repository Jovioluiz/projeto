object dmProdutoCodBarras: TdmProdutoCodBarras
  OldCreateOrder = False
  Height = 150
  Width = 215
  object dsBarras: TDataSource
    DataSet = cdsBarras
    Left = 40
    Top = 48
  end
  object cdsBarras: TClientDataSet
    PersistDataPacket.Data = {
      7E0000009619E0BD0100000018000000030000000000030000007E0009756E5F
      6D656469646101004900000001000557494454480200020014000F7469706F5F
      636F645F62617272617301004900000001000557494454480200020014000D63
      6F6469676F5F6261727261730100490000000100055749445448020002001400
      0000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 56
    object cdsBarrasun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
    end
    object cdsBarrastipo_cod_barras: TStringField
      DisplayLabel = 'Tipo C'#243'd Barras'
      FieldName = 'tipo_cod_barras'
    end
    object cdsBarrascodigo_barras: TStringField
      DisplayLabel = 'C'#243'digo Barras'
      FieldName = 'codigo_barras'
    end
  end
end
