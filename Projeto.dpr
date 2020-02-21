program Projeto;

uses
  Vcl.Forms,
  uValidaDcto in 'uValidaDcto.pas',
  uTelaInicial in 'uTelaInicial.pas' {frm_Principal},
  uConexao in 'uConexao.pas' {fConexao},
  cCTA_FORMA_PAGAMENTO in 'cCTA_FORMA_PAGAMENTO.pas' {cadFormaPagamento},
  uCadTABELAPRECO in 'uCadTABELAPRECO.pas' {frmcadTabelaPreco},
  uCadTabelaPrecoProduto in 'uCadTabelaPrecoProduto.pas' {frmCadTabelaPrecoProduto},
  cPRODUTO in 'cPRODUTO.pas' {fCadProduto},
  cCTA_COND_PGTO in 'cCTA_COND_PGTO.pas' {cadCondPgto},
  cConsultaPRODUTO in 'cConsultaPRODUTO.pas' {fConsultaProduto},
  cCLIENTE in 'cCLIENTE.pas' {cadCliente},
  cConsultaCLIENTE in 'cConsultaCLIENTE.pas' {consultaCliente},
  uPedidoVenda in 'uPedidoVenda.pas' {frmPedidoVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_Principal, frm_Principal);
  Application.CreateForm(TfConexao, fConexao);
  Application.CreateForm(TfConsultaProduto, fConsultaProduto);
  Application.CreateForm(TcadFormaPagamento, cadFormaPagamento);
  Application.CreateForm(TcadCondPgto, cadCondPgto);
  Application.CreateForm(TfrmcadTabelaPreco, frmcadTabelaPreco);
  Application.CreateForm(TfrmCadTabelaPrecoProduto, frmCadTabelaPrecoProduto);
  Application.CreateForm(TfCadProduto, fCadProduto);
  Application.CreateForm(TcadCondPgto, cadCondPgto);
  Application.CreateForm(TfConsultaProduto, fConsultaProduto);
  Application.CreateForm(TcadCliente, cadCliente);
  Application.CreateForm(TconsultaCliente, consultaCliente);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.CreateForm(TfrmPedidoVenda, frmPedidoVenda);
  Application.Run;

end.
