unit uVisualizaPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, EUserAcs,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uConexao;

type
  TfrmVisualizaPedidoVenda = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtNrPedido: TEdit;
    Label2: TLabel;
    edtCdCliente: TEdit;
    edtNomeCliente: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtCidadeCliente: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtCdFormaPgto: TEdit;
    edtCdCondPgto: TEdit;
    edtNomeFormaPgto: TEdit;
    edtNomeCondPgto: TEdit;
    dbGridProdutos: TDBGrid;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtVlDescTotalPedido: TEdit;
    edtVlAcrescimoTotalPedido: TEdit;
    edtVlTotalPedido: TEdit;
    btnConfirmarPedido: TButton;
    btnCancelar: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    edtFl_orcamento: TCheckBox;
    btnEditarPedido: TButton;
    sqlVisualizaPedidoVenda: TFDQuery;

    procedure dbGridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNrPedidoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVisualizaPedidoVenda: TfrmVisualizaPedidoVenda;

implementation

{$R *.dfm}


procedure TfrmVisualizaPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;


//Faz a linha zebrada no grid dos itens
procedure TfrmVisualizaPedidoVenda.dbGridProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with dbGridProdutos do
    begin
      if Odd(DataSource.DataSet.RecNo) then
        Canvas.Brush.Color := clSilver
      else
        Canvas.Brush.Color := clWindow;

    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;
procedure TfrmVisualizaPedidoVenda.edtNrPedidoExit(Sender: TObject);
var
  tempC, tempU : String;
begin
  sqlVisualizaPedidoVenda.Close;
  sqlVisualizaPedidoVenda.SQL.Text := 'select ' +
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


  sqlVisualizaPedidoVenda.ParamByName('nr_pedido').AsInteger := StrToInt(edtNrPedido.Text);
  //sqlVisualizaPedidoVenda.Open();

  edtCdCliente.Text := IntToStr(sqlVisualizaPedidoVenda.FieldByName('cd_cliente').AsInteger);
  edtNomeCliente.Text := sqlVisualizaPedidoVenda.FieldByName('nome').AsString;
  tempC := sqlVisualizaPedidoVenda.FieldByName('cidade').Text;
  tempU := sqlVisualizaPedidoVenda.FieldByName('uf').Text;
  edtCidadeCliente.Text := Concat(tempC + '/' + tempU);
  edtCdFormaPgto.Text := IntToStr(sqlVisualizaPedidoVenda.FieldByName('cd_forma_pag').AsInteger);
  edtNomeFormaPgto.Text := sqlVisualizaPedidoVenda.FieldByName('nm_forma_pag').AsString;
  edtCdCondPgto.Text := IntToStr(sqlVisualizaPedidoVenda.FieldByName('cd_cond_pag').AsInteger);
  edtNomeCondPgto.Text := sqlVisualizaPedidoVenda.FieldByName('nm_cond_pag').AsString;



  edtVlDescTotalPedido.Text := CurrToStr(sqlVisualizaPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency);
  edtVlAcrescimoTotalPedido.Text := CurrToStr(sqlVisualizaPedidoVenda.FieldByName('vl_acrescimo').AsCurrency);
  edtVlTotalPedido.Text := CurrToStr(sqlVisualizaPedidoVenda.FieldByName('vl_total').AsCurrency);

  sqlVisualizaPedidoVenda.Open();

  dbGridProdutos.DataSource := DataSource1;
  dbGridProdutos.Columns[0].Title.Caption := 'C�d. Produto';
  dbGridProdutos.Columns[0].FieldName := 'cd_produto';
  dbGridProdutos.Columns[1].Title.Caption := 'Nome Produto';
  dbGridProdutos.Columns[1].FieldName := 'desc_produto';
  dbGridProdutos.Columns[2].Title.Caption := 'Qtdade';
  dbGridProdutos.Columns[2].FieldName := 'qtd_venda';
  dbGridProdutos.Columns[3].Title.Caption := 'Tabela Pre�o';
  dbGridProdutos.Columns[3].FieldName := 'cd_tabela_preco';
  dbGridProdutos.Columns[4].Title.Caption := 'UN Medida';
  dbGridProdutos.Columns[4].FieldName := 'un_medida';
  dbGridProdutos.Columns[5].Title.Caption := 'Valor Unit�rio';
  dbGridProdutos.Columns[5].FieldName := 'vl_unitario';
  dbGridProdutos.Columns[6].Title.Caption := 'Valor Desconto';
  dbGridProdutos.Columns[6].FieldName := 'vl_desconto';
  dbGridProdutos.Columns[7].Title.Caption := 'Valor Desconto';
  dbGridProdutos.Columns[7].FieldName := 'vl_desconto';
  dbGridProdutos.Columns[8].Title.Caption := 'Valor Total';
  dbGridProdutos.Columns[8].FieldName := 'vl_total_item';







end;

end.