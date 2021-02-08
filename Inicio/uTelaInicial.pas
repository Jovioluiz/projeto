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
  uConfiguracoes, uUtil, uLista, Vcl.AppEvnts;

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
    GravarVendas1: TMenuItem;
    Estoque1: TMenuItem;
    CadastroEndereo1: TMenuItem;
    Importao1: TMenuItem;
    ImportarProdutos1: TMenuItem;
    este1: TMenuItem;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
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
    procedure Produtos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Configuraes1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Usurios1Click(Sender: TObject);
    procedure ControleAcesso1Click(Sender: TObject);
    procedure GravarVendas1Click(Sender: TObject);
    procedure CadastroEndereo1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ImportarProdutos1Click(Sender: TObject);
    procedure este1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  temPermissao : Boolean;
  acesso : TValidaDados;

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
    cdAcaoCadastroEndereco = 17;

implementation

{$R *.dfm}

uses uUsuario, uControleAcesso, uDataModule, uGravaArquivo, fCadastroEnderecos,
  uSplash, fImportaDados;


procedure TfrmPrincipal.ApplicationEvents1Minimize(Sender: TObject);
begin
  Self.Hide;
  Self.WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TfrmPrincipal.Cadastro2Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadastraTributacaoItem);

  try
    if temPermissao then
    begin
      frmCadastraTributacaoItem := TfrmCadastraTributacaoItem.Create(Self);
      frmCadastraTributacaoItem.ShowModal;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.CadastroEndereo1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadastroEndereco);

  try
    if temPermissao then
    begin
      frmCadastroEnderecos := TfrmCadastroEnderecos.Create(Self);
      frmCadastroEnderecos.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadCliente);

  try
    if temPermissao then
    begin
      frmCadCliente := TfrmCadCliente.Create(Self);
      frmCadCliente.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.CondicaoPagamento1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadCondPgto);

  try
    if temPermissao then
    begin
      frmCadCondPgto := TfrmCadCondPgto.Create(Self);
      frmCadCondPgto.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.Configuraes1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoConfiguracoes);

  try
    if temPermissao then
    begin
      frmConfiguracoes := TfrmConfiguracoes.Create(Self);
      frmConfiguracoes.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.ControleAcesso1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoControleAcesso);

  try
    if temPermissao then
    begin
      frmControleAcesso := TfrmControleAcesso.Create(Self);
      frmControleAcesso.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.este1Click(Sender: TObject);
begin
  frmlista := Tfrmlista.Create(Self);
  frmlista.Show;
end;

procedure TfrmPrincipal.FormaPagamento1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadFormaPagamento);

  try
    if temPermissao then
    begin
      frmCadFormaPagamento := TfrmCadFormaPagamento.Create(Self);
      frmCadFormaPagamento.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal := nil;
  TrayIcon1.Visible := False;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
  if (Application.MessageBox('Deseja Sair do Sistema?','Atenção', MB_YESNO) = IDYES) then
    CanClose := True;
end;

//mostra o usuário logado
procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    //StatusBar1.Panels.Items[0].Text := Concat('Usuário Logado: ', frmLogin.edtUsuario.Text);
    frmsplash := TfrmSplash.Create(Self);
    frmSplash.ShowModal;
  finally
    frmSplash.Free;
  end;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Sair do Sistema?','Atenção', MB_YESNO) = IDYES) then
      Close;
  end;
end;

procedure TfrmPrincipal.GravarVendas1Click(Sender: TObject);
begin
  frmGravaArquivo := TfrmGravaArquivo.Create(Self);
  frmGravaArquivo.ShowModal
end;


procedure TfrmPrincipal.ImportarProdutos1Click(Sender: TObject);
begin
  frmImportaDados := TfrmImportaDados.Create(Self);
  frmImportaDados.Show;
end;

procedure TfrmPrincipal.NotaEntrada1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoLancamentoNotaEntrada);

  try
    if temPermissao then
    begin
      frmLancamentoNotaEntrada := TfrmLancamentoNotaEntrada.Create(Self);
      frmLancamentoNotaEntrada.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.PedidodeVenda1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoPedidoVenda);

  try
    if temPermissao then
    begin
      frmPedidoVenda := TfrmPedidoVenda.Create(Self);
      frmPedidoVenda.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoCadProduto);

  try
    if temPermissao then
    begin
      frmCadProduto := TfrmCadProduto.Create(Self);
      frmCadProduto.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoConsultaProdutos);

  try
    if temPermissao then
    begin
      frmConsultaProdutos := TfrmConsultaProdutos.Create(Self);
      frmConsultaProdutos.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente sair do Sistema?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmPrincipal.TabeladePreo1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaocadTabelaPreco);

  try
    if temPermissao then
    begin
      frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
      frmcadTabelaPreco.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show;
  WindowState := wsMaximized;
  Application.BringToFront;
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoUsuario);

  try
    if temPermissao then
    begin
      frmUsuario := TfrmUsuario.Create(Self);
      frmUsuario.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.VendaDiria1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoRelVendaDiaria);

  try
    if temPermissao then
    begin
      frmRelVendaDiaria := TfrmRelVendaDiaria.Create(Self);
      frmRelVendaDiaria.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

procedure TfrmPrincipal.VisualizarPedidoVenda1Click(Sender: TObject);
begin
  temPermissao := False;
  acesso := TValidaDados.Create;
  temPermissao := acesso.validaAcessoAcao(idUsuario, cdAcaoVisualizaPedidoVenda);

  try
    if temPermissao then
    begin
      frmVisualizaPedidoVenda := TfrmVisualizaPedidoVenda.Create(Self);
      frmVisualizaPedidoVenda.Show;
    end;
  finally
    FreeAndNil(acesso);
  end;
end;

end.
