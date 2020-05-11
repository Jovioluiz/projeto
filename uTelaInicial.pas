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
  uLancamentoNotaEntrada, uCadastroTributacaoItem, Vcl.ComCtrls, uLogin, uConsultaProduto;

type
  Tfrm_Principal = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

{$R *.dfm}


procedure Tfrm_Principal.Cadastro2Click(Sender: TObject);
begin
  frmCadastraTributacaoItem := TfrmCadastraTributacaoItem.Create(Self);
  frmCadastraTributacaoItem.Show;
end;

procedure Tfrm_Principal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(Self);
  frmCadCliente.Show;

end;

procedure Tfrm_Principal.Cliente2Click(Sender: TObject);
begin
  frmConsultaCliente := TfrmConsultaCliente.Create(Self);
  frmConsultaCliente.Show;
end;

procedure Tfrm_Principal.CondicaoPagamento1Click(Sender: TObject);
begin
  frmCadCondPgto := TfrmCadCondPgto.Create(Self);
  frmCadCondPgto.Show;
end;

procedure Tfrm_Principal.FormaPagamento1Click(Sender: TObject);
begin
  frmCadFormaPagamento := TfrmCadFormaPagamento.Create(Self);
  frmCadFormaPagamento.Show;
end;


procedure Tfrm_Principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frm_Principal := nil;
end;

//mostra o usuário logado
procedure Tfrm_Principal.FormCreate(Sender: TObject);
begin
  StatusBar1.Panels.Items[0].Text := Concat('Usuário Logado: ', frm_Login.edtUsuario.Text);
end;

procedure Tfrm_Principal.NotaEntrada1Click(Sender: TObject);
begin
  frmLancamentoNotaEntrada := TfrmLancamentoNotaEntrada.Create(Self);
  frmLancamentoNotaEntrada.Show;
end;

procedure Tfrm_Principal.PedidodeVenda1Click(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Self);
  frmPedidoVenda.Show;
end;

procedure Tfrm_Principal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(Self);
  frmCadProduto.Show;
end;

procedure Tfrm_Principal.Produtos1Click(Sender: TObject);
begin
  frmConsultaProdutos := TfrmConsultaProdutos.Create(Self);
  frmConsultaProdutos.Show;
end;

procedure Tfrm_Principal.Sair1Click(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente sair do Sistema?','Atenção', MB_YESNO) = IDYES) then
  begin
    Close;
  end;
end;

procedure Tfrm_Principal.TabeladePreo1Click(Sender: TObject);
begin
  frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
  frmcadTabelaPreco.ShowModal;
end;

procedure Tfrm_Principal.Timer1Timer(Sender: TObject);
begin
  StatusBar1.Panels.Items[1].Text := DateTimeToStr(Now);
end;

procedure Tfrm_Principal.VendaDiria1Click(Sender: TObject);
begin
  frmRelVendaDiaria := TfrmRelVendaDiaria.Create(Self);
  frmRelVendaDiaria.Show;
end;

procedure Tfrm_Principal.VisualizarPedidoVenda1Click(Sender: TObject);
begin
  frmVisualizaPedidoVenda := TfrmVisualizaPedidoVenda.Create(Self);
  frmVisualizaPedidoVenda.Show;
end;

end.
