unit uEdicaoPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, System.UITypes, Vcl.Mask, Vcl.Buttons;

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
    edtDataEmissao: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    edtCdProduto: TEdit;
    edtNomeProduto: TEdit;
    edtQtdade: TEdit;
    edtTabelaPreco: TEdit;
    edtDescTabPreco: TEdit;
    edtVlUnitario: TEdit;
    edtVlDesconto: TEdit;
    edtVlTotal: TEdit;
    edtUnMedida: TComboBox;
    SpeedButton1: TSpeedButton;
    btnConfirmar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridProdutosDblClick(Sender: TObject);
    procedure edtCdProdutoChange(Sender: TObject);
    procedure edtTabelaPrecoChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    //procedure edtTabelaPrecoChange(Sender: TObject);
  private
    { Private declarations }
    edicao : Boolean;
  public
    { Public declarations }
  end;

var
  frm_Edicao_Pedido_Venda: Tfrm_Edicao_Pedido_Venda;

implementation

{$R *.dfm}

uses uVisualizaPedidoVenda, uConfiguracoes;

procedure Tfrm_Edicao_Pedido_Venda.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

//da erro aqui, não carrega os campos certos e limpa o grid
procedure Tfrm_Edicao_Pedido_Venda.dbGridProdutosDblClick(Sender: TObject);
begin
  edtCdProduto.Text := dbGridProdutos.Fields[0].AsString;
  edtNomeProduto.Text := dbGridProdutos.Fields[1].AsString;
  edtQtdade.Text := dbGridProdutos.Fields[2].AsString;
  edtTabelaPreco.Text := dbGridProdutos.Fields[3].AsString;
  edtUnMedida.Text := dbGridProdutos.Fields[4].AsString;
  edtVlUnitario.Text := dbGridProdutos.Fields[5].AsString;
  edtVlDesconto.Text := dbGridProdutos.Fields[6].AsString;
  edtVlTotal.Text := dbGridProdutos.Fields[7].AsString;
  edicao := True;
end;

procedure Tfrm_Edicao_Pedido_Venda.edtCdProdutoChange(Sender: TObject);
begin
  if edtCdProduto.Text = EmptyStr then
  begin
    edtNomeProduto.Text := '';
    edtQtdade.Text := '';
    edtUnMedida.Text := '';
    edtTabelaPreco.Text := '';
    edtDescTabPreco.Text := '';
    edtVlUnitario.Text := '';
    Exit;
  end;

  sqlCarregaPedidoVenda.Close;
  sqlCarregaPedidoVenda.SQL.Text := 'select '+
                                          'p.cd_produto,                  '+
                                          'p.desc_produto,                '+
                                          'tpp.un_medida,                 '+
                                          'tpp.cd_tabela,                 '+
                                          'tp.nm_tabela,                  '+
                                          'tpp.valor                      '+
                                      'from                               '+
                                          'produto p                      '+
                                      'join tabela_preco_produto tpp on   '+
                                          'p.cd_produto = tpp.cd_produto  '+
                                      'join tabela_preco tp on            '+
                                          'tpp.cd_tabela = tp.cd_tabela   '+
                                      'where (p.cd_produto = :cd_produto) '+
                                      'and (p.fl_ativo = true)';

  sqlCarregaPedidoVenda.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  sqlCarregaPedidoVenda.Open();
  edtNomeProduto.Text := sqlCarregaPedidoVenda.FieldByName('desc_produto').AsString;
  edtUnMedida.Text := sqlCarregaPedidoVenda.FieldByName('un_medida').AsString;
  edtTabelaPreco.Text := IntToStr(sqlCarregaPedidoVenda.FieldByName('cd_tabela').AsInteger);
  edtDescTabPreco.Text := sqlCarregaPedidoVenda.FieldByName('nm_tabela').AsString;
  edtVlUnitario.Text := CurrToStr(sqlCarregaPedidoVenda.FieldByName('valor').AsCurrency);
end;

procedure Tfrm_Edicao_Pedido_Venda.edtTabelaPrecoChange(Sender: TObject);
begin
  if edtTabelaPreco.Text = EmptyStr then
    begin
      edtDescTabPreco.Text := '';
      edtVlUnitario.Text := '';
      Exit;
    end;


  sqlCarregaPedidoVenda.Close;
  sqlCarregaPedidoVenda.SQL.Text := 'select                              '+
                                           'tp.cd_tabela,                 '+
                                           'tp.nm_tabela,                 '+
                                           'tpp.valor                     '+
                                      'from                               '+
                                          'tabela_preco tp                '+
                                      'join tabela_preco_produto tpp on   '+
                                          'tp.cd_tabela = tpp.cd_tabela   '+
                                      'join produto p on                  '+
                                          'tpp.cd_produto = p.cd_produto  '+
                                      'where (tp.cd_tabela = :cd_tabela)  '+
                                      'and (p.cd_produto = :cd_produto)';

  sqlCarregaPedidoVenda.ParamByName('cd_tabela').AsInteger := StrToInt(edtTabelaPreco.Text);
  sqlCarregaPedidoVenda.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  sqlCarregaPedidoVenda.Open();
  edtDescTabPreco.Text:= sqlCarregaPedidoVenda.FieldByName('nm_tabela').AsString;
  edtVlUnitario.Text := CurrToStr(sqlCarregaPedidoVenda.FieldByName('valor').AsCurrency);
end;

procedure Tfrm_Edicao_Pedido_Venda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
frm_Edicao_Pedido_Venda := nil;
end;

procedure Tfrm_Edicao_Pedido_Venda.FormCreate(Sender: TObject);
var tempC, tempU : String;
edicao : TfrmConfiguracoes;
begin
  try
    edicao := TfrmConfiguracoes.Create(Self);
    sqlCarregaPedidoVenda.Close;
    sqlCarregaPedidoVenda.SQL.Text := 'select                                             '+
                                          'pv.nr_pedido,                                  '+
                                          'pv.fl_orcamento,                               '+
                                          'pv.cd_cliente,                                 '+
                                          'c.nome,                                        '+
                                          'e.cidade,                                      '+
                                          'e.uf,                                          '+
                                          'pv.cd_forma_pag,                               '+
                                          'cfp.nm_forma_pag,                              '+
                                          'pv.cd_cond_pag,                                '+
                                          'ccp.nm_cond_pag,                               '+
                                          'pvi.cd_produto,                                '+
                                          'p.desc_produto,                                '+
                                          'pvi.qtd_venda,                                 '+
                                          'pvi.cd_tabela_preco,                           '+
                                          'p.un_medida,                                   '+
                                          'pvi.vl_unitario,                               '+
                                          'pvi.vl_desconto,                               '+
                                          'pvi.vl_total_item,                             '+
                                          'pvi.vl_total_item as icms_vl_base,             '+
                                          'pvi.icms_pc_aliq,                              '+
                                          '((pvi.vl_total_item * pvi.icms_pc_aliq) / 100) as icms_valor, '+
                                          'pvi.vl_total_item as ipi_vl_base,              '+
                                          'pvi.ipi_pc_aliq,                               '+
                                          '((pvi.vl_total_item * pvi.ipi_pc_aliq) / 100) as ipi_valor,   '+
                                          'pvi.vl_total_item as pis_cofins_vl_base,       '+
                                          'pvi.pis_cofins_pc_aliq,                        '+
                                          '((pvi.vl_total_item * pvi.pis_cofins_pc_aliq) / 100) as pis_cofins_valor, '+
                                          'pvi.vl_total_item,                             '+
                                          'pv.vl_desconto_pedido,                         '+
                                          'pv.vl_acrescimo,                               '+
                                          'pv.vl_total                                    '+
                                      'from                                               '+
                                       '   pedido_venda pv                                '+
                                      'join pedido_venda_item pvi on                      '+
                                       '   pv.id_geral = pvi.id_pedido_venda              '+
                                       'join cta_forma_pagamento cfp on                   '+
                                          'pv.cd_forma_pag = cfp.cd_forma_pag             '+
                                      'join cta_cond_pagamento ccp on                     '+
                                          'cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento  '+
                                      'join cliente c on                                  '+
                                       '   pv.cd_cliente = c.cd_cliente                   '+
                                       'join endereco e on                                '+
                                          'c.cd_cliente = e.cd_cliente                    '+
                                      'join produto p on                                  '+
                                       '   pvi.cd_produto = p.cd_produto                  '+
                                      'where                                              '+
                                       '   pv.nr_pedido = :nr_pedido';

    sqlCarregaPedidoVenda.ParamByName('nr_pedido').AsInteger := StrToInt(uVisualizaPedidoVenda.frmVisualizaPedidoVenda.edtNrPedido.Text);
    //sqlCarregaPedidoVenda.ParamByName('nr_pedido').AsInteger := StrToInt(uVisualizaPedidoVenda.frmVisualizaPedidoVenda.edtNrPedido.Text);
    sqlCarregaPedidoVenda.Open();
    edtNrPedido.Text := IntToStr(sqlCarregaPedidoVenda.FieldByName('nr_pedido').AsInteger);
    edtFl_orcamento.Checked := sqlCarregaPedidoVenda.FieldByName('fl_orcamento').AsBoolean;
    if edicao.rgEditaClientePV.ItemIndex = 0 then
      begin
        edtCdCliente.Enabled := True;
      end;

    edtCdCliente.Text := IntToStr(sqlCarregaPedidoVenda.FieldByName('cd_cliente').AsInteger);
    edtNomeCliente.Text := sqlCarregaPedidoVenda.FieldByName('nome').AsString;
    tempC := sqlCarregaPedidoVenda.FieldByName('cidade').Text;
    tempU := sqlCarregaPedidoVenda.FieldByName('uf').Text;
    edtCidadeCliente.Text := Concat(tempC + ' / ' + tempU);
    edtCdFormaPgto.Text := IntToStr(sqlCarregaPedidoVenda.FieldByName('cd_forma_pag').AsInteger);
    edtNomeFormaPgto.Text := sqlCarregaPedidoVenda.FieldByName('nm_forma_pag').AsString;
    edtCdCondPgto.Text := IntToStr(sqlCarregaPedidoVenda.FieldByName('cd_cond_pag').AsInteger);
    edtNomeCondPgto.Text := sqlCarregaPedidoVenda.FieldByName('nm_cond_pag').AsString;

    edtVlDescTotalPedido.Text := CurrToStr(sqlCarregaPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency);
    edtVlAcrescimoTotalPedido.Text := CurrToStr(sqlCarregaPedidoVenda.FieldByName('vl_acrescimo').AsCurrency);
    edtVlTotalPedido.Text := CurrToStr(sqlCarregaPedidoVenda.FieldByName('vl_total').AsCurrency);
    edtDataEmissao.Text := DateToStr(Date());

    //lista os itens do pedido
    dbGridProdutos.DataSource := DataSource1;
    dbGridProdutos.Columns[0].Title.Caption := 'Cód. Produto';
    dbGridProdutos.Columns[0].FieldName := 'cd_produto';
    dbGridProdutos.Columns[1].Title.Caption := 'Descricao';
    dbGridProdutos.Columns[1].FieldName := 'desc_produto';
    dbGridProdutos.Columns[2].Title.Caption := 'Qtdade';
    dbGridProdutos.Columns[2].FieldName := 'qtd_venda';
    dbGridProdutos.Columns[3].Title.Caption := 'Tabela Preço';
    dbGridProdutos.Columns[3].FieldName := 'cd_tabela_preco';
    dbGridProdutos.Columns[4].Title.Caption := 'UN Medida';
    dbGridProdutos.Columns[4].FieldName := 'un_medida';
    dbGridProdutos.Columns[5].Title.Caption := 'Valor Unitário';
    dbGridProdutos.Columns[5].FieldName := 'vl_unitario';
    dbGridProdutos.Columns[6].Title.Caption := 'Valor Desconto';
    dbGridProdutos.Columns[6].FieldName := 'vl_desconto';
    dbGridProdutos.Columns[7].Title.Caption := 'Valor Total';
    dbGridProdutos.Columns[7].FieldName := 'vl_total_item';
    dbGridProdutos.Columns[8].Title.Caption := 'Valor Base ICMS';
    dbGridProdutos.Columns[8].FieldName := 'icms_vl_base';
    dbGridProdutos.Columns[9].Title.Caption := 'Aliq ICMS';
    dbGridProdutos.Columns[9].FieldName := 'icms_pc_aliq';
    dbGridProdutos.Columns[10].Title.Caption := 'Valor ICMS';
    dbGridProdutos.Columns[10].FieldName := 'icms_valor';
    dbGridProdutos.Columns[11].Title.Caption := 'Valor Base IPI';
    dbGridProdutos.Columns[11].FieldName := 'ipi_vl_base';
    dbGridProdutos.Columns[12].Title.Caption := 'Aliq IPI';
    dbGridProdutos.Columns[12].FieldName := 'ipi_pc_aliq';
    dbGridProdutos.Columns[13].Title.Caption := 'Valor IPI';
    dbGridProdutos.Columns[13].FieldName := 'ipi_valor';
    dbGridProdutos.Columns[14].Title.Caption := 'Valor Base PIS/COFINS';
    dbGridProdutos.Columns[14].FieldName := 'pis_cofins_vl_base';
    dbGridProdutos.Columns[15].Title.Caption := 'Aliq PIS/COFINS';
    dbGridProdutos.Columns[15].FieldName := 'pis_cofins_pc_aliq';
    dbGridProdutos.Columns[16].Title.Caption := 'Valor PIS/COFINS';
    dbGridProdutos.Columns[16].FieldName := 'pis_cofins_valor';

  except
    edicao.Free;
  end;
end;

procedure Tfrm_Edicao_Pedido_Venda.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

end.
