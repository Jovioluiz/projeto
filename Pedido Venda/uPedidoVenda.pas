unit uPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uConexao, Vcl.Mask,
  Vcl.ComCtrls, System.Generics.Collections;

type
  TfrmPedidoVenda = class(TfrmConexao)
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
    Label7: TLabel;
    edtCdProduto: TEdit;
    edtDescProduto: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtQtdade: TEdit;
    edtUnMedida: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtCdtabelaPreco: TEdit;
    edtDescTabelaPreco: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    edtVlUnitario: TEdit;
    edtVlTotal: TEdit;
    btnAdicionar: TButton;
    dbGridProdutos: TDBGrid;
    Label15: TLabel;
    edtVlDescontoItem: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtVlDescTotalPedido: TEdit;
    edtVlAcrescimoTotalPedido: TEdit;
    edtVlTotalPedido: TEdit;
    btnConfirmarPedido: TButton;
    btnCancelar: TButton;
    cdsPedidoVenda: TClientDataSet;
    dsPedidoVenda: TDataSource;
    edtFl_orcamento: TCheckBox;
    edtDataEmissao: TMaskEdit;
    Label19: TLabel;
    intgrfldPedidoVendacd_produto: TIntegerField;
    cdsPedidoVendadescricao: TStringField;
    cdsPedidoVendaqtd_venda: TFloatField;
    intgrfldPedidoVendacd_tabela_preco: TIntegerField;
    cdsPedidoVendaun_medida: TStringField;
    cdsPedidoVendavl_unitario: TCurrencyField;
    cdsPedidoVendavl_desconto: TCurrencyField;
    cdsPedidoVendavl_total_item: TCurrencyField;
    cdsPedidoVendaicms_vl_base: TCurrencyField;
    cdsPedidoVendaicms_pc_aliq: TCurrencyField;
    cdsPedidoVendaicms_valor: TCurrencyField;
    cdsPedidoVendaipi_vl_base: TCurrencyField;
    cdsPedidoVendaipi_pc_aliq: TCurrencyField;
    cdsPedidoVendaipi_valor: TCurrencyField;
    cdsPedidoVendapis_cofins_vl_base: TCurrencyField;
    cdsPedidoVendapis_cofins_pc_aliq: TCurrencyField;
    cdsPedidoVendapis_cofins_valor: TCurrencyField;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCdClienteChange(Sender: TObject);
    procedure edtCdClienteExit(Sender: TObject);
    procedure edtCdFormaPgtoChange(Sender: TObject);
    procedure edtCdFormaPgtoExit(Sender: TObject);
    procedure edtCdCondPgtoChange(Sender: TObject);
    procedure edtCdCondPgtoExit(Sender: TObject);
    procedure edtCdProdutoChange(Sender: TObject);
    procedure edtCdtabelaPrecoChange(Sender: TObject);
    procedure edtCdtabelaPrecoExit(Sender: TObject);
    procedure edtQtdadeChange(Sender: TObject);
    procedure edtVlDescontoItemExit(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure dbGridProdutosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCdProdutoExit(Sender: TObject);
    procedure edtVlDescTotalPedidoExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarPedidoClick(Sender: TObject);
    procedure edtVlAcrescimoTotalPedidoExit(Sender: TObject);
    procedure dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQtdadeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbGridProdutosDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    edicaoItem : Boolean;
    procedure limpaCampos;
    procedure limpaDados;
    procedure atualizaEstoqueProduto;
    function GeraNumeroPedido: Int8;
    function ProdutoJaLancado(CodProduto: Integer): Boolean;
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

uses
  uclPedidoVenda, uDataModule, uGerador, uConfiguracoes;

{$R *.dfm}


procedure TfrmPedidoVenda.atualizaEstoqueProduto;
const
  sql_update = 'update '+
                    'produto '+
              'set '+
                    'qtd_estoque = :qtd_estoque '+
              'where cd_produto = :cd_produto';

  sql_select = 'select '+
                  'qtd_estoque '+
              'from '+
                  'produto '+
              'where '+
                  'cd_produto = :cd_produto';
var
  qry: TFDQuery;
  qtdade, qttotal: Double;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  dm.FDConnection1.StartTransaction;

  try
    cdsPedidoVenda.DisableControls;
    cdsPedidoVenda.First;
    while not cdsPedidoVenda.Eof do
    begin
      qry.SQL.Clear;
      qry.SQL.Add(sql_select);
      qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
      qry.Open(sql_select);

      qtdade := qry.FieldByName('qtd_estoque').AsFloat;//quantidade no banco
      qttotal := qtdade - cdsPedidoVenda.FieldByName('qtd_venda').AsInteger; //diminui com a informada no pedido

      qry.SQL.Clear;

      qry.SQL.Add(sql_update);
      qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
      qry.ParamByName('qtd_estoque').AsFloat := qttotal;

      qry.ExecSQL;
      cdsPedidoVenda.Next;
      dm.FDConnection1.Commit;
    end;
  finally
    qry.Free;
    dm.FDConnection1.Rollback;
    cdsPedidoVenda.EnableControls;
  end;
end;

procedure TfrmPedidoVenda.btnAdicionarClick(Sender: TObject);
//adiciona os produtos no grid
const
  sql = 'select '+
        '    pt.cd_produto, '+
        '    pt.cd_tributacao_icms,'+
        '    gti.aliquota_icms,'+
        '    pt.cd_tributacao_ipi,'+
        '    gtipi.aliquota_ipi,'+
        '    pt.cd_tributacao_pis_cofins,'+
        '    gtpc.aliquota_pis_cofins '+
        'from '+
        '    produto_tributacao pt '+
        'join grupo_tributacao_icms gti on '+
        '    pt.cd_tributacao_icms = gti.cd_tributacao '+
        'join grupo_tributacao_ipi gtipi on '+
        '    pt.cd_tributacao_ipi = gtipi.cd_tributacao '+
        'join grupo_tributacao_pis_cofins gtpc on '+
        '    pt.cd_tributacao_pis_cofins = gtpc.cd_tributacao '+
        'where '+
        '    pt.cd_produto = :cd_produto';
 var
  vl_total_itens : Currency;
  aliq_icms, aliq_ipi, aliq_pis_cofins : Double;
  lancado: Boolean;
  qry: TFDQuery;
  lancaProduto: TfrmConfiguracoes;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  lancaProduto := TfrmConfiguracoes.Create(Self);

  try
    qry.Close;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
    qry.Open(sql);

    if ProdutoJaLancado(StrToInt(edtCdProduto.Text))
      and (lancaProduto.cbbLancaItemPedido.ItemIndex = 1) then
      raise Exception.Create('O produto j� est� lan�ado');

    aliq_icms := qry.FieldByName('aliquota_icms').AsCurrency;
    aliq_ipi := qry.FieldByName('aliquota_ipi').AsCurrency;
    aliq_pis_cofins := qry.FieldByName('aliquota_pis_cofins').AsCurrency;

    if edicaoItem then
    begin
      try
        cdsPedidoVenda.Edit;//entra em modo de edi��o
        cdsPedidoVenda.FieldByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
        cdsPedidoVenda.FieldByName('qtd_venda').AsInteger := StrToInt(edtQtdade.Text);
        cdsPedidoVenda.FieldByName('un_medida').AsString := edtUnMedida.Text;
        cdsPedidoVenda.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtVlUnitario.Text);
        cdsPedidoVenda.FieldByName('vl_desconto').AsCurrency := StrToCurr(edtVlDescontoItem.Text);
        cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency := StrToCurr(edtVlTotal.Text);
        if aliq_icms = 0 then
        begin
          cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency := 0;
          cdsPedidoVenda.FieldByName('icms_pc_aliq').AsFloat := 0;
          cdsPedidoVenda.FieldByName('icms_valor').AsCurrency := 0;
        end
        else
        begin
          cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
          cdsPedidoVenda.FieldByName('icms_pc_aliq').AsFloat := aliq_icms;
          cdsPedidoVenda.FieldByName('icms_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_icms) / 100;
        end;
        if aliq_ipi = 0 then
        begin
          cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency := 0;
          cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsFloat := 0;
          cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency := 0;
        end
        else
        begin
          cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
          cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsFloat := aliq_ipi;
          cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_ipi) / 100;
        end;
        if aliq_pis_cofins = 0 then
        begin
          cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency := 0;
          cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsFloat := 0;
          cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency := 0;
        end
        else
        begin
          cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
          cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsFloat := aliq_pis_cofins;
          cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_pis_cofins) / 100;
        end;
      finally
        cdsPedidoVenda.Insert;
        edicaoItem := False;
      end;
    end
    else
    begin
      cdsPedidoVenda.Append;
      cdsPedidoVenda.FieldByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
      cdsPedidoVenda.FieldByName('descricao').AsString := edtDescProduto.Text;
      cdsPedidoVenda.FieldByName('qtd_venda').AsInteger := StrToInt(edtQtdade.Text);
      cdsPedidoVenda.FieldByName('cd_tabela_preco').AsInteger := StrToInt(edtCdtabelaPreco.Text);
      cdsPedidoVenda.FieldByName('un_medida').AsString := edtUnMedida.Text;
      cdsPedidoVenda.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtVlUnitario.Text);
      cdsPedidoVenda.FieldByName('vl_desconto').AsCurrency := StrToCurr(edtVlDescontoItem.Text);
      cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency := StrToCurr(edtVlTotal.Text);
      if aliq_icms = 0 then
      begin
        cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency := 0;
        cdsPedidoVenda.FieldByName('icms_pc_aliq').AsFloat := 0;
        cdsPedidoVenda.FieldByName('icms_valor').AsCurrency := 0;
      end
      else
      begin
        cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
        cdsPedidoVenda.FieldByName('icms_pc_aliq').AsFloat := aliq_icms;
        cdsPedidoVenda.FieldByName('icms_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_icms) / 100;
      end;
      if aliq_ipi = 0 then
      begin
        cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency := 0;
        cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsFloat := 0;
        cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency := 0;
      end
      else
      begin
        cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
        cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsFloat := aliq_ipi;
        cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_ipi) / 100;
      end;
      if aliq_pis_cofins = 0 then
      begin
        cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency := 0;
        cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsFloat := 0;
        cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency := 0;
      end
      else
      begin
        cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
        cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsFloat := aliq_pis_cofins;
        cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq_pis_cofins) / 100;
      end;
      cdsPedidoVenda.Post;
    end;

    //soma os valores totais dos itens e preenche o valor total do pedido
    vl_total_itens := 0;

    with cdsPedidoVenda do
    begin
      cdsPedidoVenda.DisableControls;
      cdsPedidoVenda.First;

      while not cdsPedidoVenda.Eof do
      begin
        vl_total_itens := (vl_total_itens + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
        cdsPedidoVenda.Next;
      end;

      edtVlTotalPedido.Text := CurrToStr(vl_total_itens);
      cdsPedidoVenda.EnableControls;
    end;
  finally
    limpaCampos;
    qry.Free;
  end;
end;


procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente fechar?','Aten��o', MB_YESNO) = IDYES) then
  begin
    Close;
  end;
end;

//grava os dados na pedido_venda e pedido_venda_item
procedure TfrmPedidoVenda.btnConfirmarPedidoClick(Sender: TObject);
const
  sql_Insert_pedido = 'insert ' +
                      '    into ' +
                      'pedido_venda (id_geral, nr_pedido, cd_cliente, cd_forma_pag, cd_cond_pag, vl_desconto_pedido, '+
                      '              vl_acrescimo, vl_total, fl_orcamento, dt_emissao) ' +
                      'values (:id_geral, :nr_pedido, :cd_cliente, :cd_forma_pag, :cd_cond_pag, :vl_desconto_pedido, '+
                      '        :vl_acrescimo, :vl_total, :fl_orcamento, :dt_emissao)';
  sql_insert_itens = 'insert '+
                     '    into '+
                     'pedido_venda_item (id_geral, id_pedido_venda, cd_produto, vl_unitario, vl_total_item, qtd_venda, '+
                     'vl_desconto, cd_tabela_preco, icms_vl_base, icms_pc_aliq, icms_valor, ipi_vl_base, ipi_pc_aliq, '+
                     'ipi_valor, pis_cofins_vl_base, pis_cofins_pc_aliq, pis_cofins_valor, un_medida) '+
                     'values (:id_geral, :id_pedido_venda, :cd_produto, :vl_unitario, :vl_total_item, '+
                     ':qtd_venda, :vl_desconto, :cd_tabela_preco, :icms_vl_base, :icms_pc_aliq, :icms_valor, '+
                     ':ipi_vl_base, :ipi_pc_aliq, :ipi_valor, :pis_cofins_vl_base, :pis_cofins_pc_aliq, :pis_cofins_valor, :un_medida)';
var
  nr_pedido, id_geral: Largeint;
  Tempo : Integer;
  qry, qryItens: TFDQuery;
  idGeral, idGeralPvi: TGerador;

begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  qryItens := TFDQuery.Create(Self);
  qryItens.Connection := dm.FDConnection1;
  qry.Connection.StartTransaction;
  idGeral := TGerador.Create;
  idGeralPvi := TGerador.Create;
  try
    try
      nr_pedido := 0;

      nr_pedido := GeraNumeroPedido;
      edtNrPedido.Text := IntToStr(nr_pedido);
      id_geral := idGeral.GeraIdGeral;

      //insert na pedido_venda

      qry.SQL.Add(sql_Insert_pedido);
      qry.ParamByName('id_geral').AsInteger := id_geral;
      qry.ParamByName('nr_pedido').AsInteger := nr_pedido;
      qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
      qry.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
      qry.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
      qry.ParamByName('vl_desconto_pedido').AsCurrency := StrToCurr(edtVlDescTotalPedido.Text);
      qry.ParamByName('vl_acrescimo').AsCurrency := StrToCurr(edtVlAcrescimoTotalPedido.Text);
      qry.ParamByName('vl_total').AsCurrency := StrToCurr(edtVlTotalPedido.Text);
      qry.ParamByName('fl_orcamento').AsBoolean := edtFl_orcamento.Checked;
      qry.ParamByName('dt_emissao').AsDate := StrToDate(edtDataEmissao.Text);
      qry.ExecSQL;

      //insert na pedido_venda_item
      with cdsPedidoVenda do
      begin
        cdsPedidoVenda.DisableControls;
        cdsPedidoVenda.First;
        while not cdsPedidoVenda.Eof do
        begin
          qryItens.SQL.Clear;

          qryItens.SQL.Add(sql_insert_itens);
          qryItens.ParamByName('id_geral').AsInteger := idGeralPvi.GeraIdGeral;
          qryItens.ParamByName('id_pedido_venda').AsInteger := id_geral;
          qryItens.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
          qryItens.ParamByName('vl_unitario').AsCurrency := cdsPedidoVenda.FieldByName('vl_unitario').AsCurrency;
          qryItens.ParamByName('vl_total_item').AsCurrency := cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency;
          qryItens.ParamByName('qtd_venda').AsInteger := cdsPedidoVenda.FieldByName('qtd_venda').AsInteger;
          qryItens.ParamByName('vl_desconto').AsCurrency := cdsPedidoVenda.FieldByName('vl_desconto').AsCurrency;
          qryItens.ParamByName('cd_tabela_preco').AsInteger := cdsPedidoVenda.FieldByName('cd_tabela_preco').AsInteger;
          qryItens.ParamByName('icms_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency;
          qryItens.ParamByName('icms_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('icms_pc_aliq').AsCurrency;
          qryItens.ParamByName('icms_valor').AsCurrency := cdsPedidoVenda.FieldByName('icms_valor').AsCurrency;
          qryItens.ParamByName('ipi_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency;
          qryItens.ParamByName('ipi_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsCurrency;
          qryItens.ParamByName('ipi_valor').AsCurrency := cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency;
          qryItens.ParamByName('pis_cofins_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency;
          qryItens.ParamByName('pis_cofins_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsCurrency;
          qryItens.ParamByName('pis_cofins_valor').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency;
          qryItens.ParamByName('un_medida').AsString := cdsPedidoVenda.FieldByName('un_medida').AsString;
          qryItens.ExecSQL;
          cdsPedidoVenda.Next;
        end;
      end;

      atualizaEstoqueProduto;

      dm.FDConnection1.Commit;
      dm.FDConnection1.Close;

      ShowMessage('Pedido ' + edtNrPedido.Text + ' Gravado Com Sucesso');
      limpaDados;

    except
      on E : exception do
      begin
        dm.FDConnection1.Rollback;
        ShowMessage('Erro ao gravar os dados do pedido ' + edtNrPedido.Text + E.Message);
        Exit;
      end;
    end;
  finally
    idGeral.Free;
    idGeralPvi.Free;
    qry.Free;
    qryItens.Free;
  end;
end;


procedure TfrmPedidoVenda.dbGridProdutosDblClick(Sender: TObject);
//carrega os itens para edi��o
begin
  edtCdProduto.Text := cdsPedidoVenda.FieldByName('cd_produto').AsString;
  edtDescProduto.Text := cdsPedidoVenda.FieldByName('descricao').AsString;
  edtQtdade.Text := cdsPedidoVenda.FieldByName('qtd_venda').AsString;
  edtCdtabelaPreco.Text := cdsPedidoVenda.FieldByName('cd_tabela_preco').AsString;
  edtUnMedida.Text := cdsPedidoVenda.FieldByName('un_medida').AsString;
  edtVlUnitario.Text := cdsPedidoVenda.FieldByName('vl_unitario').AsString;
  edtVlDescontoItem.Text := cdsPedidoVenda.FieldByName('vl_desconto').AsString;
  edtVlTotal.Text := cdsPedidoVenda.FieldByName('vl_total_item').AsString;
  edicaoItem := true;
end;

//Faz a linha zebrada no grid dos itens
procedure TfrmPedidoVenda.dbGridProdutosDrawColumnCell(Sender: TObject;
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

//excluir registro do grid
procedure TfrmPedidoVenda.dbGridProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if MessageDlg('Deseja excluir o item do pedido?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
    begin
      cdsPedidoVenda.Delete;
      edtCdProduto.SetFocus;
    end;
  end;
end;

//busca o cliente
procedure TfrmPedidoVenda.edtCdClienteChange(Sender: TObject);
const
  sql_cliente = 'select '+
                '   c.cd_cliente, '+
                '   c.nome, '+
                '   e.cidade, '+
                '   e.uf '+
                'from '+
                '   cliente c '+
                'join endereco_cliente e on '+
                '   c.cd_cliente = e.cd_cliente '+
                'where '+
                '   (c.cd_cliente = :cd_cliente) and '+
                '   (c.fl_ativo = true)';
var
  tempC, tempU: String;
  qry: TFDQuery;
begin
  if edtCdCliente.Text = EmptyStr then
  begin
    edtNomeCliente.Text := '';
    edtCidadeCliente.Text := '';
    Exit;
  end;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sql_cliente);
    qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
    qry.Open();

    edtNomeCliente.Text := qry.FieldByName('nome').AsString;
    tempC := qry.FieldByName('cidade').Text;
    tempU := qry.FieldByName('uf').Text;
    edtCidadeCliente.Text := Concat(tempC + '/' + tempU);
  finally
    qry.Free;
  end;
  end;

//valida se n�o foi encontrado nenhum cliente
procedure TfrmPedidoVenda.edtCdClienteExit(Sender: TObject);
var
  cliente: TPedidoVenda;
  resposta : Boolean;
begin
  cliente := TPedidoVenda.Create;
  resposta := cliente.ValidaCliente(StrToInt(edtCdCliente.Text));

  try
    if not resposta then
    begin
      if (Application.MessageBox('Cliente n�o encontrado ou Inativo','Aten��o', MB_OK) = idOK) then
      begin
        edtCdCliente.SetFocus;
      end;
    end;
  finally
    FreeAndNil(cliente);
  end;
end;

//busca a condi��o de pgto
procedure TfrmPedidoVenda.edtCdCondPgtoChange(Sender: TObject);
var
  condicao: TPedidoVenda;
  lista: TList<String>;
begin
  if edtCdCondPgto.Text = EmptyStr then
  begin
    edtNomeCondPgto.Text := '';
    Exit;
  end;

  condicao := TPedidoVenda.Create;
  lista := TList<string>.Create;

  try
    lista := condicao.BuscaCondicaoPgto(StrToInt(edtCdCondPgto.Text), StrToInt(edtCdFormaPgto.Text));
    edtNomeCondPgto.Text := lista.Items[0];
  finally
    FreeAndNil(condicao);
    FreeAndNil(lista);
  end;
end;

//valida se n�o foi encontrado nenhuma condi��o de pagamento
procedure TfrmPedidoVenda.edtCdCondPgtoExit(Sender: TObject);
var
  condPgto: TPedidoVenda;
  resposta : Boolean;
begin
  condPgto := TPedidoVenda.Create;
  resposta := condPgto.ValidaCondPgto(StrToInt(edtCdCondPgto.Text), StrToInt(edtCdFormaPgto.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Condi��o de pagamento n�o encontrada', 'Aten��o', MB_OK) = idOK) then
      begin
        edtCdCondPgto.SetFocus;
      end;
    end;
  finally
    FreeAndNil(condPgto);
  end;
end;

//busca a forma pgto
procedure TfrmPedidoVenda.edtCdFormaPgtoChange(Sender: TObject);
var
  forma: TPedidoVenda;
  lista: TList<String>;
begin
  forma := TPedidoVenda.Create;
  lista := TList<string>.Create;

  if edtCdFormaPgto.Text = EmptyStr then
  begin
    edtNomeFormaPgto.Text := '';
    Exit;
  end;

  try
    lista := forma.BuscaFormaPgto(StrToInt(edtCdFormaPgto.Text));
    edtNomeFormaPgto.Text := lista.Items[0];
  finally
    FreeAndNil(forma);
    FreeAndNil(lista);
  end;
end;

//valida se n�o foi encontrado nenhuma forma de pagamento
procedure TfrmPedidoVenda.edtCdFormaPgtoExit(Sender: TObject);
var
  formaPgto: TPedidoVenda;
  resposta : Boolean;
begin
  formaPgto := TPedidoVenda.Create;
  resposta := formaPgto.ValidaFormaPgto(StrToInt(edtCdFormaPgto.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Forma de Pagamento n�o encontrada', 'Aten��o', MB_OK) = idOK) then
        edtCdFormaPgto.SetFocus;
    end;
  finally
    FreeAndNil(formaPgto);
  end;
end;


procedure TfrmPedidoVenda.edtCdProdutoChange(Sender: TObject);
var
  produto: TPedidoVenda;
  lista: TList<String>;
begin
  produto := TPedidoVenda.Create;
  lista := TList<string>.Create;
  
  if edtCdProduto.Text = EmptyStr then
  begin
    edtDescProduto.Text := '';
    edtQtdade.Text := '';
    edtUnMedida.Text := '';
    edtCdtabelaPreco.Text := '';
    edtDescTabelaPreco.Text := '';
    edtVlUnitario.Text := '';
    Exit;
  end;

  try
    lista := produto.BuscaProduto(StrToInt(edtCdProduto.Text));

    //preenche os dados da lista nos campos

    edtDescProduto.Text := lista.Items[0];
    edtUnMedida.Text := lista.Items[1];
    edtCdtabelaPreco.Text := lista.Items[2];
    edtDescTabelaPreco.Text := lista.Items[3];
    edtVlUnitario.Text := lista.Items[4];
  finally
    FreeAndNil(produto);
    FreeAndNil(lista);
  end;
end;

procedure TfrmPedidoVenda.edtCdProdutoExit(Sender: TObject);
var
  produto: TPedidoVenda;
  resposta : Boolean;
begin
  produto := TPedidoVenda.Create;
  resposta := produto.ValidaProduto(StrToInt(edtCdCondPgto.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Produto sem pre�o Cadastrado ou Inativo!', 'Verifique', MB_OK) = idOK) then
      begin
        edtCdtabelaPreco.Text := '';
        edtCdProduto.SetFocus;
      end;
    end;
  finally
    FreeAndNil(produto);
  end;
end;

//busca a tabela de pre�o
procedure TfrmPedidoVenda.edtCdtabelaPrecoChange(Sender: TObject);
var
  tabela: TPedidoVenda;
  lista: TList<String>;
begin
  tabela := TPedidoVenda.Create;
  lista := TList<string>.Create;

  if edtCdtabelaPreco.Text = EmptyStr then
  begin
    edtDescTabelaPreco.Text := '';
    edtVlUnitario.Text := '';
    Exit;
  end;

  try
    lista := tabela.BuscaTabelaPreco(StrToInt(edtCdtabelaPreco.Text), StrToInt(edtCdProduto.Text));

    edtDescTabelaPreco.Text:= lista.Items[0];
    edtVlUnitario.Text := lista.Items[1];
  finally
    FreeAndNil(tabela);
    FreeAndNil(lista);
  end;
end;

procedure TfrmPedidoVenda.edtCdtabelaPrecoExit(Sender: TObject);
var
  valor_total, vl_unitario, qtdade : Currency;
  tabela: TPedidoVenda;
  resposta : Boolean;
begin
  tabela := TPedidoVenda.Create;
  resposta := tabela.ValidaTabelaPreco(StrToInt(edtCdtabelaPreco.Text), StrToInt(edtCdProduto.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Tabela de Pre�o n�o encontrada', 'Aten��o', MB_OK) = idOK) then
      begin
        edtCdtabelaPreco.SetFocus;
      end;
    end
    else
    begin
      //recalcula o valor total do item ao alterar a tabela de pre�o
      //fazer function na uclpedidovenda
      vl_unitario := StrToCurr(edtVlUnitario.Text);
      qtdade := StrToCurr(edtQtdade.Text);
      valor_total := qtdade * vl_unitario;
      edtVlTotal.Text := CurrToStr(valor_total);
      edtVlDescontoItem.Enabled := true;
    end;
  finally
    FreeAndNil(tabela);
  end;
end;

//calcula o valor total do item ao alterar a quantidade
procedure TfrmPedidoVenda.edtQtdadeChange(Sender: TObject);
var pv: TPedidoVenda;
valorTotal: Double;
begin
  pv := TPedidoVenda.Create;

  try
    if edtQtdade.Text = EmptyStr then
    begin
      edtVlTotal.Text := '';
      Exit;
    end
    else
    begin
      valorTotal := pv.CalcValorTotalItem(StrToFloat(edtVlUnitario.Text), StrToFloat(edtQtdade.Text));
      edtVlTotal.Text := FloatToStr(valorTotal);
      edtVlDescontoItem.Enabled := true;
    end;
  finally
    FreeAndNil(pv);
  end;
end;


procedure TfrmPedidoVenda.edtQtdadeExit(Sender: TObject);
var
  ValidaQtdade : TPedidoVenda;
  resposta : Boolean;
begin
  ValidaQtdade := TPedidoVenda.Create;
  resposta := ValidaQtdade.ValidaQtdadeItem(StrToInt(edtCdProduto.Text), StrToFloat(edtQtdade.Text));

  try
    if edtQtdade.Text = '0' then
    begin
      ShowMessage('Informe uma quantidade maior que 0');
      edtCdProduto.SetFocus;
    end;

    if resposta then
    begin
      ShowMessage('Quantidade informada maior que a dispon�vel.');
      //+ #13 +'Quantidade dispon�vel: ' + FloatToStr(qtdade));
      edtQtdade.SetFocus;
      Exit;
    end;
  finally
    FreeAndNil(ValidaQtdade);
  end;
end;


procedure TfrmPedidoVenda.edtVlAcrescimoTotalPedidoExit(Sender: TObject);
//recalcula o valor total se informado um valor de acrescimo no total do pedido
var
  vl_total_com_acrescimo, vl_acrescimo,
  vl_total_pedido, valor_total, valor_desconto : Currency;
begin
  try
    cdsPedidoVenda.DisableControls;

    if (edtVlAcrescimoTotalPedido.Text = '0') or (edtVlAcrescimoTotalPedido.Text = '0,00') then
    begin
      edtVlAcrescimoTotalPedido.Text := CurrToStr(0);
      valor_total := 0;

      with cdsPedidoVenda do
      begin
        cdsPedidoVenda.First;
        while not cdsPedidoVenda.Eof do
        begin
          valor_total := (valor_total + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
          cdsPedidoVenda.Next;
        end;
        edtVlTotalPedido.Text := CurrToStr(valor_total);
      end;
    end
    else
    begin
      valor_desconto := StrToCurr(edtVlDescTotalPedido.Text); //desconto no total do pedido
      vl_total_pedido := 0;
      vl_acrescimo := StrToCurr(edtVlAcrescimoTotalPedido.Text);

      cdsPedidoVenda.DisableControls;
      with cdsPedidoVenda do
      begin
        cdsPedidoVenda.First;
        while not cdsPedidoVenda.Eof do
        begin
          vl_total_pedido := (vl_total_pedido + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
          cdsPedidoVenda.Next;
        end;
      end;

      vl_total_com_acrescimo := (vl_total_pedido + vl_acrescimo) - valor_desconto;
      edtVlTotalPedido.Text := CurrToStr(vl_total_com_acrescimo);
    end;
  finally
    cdsPedidoVenda.EnableControls;
  end;
end;

//altera o valor total ao sair do campo de desconto
procedure TfrmPedidoVenda.edtVlDescontoItemExit(Sender: TObject);
var vl_desconto, vl_total, vl_total_com_desc : Currency;
begin
  if edtVlDescontoItem.Text = EmptyStr then
  begin
    edtVlDescontoItem.Text := '0,00';
  end
  else
  begin
    vl_desconto := StrToCurr(edtVlDescontoItem.Text);
    vl_total := StrToCurr(edtVlTotal.Text);
    vl_total_com_desc := vl_total - vl_desconto;
    edtVlTotal.Text := CurrToStr(vl_total_com_desc);
    edtVlDescontoItem.Enabled := false;
  end;
end;

//recalcula o valor total se informado um valor de desconto no total do pedido
procedure TfrmPedidoVenda.edtVlDescTotalPedidoExit(Sender: TObject);
var
  vl_total_com_desconto, vl_desconto, vl_total_pedido, valor_total : Currency;
begin
  if (edtVlDescTotalPedido.Text = '0') or (edtVlDescTotalPedido.Text = '0,00') then
  begin
    edtVlDescTotalPedido.Text := CurrToStr(0);
    valor_total := 0;
    //soma os valores totais dos itens
    with cdsPedidoVenda do
    begin
      cdsPedidoVenda.DisableControls;
      cdsPedidoVenda.First;
      while not cdsPedidoVenda.Eof do
      begin
        valor_total := (valor_total + cdsPedidoVenda.FieldByName('Valor Total').AsCurrency);
        cdsPedidoVenda.Next;
      end;
      edtVlTotalPedido.Text := CurrToStr(valor_total);
      cdsPedidoVenda.EnableControls;
    end;
  end
  else
  begin
    vl_total_pedido := 0;
    vl_desconto := StrToCurr(edtVlDescTotalPedido.Text);
    with cdsPedidoVenda do
    begin
      cdsPedidoVenda.DisableControls;
      cdsPedidoVenda.First;
      while not cdsPedidoVenda.Eof do
      begin
        vl_total_pedido := (vl_total_pedido + cdsPedidoVenda.FieldByName('Valor Total').AsCurrency);
        cdsPedidoVenda.Next;
      end;
      //edtVlTotalPedido.Text := CurrToStr(valor_total);
      cdsPedidoVenda.EnableControls;
    end;
    vl_total_com_desconto := vl_total_pedido - vl_desconto;
    edtVlTotalPedido.Text := CurrToStr(vl_total_com_desconto);
  end;
end;

//seta a data atual na data de emiss�o
procedure TfrmPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmPedidoVenda := nil;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  edtDataEmissao.Text := DateToStr(Date());
end;

procedure TfrmPedidoVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Fechar?','Aten��o', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
end;

procedure TfrmPedidoVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;


function TfrmPedidoVenda.GeraNumeroPedido: Int8;
const
  sqlNrPedido = 'select '+
                '*  '+
                'from func_nr_pedido()';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(sqlNrPedido);
    qry.Open(sqlNrPedido);

    Result := qry.FieldByName('func_nr_pedido').AsLargeInt;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.limpaCampos;
begin
  edtCdProduto.Clear;
  edtDescProduto.Clear;
  edtQtdade.Clear;
  edtCdtabelaPreco.Clear;
  edtUnMedida.Clear;
  edtVlUnitario.Clear;
  edtVlDescontoItem.Clear;
  edtVlTotal.Clear;
  edtCdProduto.SetFocus;
  edtVlDescTotalPedido.Text := '0,00';
  edtVlAcrescimoTotalPedido.Text := '0,00';
end;
procedure TfrmPedidoVenda.limpaDados;
begin
  edtNrPedido.Clear;
  edtCdCliente.Clear;
  edtNomeCliente.Clear;
  edtCidadeCliente.Clear;
  edtCdFormaPgto.Clear;
  edtNomeFormaPgto.Clear;
  edtCdCondPgto.Clear;
  edtNomeCondPgto.Clear;
  edtVlDescTotalPedido.Clear;
  edtVlAcrescimoTotalPedido.Clear;
  edtVlTotalPedido.Clear;
  dbGridProdutos.DataSource := nil;
end;

function TfrmPedidoVenda.ProdutoJaLancado(CodProduto: Integer): Boolean;
begin
  Result := False;

  if cdsPedidoVenda.Locate('cd_produto', VarArrayOf([CodProduto]), []) then
    Result := True;
end;

end.