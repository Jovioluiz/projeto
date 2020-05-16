program Projeto;

uses
  Vcl.Forms,
  uValidaDcto in 'uValidaDcto.pas',
  uTelaInicial in 'uTelaInicial.pas' {frm_Principal},
  uConexao in 'uConexao.pas' {frmConexao},
  cCTA_FORMA_PAGAMENTO in 'cCTA_FORMA_PAGAMENTO.pas' {frmCadFormaPagamento},
  uCadTABELAPRECO in 'uCadTABELAPRECO.pas' {frmcadTabelaPreco},
  uCadTabelaPrecoProduto in 'uCadTabelaPrecoProduto.pas' {frmCadTabelaPrecoProduto},
  cPRODUTO in 'cPRODUTO.pas' {frmCadProduto},
  cCTA_COND_PGTO in 'cCTA_COND_PGTO.pas' {frmCadCondPgto},
  cCLIENTE in 'cCLIENTE.pas' {frmCadCliente},
  uVisualizaPedidoVenda in 'uVisualizaPedidoVenda.pas' {frmVisualizaPedidoVenda},
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedidoVenda},
  uLogin in 'uLogin.pas' {frm_Login},
  uCadastroTributacaoItem in 'uCadastroTributacaoItem.pas' {frmCadastraTributacaoItem},
  uLancamentoNotaEntrada in 'uLancamentoNotaEntrada.pas' {frmLancamentoNotaEntrada},
  UfrmRelVendaDiaria in 'UfrmRelVendaDiaria.pas' {frmRelVendaDiaria},
  Vcl.Themes,
  Vcl.Styles,
  uDataModule in 'uDataModule.pas' {dm: TDataModule},
  uEdicaoPedidoVenda in 'uEdicaoPedidoVenda.pas' {frm_Edicao_Pedido_Venda},
  uConfiguracoes in 'uConfiguracoes.pas' {frmConfiguracoes};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Login, frm_Login);
  Application.CreateForm(TfrmConexao, frmConexao);
  Application.CreateForm(Tdm, dm);
  Application.Run;

end.
