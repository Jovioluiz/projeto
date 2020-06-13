object frm_Principal: Tfrm_Principal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Tela Inicial'
  ClientHeight = 665
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuCadastro
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 646
    Width = 1000
    Height = 19
    Panels = <
      item
        Text = 'Usuario'
        Width = 200
      end
      item
        Text = 'Hora'
        Width = 50
      end>
  end
  object MenuCadastro: TMainMenu
    Left = 24
    Top = 16
    object MenuItemCad: TMenuItem
      Caption = 'Cadastro'
      object Cadastro1: TMenuItem
        Caption = 'Cadastro'
        object Cliente1: TMenuItem
          Caption = 'Cliente'
          OnClick = Cliente1Click
        end
        object Produto1: TMenuItem
          Caption = 'Produto'
          OnClick = Produto1Click
        end
        object FormaPagamento1: TMenuItem
          Caption = 'Forma Pagamento'
          OnClick = FormaPagamento1Click
        end
        object CondicaoPagamento1: TMenuItem
          Caption = 'Condi'#231#227'o Pagamento'
          OnClick = CondicaoPagamento1Click
        end
        object TabeladePreo1: TMenuItem
          Caption = 'Tabela de Pre'#231'o'
          OnClick = TabeladePreo1Click
        end
      end
    end
    object Consulta1: TMenuItem
      Caption = 'Consulta'
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
    object PedidoVenda1: TMenuItem
      Caption = 'Pedido Venda'
      object PedidodeVenda1: TMenuItem
        Caption = 'Pedido de Venda'
        OnClick = PedidodeVenda1Click
      end
      object VisualizarPedidoVenda1: TMenuItem
        Caption = 'Visualizar Pedido Venda'
        OnClick = VisualizarPedidoVenda1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object VendaDiria1: TMenuItem
        Caption = 'Venda Di'#225'ria'
        OnClick = VendaDiria1Click
      end
    end
    object LanamentoNotas1: TMenuItem
      Caption = 'Lan'#231'amento Notas'
      object NotaEntrada1: TMenuItem
        Caption = 'Nota Entrada'
        OnClick = NotaEntrada1Click
      end
    end
    object ipoTributao1: TMenuItem
      Caption = 'Tributa'#231#227'o'
      object Cadastro2: TMenuItem
        Caption = 'Cadastro'
        OnClick = Cadastro2Click
      end
    end
    object Sistem1: TMenuItem
      Caption = 'Sistema'
      object Configuraes1: TMenuItem
        Caption = 'Configura'#231#245'es'
        OnClick = Configuraes1Click
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 312
    Top = 600
  end
end
