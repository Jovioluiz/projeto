object dmPedidoVenda: TdmPedidoVenda
  OldCreateOrder = False
  Height = 179
  Width = 324
  object dsPedidoVendaItem: TDataSource
    DataSet = cdsPedidoVendaItem
    Left = 48
    Top = 24
  end
  object cdsPedidoVendaItem: TClientDataSet
    PersistDataPacket.Data = {
      D80200009619E0BD010000001800000015000000000003000000D80203736571
      04000100000000000869645F676572616C08000100000000000769645F697465
      6D08000100000000000F69645F70656469646F5F76656E646108000100000000
      000A63645F70726F6475746F0100490000000100055749445448020002001400
      0964657363726963616F01004900000001000557494454480200020014000971
      74645F76656E646108000400000000000F63645F746162656C615F707265636F
      040001000000000009756E5F6D65646964610100490000000100055749445448
      0200020005000B766C5F756E69746172696F0800040000000100075355425459
      50450200490006004D6F6E6579000B766C5F646573636F6E746F080004000000
      010007535542545950450200490006004D6F6E6579000D766C5F746F74616C5F
      6974656D080004000000010007535542545950450200490006004D6F6E657900
      0C69636D735F766C5F6261736508000400000001000753554254595045020049
      0006004D6F6E6579000C69636D735F70635F616C697108000400000001000753
      5542545950450200490006004D6F6E6579000A69636D735F76616C6F72080004
      000000010007535542545950450200490006004D6F6E6579000B6970695F766C
      5F62617365080004000000010007535542545950450200490006004D6F6E6579
      000B6970695F70635F616C697108000400000001000753554254595045020049
      0006004D6F6E657900096970695F76616C6F7208000400000001000753554254
      5950450200490006004D6F6E657900127069735F636F66696E735F766C5F6261
      7365080004000000010007535542545950450200490006004D6F6E6579001270
      69735F636F66696E735F70635F616C6971080004000000010007535542545950
      450200490006004D6F6E657900107069735F636F66696E735F76616C6F720800
      04000000010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'seq'
        DataType = ftInteger
      end
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'id_item'
        DataType = ftLargeint
      end
      item
        Name = 'id_pedido_venda'
        DataType = ftLargeint
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
        Name = 'qtd_venda'
        DataType = ftFloat
      end
      item
        Name = 'cd_tabela_preco'
        DataType = ftInteger
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
        Name = 'vl_desconto'
        DataType = ftCurrency
      end
      item
        Name = 'vl_total_item'
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
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 160
    Top = 24
    object cdsPedidoVendaItemseq: TIntegerField
      FieldName = 'seq'
    end
    object cdsPedidoVendaItemid_geral: TLargeintField
      FieldName = 'id_geral'
      Visible = False
    end
    object cdsPedidoVendaItemid_item: TLargeintField
      FieldName = 'id_item'
      Visible = False
    end
    object cdsPedidoVendaItemid_pedido_venda: TLargeintField
      FieldName = 'id_pedido_venda'
      Visible = False
    end
    object cdsPedidoVendaItemcd_produto: TStringField
      DisplayLabel = 'C'#243'd Produto'
      FieldName = 'cd_produto'
    end
    object cdsPedidoVendaItemdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
    end
    object cdsPedidoVendaItemqtd_venda: TFloatField
      DisplayLabel = 'Qtd'
      FieldName = 'qtd_venda'
    end
    object cdsPedidoVendaItemcd_tabela_preco: TIntegerField
      DisplayLabel = 'C'#243'd. Tabela'
      FieldName = 'cd_tabela_preco'
    end
    object cdsPedidoVendaItemun_medida: TStringField
      DisplayLabel = 'UN'
      FieldName = 'un_medida'
      Size = 5
    end
    object cdsPedidoVendaItemvl_unitario: TCurrencyField
      DisplayLabel = 'Valor Un.'
      FieldName = 'vl_unitario'
    end
    object cdsPedidoVendaItemvl_desconto: TCurrencyField
      DisplayLabel = 'Valor Desc.'
      FieldName = 'vl_desconto'
    end
    object cdsPedidoVendaItemvl_total_item: TCurrencyField
      DisplayLabel = 'Valor Total'
      FieldName = 'vl_total_item'
    end
    object cdsPedidoVendaItemicms_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base ICMS '
      FieldName = 'icms_vl_base'
    end
    object cdsPedidoVendaItemicms_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. ICMS'
      FieldName = 'icms_pc_aliq'
    end
    object cdsPedidoVendaItemicms_valor: TCurrencyField
      DisplayLabel = 'Valor ICMS'
      FieldName = 'icms_valor'
    end
    object cdsPedidoVendaItemipi_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base IPI'
      FieldName = 'ipi_vl_base'
    end
    object cdsPedidoVendaItemipi_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. IPI'
      FieldName = 'ipi_pc_aliq'
    end
    object cdsPedidoVendaItemipi_valor: TCurrencyField
      DisplayLabel = 'Valor IPI'
      FieldName = 'ipi_valor'
    end
    object cdsPedidoVendaItempis_cofins_vl_base: TCurrencyField
      DisplayLabel = 'Valor Base PIS/COFINS'
      FieldName = 'pis_cofins_vl_base'
    end
    object cdsPedidoVendaItempis_cofins_pc_aliq: TCurrencyField
      DisplayLabel = 'Aliq. PIS/COFINS'
      FieldName = 'pis_cofins_pc_aliq'
    end
    object cdsPedidoVendaItempis_cofins_valor: TCurrencyField
      DisplayLabel = 'Valor PIS/COFINS'
      FieldName = 'pis_cofins_valor'
    end
  end
  object dsPedidoVenda: TDataSource
    DataSet = cdsPedidoVenda
    Left = 48
    Top = 104
  end
  object cdsPedidoVenda: TClientDataSet
    PersistDataPacket.Data = {
      3F0100009619E0BD01000000180000000B0000000000030000003F010869645F
      676572616C0800010000000000096E725F70656469646F04000100000000000A
      63645F636C69656E746504000100000000000C63645F666F726D615F70616704
      000100000000000B63645F636F6E645F706167040001000000000012766C5F64
      6573636F6E746F5F70656469646F080004000000010007535542545950450200
      490006004D6F6E6579000C766C5F616372657363696D6F080004000000010007
      535542545950450200490006004D6F6E65790008766C5F746F74616C08000400
      0000010007535542545950450200490006004D6F6E6579000C666C5F6F726361
      6D656E746F02000300000000000A64745F656D697373616F0400060000000000
      0C666C5F63616E63656C61646F01004900000001000557494454480200020001
      000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'nr_pedido'
        DataType = ftInteger
      end
      item
        Name = 'cd_cliente'
        DataType = ftInteger
      end
      item
        Name = 'cd_forma_pag'
        DataType = ftInteger
      end
      item
        Name = 'cd_cond_pag'
        DataType = ftInteger
      end
      item
        Name = 'vl_desconto_pedido'
        DataType = ftCurrency
      end
      item
        Name = 'vl_acrescimo'
        DataType = ftCurrency
      end
      item
        Name = 'vl_total'
        DataType = ftCurrency
      end
      item
        Name = 'fl_orcamento'
        DataType = ftBoolean
      end
      item
        Name = 'dt_emissao'
        DataType = ftDate
      end
      item
        Name = 'fl_cancelado'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 152
    Top = 104
    object cdsPedidoVendaid_geral: TLargeintField
      FieldName = 'id_geral'
    end
    object cdsPedidoVendanr_pedido: TIntegerField
      FieldName = 'nr_pedido'
    end
    object cdsPedidoVendacd_cliente: TIntegerField
      FieldName = 'cd_cliente'
    end
    object cdsPedidoVendacd_forma_pag: TIntegerField
      FieldName = 'cd_forma_pag'
    end
    object cdsPedidoVendacd_cond_pag: TIntegerField
      FieldName = 'cd_cond_pag'
    end
    object cdsPedidoVendavl_desconto_pedido: TCurrencyField
      FieldName = 'vl_desconto_pedido'
    end
    object cdsPedidoVendavl_acrescimo: TCurrencyField
      FieldName = 'vl_acrescimo'
    end
    object cdsPedidoVendavl_total: TCurrencyField
      FieldName = 'vl_total'
    end
    object cdsPedidoVendafl_orcamento: TBooleanField
      FieldName = 'fl_orcamento'
    end
    object cdsPedidoVendadt_emissao: TDateField
      FieldName = 'dt_emissao'
    end
    object cdsPedidoVendafl_cancelado: TStringField
      FieldName = 'fl_cancelado'
      Size = 1
    end
  end
end
