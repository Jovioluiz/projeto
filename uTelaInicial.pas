unit uTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, cCLIENTE,
  cPRODUTO,
  cCTA_FORMA_PAGAMENTO, Vcl.ExtCtrls, cCTA_COND_PGTO, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, uCadTABELAPRECO, uPedidoVenda, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uVisualizaPedidoVenda, UfrmRelVendaDiaria,
  uLancamentoNotaEntrada, uCadastroTributacaoItem, Vcl.ComCtrls, uLogin, uConsultaProduto,
  uConfiguracoes, uValidaDados;

type
  TfrmPrincipal = class(TForm)
    MenuCadastro: TMainMenu;
    MenuItemCad: TMenuItem;
    Cadastro1: TMenuItem;
    Cliente1: TMenuItem;
    Produto1: TMenuItem;
    FormaPagamento1: TMenuItem;
    CondicaoPagamento1: TMenuItem;
    Sistem1: TMenuItem;
    Sair1: TMenuItem;
    Consulta1: TMenuItem;
    TabeladePreo1: TMenuItem;
    PedidoVenda1: TMenuItem;
    PedidodeVenda1: TMenuItem;
    VisualizarPedidoVenda1: TMenuItem;
    Relatrios1: TMenuItem;
    VendaDiria1: TMenuItem;
    LanamentoNotas1: TMenuItem;
    NotaEntrada1: TMenuItem;
    ipoTributao1: TMenuItem;
    Cadastro2: TMenuItem;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Produtos1: TMenuItem;
    Configuraes1: TMenuItem;
    Usurios1: TMenuItem;
    ControleAcesso1: TMenuItem;
    query: TFDQuery;
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure FormaPagamento1Click(Sender: TObject);
    procedure CondicaoPagamento1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure TabeladePreo1Click(Sender: TObject);
    procedure PedidodeVenda1Click(Sender: TObject);
    procedure VisualizarPedidoVenda1Click(Sender: TObject);
    procedure VendaDiria1Click(Sender: TObject);
    procedure NotaEntrada1Click(Sender: TObject);
    procedure Cadastro2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Configuraes1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Usurios1Click(Sender: TObject);
    procedure ControleAcesso1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  temPermissao : Boolean;
  cliente : TValidaDados;

  //ações
  const
    cdAcaoCadCliente = 1;
    cdAcaoCadProduto = 2;
    cdAcaoCadFormaPagamento = 3;
    cdAcaoCadCondPgto = 4;
    cdAcaocadTabelaPreco = 5;
    cdAcaoCadTabelaPrecoProduto = 6;
    cdAcaoConsultaProdutos = 7;
    cdAcaoPedidoVenda = 8;
    cdAcaoVisualizaPedidoVenda = 9;
    cdAcaoEdicaoPedidoVenda = 10;
    cdAcaoRelVendaDiaria = 11;
    cdAcaoLancamentoNotaEntrada = 12;
    cdAcaoCadastraTributacaoItem = 13;
    cdAcaoConfiguracoes = 14;
    cdAcaoUsuario = 15;
    cdAcaoControleAcesso = 16;

implementation

{$R *.dfm}

uses uUsuario, uControleAcesso, uDataModule;


procedure TfrmPrincipal.Cadastro2Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoCadastraTributacaoItem);

  if temPermissao = True then
  begin
    frmCadastraTributacaoItem := TfrmCadastraTributacaoItem.Create(Self);
    frmCadastraTributacaoItem.ShowModal;
  end;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoCadCliente);

  if temPermissao = True then
  begin
    frmCadCliente := TfrmCadCliente.Create(Self);
    frmCadCliente.ShowModal;
  end;
end;

procedure TfrmPrincipal.CondicaoPagamento1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoCadCondPgto);

  if temPermissao = True then
  begin
    frmCadCondPgto := TfrmCadCondPgto.Create(Self);
    frmCadCondPgto.ShowModal;
  end;
end;

procedure TfrmPrincipal.Configuraes1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoConfiguracoes);

  if temPermissao = True then
  begin
    frmConfiguracoes := TfrmConfiguracoes.Create(Self);
    frmConfiguracoes.ShowModal;
  end;
end;

procedure TfrmPrincipal.ControleAcesso1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoControleAcesso);

  if temPermissao = True then
  begin
    frmControleAcesso := TfrmControleAcesso.Create(Self);
    frmControleAcesso.ShowModal;
  end;
end;

procedure TfrmPrincipal.FormaPagamento1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoCadFormaPagamento);

  if temPermissao = True then
  begin
    frmCadFormaPagamento := TfrmCadFormaPagamento.Create(Self);
    frmCadFormaPagamento.ShowModal;
  end;
end;


procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal := nil;
end;

//mostra o usuário logado
procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := Concat('Usuário Logado: ', frmLogin.edtUsuario.Text);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja realmente sair do sistema?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
end;

procedure TfrmPrincipal.NotaEntrada1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoLancamentoNotaEntrada);

  if temPermissao = True then
  begin
    frmLancamentoNotaEntrada := TfrmLancamentoNotaEntrada.Create(Self);
    frmLancamentoNotaEntrada.Show;
  end;
end;

procedure TfrmPrincipal.PedidodeVenda1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoPedidoVenda);

  if temPermissao = True then
  begin
    frmPedidoVenda := TfrmPedidoVenda.Create(Self);
    frmPedidoVenda.Show;
  end;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoCadProduto);

  if temPermissao = True then
  begin
    frmCadProduto := TfrmCadProduto.Create(Self);
    frmCadProduto.ShowModal;
  end;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoConsultaProdutos);

  if temPermissao = True then
  begin
    frmConsultaProdutos := TfrmConsultaProdutos.Create(Self);
    frmConsultaProdutos.Show;
  end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente sair do Sistema?','Atenção', MB_YESNO) = IDYES) then
  begin
    Close;
  end;
end;

procedure TfrmPrincipal.TabeladePreo1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaocadTabelaPreco);

  if temPermissao = True then
  begin
    frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
    frmcadTabelaPreco.ShowModal;
  end;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text := DateTimeToStr(Now);
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoUsuario);

  if temPermissao = True then
  begin
    frmUsuario := TfrmUsuario.Create(Self);
    frmUsuario.ShowModal;
  end;
end;

procedure TfrmPrincipal.VendaDiria1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoRelVendaDiaria);

  if temPermissao = True then
  begin
    frmRelVendaDiaria := TfrmRelVendaDiaria.Create(Self);
    frmRelVendaDiaria.Show;
  end;
end;

procedure TfrmPrincipal.VisualizarPedidoVenda1Click(Sender: TObject);
begin
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, cdAcaoVisualizaPedidoVenda);

  if temPermissao = True then
  begin
    frmVisualizaPedidoVenda := TfrmVisualizaPedidoVenda.Create(Self);
    frmVisualizaPedidoVenda.Show;
  end;
end;

end.
