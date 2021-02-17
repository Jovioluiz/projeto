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
      8D0000009619E0BD0100000018000000050000000000030000008D000763645F
      6163616F0400010000000000076E6D5F6163616F010049000000010005574944
      5448020002001E0011666C5F7065726D6974655F61636573736F020003000000
      000011666C5F7065726D6974655F65646963616F02000300000000000A63645F
      7573756172696F04000100000000000000}
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
        Size = 30
      end
      item
        Name = 'fl_permite_acesso'
        DataType = ftBoolean
      end
      item
        Name = 'fl_permite_edicao'
        DataType = ftBoolean
      end
      item
        Name = 'cd_usuario'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 120
    Top = 48
    object cdscd_acao: TIntegerField
      FieldName = 'cd_acao'
    end
    object cdsnm_acao: TStringField
      FieldName = 'nm_acao'
      Size = 25
    end
    object cdsfl_permite_acesso: TBooleanField
      FieldName = 'fl_permite_acesso'
    end
    object cdsfl_permite_edicao: TBooleanField
      FieldName = 'fl_permite_edicao'
    end
    object cdscd_usuario: TIntegerField
      FieldName = 'cd_usuario'
    end
  end
end
