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
  uConsultaProduto in 'Consulta\uConsultaProduto.pas' {frmConsultaProdutos},
  uUsuario in 'Usuario\uUsuario.pas' {frmUsuario},
  UfrmRelVendaDiaria in 'Arquivos\UfrmRelVendaDiaria.pas' {frmRelVendaDiaria},
  uControleAcesso in 'Acesso\uControleAcesso.pas' {frmControleAcesso},
  uUtil in 'Validacao\uUtil.pas',
  dtmConsultaProduto in 'Consulta\dtmConsultaProduto.pas' {dmConsultaProduto: TDataModule},
  uclPedidoVenda in 'Pedido Venda\uclPedidoVenda.pas',
  uGravaArquivo in 'Arquivos\uGravaArquivo.pas' {frmGravaArquivo},
  uVersao in 'Validacao\uVersao.pas',
  uConsulta in 'Consulta\uConsulta.pas' {frmConsulta},
  uclValidacoesEntrada in 'Entrada\uclValidacoesEntrada.pas',
  uGerador in 'uGerador.pas' {$R *.res},
  fCadastroEnderecos in 'WMS\fCadastroEnderecos.pas' {frmCadastroEnderecos},
  uCadastrarSenha in 'Cadastros\uCadastrarSenha.pas' {frmCadastraSenha},
  uImportaDados in 'Arquivos\uImportaDados.pas' {frmImportaDados},
  uSplash in 'Inicio\uSplash.pas' {frmSplash},
  uLista in 'Outros\uLista.pas' {frmLista},
  uclCliente in 'Cadastros\Persistencia\uclCliente.pas',
  uclCta_Cond_Pgto in 'Cadastros\Persistencia\uclCta_Cond_Pgto.pas',
  uclCtaFormaPagamento in 'Cadastros\Persistencia\uclCtaFormaPagamento.pas';

{$R *.res}

begin
  Application.CreateForm(Tdm, dm);
  frmLogin := TfrmLogin.Create(nil);
  if frmLogin.ShowModal = mrOK then
  begin
    FreeAndNil(frmLogin);
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TdmConsultaProduto, dmConsultaProduto);
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.Run;
  end;
end.
