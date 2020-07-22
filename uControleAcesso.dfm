object frmControleAcesso: TfrmControleAcesso
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Controle de Acesso'
  ClientHeight = 421
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 9
    Top = 16
    Width = 48
    Height = 18
    Caption = 'Usu'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtUsuario: TEdit
    Left = 80
    Top = 16
    Width = 73
    Height = 21
    TabOrder = 0
    OnExit = edtUsuarioExit
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 484
    Height = 353
    Caption = 'A'#231#245'es'
    TabOrder = 1
    object cbCadCliente: TCheckBox
      Left = 16
      Top = 32
      Width = 113
      Height = 17
      Caption = 'Cadastro Cliente '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object cbCadProduto: TCheckBox
      Left = 16
      Top = 72
      Width = 129
      Height = 17
      Caption = 'Cadastro Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbCadCtaFormaPag: TCheckBox
      Left = 16
      Top = 112
      Width = 185
      Height = 17
      Caption = 'Cadastro Forma Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cbCadCtaCondPag: TCheckBox
      Left = 16
      Top = 152
      Width = 193
      Height = 17
      Caption = 'Cadastro Condi'#231#227'o Pagamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cbCadTributacao: TCheckBox
      Left = 16
      Top = 192
      Width = 193
      Height = 17
      Caption = 'Cadastro Tributa'#231#227'o Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object cbCadTabelaPreco: TCheckBox
      Left = 16
      Top = 232
      Width = 153
      Height = 17
      Caption = 'Cadastro Tabela Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object cbCadTabelaPrecoProduto: TCheckBox
      Left = 16
      Top = 272
      Width = 209
      Height = 17
      Caption = 'Cadastro Produto Tabela Pre'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object cbCadConfig: TCheckBox
      Left = 296
      Top = 32
      Width = 105
      Height = 17
      Caption = 'Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object cbConsultaProduto: TCheckBox
      Left = 296
      Top = 112
      Width = 177
      Height = 17
      Caption = 'Consulta Detalhada Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object cbCadAcesso: TCheckBox
      Left = 296
      Top = 72
      Width = 177
      Height = 17
      Caption = 'Controle de Acesso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
    object cbPedidoVenda: TCheckBox
      Left = 296
      Top = 152
      Width = 177
      Height = 17
      Caption = 'Pedido Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
    end
    object cbEdicaoPedido: TCheckBox
      Left = 296
      Top = 192
      Width = 177
      Height = 17
      Caption = 'Edi'#231#227'o Pedido Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
    end
    object cbRel: TCheckBox
      Left = 296
      Top = 272
      Width = 177
      Height = 17
      Caption = 'Relat'#243'rio Venda Di'#225'ria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
    end
    object cbNotaEntrada: TCheckBox
      Left = 296
      Top = 312
      Width = 177
      Height = 17
      Caption = 'Nota de Entrada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object cbVisualizaPedido: TCheckBox
      Left = 296
      Top = 232
      Width = 177
      Height = 17
      Caption = 'Visualiza Pedido Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
    end
    object cbCadUsuario: TCheckBox
      Left = 16
      Top = 312
      Width = 129
      Height = 17
      Caption = 'Cadastro Usu'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
  end
  object edtNomeUsuario: TEdit
    Left = 160
    Top = 16
    Width = 161
    Height = 21
    Enabled = False
    TabOrder = 2
    OnExit = edtUsuarioExit
  end
  object query: TFDQuery
    Connection = dm.FDConnection1
    Left = 432
    Top = 16
  end
end
