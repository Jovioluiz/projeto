unit uVisualizaPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
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
    btnCancelar: TButton;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    edtFl_orcamento: TCheckBox;
    btnEditarPedido: TButton;
    sqlVisualizaPedidoVenda: TFDQuery;
    btnImprimir: TButton;

    procedure dbGridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNrPedidoExit(Sender: TObject);
    procedure btnEditarPedidoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVisualizaPedidoVenda: TfrmVisualizaPedidoVenda;

implementation

{$R *.dfm}

uses uEdicaoPedidoVenda, uDataModule;


procedure TfrmVisualizaPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;


procedure TfrmVisualizaPedidoVenda.btnEditarPedidoClick(Sender: TObject);
begin
 if edtFl_orcamento.Checked = false then
  begin
   MessageDlg('O pedido não pode ser editado', mtWarning, [mbOK],0);
  end
 else
  begin
    frm_Edicao_Pedido_Venda := Tfrm_Edicao_Pedido_Venda.Create(Self);
    frm_Edicao_Pedido_Venda.Show;
  end;

end;


procedure TfrmVisualizaPedidoVenda.btnImprimirClick(Sender: TObject);
begin
  with dm.sqlPedidoVenda do
    begin
      Close;
      SQL.Clear;

      SQL.Add('select                                                     '+
                  '    pv.nr_pedido,                                          '+
                  '    pvi.cd_produto,                                        '+
                  '    p.desc_produto,                                        '+
                  '    c.cd_cliente,                                          '+
                  '    c.nome,                                                '+
                  '    cfp.cd_forma_pag,                                      '+
                  '    cfp.nm_forma_pag,                                      '+
                  '    ccp.cd_cond_pag,                                       '+
                  '    ccp.nm_cond_pag,                                       '+
                  '    pvi.qtd_venda,                                         '+
                  '    pvi.un_medida,                                         '+
                  '    pvi.vl_unitario,                                       '+
                  '    sum(pvi.vl_unitario * pvi.qtd_venda) as total_item,    '+
                  '    pv.vl_total                                            '+
                  'from                                                       '+
                  '    pedido_venda pv                                        '+
                  'join pedido_venda_item pvi on                              '+
                  '    pv.id_geral = pvi.id_pedido_venda                      '+
                  'join cliente c on                                          '+
                  '    pv.cd_cliente = c.cd_cliente                           '+
                  'join produto p on                                          '+
                  '    p.cd_produto = pvi.cd_produto                          '+
                  'join cta_forma_pagamento cfp on                            '+
                  '    pv.cd_forma_pag = cfp.cd_forma_pag                     '+
                  'join cta_cond_pagamento ccp on                             '+
                  '    cfp.cd_forma_pag = ccp.cd_cta_forma_pagamento          '+
                  'where pv.nr_pedido = :nr_pedido ');

      ParamByName('nr_pedido').AsInteger := StrToInt(edtNrPedido.Text);

                  SQL.Add('group by             '+
                          '    pv.nr_pedido,    '+
                          '    pvi.cd_produto,  '+
                          '    p.desc_produto,  '+
                          '    c.cd_cliente,    '+
                          '    c.nome,          '+
                          '    cfp.cd_forma_pag,'+
                          '    cfp.nm_forma_pag,'+
                          '    ccp.cd_cond_pag, '+
                          '    ccp.nm_cond_pag, '+
                          '    pvi.qtd_venda,   '+
                          '    pvi.un_medida,   '+
                          '    pvi.vl_unitario, '+
                          '    pv.vl_total      '+
                          'order by             '+
                          '    pv.nr_pedido');



      Open();

      dm.reportPedidoVenda.LoadFromFile(GetCurrentDir + '\rel\rel_pedido_venda.fr3');
      dm.reportPedidoVenda.ShowReport();
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

//carrega os dados do pedido
procedure TfrmVisualizaPedidoVenda.edtNrPedidoExit(Sender: TObject);
var
  tempC, tempU : String;
begin

  sqlVisualizaPedidoVenda.Close;
  sqlVisualizaPedidoVenda.SQL.Text := 'select                                             '+
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

  sqlVisualizaPedidoVenda.ParamByName('nr_pedido').AsInteger := StrToInt(edtNrPedido.Text);
  sqlVisualizaPedidoVenda.Open();

if sqlVisualizaPedidoVenda.IsEmpty then
  begin
    if (Application.MessageBox('Pedido não Encontrado! Verifique', 'Atenção', MB_OK) = idOK) then
     begin
      edtCdCliente.Clear;
      edtCidadeCliente.Clear;
      edtCdFormaPgto.Clear;
      edtCdCondPgto.Clear;
      edtNomeCliente.Clear;
      edtNomeFormaPgto.Clear;
      edtNomeCondPgto.Clear;
      edtNrPedido.SetFocus;
      exit;
     end;
  end
else
  begin
    edtFl_orcamento.Checked := sqlVisualizaPedidoVenda.FieldByName('fl_orcamento').AsBoolean;
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
  end;
end;

procedure TfrmVisualizaPedidoVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
frmVisualizaPedidoVenda := nil;
end;

procedure TfrmVisualizaPedidoVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

end.
