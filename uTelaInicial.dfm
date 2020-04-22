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
  Icon.Data = {
    0000010001001010100001000400280100001600000028000000100000002000
    000001000400000000008000000000000000000000001000000000000000B1B1
    B100FFFFFF003434340044444400F5F5F500B0B0B000FEFEFE002F2F2F003131
    310033333300EBEBEB0000000000000000000000000000000000000000001111
    1111111111111111111111111111111111119111111111111111991111111111
    1111991111111111111191111111119996119991111119999999999111117991
    9999999411111111118999991111111115912999991111119999113999991111
    A111111109991111111111111111111111111111111111111111111111110000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  Menu = MenuCadastro
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
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
        Text = 'tempo logado'
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
      object Cliente2: TMenuItem
        Caption = 'Cliente'
        OnClick = Cliente2Click
      end
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
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 304
    Top = 616
  end
end
