object frmConsulta: TfrmConsulta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Consulta'
  ClientHeight = 386
  ClientWidth = 726
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
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 386
    Align = alClient
    TabOrder = 0
    object dbgrd1: TDBGrid
      Left = 0
      Top = 1
      Width = 726
      Height = 288
      DataSource = ds
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgrd1DblClick
    end
    object rgFiltros: TRadioGroup
      Left = 543
      Top = 295
      Width = 113
      Height = 74
      Caption = 'Filtros'
      ItemIndex = 0
      Items.Strings = (
        'Nome'
        'C'#243'digo'
        'CPF/CNPJ')
      TabOrder = 0
    end
    object edtBusca: TEdit
      Left = 8
      Top = 320
      Width = 513
      Height = 21
      TabOrder = 2
    end
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_cliente'
        DataType = ftInteger
      end
      item
        Name = 'nm_cliente'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cpf_cnpj'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 232
    Top = 192
    object cdsConsultacd_cliente: TIntegerField
      DisplayLabel = 'C'#243'd Cliente'
      DisplayWidth = 12
      FieldName = 'cd_cliente'
    end
    object cdsConsultanm_cliente: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'nm_cliente'
    end
    object cdsConsultacpf_cnpj: TStringField
      DisplayLabel = 'CPF/CNPJ'
      DisplayWidth = 34
      FieldName = 'cpf_cnpj'
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 304
    Top = 192
  end
  object cds: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 616
    Top = 184
  end
  object ds: TDataSource
    DataSet = cds
    Left = 544
    Top = 192
  end
end
