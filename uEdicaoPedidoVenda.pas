unit uEdicaoPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  Tfrm_Edicao_Pedido_Venda = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtCdFormaPgto: TEdit;
    edtCdCondPgto: TEdit;
    edtNomeCondPgto: TEdit;
    dbGridProdutos: TDBGrid;
    edtVlDescTotalPedido: TEdit;
    edtVlAcrescimoTotalPedido: TEdit;
    edtVlTotalPedido: TEdit;
    btnCancelar: TButton;
    edtNrPedido: TEdit;
    edtCdCliente: TEdit;
    edtNomeCliente: TEdit;
    edtCidadeCliente: TEdit;
    edtNomeFormaPgto: TEdit;
    edtFl_orcamento: TCheckBox;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    sqlCarregaPedidoVenda: TFDQuery;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Edicao_Pedido_Venda: Tfrm_Edicao_Pedido_Venda;

implementation

{$R *.dfm}

procedure Tfrm_Edicao_Pedido_Venda.FormCreate(Sender: TObject);
begin
  sqlCarregaPedidoVenda.Close;
  sqlCarregaPedidoVenda.SQL.Text := 'select ' +
                                          ' pv.fl_orcamento, '+
                                          ' pv.cd_cliente, '+
                                          'c.nome, '+
                                          'e.cidade, '+
                                          'e.uf, '+
                                          'pv.cd_forma_pag, '+
                                          'cfp.nm_forma_pag, '+
                                          'pv.cd_cond_pag,    '+
                                          'ccp.nm_cond_pag,    '+
                                          'pvi.cd_produto,      '+
                                          'p.desc_produto,         '+
                                          'pvi.qtd_venda,          '+
                                          'pvi.cd_tabela_preco,    '+
                                          'p.un_medida,            '+
                                          'pvi.vl_unitario,        '+
                                          'pvi.vl_desconto,        '+
                                          'pvi.vl_total_item,      '+
                                          'pv.vl_desconto_pedido,         '+
                                          'pv.vl_acrescimo,                     '+
                                          'pv.vl_total                          '+
                                      'from                                     '+
                                       '   pedido_venda pv                      '+
                                      'join pedido_venda_item pvi on            '+
                                       '   pv.id_geral = pvi.id_pedido_venda    '+
                                       'join cta_forma_pagamento cfp on          '+
                                          'pv.cd_forma_pag = cfp.cd_forma_pag    '+
                                      'join cta_cond_pagamento ccp on            '+
                                          'cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento '+
                                      'join cliente c on                        '+
                                       '   pv.cd_cliente = c.cd_cliente         '+
                                       'join endereco e on '+
                                          'c.cd_cliente = e.cd_cliente '+
                                      'join produto p on                        '+
                                       '   pvi.cd_produto = p.cd_produto        '+
                                      'where                                    '+
                                       '   pv.nr_pedido = :nr_pedido            ';
end;

end.
