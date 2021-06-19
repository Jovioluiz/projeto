object dmNotaEntrada: TdmNotaEntrada
  OldCreateOrder = False
  Height = 153
  Width = 128
  object dsNfc: TDataSource
    DataSet = cdsNfc
    Left = 24
    Top = 24
  end
  object cdsNfc: TClientDataSet
    PersistDataPacket.Data = {
      C70200009619E0BD020000001800000013000000000003000000C7020869645F
      676572616C08000100000000000B6463746F5F6E756D65726F04000100000000
      0005736572696501004900000001000557494454480200020014000D63645F66
      6F726E656365646F7204000100000000000A64745F656D697373616F10001100
      000001000753554254595045020049000A00466F726D6174746564000E64745F
      7265636562696D656E746F10001100000001000753554254595045020049000A
      00466F726D6174746564000D64745F6C616E63616D656E746F10001100000001
      000753554254595045020049000A00466F726D6174746564000B63645F6F7065
      726163616F04000100000000000963645F6D6F64656C6F010049000000010005
      57494454480200020014000B76616C6F725F746F74616C080004000000010007
      535542545950450200490006004D6F6E6579000C766C5F626173655F69636D73
      080004000000010007535542545950450200490006004D6F6E6579000C70635F
      616C69715F69636D73080004000000010007535542545950450200490006004D
      6F6E6579000A76616C6F725F69636D7308000400000001000753554254595045
      0200490006004D6F6E6579000B76616C6F725F66726574650800040000000100
      07535542545950450200490006004D6F6E6579000976616C6F725F6970690800
      04000000010007535542545950450200490006004D6F6E6579000976616C6F72
      5F697373080004000000010007535542545950450200490006004D6F6E657900
      0E76616C6F725F646573636F6E746F0800040000000100075355425459504502
      00490006004D6F6E6579000F76616C6F725F616372657363696D6F0800040000
      00010007535542545950450200490006004D6F6E6579001576616C6F725F6F75
      747261735F646573706573617308000400000001000753554254595045020049
      0006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'dcto_numero'
        DataType = ftInteger
      end
      item
        Name = 'serie'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cd_fornecedor'
        DataType = ftInteger
      end
      item
        Name = 'dt_emissao'
        DataType = ftTimeStamp
      end
      item
        Name = 'dt_recebimento'
        DataType = ftTimeStamp
      end
      item
        Name = 'dt_lancamento'
        DataType = ftTimeStamp
      end
      item
        Name = 'cd_operacao'
        DataType = ftInteger
      end
      item
        Name = 'cd_modelo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'valor_total'
        DataType = ftCurrency
      end
      item
        Name = 'vl_base_icms'
        DataType = ftCurrency
      end
      item
        Name = 'pc_aliq_icms'
        DataType = ftCurrency
      end
      item
        Name = 'valor_icms'
        DataType = ftCurrency
      end
      item
        Name = 'valor_frete'
        DataType = ftCurrency
      end
      item
        Name = 'valor_ipi'
        DataType = ftCurrency
      end
      item
        Name = 'valor_iss'
        DataType = ftCurrency
      end
      item
        Name = 'valor_desconto'
        DataType = ftCurrency
      end
      item
        Name = 'valor_acrescimo'
        DataType = ftCurrency
      end
      item
        Name = 'valor_outras_despesas'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 24
    object cdsNfcid_geral: TLargeintField
      FieldName = 'id_geral'
    end
    object cdsNfcdcto_numero: TIntegerField
      FieldName = 'dcto_numero'
    end
    object cdsNfcserie: TStringField
      FieldName = 'serie'
    end
    object cdsNfccd_fornecedor: TIntegerField
      FieldName = 'cd_fornecedor'
    end
    object cdsNfcdt_emissao: TSQLTimeStampField
      FieldName = 'dt_emissao'
    end
    object cdsNfcdt_recebimento: TSQLTimeStampField
      FieldName = 'dt_recebimento'
    end
    object cdsNfcdt_lancamento: TSQLTimeStampField
      FieldName = 'dt_lancamento'
    end
    object cdsNfccd_operacao: TIntegerField
      FieldName = 'cd_operacao'
    end
    object cdsNfccd_modelo: TStringField
      FieldName = 'cd_modelo'
    end
    object cdsNfcvalor_total: TCurrencyField
      FieldName = 'valor_total'
    end
    object cdsNfcvl_base_icms: TCurrencyField
      FieldName = 'vl_base_icms'
    end
    object cdsNfcpc_aliq_icms: TCurrencyField
      FieldName = 'pc_aliq_icms'
    end
    object cdsNfcvalor_icms: TCurrencyField
      FieldName = 'valor_icms'
    end
    object cdsNfcvalor_frete: TCurrencyField
      FieldName = 'valor_frete'
    end
    object cdsNfcvalor_ipi: TCurrencyField
      FieldName = 'valor_ipi'
    end
    object cdsNfcvalor_iss: TCurrencyField
      FieldName = 'valor_iss'
    end
    object cdsNfcvalor_desconto: TCurrencyField
      FieldName = 'valor_desconto'
    end
    object cdsNfcvalor_acrescimo: TCurrencyField
      FieldName = 'valor_acrescimo'
    end
    object cdsNfcvalor_outras_despesas: TCurrencyField
      FieldName = 'valor_outras_despesas'
    end
  end
  object dsNfi: TDataSource
    DataSet = cdsNfi
    Left = 24
    Top = 96
  end
  object cdsNfi: TClientDataSet
    PersistDataPacket.Data = {
      B40300009619E0BD01000000180000001A000000000003000000B4030869645F
      676572616C08000100000000000669645F6E666308000100000000000C736571
      5F6974656D5F6E666904000100000000000769645F6974656D04000100000000
      000A63645F70726F6475746F0100490000000100055749445448020002001400
      0964657363726963616F01004900000001000557494454480200020014000F66
      61746F725F636F6E76657273616F04000100000000000B7174645F6573746F71
      7565080004000000000009756E5F6D6564696461010049000000010005574944
      54480200020005000B766C5F756E69746172696F080004000000010007535542
      545950450200490006004D6F6E65790010766C5F66726574655F726174656164
      6F080004000000010007535542545950450200490006004D6F6E65790013766C
      5F646573636F6E746F5F7261746561646F080004000000010007535542545950
      450200490006004D6F6E65790014766C5F616372657363696D6F5F7261746561
      646F080004000000010007535542545950450200490006004D6F6E6579000C69
      636D735F766C5F62617365080004000000010007535542545950450200490006
      004D6F6E6579000C69636D735F70635F616C6971080004000000010007535542
      545950450200490006004D6F6E6579000A69636D735F76616C6F720800040000
      00010007535542545950450200490006004D6F6E6579000B6970695F766C5F62
      617365080004000000010007535542545950450200490006004D6F6E6579000B
      6970695F70635F616C6971080004000000010007535542545950450200490006
      004D6F6E657900096970695F76616C6F72080004000000010007535542545950
      450200490006004D6F6E657900127069735F636F66696E735F766C5F62617365
      080004000000010007535542545950450200490006004D6F6E65790012706973
      5F636F66696E735F70635F616C69710800040000000100075355425459504502
      00490006004D6F6E657900107069735F636F66696E735F76616C6F7208000400
      0000010007535542545950450200490006004D6F6E6579000B6973735F766C5F
      62617365080004000000010007535542545950450200490006004D6F6E657900
      0B6973735F70635F616C69710800040000000100075355425459504502004900
      06004D6F6E657900096973735F76616C6F720800040000000100075355425459
      50450200490006004D6F6E6579000B76616C6F725F746F74616C080004000000
      010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'id_nfc'
        DataType = ftLargeint
      end
      item
        Name = 'seq_item_nfi'
        DataType = ftInteger
      end
      item
        Name = 'id_item'
        DataType = ftInteger
      end
      item
        Name = 'cd_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'descricao'
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
        Name = 'un_medida'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'vl_unitario'
        DataType = ftCurrency
      end
      item
        Name = 'vl_frete_rateado'
        DataType = ftCurrency
      end
      item
        Name = 'vl_desconto_rateado'
        DataType = ftCurrency
      end
      item
        Name = 'vl_acrescimo_rateado'
        DataType = ftCurrency
      end
      item
        Name = 'icms_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'icms_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'icms_valor'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'ipi_valor'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'pis_cofins_valor'
        DataType = ftCurrency
      end
      item
        Name = 'iss_vl_base'
        DataType = ftCurrency
      end
      item
        Name = 'iss_pc_aliq'
        DataType = ftCurrency
      end
      item
        Name = 'iss_valor'
        DataType = ftCurrency
      end
      item
        Name = 'valor_total'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 96
    object cdsNfiid_geral: TLargeintField
      FieldName = 'id_geral'
      Visible = False
    end
    object cdsNfiid_nfc: TLargeintField
      FieldName = 'id_nfc'
      Visible = False
    end
    object cdsNfiseq_item_nfi: TIntegerField
      DisplayLabel = 'Seq'
      FieldName = 'seq_item_nfi'
    end
    object cdsNfiid_item: TIntegerField
      FieldName = 'id_item'
      Visible = False
    end
    object cdsNficd_produto: TStringField
      DisplayLabel = 'C'#243'd. Produto'
      FieldName = 'cd_produto'
    end
    object cdsNfidescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
    end
    object cdsNfifator_conversao: TIntegerField
      DisplayLabel = 'Fator'
      FieldName = 'fator_conversao'
    end
    object cdsNfiqtd_estoque: TFloatField
      DisplayLabel = 'Qtdade'
      FieldName = 'qtd_estoque'
    end
    object cdsNfiun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
      Size = 5
    end
    object cdsNfivl_unitario: TCurrencyField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'vl_unitario'
    end
    object cdsNfivl_frete_rateado: TCurrencyField
      FieldName = 'vl_frete_rateado'
      Visible = False
    end
    object cdsNfivl_desconto_rateado: TCurrencyField
      FieldName = 'vl_desconto_rateado'
      Visible = False
    end
    object cdsNfivl_acrescimo_rateado: TCurrencyField
      FieldName = 'vl_acrescimo_rateado'
      Visible = False
    end
    object cdsNfiicms_vl_base: TCurrencyField
      DisplayLabel = 'Vl. Base ICMS'
      FieldName = 'icms_vl_base'
    end
    object cdsNfiicms_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. ICMS'
      FieldName = 'icms_pc_aliq'
    end
    object cdsNfiicms_valor: TCurrencyField
      DisplayLabel = 'Valor ICMS'
      FieldName = 'icms_valor'
    end
    object cdsNfiipi_vl_base: TCurrencyField
      DisplayLabel = 'Vl. Base IPI'
      FieldName = 'ipi_vl_base'
    end
    object cdsNfiipi_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq IPI'
      FieldName = 'ipi_pc_aliq'
    end
    object cdsNfiipi_valor: TCurrencyField
      DisplayLabel = 'Valor IPI'
      FieldName = 'ipi_valor'
    end
    object cdsNfipis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'Vl. Base Pis/Cofins'
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsNfipis_cofins_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq Pis/Cofins'
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsNfipis_cofins_valor: TCurrencyField
      DisplayLabel = 'Valor Pis/Cofins'
      FieldName = 'pis_cofins_valor'
    end
    object cdsNfiiss_vl_base: TCurrencyField
      DisplayLabel = 'Vl. Base ISS'
      FieldName = 'iss_vl_base'
    end
    object cdsNfiiss_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq ISS'
      FieldName = 'iss_pc_aliq'
    end
    object cdsNfiiss_valor: TCurrencyField
      DisplayLabel = 'Valor ISS'
      FieldName = 'iss_valor'
    end
    object cdsNfivalor_total: TCurrencyField
      DisplayLabel = 'Total Item'
      FieldName = 'valor_total'
    end
  end
end
