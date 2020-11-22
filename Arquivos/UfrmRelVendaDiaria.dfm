object frmRelVendaDiaria: TfrmRelVendaDiaria
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Venda Por Per'#237'odo'
  ClientHeight = 734
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 152
    Top = 32
    Width = 136
    Height = 17
    Caption = 'Relat'#243'rio de Vendas '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Height = 734
    ExplicitLeft = 144
    ExplicitTop = 704
    ExplicitHeight = 100
  end
  object Label3: TLabel
    Left = 9
    Top = 85
    Width = 53
    Height = 13
    Caption = 'Data Inicial'
  end
  object Label4: TLabel
    Left = 169
    Top = 85
    Width = 48
    Height = 13
    Caption = 'Data Final'
  end
  object dbGridProdutosVendas: TDBGrid
    Left = 8
    Top = 132
    Width = 444
    Height = 561
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Cd. Cliente'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nr. Pedido'
        ReadOnly = True
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Acrescimo'
        ReadOnly = True
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Desconto'
        ReadOnly = True
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor Total'
        ReadOnly = True
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Data Emiss'#227'o'
        ReadOnly = True
        Width = 73
        Visible = True
      end>
  end
  object btnPesquisar: TButton
    Left = 320
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 2
    OnClick = btnPesquisarClick
  end
  object edtDtemissaoInicial: TMaskEdit
    Left = 72
    Top = 82
    Width = 71
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object edtValorTotal: TEdit
    Left = 320
    Top = 699
    Width = 67
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object edtDtemissaoFinal: TMaskEdit
    Left = 232
    Top = 82
    Width = 71
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
  end
  object edtValorDesconto: TEdit
    Left = 232
    Top = 699
    Width = 67
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object edtValorAcrescimo: TEdit
    Left = 149
    Top = 699
    Width = 67
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object DataSource1: TDataSource
    DataSet = sqlListaVendaDiaria
    Left = 72
    Top = 296
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    MasterSource = DataSource1
    PacketRecords = 0
    Params = <
      item
        DataType = ftUnknown
        Name = 'cd_cliente'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'nr_pedido'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vl_acrescimo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vl_desconto_pedido'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vl_total'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dt_emissao'
        ParamType = ptUnknown
      end>
    Left = 152
    Top = 296
  end
  object sqlListaVendaDiaria: TFDQuery
    Connection = dm.conexaoBanco
    Left = 248
    Top = 296
  end
  object sqlSoma: TFDQuery
    Connection = dm.conexaoBanco
    Left = 336
    Top = 296
  end
end
