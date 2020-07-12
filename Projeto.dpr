program Projeto;

uses
  Vcl.Forms,
  uValidaDcto in 'uValidaDcto.pas',
  uTelaInicial in 'uTelaInicial.pas' {frmPrincipal},
  uConexao in 'uConexao.pas' {frmConexao},
  cCTA_FORMA_PAGAMENTO in 'cCTA_FORMA_PAGAMENTO.pas' {frmCadFormaPagamento},
  uCadTABELAPRECO in 'uCadTABELAPRECO.pas' {frmcadTabelaPreco},
  uCadTabelaPrecoProduto in 'uCadTabelaPrecoProduto.pas' {frmCadTabelaPrecoProduto},
  cPRODUTO in 'cPRODUTO.pas' {frmCadProduto},
  cCTA_COND_PGTO in 'cCTA_COND_PGTO.pas' {frmCadCondPgto},
  cCLIENTE in 'cCLIENTE.pas' {frmCadCliente},
  uVisualizaPedidoVenda in 'uVisualizaPedidoVenda.pas' {frmVisualizaPedidoVenda},
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedidoVenda},
  uLogin in 'uLogin.pas' {frmLogin},
  uCadastroTributacaoItem in 'uCadastroTributacaoItem.pas' {frmCadastraTributacaoItem},
  uLancamentoNotaEntrada in 'uLancamentoNotaEntrada.pas' {frmLancamentoNotaEntrada},
  Vcl.Themes,
  Vcl.Styles,
  uDataModule in 'uDataModule.pas' {dm: TDataModule},
  uEdicaoPedidoVenda in 'uEdicaoPedidoVenda.pas' {frmEdicaoPedidoVenda},
  uConfiguracoes in 'uConfiguracoes.pas' {frmConfiguracoes},
  uConsultaProduto in 'uConsultaProduto.pas' {frmConsultaProdutos},
  uUsuario in 'uUsuario.pas' {frmUsuario},
  UfrmRelVendaDiaria in 'UfrmRelVendaDiaria.pas' {frmRelVendaDiaria};

//uConsulta in 'uConsulta.pas' {frmConsulta};

//TestuLogin in 'Teste\TestuLogin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmConexao, frmConexao);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmUsuario, frmUsuario);
  Application.CreateForm(TfrmRelVendaDiaria, frmRelVendaDiaria);
  Application.Run;

end.
