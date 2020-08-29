object frmConsulta: TfrmConsulta
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Consulta'
  ClientHeight = 336
  ClientWidth = 657
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
    Width = 657
    Height = 336
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 112
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbgrd1: TDBGrid
      Left = 1
      Top = 1
      Width = 655
      Height = 334
      Align = alClient
      DataSource = dsConsulta
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object cdsConsulta: TClientDataSet
    PersistDataPacket.Data = {
      690000009619E0BD01000000180000000300000000000300000069000A63645F
      636C69656E746504000100000000000A6E6D5F636C69656E7465010049000000
      0100055749445448020002001400086370665F636E706A010049000000010005
      57494454480200020014000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 192
    object intgrfldConsultacd_cliente: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      DisplayWidth = 20
      FieldName = 'cd_cliente'
    end
    object cdsConsultanm_cliente: TStringField
      DisplayLabel = 'Nome Cliente'
      DisplayWidth = 31
      FieldName = 'nm_cliente'
    end
    object cdsConsultacpf_cnpj: TStringField
      DisplayLabel = 'CPF/CNPJ'
      DisplayWidth = 31
      FieldName = 'cpf_cnpj'
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 304
    Top = 192
  end
end
