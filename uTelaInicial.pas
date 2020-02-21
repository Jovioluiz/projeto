unit uTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, cCLIENTE, cPRODUTO,
  cCTA_FORMA_PAGAMENTO, Vcl.ExtCtrls, cCTA_COND_PGTO, Vcl.Imaging.jpeg, cConsultaCLIENTE,
  Vcl.Imaging.pngimage, uCadTABELAPRECO, uPedidoVenda, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

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
    procedure Cliente1Click(Sender: TObject);
    procedure Produto1Click(Sender: TObject);
    procedure FormaPagamento1Click(Sender: TObject);
    procedure CondicaoPagamento1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure Cliente2Click(Sender: TObject);
    procedure consultaProdutoClick(Sender: TObject);
    procedure TabeladePreo1Click(Sender: TObject);
    procedure PedidodeVenda1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

{$R *.dfm}

uses cConsultaPRODUTO;

procedure Tfrm_Principal.Cliente1Click(Sender: TObject);
begin
  cadCliente := TcadCliente.Create(Self);
  cadCliente.ShowModal;
end;

procedure Tfrm_Principal.Cliente2Click(Sender: TObject);
begin
  consultaCliente := TconsultaCliente.Create(Self);
  consultaCliente.ShowModal;
end;

procedure Tfrm_Principal.CondicaoPagamento1Click(Sender: TObject);
begin
  cadCondPgto := TcadCondPgto.Create(Self);
  cadCondPgto.ShowModal;
end;

procedure Tfrm_Principal.consultaProdutoClick(Sender: TObject);
begin
  fConsultaProduto := TfConsultaProduto.Create(Self);
  fConsultaProduto.ShowModal;
end;

procedure Tfrm_Principal.FormaPagamento1Click(Sender: TObject);
begin
  cadFormaPagamento := TcadFormaPagamento.Create(Self);
  cadFormaPagamento.ShowModal;
end;

procedure Tfrm_Principal.PedidodeVenda1Click(Sender: TObject);
begin
  frmPedidoVenda := TfrmPedidoVenda.Create(Self);
  frmPedidoVenda.ShowModal;
end;

procedure Tfrm_Principal.Produto1Click(Sender: TObject);
begin
  fCadProduto := TfCadProduto.Create(Self);
  fCadProduto.ShowModal;
end;

procedure Tfrm_Principal.Sair1Click(Sender: TObject);
begin
  if MessageDlg('Deseja sair do Sistema?', mtConfirmation, [mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

procedure Tfrm_Principal.TabeladePreo1Click(Sender: TObject);
begin
 frmcadTabelaPreco := TfrmcadTabelaPreco.Create(Self);
 frmcadTabelaPreco.ShowModal;
end;

end.

