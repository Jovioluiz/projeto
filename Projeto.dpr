{$REGION
  Autor: 'Jóvio Luiz Giacomolli'}
{$ENDREGION}
program Projeto;

uses
  Vcl.Forms,
  SysUtils,
  Controls,
  uValidaDcto in 'Validacao\uValidaDcto.pas',
  uTelaInicial in 'Inicio\uTelaInicial.pas' {frmPrincipal},
  cCTA_FORMA_PAGAMENTO in 'Cadastros\cCTA_FORMA_PAGAMENTO.pas' {frmCadFormaPagamento},
  uCadTABELAPRECO in 'Cadastros\uCadTABELAPRECO.pas' {frmcadTabelaPreco},
  uCadTabelaPrecoProduto in 'Cadastros\uCadTabelaPrecoProduto.pas' {frmCadTabelaPrecoProduto},
  cPRODUTO in 'Cadastros\cPRODUTO.pas' {frmCadProduto},
  cCTA_COND_PGTO in 'Cadastros\cCTA_COND_PGTO.pas' {frmCadCondPgto},
  cCLIENTE in 'Cadastros\cCLIENTE.pas' {frmCadCliente},
  uVisualizaPedidoVenda in 'Pedido Venda\uVisualizaPedidoVenda.pas' {frmVisualizaPedidoVenda},
  uPedidoVenda in 'Pedido Venda\uPedidoVenda.pas' {frmPedidoVenda},
  uLogin in 'Login\uLogin.pas' {frmLogin},
  uCadastroTributacaoItem in 'Cadastros\uCadastroTributacaoItem.pas' {frmCadastraTributacaoItem},
  uLancamentoNotaEntrada in 'Entrada\uLancamentoNotaEntrada.pas' {frmLancamentoNotaEntrada},
  Vcl.Themes,
  Vcl.Styles,
  uDataModule in 'Conexao\uDataModule.pas' {dm: TDataModule},
  uEdicaoPedidoVenda in 'Pedido Venda\uEdicaoPedidoVenda.pas' {frmEdicaoPedidoVenda},
  uConfiguracoes in 'Configuracoes\uConfiguracoes.pas' {frmConfiguracoes},
  FConsultaProduto in 'Consulta\FConsultaProduto.pas' {frmConsultaProdutos},
  uUsuario in 'Usuario\uUsuario.pas' {frmUsuario},
  UfrmRelVendaDiaria in 'Arquivos\UfrmRelVendaDiaria.pas' {frmRelVendaDiaria},
  fControleAcesso in 'Acesso\fControleAcesso.pas' {frmControleAcesso},
  uUtil in 'Validacao\uUtil.pas',
  dtmConsultaProduto in 'Consulta\dtmConsultaProduto.pas' {dmConsultaProduto: TDataModule},
  uclPedidoVenda in 'Pedido Venda\uclPedidoVenda.pas',
  uGravaArquivo in 'Arquivos\uGravaArquivo.pas' {frmGravaArquivo},
  uVersao in 'Validacao\uVersao.pas',
  uConsulta in 'Consulta\uConsulta.pas' {frmConsulta},
  uclNotaEntrada in 'Entrada\uclNotaEntrada.pas',
  uGerador in 'Outros\uGerador.pas' {$R *.res},
  fCadastroEnderecos in 'WMS\fCadastroEnderecos.pas' {frmCadastroEnderecos},
  uCadastrarSenha in 'Cadastros\uCadastrarSenha.pas' {frmCadastraSenha},
  uSplash in 'Inicio\uSplash.pas' {frmSplash},
  uLista in 'Outros\uLista.pas' {frmLista},
  uclCliente in 'Cadastros\Persistencia\uclCliente.pas',
  uclCta_Cond_Pgto in 'Cadastros\Persistencia\uclCta_Cond_Pgto.pas',
  uInterface in 'Outros\uInterface.pas',
  uclCtaFormaPagamento in 'Cadastros\Persistencia\uclCtaFormaPagamento.pas',
  fConexao in 'Conexao\fConexao.pas' {frmConexao},
  uclPadrao in 'Outros\uclPadrao.pas',
  uclProduto in 'Cadastros\Persistencia\uclProduto.pas',
  uclProdutoTributacao in 'Cadastros\Persistencia\uclProdutoTributacao.pas',
  dProdutoCodBarras in 'Cadastros\dProdutoCodBarras.pas' {dmProdutoCodBarras: TDataModule},
  uclTabelaPreco in 'Cadastros\Persistencia\uclTabelaPreco.pas',
  uclTabelaPrecoProduto in 'Cadastros\Persistencia\uclTabelaPrecoProduto.pas',
  uConexao in 'Conexao\uConexao.pas',
  uEnderecoWMS in 'WMS\uEnderecoWMS.pas',
  uValidacoesLogin in 'Login\uValidacoesLogin.pas',
  dImportaDados in 'Arquivos\dImportaDados.pas' {dmImportaDados: TDataModule},
  fImportaDados in 'Arquivos\fImportaDados.pas' {frmImportaDados},
  uImportacaoDados in 'Arquivos\uImportacaoDados.pas',
  uControleAcessoSistema in 'Acesso\uControleAcessoSistema.pas',
  dControleAcesso in 'Acesso\dControleAcesso.pas' {dmControleAcesso: TDataModule},
  uConsultaProdutos in 'Consulta\uConsultaProdutos.pas',
  uThread in 'Outros\uThread.pas',
  dTabelaPreco in 'Cadastros\dTabelaPreco.pas' {dmProdutosTabelaPreco: TDataModule},
  fGridsThread in 'Outros\fGridsThread.pas' {fThreads},
  fVisualizaCodigoBarras in 'Outros\fVisualizaCodigoBarras.pas' {fVisualizaCodBarras},
  transferenciaTabelas in 'Outros\transferenciaTabelas.pas',
  dWMS in 'WMS\dWMS.pas' {dmWMS: TDataModule},
  dPedidoVenda in 'Pedido Venda\dPedidoVenda.pas' {dmPedidoVenda: TDataModule},
  dNotaEntrada in 'Entrada\dNotaEntrada.pas' {dmNotaEntrada: TDataModule},
  uMovimentacaoEstoque in 'Estoque\uMovimentacaoEstoque.pas';

{$R *.res}

begin
  Application.CreateForm(Tdm, dm);
  frmLogin := TfrmLogin.Create(nil);

  if frmLogin.ShowModal = mrOK then
  begin
    FreeAndNil(frmLogin);
    Application.Initialize;
    ReportMemoryLeaksOnShutdown := True;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.Run;
  end;
end.
