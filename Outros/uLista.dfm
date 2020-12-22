object frmLista: TfrmLista
  Left = 0
  Top = 0
  Caption = 'frmLista'
  ClientHeight = 376
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
    Top = 152
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
end
