unit uTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, cCLIENTE, cPRODUTO,
  cCTA_FORMA_PAGAMENTO, Vcl.ExtCtrls, cCTA_COND_PGTO;

type
  Tfrm_Principal = class(TForm)
    tpTelaInicial: TPanel;
    btnCadastrarCliente: TButton;
    btnCadProduto: TButton;
    btnCadFormaPgto: TButton;
    btnFechar: TButton;
    btnCadCondPgto: TButton;
    procedure btnCadastrarClienteClick(Sender: TObject);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure btnCadFormaPgtoClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCadCondPgtoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Principal: Tfrm_Principal;

implementation

{$R *.dfm}

//abre a tela de cadastro de cliente
procedure Tfrm_Principal.btnCadastrarClienteClick(Sender: TObject);
begin
 cadCliente := TcadCliente.Create(Self);
 cadCliente.ShowModal;
end;

procedure Tfrm_Principal.btnCadCondPgtoClick(Sender: TObject);
begin
  cadCondPgto := TcadCondPgto.Create(Self);
  cadCondPgto.ShowModal;
end;

procedure Tfrm_Principal.btnCadFormaPgtoClick(Sender: TObject);
begin
 cadFormaPagamento := TcadFormaPagamento.Create(Self);
 cadFormaPagamento.ShowModal;
end;

procedure Tfrm_Principal.btnCadProdutoClick(Sender: TObject);
begin
  fCadProduto := TfCadProduto.Create(Self);
  fCadProduto.ShowModal;
end;

procedure Tfrm_Principal.btnFecharClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

end.
