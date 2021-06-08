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
      7F0000009619E0BD0100000018000000040000000000030000007F000763645F
      6163616F0400010000000000076E6D5F6163616F010049000000010005574944
      5448020002001E0011666C5F7065726D6974655F65646963616F010049000000
      01000557494454480200020005000A63645F7573756172696F04000100000000
      000000}
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
        Name = 'fl_permite_edicao'
        DataType = ftString
        Size = 5
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
      DisplayLabel = 'C'#243'd. A'#231#227'o'
      FieldName = 'cd_acao'
    end
    object cdsnm_acao: TStringField
      DisplayLabel = 'Nome A'#231#227'o'
      FieldName = 'nm_acao'
      Size = 25
    end
    object cdsfl_permite_edicao: TStringField
      DisplayLabel = 'Edi'#231#227'o'
      FieldName = 'fl_permite_edicao'
      Size = 5
    end
    object cdscd_usuario: TIntegerField
      FieldName = 'cd_usuario'
      Visible = False
    end
  end
end
