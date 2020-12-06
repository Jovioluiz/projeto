object frmImportaDados: TfrmImportaDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Importar Produtos'
  ClientHeight = 496
  ClientWidth = 645
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
  object Label1: TLabel
    Left = 24
    Top = 19
    Width = 41
    Height = 13
    Caption = 'Arquivo:'
  end
  object SpeedButton1: TSpeedButton
    Left = 367
    Top = 16
    Width = 26
    Height = 22
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object Gauge1: TGauge
    Left = 71
    Top = 247
    Width = 522
    Height = 17
    Progress = 0
    Visible = False
  end
  object btnGravar: TButton
    Left = 399
    Top = 14
    Width = 98
    Height = 25
    Caption = 'Gravar Produto'
    TabOrder = 0
    OnClick = btnGravarClick
  end
  object edtArquivo: TEdit
    Left = 71
    Top = 16
    Width = 290
    Height = 21
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 110
    Width = 98
    Height = 25
    Caption = 'Visualizar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 150
    Width = 645
    Height = 346
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 142
    object DBGrid1: TDBGrid
      Left = 1
      Top = 0
      Width = 643
      Height = 345
      Align = alBottom
      DataSource = dsRegistros
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dlArquivo: TOpenTextFileDialog
    Left = 576
    Top = 8
  end
  object dsRegistros: TDataSource
    DataSet = cdsRegistros
    Left = 256
    Top = 264
  end
  object cdsRegistros: TClientDataSet
    PersistDataPacket.Data = {
      AC0000009619E0BD010000001800000006000000000003000000AC000A63645F
      70726F6475746F04000100000000000C646573635F70726F6475746F01004900
      0000010005574944544802000200140009756E5F6D6564696461010049000000
      01000557494454480200020014000F6661746F725F636F6E76657273616F0400
      0100000000000C7065736F5F6C69717569646F08000400000000000A7065736F
      5F627275746F08000400000000000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 264
    object cdsRegistroscd_produto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      DisplayWidth = 10
      FieldName = 'cd_produto'
    end
    object cdsRegistrosdesc_produto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 25
      FieldName = 'desc_produto'
    end
    object cdsRegistrosun_medida: TStringField
      DisplayLabel = 'UN Medida'
      DisplayWidth = 20
      FieldName = 'un_medida'
    end
    object cdsRegistrosfator_conversao: TIntegerField
      DisplayLabel = 'Fator Convers'#227'o'
      DisplayWidth = 13
      FieldName = 'fator_conversao'
    end
    object cdsRegistrospeso_liquido: TFloatField
      DisplayLabel = 'Peso Liquido'
      DisplayWidth = 10
      FieldName = 'peso_liquido'
    end
    object cdsRegistrospeso_bruto: TFloatField
      DisplayLabel = 'Peso Bruto'
      DisplayWidth = 17
      FieldName = 'peso_bruto'
    end
  end
end
