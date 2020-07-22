unit uTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, cCLIENTE,
  cPRODUTO,
  cCTA_FORMA_PAGAMENTO, Vcl.ExtCtrls, cCTA_COND_PGTO, Vcl.Imaging.jpeg,
  cConsultaCLIENTE,
  Vcl.Imaging.pngimage, uCadTABELAPRECO, uPedidoVenda, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uVisualizaPedidoVenda, UfrmRelVendaDiaria,
  uLancamentoNotaEntrada, uCadastroTributacaoItem, Vcl.ComCtrls, uLogin, uConsultaProduto,
  uConfiguracoes;

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
    procedure Cliente2Click(Sender: TObject);
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

implementation

{$R *.dfm}

uses uUsuario, uControleAcesso, uDataModule;


procedure TfrmPrincipal.Cadastro2Click(Sender: TObject);
begin
  frmCadastraTributacaoItem := TfrmCadastraTributacaoItem.Create(Self);
  frmCadastraTributacaoItem.ShowModal;
end;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
var
  temPermissao : Boolean;
begin
  query.Close;
  query.SQL.Clear;
  query.SQL.Text := 'select '+
                       '  fl_permite_acesso '+
                       'from '+
                       '  usuario_acao '+
                       'where '+
                       '  cd_acao = 4 and '+
                       '  cd_usuario = :cd_usuario';
  query.ParamByName('cd_usuario').AsInteger := idUsuario;
  query.Open();

  temPermissao := query.FieldByName('fl_permite_acesso').AsBoolean;

  if temPermissao = False then
  begin
    ShowMessage('usu�rio n�o possui permiss�o de acesso!');
    Exit;
  end
  else
  begin
    frmCadCliente := TfrmCadCliente.Create(Self);
    frmCadCliente.ShowModal;
  end;
end;

procedure TfrmPrincipal.Cliente2Click(Sender: TObject);
begin
  frmConsultaCliente := TfrmConsultaCliente.Create(Self);
  frmConsultaCliente.Show;
end;

procedure TfrmPrincipal.CondicaoPagamento1Click(Sender: TObject);
begin
  frmCadCondPgto := TfrmCadCondPgto.Create(Self);
  frmCadCondPgto.ShowModal;
end;

procedure TfrmPrincipal.Configuraes1Click(Sender: TObject);
begin
  frmConfiguracoes := TfrmConfiguracoes.Create(Self);
  frmConfiguracoes.ShowModal;
end;

procedure TfrmPrincipal.ControleAcesso1Click(Sender: TObject);
begin
  frmControleAcesso := TfrmControleAcesso.Create(Self);
  frmControleAcesso.ShowModal;
end;

procedure TfrmPrincipal.FormaPagamento1Click(Sender: TObject);
begin
  frmCadFormaPagamento := TfrmCadFormaPagamento.Create(Self);
  frmCadFormaPagamento.ShowModal;
end;


procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal := nil;
end;

//mostra o usu�rio logado
procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := Concat('Usu�rio Logado: ', frmLogin.edtUsuario.Text);
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_ESCAPE then //ESC
  begin
  if (Application.MessageBox('Deseja realmente sair do sistema?','Aten��o', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
end;

procedure TfrmPrincipal.NotaEntrada1Click(Sender: TObject);
begin
  frmLancamentoNotaEntrada := TfrmLancamentoNotaEntrada.Create(Self);
  frmLancamentoNotaEntrada.Show;
end;

procedure TfrmPrincipal.PedidodeVenda1Click(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Self);
  frmPedidoVenda.Show;
end;

procedure TfrmPrincipal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(Self);
  frmCadProduto.ShowModal;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  frmConsultaProdutos := TfrmConsultaProdutos.Create(Self);
  frmConsultaProdutos.Show;
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente sair do Sistema?','Aten��o', MB_YESNO) = IDYES) then
  begin
    Close;
  end;
end;

procedure TfrmPrincipal.TabeladePreo1Click(Sender: TObject);
begin
  frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
  frmcadTabelaPreco.ShowModal;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text := DateTimeToStr(Now);
end;

procedure TfrmPrincipal.Usurios1Click(Sender: TObject);
begin
  frmUsuario := TfrmUsuario.Create(Self);
  frmUsuario.ShowModal;
end;

procedure TfrmPrincipal.VendaDiria1Click(Sender: TObject);
begin
  frmRelVendaDiaria := TfrmRelVendaDiaria.Create(Self);
  frmRelVendaDiaria.Show;
end;

procedure TfrmPrincipal.VisualizarPedidoVenda1Click(Sender: TObject);
begin
  frmVisualizaPedidoVenda := TfrmVisualizaPedidoVenda.Create(Self);
  frmVisualizaPedidoVenda.Show;
end;

end.
