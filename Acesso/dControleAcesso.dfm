object dmControleAcesso: TdmControleAcesso
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ds: TDataSource
    DataSet = cds
    Left = 48
    Top = 48
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      7A0000009619E0BD0100000018000000040000000000030000007A000763645F
      6163616F0400010000000000076E6D5F6163616F010049000000010005574944
      544802000200320011666C5F7065726D6974655F61636573736F020003000000
      000011666C5F7065726D6974655F65646963616F02000300000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_acao'
        DataType = ftInteger
      end
      item
        Name = 'nm_acao'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'fl_permite_acesso'
        DataType = ftBoolean
      end
      item
        Name = 'fl_permite_edicao'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 48
  end
end
