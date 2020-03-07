program Projeto;

uses
  Vcl.Forms,
  uValidaDcto in 'uValidaDcto.pas',
  uTelaInicial in 'uTelaInicial.pas' {frm_Principal},
  uConexao in 'uConexao.pas' {fConexao},
  cCTA_FORMA_PAGAMENTO in 'cCTA_FORMA_PAGAMENTO.pas' {frmCadFormaPagamento},
  uCadTABELAPRECO in 'uCadTABELAPRECO.pas' {frmcadTabelaPreco},
  uCadTabelaPrecoProduto in 'uCadTabelaPrecoProduto.pas' {frmCadTabelaPrecoProduto},
  cPRODUTO in 'cPRODUTO.pas' {frmCadProduto},
  cCTA_COND_PGTO in 'cCTA_COND_PGTO.pas' {frmCadCondPgto},
  cConsultaPRODUTO in 'cConsultaPRODUTO.pas' {frmConsultaProduto},
  cCLIENTE in 'cCLIENTE.pas' {frmCadCliente},
  cConsultaCLIENTE in 'cConsultaCLIENTE.pas' {frmConsultaCliente},
  uVisualizaPedidoVenda in 'uVisualizaPedidoVenda.pas' {frmVisualizaPedidoVenda},
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedidoVenda},
  uLogin in 'uLogin.pas' {frm_Login};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Login, frm_Login);
  Application.CreateForm(Tfrm_Principal, frm_Principal);
  Application.CreateForm(TfConexao, fConexao);
  Application.CreateForm(TfrmConsultaProduto, frmConsultaProduto);
  Application.CreateForm(TfrmCadFormaPagamento, frmCadFormaPagamento);
  Application.CreateForm(TfrmCadCondPgto, frmCadCondPgto);
  Application.CreateForm(TfrmcadTabelaPreco, frmcadTabelaPreco);
  Application.CreateForm(TfrmCadTabelaPrecoProduto, frmCadTabelaPrecoProduto);
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  Application.CreateForm(TfrmCadCondPgto, frmCadCondPgto);
  Application.CreateForm(TfrmConsultaProduto, frmConsultaProduto);
  Application.CreateForm(TfrmCadCliente, frmCadCliente);
  Application.CreateForm(TfrmConsultaCliente, frmConsultaCliente);
  Application.CreateForm(TfrmVisualizaPedidoVenda, frmVisualizaPedidoVenda);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;

end.
