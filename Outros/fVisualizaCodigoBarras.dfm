object fVisualizaCodBarras: TfVisualizaCodBarras
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'C'#243'digo de barras do item: '
  ClientHeight = 116
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbGridCodBarras: TDBGrid
    Left = 0
    Top = 0
    Width = 250
    Height = 116
    Align = alClient
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ds: TDataSource
    DataSet = cds
    Left = 104
    Top = 40
  end
  object cds: TClientDataSet
    PersistDataPacket.Data = {
      560000009619E0BD01000000180000000200000000000300000056000963645F
      6261727261730100490000000100055749445448020002000F0009756E5F6D65
      6469646101004900000001000557494454480200020005000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cd_barras'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 168
    Top = 40
  end
end
