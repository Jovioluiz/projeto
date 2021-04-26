object frmLista: TfrmLista
  Left = 0
  Top = 0
  Caption = 'frmLista'
  ClientHeight = 679
  ClientWidth = 1219
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 32
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnAdd: TButton
    Left = 32
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object DBGrid1: TDBGrid
    Left = 32
    Top = 143
    Width = 577
    Height = 201
    DataSource = ds
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 136
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    OnClick = Button1Click
  end
  object edtCont: TEdit
    Left = 32
    Top = 347
    Width = 49
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object Button2: TButton
    Left = 632
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Listar'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 632
    Top = 143
    Width = 577
    Height = 201
    TabOrder = 7
  end
  object DBGrid2: TDBGrid
    Left = 32
    Top = 424
    Width = 577
    Height = 225
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button3: TButton
    Left = 32
    Top = 393
    Width = 75
    Height = 25
    Caption = 'Listar'
    TabOrder = 9
    OnClick = Button3Click
  end
  object edtBuscar: TEdit
    Left = 113
    Top = 393
    Width = 121
    Height = 25
    TabOrder = 10
    OnChange = edtBuscarChange
  end
  object Memo2: TMemo
    Left = 632
    Top = 424
    Width = 577
    Height = 217
    Lines.Strings = (
      '')
    TabOrder = 11
  end
  object Button4: TButton
    Left = 632
    Top = 393
    Width = 75
    Height = 25
    Caption = 'Listar'
    TabOrder = 12
    OnClick = Button4Click
  end
  object ds: TDataSource
    DataSet = cds
    Left = 408
    Top = 232
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      D40000009619E0BD010000001800000007000000000003000000D4000A63645F
      636C69656E74650400010000000000046E6F6D65010049000000010005574944
      54480200020014000974705F706573736F610100490000000100055749445448
      0200020014000874656C65666F6E650100490000000100055749445448020002
      0014000763656C756C6172010049000000010005574944544802000200140005
      656D61696C0100490000000100055749445448020002001400086370665F636E
      706A01004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 496
    Top = 232
    object cdscd_cliente: TIntegerField
      DisplayWidth = 9
      FieldName = 'cd_cliente'
    end
    object cdsnome: TStringField
      DisplayWidth = 14
      FieldName = 'nome'
    end
    object cdstp_pessoa: TStringField
      DisplayWidth = 14
      FieldName = 'tp_pessoa'
    end
    object cdstelefone: TStringField
      DisplayWidth = 12
      FieldName = 'telefone'
    end
    object cdscelular: TStringField
      DisplayWidth = 11
      FieldName = 'celular'
    end
    object cdsemail: TStringField
      DisplayWidth = 14
      FieldName = 'email'
    end
    object cdscpf_cnpj: TStringField
      DisplayWidth = 12
      FieldName = 'cpf_cnpj'
    end
  end
  object dsPedido: TDataSource
    DataSet = cdsPedido
    Left = 272
    Top = 472
  end
  object cdsPedido: TClientDataSet
    PersistDataPacket.Data = {
      5F0000009619E0BD0100000018000000030000000000030000005F000F69645F
      70656469646F5F76656E646108000100000000000869645F676572616C080001
      00000000000763645F6974656D01004900000001000557494454480200020014
      000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'id_pedido_venda'
        DataType = ftLargeint
      end
      item
        Name = 'id_geral'
        DataType = ftLargeint
      end
      item
        Name = 'cd_item'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 328
    Top = 472
  end
end
