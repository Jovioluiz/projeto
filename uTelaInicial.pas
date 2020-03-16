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
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uVisualizaPedidoVenda, cConsultaPRODUTO, UfrmRelVendaDiaria,
  uLancamentoNotaEntrada;

type
  Tfrm_Principal = class(TForm)
    tpTelaInicial: TPanel;
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
    Cliente2: TMenuItem;
    consultaProduto: TMenuItem;
    TabeladePreo1: TMenuItem;
    PedidoVenda1: TMenuItem;
    PedidodeVenda1: TMenuItem;
    VisualizarPedidoVenda1: TMenuItem;
    Relatrios1: TMenuItem;
    VendaDiria1: TMenuItem;
    LanamentoNotas1: TMenuItem;
    NotaEntrada1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure FormaPagamento1Click(Sender: TObject);
    procedure CondicaoPagamento1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure consultaProdutoClick(Sender: TObject);
    procedure TabeladePreo1Click(Sender: TObject);
    procedure PedidodeVenda1Click(Sender: TObject);
    procedure VisualizarPedidoVenda1Click(Sender: TObject);
    procedure VendaDiria1Click(Sender: TObject);
    procedure NotaEntrada1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

{$R *.dfm}


procedure Tfrm_Principal.Cliente1Click(Sender: TObject);
begin
  frmCadCliente := TfrmCadCliente.Create(Self);
  try
    frmCadCliente.ShowModal;
  finally
    FreeAndNil(frmCadCliente);
  end;

end;

procedure Tfrm_Principal.Cliente2Click(Sender: TObject);
begin
  frmConsultaCliente := TfrmConsultaCliente.Create(Self);
  frmConsultaCliente.ShowModal;
end;

procedure Tfrm_Principal.CondicaoPagamento1Click(Sender: TObject);
begin
  frmCadCondPgto := TfrmCadCondPgto.Create(Self);
  frmCadCondPgto.ShowModal;
end;

procedure Tfrm_Principal.consultaProdutoClick(Sender: TObject);
begin
  frmConsultaProduto := TfrmConsultaProduto.Create(Self);
  frmConsultaProduto.ShowModal;
end;

procedure Tfrm_Principal.FormaPagamento1Click(Sender: TObject);
begin
  frmCadFormaPagamento := TfrmCadFormaPagamento.Create(Self);
  frmCadFormaPagamento.ShowModal;
end;

procedure Tfrm_Principal.NotaEntrada1Click(Sender: TObject);
begin
  frmLancamentoNotaEntrada := TfrmLancamentoNotaEntrada.Create(Self);
  frmLancamentoNotaEntrada.Show;
end;

procedure Tfrm_Principal.PedidodeVenda1Click(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Self);
  frmPedidoVenda.ShowModal;
end;

procedure Tfrm_Principal.Produto1Click(Sender: TObject);
begin
  frmCadProduto := TfrmCadProduto.Create(Self);
  frmCadProduto.ShowModal;
end;

procedure Tfrm_Principal.Sair1Click(Sender: TObject);
begin
  if MessageDlg('Deseja sair do Sistema?', mtConfirmation, [mbYes, mbNo], 0) = 6  then
  begin
    Close;
  end;
end;

procedure Tfrm_Principal.TabeladePreo1Click(Sender: TObject);
begin
  frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
  frmcadTabelaPreco.ShowModal;
end;

procedure Tfrm_Principal.VendaDiria1Click(Sender: TObject);
begin
  frmRelVendaDiaria := TfrmRelVendaDiaria.Create(Self);
  frmRelVendaDiaria.Show;
end;

procedure Tfrm_Principal.VisualizarPedidoVenda1Click(Sender: TObject);
begin
  frmVisualizaPedidoVenda := TfrmVisualizaPedidoVenda.Create(Self);
  frmVisualizaPedidoVenda.ShowModal;
end;

end.
