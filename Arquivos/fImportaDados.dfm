object frmImportaDados: TfrmImportaDados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Importar Dados'
  ClientHeight = 504
  ClientWidth = 635
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 504
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 633
      Height = 502
      ActivePage = tbClientes
      Align = alClient
      TabOrder = 0
      object tbProdutos: TTabSheet
        Caption = 'Produtos'
        OnHide = tbProdutosHide
        object Label1: TLabel
          Left = 3
          Top = 19
          Width = 41
          Height = 13
          Caption = 'Arquivo:'
        end
        object btnBuscarArquivoProduto: TSpeedButton
          Left = 346
          Top = 15
          Width = 26
          Height = 22
          Caption = '...'
          OnClick = btnBuscarArquivoProdutoClick
        end
        object edtArquivo: TEdit
          Left = 50
          Top = 16
          Width = 290
          Height = 21
          Enabled = False
          TabOrder = 0
        end
        object btnVisualizarProdutos: TButton
          Left = 378
          Top = 14
          Width = 98
          Height = 25
          Caption = 'Visualizar'
          TabOrder = 1
          OnClick = btnVisualizarProdutosClick
        end
        object btnGravar: TButton
          Left = 513
          Top = 96
          Width = 98
          Height = 25
          Caption = 'Gravar Produto'
          TabOrder = 2
          OnClick = btnGravarClick
        end
        object Panel1: TPanel
          Left = 0
          Top = 127
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
            DataSource = dmImportaDados.dsProdutos
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        OnHide = tbClientesHide
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
          Enabled = False
          TabOrder = 0
        end
        object btnVisualizarCliente: TButton
          Left = 378
          Top = 14
          Width = 98
          Height = 25
          Caption = 'Visualizar'
          TabOrder = 1
          OnClick = btnVisualizarClienteClick
        end
        object btnGravarCliente: TButton
          Left = 516
          Top = 96
          Width = 98
          Height = 25
          Caption = 'Gravar Cliente'
          TabOrder = 2
          OnClick = btnGravarClienteClick
        end
        object dbGridClientes: TDBGrid
          Left = 0
          Top = 186
          Width = 625
          Height = 288
          Align = alBottom
          DataSource = dmImportaDados.dsClientes
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
end
