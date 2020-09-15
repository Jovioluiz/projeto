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
    cdsProdutos: TClientDataSet;
    dsProdutos: TDataSource;
    edtFl_orcamento: TCheckBox;
    btnEditarPedido: TButton;
    btnImprimir: TButton;
    cdsProdutoscd_produto: TIntegerField;
    cdsProdutosdesc_produto: TStringField;
    cdsProdutosqtd_venda: TFloatField;
    cdsProdutoscd_tabela_preco: TIntegerField;
    cdsProdutosun_medida: TStringField;
    cdsProdutosvl_unitario: TCurrencyField;
    cdsProdutosvl_desconto: TCurrencyField;
    cdsProdutosvl_total_item: TCurrencyField;
    cdsProdutosicms_vl_base: TCurrencyField;
    cdsProdutosicms_pc_aliq: TCurrencyField;
    cdsProdutosicms_valor: TCurrencyField;
    cdsProdutosipi_vl_base: TCurrencyField;
    cdsProdutosipi_pc_aliq: TCurrencyField;
    cdsProdutosipi_valor: TCurrencyField;
    cdsProdutospis_cofins_vl_base: TCurrencyField;
    cdsProdutospis_cofins_pc_aliq: TCurrencyField;
    cdsProdutospis_cofins_valor: TCurrencyField;

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
    frmEdicaoPedidoVenda := TfrmEdicaoPedidoVenda.Create(Self);
    frmEdicaoPedidoVenda.ShowModal;
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

   // dm.reportPedidoVenda.LoadFromFile(GetCurrentDir + '\rel\rel_pedido_venda.fr3');
   // dm.reportPedidoVenda.ShowReport();
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
const
  SQL_PEDIDO = 'select                                          '+
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
             'join endereco_cliente e on                        '+
                'c.cd_cliente = e.cd_cliente                    '+
            'join produto p on                                  '+
             '   pvi.cd_produto = p.cd_produto                  '+
            'where                                              '+
             '   pv.nr_pedido = :nr_pedido';
var
  tempC, tempU : String;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    cdsProdutos.EmptyDataSet;

    qry.SQL.Add(SQL_PEDIDO);
    qry.ParamByName('nr_pedido').AsInteger := StrToInt(edtNrPedido.Text);
    qry.Open(SQL_PEDIDO);

    if qry.IsEmpty then
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
      edtFl_orcamento.Checked := qry.FieldByName('fl_orcamento').AsBoolean;
      edtCdCliente.Text := IntToStr(qry.FieldByName('cd_cliente').AsInteger);
      edtNomeCliente.Text := qry.FieldByName('nome').AsString;
      tempC := qry.FieldByName('cidade').Text;
      tempU := qry.FieldByName('uf').Text;
      edtCidadeCliente.Text := Concat(tempC + '/' + tempU);
      edtCdFormaPgto.Text := IntToStr(qry.FieldByName('cd_forma_pag').AsInteger);
      edtNomeFormaPgto.Text := qry.FieldByName('nm_forma_pag').AsString;
      edtCdCondPgto.Text := IntToStr(qry.FieldByName('cd_cond_pag').AsInteger);
      edtNomeCondPgto.Text := qry.FieldByName('nm_cond_pag').AsString;

      edtVlDescTotalPedido.Text := CurrToStr(qry.FieldByName('vl_desconto_pedido').AsCurrency);
      edtVlAcrescimoTotalPedido.Text := CurrToStr(qry.FieldByName('vl_acrescimo').AsCurrency);
      edtVlTotalPedido.Text := CurrToStr(qry.FieldByName('vl_total').AsCurrency);

      //lista os itens do pedido

      qry.First;

      while not qry.Eof do
      begin
        cdsProdutos.Append;
        cdsProdutos.FieldByName('cd_produto').AsInteger := qry.FieldByName('cd_produto').AsInteger;
        cdsProdutos.FieldByName('desc_produto').AsString := qry.FieldByName('desc_produto').AsString;
        cdsProdutos.FieldByName('qtd_venda').AsFloat := qry.FieldByName('qtd_venda').AsFloat;
        cdsProdutos.FieldByName('cd_tabela_preco').AsInteger := qry.FieldByName('cd_tabela_preco').AsInteger;
        cdsProdutos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
        cdsProdutos.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
        cdsProdutos.FieldByName('vl_desconto').AsCurrency := qry.FieldByName('vl_desconto').AsCurrency;
        cdsProdutos.FieldByName('vl_total_item').AsCurrency := qry.FieldByName('vl_total_item').AsCurrency;
        cdsProdutos.FieldByName('icms_vl_base').AsCurrency := qry.FieldByName('icms_vl_base').AsCurrency;
        cdsProdutos.FieldByName('icms_pc_aliq').AsCurrency := qry.FieldByName('icms_pc_aliq').AsCurrency;
        cdsProdutos.FieldByName('icms_valor').AsCurrency := qry.FieldByName('icms_valor').AsCurrency;
        cdsProdutos.FieldByName('ipi_vl_base').AsCurrency := qry.FieldByName('ipi_vl_base').AsCurrency;
        cdsProdutos.FieldByName('ipi_pc_aliq').AsCurrency := qry.FieldByName('ipi_pc_aliq').AsCurrency;
        cdsProdutos.FieldByName('ipi_valor').AsCurrency := qry.FieldByName('ipi_valor').AsCurrency;
        cdsProdutos.FieldByName('pis_cofins_vl_base').AsCurrency := qry.FieldByName('pis_cofins_vl_base').AsCurrency;
        cdsProdutos.FieldByName('pis_cofins_pc_aliq').AsCurrency := qry.FieldByName('pis_cofins_pc_aliq').AsCurrency;
        cdsProdutos.FieldByName('pis_cofins_valor').AsCurrency := qry.FieldByName('pis_cofins_valor').AsCurrency;
        cdsProdutos.Post;
        qry.Next;
      end;
    end;
  finally
    qry.Free;
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
