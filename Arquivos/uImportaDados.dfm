object frmImportaDados: TfrmImportaDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Importar Dados'
  ClientHeight = 486
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
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 486
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 633
      Height = 484
      ActivePage = tbProdutos
      Align = alClient
      TabOrder = 0
      object tbProdutos: TTabSheet
        Caption = 'Produtos'
        object Label1: TLabel
          Left = 3
          Top = 19
          Width = 41
          Height = 13
          Caption = 'Arquivo:'
        end
        object SpeedButton1: TSpeedButton
          Left = 346
          Top = 15
          Width = 26
          Height = 22
          Caption = '...'
          OnClick = SpeedButton1Click
        end
        object edtArquivo: TEdit
          Left = 50
          Top = 16
          Width = 290
          Height = 21
          TabOrder = 0
        end
        object btnVisualizarProdutos: TButton
          Left = 3
          Top = 70
          Width = 98
          Height = 25
          Caption = 'Visualizar'
          TabOrder = 1
          OnClick = btnVisualizarProdutosClick
        end
        object btnGravar: TButton
          Left = 378
          Top = 14
          Width = 98
          Height = 25
          Caption = 'Gravar Produto'
          TabOrder = 2
          OnClick = btnGravarClick
        end
        object Panel1: TPanel
          Left = 0
          Top = 109
          Width = 625
          Height = 347
          Align = alBottom
          TabOrder = 3
          object gaugeProdutos: TGauge
            Left = 50
            Top = 32
            Width = 521
            Height = 18
            Progress = 0
            Visible = False
          end
          object dbGridProdutos: TDBGrid
            Left = 1
            Top = 56
            Width = 623
            Height = 290
            Align = alBottom
            DataSource = dsProdutos
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
          end
        end
      end
      object tbClientes: TTabSheet
        Caption = 'Clientes'
        ImageIndex = 1
        object Label2: TLabel
          Left = 3
          Top = 19
          Width = 41
          Height = 13
          Caption = 'Arquivo:'
        end
        object btnBuscaArquivoCliente: TSpeedButton
          Left = 346
          Top = 15
          Width = 26
          Height = 22
          Caption = '...'
          OnClick = btnBuscaArquivoClienteClick
        end
        object gaugeClientes: TGauge
          Left = 50
          Top = 144
          Width = 542
          Height = 18
          Progress = 0
          Visible = False
        end
        object edtArquivoCliente: TEdit
          Left = 50
          Top = 16
          Width = 290
          Height = 21
          TabOrder = 0
        end
        object btnVisualizarCliente: TButton
          Left = 3
          Top = 70
          Width = 98
          Height = 25
          Caption = 'Visualizar'
          TabOrder = 1
        end
        object btnGravarCliente: TButton
          Left = 378
          Top = 14
          Width = 98
          Height = 25
          Caption = 'Gravar Cliente'
          TabOrder = 2
          OnClick = btnGravarClienteClick
        end
        object dbGridClientes: TDBGrid
          Left = 0
          Top = 168
          Width = 625
          Height = 288
          Align = alBottom
          DataSource = dsClientes
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
    end
  end
  object dlArquivo: TOpenTextFileDialog
    Left = 576
    Top = 8
  end
  object dsClientes: TDataSource
    DataSet = cdsCliente
    Left = 288
    Top = 264
  end
  object cdsCliente: TClientDataSet
    PersistDataPacket.Data = {
      190100009619E0BD01000000180000000A000000000003000000190103736571
      04000100000000000A63645F636C69656E746504000100000000000A6E6D5F63
      6C69656E746501004900000001000557494454480200020032000974705F7065
      73736F6101004900000001000557494454480200020002000874656C65666F6E
      6501004900000001000557494454480200020014000763656C756C6172010049
      000000010005574944544802000200140005656D61696C010049000000010005
      5749445448020002001400086370665F636E706A010049000000010005574944
      54480200020014000572675F6965010049000000010005574944544802000200
      14001064745F6E6173635F66756E646163616F08000800000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'seq'
        DataType = ftInteger
      end
      item
        Name = 'cd_cliente'
        DataType = ftInteger
      end
      item
        Name = 'nm_cliente'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'tp_pessoa'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'celular'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'email'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cpf_cnpj'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'rg_ie'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'dt_nasc_fundacao'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 360
    Top = 264
    object cdsClienteseq: TIntegerField
      DisplayWidth = 6
      FieldName = 'seq'
    end
    object cdsClientecd_produto: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      DisplayWidth = 10
      FieldName = 'cd_cliente'
    end
    object cdsClientedesc_produto: TStringField
      DisplayLabel = 'Nome Cliente'
      DisplayWidth = 25
      FieldName = 'nm_cliente'
    end
    object cdsClienteun_medida: TStringField
      DisplayLabel = 'Tipo Pessoa'
      DisplayWidth = 20
      FieldName = 'tp_pessoa'
      Size = 2
    end
    object cdsClientecelular: TStringField
      FieldName = 'celular'
    end
    object cdsClienteemail: TStringField
      FieldName = 'email'
    end
    object cdsClientetelefone: TStringField
      FieldName = 'telefone'
    end
    object cdsClientecpf_cnpj: TStringField
      DisplayLabel = 'CPF/CNPJ'
      FieldName = 'cpf_cnpj'
    end
    object cdsClienterg_ie: TStringField
      DisplayLabel = 'RG/IE'
      FieldName = 'rg_ie'
    end
    object cdsClientedt_nasc_fundacao: TDateTimeField
      DisplayLabel = 'Data Nasc/Funda'#231#227'o'
      FieldName = 'dt_nasc_fundacao'
    end
  end
  object dsProdutos: TDataSource
    DataSet = cdsProdutos
    Left = 61
    Top = 225
  end
  object cdsProdutos: TClientDataSet
    PersistDataPacket.Data = {
      B80000009619E0BD010000001800000007000000000003000000B80003736571
      04000100000000000A63645F70726F6475746F04000100000000000C64657363
      5F70726F6475746F010049000000010005574944544802000200140009756E5F
      6D656469646101004900000001000557494454480200020014000F6661746F72
      5F636F6E76657273616F04000100000000000C7065736F5F6C69717569646F08
      000400000000000A7065736F5F627275746F08000400000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'seq'
        DataType = ftInteger
      end
      item
        Name = 'cd_produto'
        DataType = ftInteger
      end
      item
        Name = 'desc_produto'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'un_medida'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'fator_conversao'
        DataType = ftInteger
      end
      item
        Name = 'peso_liquido'
        DataType = ftFloat
      end
      item
        Name = 'peso_bruto'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 133
    Top = 225
    object cdsProdutosseq: TIntegerField
      FieldName = 'seq'
    end
    object cdsProdutoscd_produto: TIntegerField
      DisplayLabel = 'C'#243'd Produto'
      FieldName = 'cd_produto'
    end
    object cdsProdutosdesc_produto: TStringField
      DisplayLabel = 'Nome Produto'
      FieldName = 'desc_produto'
    end
    object cdsProdutosun_medida: TStringField
      DisplayLabel = 'UN Medida'
      FieldName = 'un_medida'
    end
    object cdsProdutosfator_conversao: TIntegerField
      DisplayLabel = 'Fator Convers'#227'o'
      FieldName = 'fator_conversao'
    end
    object cdsProdutospeso_liquido: TFloatField
      DisplayLabel = 'Peso Liquido'
      FieldName = 'peso_liquido'
    end
    object cdsProdutospeso_bruto: TFloatField
      DisplayLabel = 'Peso Bruto'
      FieldName = 'peso_bruto'
    end
  end
end
