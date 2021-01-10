unit uPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, Vcl.Mask,
  Vcl.ComCtrls, System.Generics.Collections, {JvExStdCtrls, JvBehaviorLabel}
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc;

type
  TfrmPedidoVenda = class(TForm)
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
    intgrfldPedidoVendaseq: TIntegerField;
    document: TXMLDocument;
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
    procedure edtCdProdutoEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbGridProdutosTitleClick(Column: TColumn);
  private
    edicaoItem: Boolean;
    FNumeroPedido: Integer;
    FFIdGeral: Int64;
    { Private declarations }
    procedure SetFIdGeral(const Value: Int64);
  public
    { Public declarations }

    procedure limpaCampos;
    procedure limpaDados;
    procedure atualizaEstoqueProduto;
    function ProdutoJaLancado(CodProduto: Integer): Boolean;
    function RetornaSequencia: Integer;
    procedure AlteraSequenciaItem;
    procedure SalvaCabecalho;

    procedure SalvaItens(EhEdicao: Boolean);
    procedure setDadosNota;
    procedure cancelaPedidoVenda;
    procedure InsereWmsMvto;
    function getNumeroParcelas(CdCondPgto: Integer): Integer;
    procedure CarregaItensEdicao;

    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property FIdGeral: Int64 read FFIdGeral write SetFIdGeral;
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;
  seqItem: Integer = 1;

implementation

uses
  uclPedidoVenda, uDataModule, uGerador, uConfiguracoes, uUtil;

{$R *.dfm}


procedure TfrmPedidoVenda.AlteraSequenciaItem;
//ajusta a sequencia do item no pedido de venda
var
  i: Integer;
begin
  cdsPedidoVenda.First;
  
  for i := 1 to cdsPedidoVenda.RecordCount do
  begin
    if cdsPedidoVenda.FieldByName('seq').AsInteger <> i then
    begin
      cdsPedidoVenda.Edit;
      cdsPedidoVenda.FieldByName('seq').AsInteger := i;     
    end;
    cdsPedidoVenda.Next;  
  end;
end;

procedure TfrmPedidoVenda.atualizaEstoqueProduto;
const
  sql_update = 'update '+
                    'wms_estoque '+
              'set '+
                    'qt_estoque = :qt_estoque '+
              'where id_wms_endereco_produto = :id';

  sql_select = 'select ' +
                  'qt_estoque, ' +
                  'id_wms_endereco_produto ' +
              'from ' +
                  'wms_estoque ' +
              'where ' +
                  'cd_produto = :cd_produto';
var
  qry: TFDQuery;
  qtdade, qttotal: Double;
  id: Int64;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      cdsPedidoVenda.DisableControls;
      cdsPedidoVenda.First;
      while not cdsPedidoVenda.Eof do
      begin
        qry.SQL.Clear;
        qry.SQL.Add(sql_select);
        qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
        qry.Open(sql_select);
        id := qry.FieldByName('id_wms_endereco_produto').AsInteger;
        qtdade := qry.FieldByName('qt_estoque').AsFloat;//quantidade no banco
        qttotal := qtdade - cdsPedidoVenda.FieldByName('qtd_venda').AsInteger; //diminui com a informada no pedido

        qry.SQL.Clear;

        qry.SQL.Add(sql_update);
        qry.ParamByName('id').AsInteger := id;
        qry.ParamByName('qt_estoque').AsFloat := qttotal;

        qry.ExecSQL;
        cdsPedidoVenda.Next;
      end;
      qry.Connection.Commit;
    except
    on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do produto ' + cdsPedidoVenda.FieldByName('cd_produto').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
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
  qry.Connection := dm.conexaoBanco;
  lancaProduto := TfrmConfiguracoes.Create(Self);
  try
    qry.Close;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
    qry.Open(sql);

    if ProdutoJaLancado(StrToInt(edtCdProduto.Text))
      and (lancaProduto.cbbLancaItemPedido.ItemIndex = 1) and (not edicaoItem) then
      raise Exception.Create('O produto já está lançado');

    aliq_icms := qry.FieldByName('aliquota_icms').AsCurrency;
    aliq_ipi := qry.FieldByName('aliquota_ipi').AsCurrency;
    aliq_pis_cofins := qry.FieldByName('aliquota_pis_cofins').AsCurrency;

    if edicaoItem then
    begin
      try
        cdsPedidoVenda.Edit;//entra em modo de edição
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
        cdsPedidoVenda.Post;
        SalvaItens(edicaoItem);
      finally
        edicaoItem := False;
      end;
    end
    else
    begin
      RetornaSequencia;
      cdsPedidoVenda.Append;
      cdsPedidoVenda.FieldByName('seq').AsInteger := seqItem;
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
      SalvaItens(edicaoItem);
    end;

    //soma os valores totais dos itens e preenche o valor total do pedido
    vl_total_itens := 0;

    cdsPedidoVenda.Loop(
    procedure
    begin
      vl_total_itens := (vl_total_itens + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
    end);

    edtVlTotalPedido.Text := CurrToStr(vl_total_itens);

    seqItem := seqItem + 1;

    edtQtdade.Text := '0';
  finally
    limpaCampos;
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente Cancelar o pedido?','Atenção', MB_YESNO) = IDYES) then
  begin
    cancelaPedidoVenda;
    limpaDados;
  end;
end;

//grava os dados na pedido_venda e pedido_venda_item
procedure TfrmPedidoVenda.btnConfirmarPedidoClick(Sender: TObject);
const
  SQL_UPDATE_CABECALHO = 'update pedido_venda set cd_cliente = :cd_cliente,  '+
                         ' cd_forma_pag = :cd_forma_pag, cd_cond_pag = :cd_cond_pag, vl_desconto_pedido = :vl_desconto_pedido,   '+
                         ' vl_acrescimo = :vl_acrescimo, vl_total = :vl_total, fl_orcamento = :fl_orcamento, dt_emissao = :dt_emissao,'+
                         ' fl_cancelado = :fl_cancelado where nr_pedido = :nr_pedido';
var
  Tempo : Integer;
  qry: TFDQuery;
  idGeral, idGeralPvi: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  idGeral := TGerador.Create;
  idGeralPvi := TGerador.Create;
  try
    try
      qry.SQL.Add(SQL_UPDATE_CABECALHO);
      qry.ParamByName('nr_pedido').AsInteger := NumeroPedido;
      qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
      qry.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
      qry.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
      qry.ParamByName('vl_desconto_pedido').AsCurrency := StrToCurr(edtVlDescTotalPedido.Text);
      qry.ParamByName('vl_acrescimo').AsCurrency := StrToCurr(edtVlAcrescimoTotalPedido.Text);
      qry.ParamByName('vl_total').AsCurrency := StrToCurr(edtVlTotalPedido.Text);
      qry.ParamByName('fl_orcamento').AsBoolean := edtFl_orcamento.Checked;
      qry.ParamByName('dt_emissao').AsDate := StrToDate(edtDataEmissao.Text);
      qry.ParamByName('fl_cancelado').AsString := 'N';
      qry.ExecSQL;

      AlteraSequenciaItem;
      
      //insert na pedido_venda_item

      cdsPedidoVenda.Loop(
      procedure
      begin
        SalvaItens(True);
      end);

      //fazer o insert na wms_mvto_estoque
      InsereWmsMvto;
      atualizaEstoqueProduto;

      //setDadosNota;

      qry.Connection.Commit;

      ShowMessage('Pedido ' + edtNrPedido.Text + ' Gravado Com Sucesso');
      limpaDados;
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do pedido ' + edtNrPedido.Text + E.Message);
        Exit;
      end;
    end;
  finally
    cdsPedidoVenda.EnableControls;
    idGeral.Free;
    idGeralPvi.Free;
    qry.Free;
  end;
end;


procedure TfrmPedidoVenda.cancelaPedidoVenda;
const
  SQL = 'update pedido_venda set fl_cancelado = ''S'' where nr_pedido = :nr_pedido';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('nr_pedido').AsInteger := NumeroPedido;
      qry.ExecSQL;
      qry.Connection.Commit;

    except on E:Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao cancelar o pedido ' + NumeroPedido.ToString + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.CarregaItensEdicao;
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

procedure TfrmPedidoVenda.dbGridProdutosDblClick(Sender: TObject);
//carrega os itens para edição
begin
  CarregaItensEdicao;
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
const
  SQL_DELETE = 'delete from pedido_venda_item where cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir o item do pedido?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
      begin
        try
          qry.SQL.Add(SQL_DELETE);
          qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
          qry.ExecSQL;
          qry.Connection.Commit;
          cdsPedidoVenda.Delete;
          edtCdProduto.SetFocus;
          seqItem := seqItem - 1;
        except
        on E : exception do
          begin
            qry.Connection.Rollback;
            ShowMessage('Erro ao excluir o item do pedido ' + E.Message);
            Exit;
          end;
        end;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.dbGridProdutosTitleClick(Column: TColumn);
var
  sIndexName: string;
  oOrdenacao: TIndexOptions;
  i: smallint;
begin
  // retira a formatação em negrito de todas as colunas
  for i := 0 to dbGridProdutos.Columns.Count - 1 do
    dbGridProdutos.Columns[i].Title.Font.Style := [];

  // configura a ordenação ascendente ou descendente
  if cdsPedidoVenda.IndexName = Column.FieldName + '_ASC' then
  begin
    sIndexName := Column.FieldName + '_DESC';
    oOrdenacao := [ixDescending];
  end
  else
  begin
    sIndexName := Column.FieldName + '_ASC';
    oOrdenacao := [];
  end;

  // adiciona a ordenação no DataSet, caso não exista
  if cdsPedidoVenda.IndexDefs.IndexOf(sIndexName) < 0 then
    cdsPedidoVenda.AddIndex(sIndexName, Column.FieldName, oOrdenacao);

  cdsPedidoVenda.IndexDefs.Update;

  // formata o título da coluna em negrito
  Column.Title.Font.Style := [fsBold];

  // atribui a ordenação selecionada
  cdsPedidoVenda.IndexName := sIndexName;

  cdsPedidoVenda.First;
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
  qry.Connection := dm.conexaoBanco;

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

//valida se não foi encontrado nenhum cliente
procedure TfrmPedidoVenda.edtCdClienteExit(Sender: TObject);
var
  cliente: TPedidoVenda;
  resposta : Boolean;
begin
  if not edtCdCliente.isEmpty then
  begin
    cliente := TPedidoVenda.Create;
    resposta := cliente.ValidaCliente(StrToInt(edtCdCliente.Text));

    try
      if not resposta then
      begin
        if (Application.MessageBox('Cliente não encontrado ou Inativo','Atenção', MB_OK) = idOK) then
          edtCdCliente.SetFocus;
      end;
    finally
      FreeAndNil(cliente);
    end;
  end;
end;

//busca a condição de pgto
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

//valida se não foi encontrado nenhuma condição de pagamento
procedure TfrmPedidoVenda.edtCdCondPgtoExit(Sender: TObject);
var
  condPgto: TPedidoVenda;
  resposta : Boolean;
begin
  if not edtCdCondPgto.isEmpty then
  begin
    condPgto := TPedidoVenda.Create;
    resposta := condPgto.ValidaCondPgto(StrToInt(edtCdCondPgto.Text), StrToInt(edtCdFormaPgto.Text));

    try
      if resposta then
      begin
        if (Application.MessageBox('Condição de pagamento não encontrada', 'Atenção', MB_OK) = idOK) then
          edtCdCondPgto.SetFocus;
      end;
    finally
      FreeAndNil(condPgto);
    end;
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

//valida se não foi encontrado nenhuma forma de pagamento
procedure TfrmPedidoVenda.edtCdFormaPgtoExit(Sender: TObject);
var
  formaPgto: TPedidoVenda;
  resposta : Boolean;
begin
  if not edtCdFormaPgto.isEmpty then
  begin
    formaPgto := TPedidoVenda.Create;
    resposta := formaPgto.ValidaFormaPgto(StrToInt(edtCdFormaPgto.Text));

    try
      if resposta then
      begin
        if (Application.MessageBox('Forma de Pagamento não encontrada', 'Atenção', MB_OK) = idOK) then
          edtCdFormaPgto.SetFocus;
      end;
    finally
      FreeAndNil(formaPgto);
    end;
  end;
end;


procedure TfrmPedidoVenda.edtCdProdutoChange(Sender: TObject);
begin
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
end;

procedure TfrmPedidoVenda.edtCdProdutoEnter(Sender: TObject);
const
  SQL = 'select nr_pedido from pedido_venda where nr_pedido = :nr_pedido';
var
  qry:TFDQuery;
  geraNrPedido: TGerador;
begin
  inherited;
  geraNrPedido := TGerador.Create;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    if edtNrPedido.Text = '' then
    begin
      NumeroPedido := geraNrPedido.GeraNumeroPedido;
      edtNrPedido.Text := NumeroPedido.ToString;
    end;

    qry.SQL.Add(SQL);
    qry.ParamByName('nr_pedido').AsInteger := NumeroPedido;
    qry.Open();

    if qry.FieldByName('nr_pedido').AsInteger <> NumeroPedido then
      SalvaCabecalho;

  finally
    qry.Free
  end;
end;

procedure TfrmPedidoVenda.edtCdProdutoExit(Sender: TObject);
var
  produto: TPedidoVenda;
  resposta: Boolean;
  lista: TList<String>;
begin
  produto := TPedidoVenda.Create;
  resposta := False;
  lista := TList<string>.Create;

  try
    if edtCdProduto.Text <> '' then
      resposta := produto.ValidaProduto(StrToInt(edtCdProduto.Text));

    if (Trim(edtCdProduto.Text) = '') and (cdsPedidoVenda.RecordCount > 0) then
    begin
      edtVlDescTotalPedido.SetFocus;
      Exit;
    end;

    if not resposta then
    begin
      if (Application.MessageBox('Produto sem preço Cadastrado ou Inativo!', 'Verifique', MB_OK) = idOK) then
      begin
        edtCdtabelaPreco.Text := '';
        edtCdProduto.SetFocus;
        Exit;
      end;
    end;

    //preenche os dados da lista nos campos
    if produto.isCodBarrasProduto(edtCdProduto.Text) then
    begin
      lista := produto.BuscaProduto(edtCdProduto.Text);
      edtCdProduto.Text := lista.Items[0];
      edtDescProduto.Text := lista.Items[1];
      edtUnMedida.Text := lista.Items[2];
      edtCdtabelaPreco.Text := lista.Items[3];
      edtDescTabelaPreco.Text := lista.Items[4];
      edtVlUnitario.Text := lista.Items[5];
    end
    else
    begin
      lista := produto.BuscaProduto(StrToInt(edtCdProduto.Text));
      edtDescProduto.Text := lista.Items[0];
      edtUnMedida.Text := lista.Items[1];
      edtCdtabelaPreco.Text := lista.Items[2];
      edtDescTabelaPreco.Text := lista.Items[3];
      edtVlUnitario.Text := lista.Items[4];
    end;

  finally
    FreeAndNil(produto);
    FreeAndNil(lista);
  end;
end;

//busca a tabela de preço
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

    edtDescTabelaPreco.Text := lista.Items[0];
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
  if not edtCdtabelaPreco.isEmpty then
  begin
    tabela := TPedidoVenda.Create;
    resposta := tabela.ValidaTabelaPreco(StrToInt(edtCdtabelaPreco.Text), StrToInt(edtCdProduto.Text));

    try
      if resposta then
      begin
        if (Application.MessageBox('Tabela de Preço não encontrada', 'Atenção', MB_OK) = idOK) then
          edtCdtabelaPreco.SetFocus;
      end
      else
      begin
        //recalcula o valor total do item ao alterar a tabela de preço
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
end;

//calcula o valor total do item ao alterar a quantidade
procedure TfrmPedidoVenda.edtQtdadeChange(Sender: TObject);
var
  pv: TPedidoVenda;
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
      valorTotal := pv.CalculaValorTotalItem(StrToFloat(edtVlUnitario.Text), StrToFloat(edtQtdade.Text));
      edtVlTotal.Text := FloatToStr(valorTotal);
      edtVlDescontoItem.Enabled := true;
    end;
  finally
    FreeAndNil(pv);
  end;
end;


procedure TfrmPedidoVenda.edtQtdadeExit(Sender: TObject);
var
  qtdadeEstoque : TPedidoVenda;
  possuiEstoque : Boolean;
begin
  qtdadeEstoque := TPedidoVenda.Create;
  possuiEstoque := qtdadeEstoque.ValidaQtdadeItem(StrToInt(edtCdProduto.Text), StrToFloat(edtQtdade.Text));

  try
    if edtQtdade.Text = '0' then
    begin
      ShowMessage('Informe uma quantidade maior que 0');
      edtQtdade.SetFocus;
    end;

    if not possuiEstoque then
    begin
      edtQtdade.SetFocus;
      Exit;
    end;
  finally
    FreeAndNil(qtdadeEstoque);
  end;
end;


procedure TfrmPedidoVenda.edtVlAcrescimoTotalPedidoExit(Sender: TObject);
//recalcula o valor total se informado um valor de acrescimo no total do pedido
var
  vl_acrescimo,
  vl_total_pedido: Currency;
begin
  vl_acrescimo := StrToCurr(edtVlAcrescimoTotalPedido.Text);
  vl_total_pedido := StrToCurr(edtVlTotalPedido.Text);
  edtVlTotalPedido.Text := CurrToStr(vl_total_pedido + vl_acrescimo);
end;

//altera o valor total ao sair do campo de desconto
procedure TfrmPedidoVenda.edtVlDescontoItemExit(Sender: TObject);
var
  vlDesconto, vlUnitario,
  vlTotalComDesc: Currency;
  qtd: Double;
begin
  if edtVlDescontoItem.Text = EmptyStr then
    edtVlDescontoItem.Text := '0,00'
  else
  begin
    vlDesconto := StrToCurr(edtVlDescontoItem.Text);
    vlUnitario := StrToCurr(edtVlUnitario.Text);
    qtd := StrToFloat(edtQtdade.Text);
    vlTotalComDesc := (vlUnitario * qtd) - vlDesconto;
    edtVlTotal.Text := CurrToStr(vlTotalComDesc);
  end;
end;

//recalcula o valor total se informado um valor de desconto no total do pedido
procedure TfrmPedidoVenda.edtVlDescTotalPedidoExit(Sender: TObject);
var
  vl_desconto, vl_total_pedido, valor_total : Currency;
begin
  if not edtVlDescTotalPedido.isEmpty then
  begin
    if (edtVlDescTotalPedido.Text = '0') or (edtVlDescTotalPedido.Text = '0,00') then
    begin
      edtVlDescTotalPedido.Text := CurrToStr(0);
      valor_total := 0;

      //soma os valores totais dos itens
      cdsPedidoVenda.Loop(
        procedure
        begin
          valor_total := (valor_total + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
        end
      );

      edtVlTotalPedido.Text := CurrToStr(valor_total);
    end
    else
    begin
      vl_total_pedido := 0;

      vl_desconto := StrToCurr(FormatCurr('#,##0.00', StrToCurr(edtVlDescTotalPedido.Text)));

      cdsPedidoVenda.Loop(
        procedure
        begin
          vl_total_pedido := (vl_total_pedido + cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency);
        end
      );

      edtVlTotalPedido.Text := CurrToStr(vl_total_pedido - vl_desconto);
    end;
  end;
end;

//seta a data atual na data de emissão
procedure TfrmPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmPedidoVenda := nil;
end;

procedure TfrmPedidoVenda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if (edtNrPedido.Text <> '') or (cdsPedidoVenda.RecordCount > 0) then
  begin
    CanClose := False;
    if (Application.MessageBox('Deseja Cancelar o Pedido?','Atenção', MB_YESNO) = IDYES) then
    begin
      cancelaPedidoVenda;
      CanClose := True;
    end;
  end;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
  edtDataEmissao.Text := DateToStr(Date());
  seqItem := 1;
end;

procedure TfrmPedidoVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (edtNrPedido.Text = '') and (cdsPedidoVenda.RecordCount = 0) then
    begin
      if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
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


function TfrmPedidoVenda.getNumeroParcelas(CdCondPgto: Integer): Integer;
const
  SQL = 'select ' +
        ' nr_parcelas ' +
        'from              ' +
        '    cta_cond_pagamento ' +
        'where cd_cond_pag = :cd_cond_pag';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_cond_pag').AsInteger := CdCondPgto;
    qry.Open();
    Result := qry.FieldByName('nr_parcelas').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.InsereWmsMvto;
const
  SQL_INSERT =  'insert into ' +
                'wms_mvto_estoque(id_geral, '+
                'id_endereco_produto, '+
                'cd_produto, ' +
                'qt_estoque, ' +
                'un_estoque, ' +
                'fl_entrada_saida) values '+
                '(:id_geral, ' +
                ':id_endereco_produto, '+
                ':cd_produto, ' +
                ':qt_estoque, ' +
                ':un_estoque, ' +
                ':fl_entrada_saida)';

  SQL_SELECT = 'select ' +
               '   id_geral ' +
               'from        ' +
               '   wms_endereco_produto w    ' +
               'where                        ' +
               '   cd_produto = :cd_produto  ' +
               '   and ordem = (             ' +
               '   select                    ' +
               '       min(ordem)            ' +
               '   from                      ' +
               '       wms_endereco_produto wep ' +
               '   where                        ' +
               '       cd_produto = :cd_produto)';
var
  qry, qrySelect: TFDQuery;
  IdGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qrySelect := TFDQuery.Create(Self);
  qrySelect.Connection := dm.conexaoBanco;
  IdGeral := TGerador.Create;
  try
    try
      cdsPedidoVenda.Loop(
        procedure
        begin
          qrySelect.SQL.Clear;
          qrySelect.SQL.Add(SQL_SELECT);
          qrySelect.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
          qrySelect.Open(SQL_SELECT);

          qry.SQL.Clear;
          qry.SQL.Add(SQL_INSERT);
          qry.ParamByName('id_geral').AsFloat := IdGeral.GeraIdGeral;
          qry.ParamByName('id_endereco_produto').AsInteger := qrySelect.FieldByName('id_geral').AsInteger;
          qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
          qry.ParamByName('qt_estoque').AsFloat := cdsPedidoVenda.FieldByName('qtd_venda').AsFloat;
          qry.ParamByName('un_estoque').AsString := cdsPedidoVenda.FieldByName('un_medida').AsString;
          qry.ParamByName('fl_entrada_saida').AsString := 'S';

          qry.ExecSQL;
        end
      );
      dm.conexaoBanco.Commit;
    except
      on e:Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do movimento do produto ' + IntToStr(cdsPedidoVenda.FieldByName('cd_produto').AsInteger) + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
    qrySelect.Free;
  end;
end;

procedure TfrmPedidoVenda.setDadosNota;
const
  SQL = 'select * from vcliente where cd_cliente = :cd_cliente';
var
  i, j, nrParcelas: Integer;
  venda, cabecalho,
  cliente, endCliente,
  itens, pagamento,
  impostoItem, parcelas: IXMLNode;
  qry: TFDQuery;
  valorTotal: Currency;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  document.Active := True;
  i := 1;
  try
    valorTotal := StrToCurr(edtVlTotalPedido.Text);
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
    qry.Open(SQL);
    document.Version := '1.0';
    document.Encoding := 'UTF-8';

    venda := document.AddChild('venda');

    cabecalho := venda.AddChild('cabecalho');
    cabecalho.AddChild('nNota').Text := edtNrPedido.Text;
    cabecalho.AddChild('dtEmissao').Text := DateToStr(now);

    cliente := cabecalho.AddChild('cliente');
    cliente.AddChild('nome').Text := qry.FieldByName('nome').AsString;
    cliente.AddChild('CPF_CNPJ').Text := qry.FieldByName('cpf_cnpj').AsString;
    cliente.AddChild('RG_IE').Text := qry.FieldByName('rg_ie').AsString;

    endCliente := cliente.AddChild('enderCliente');
    endCliente.AddChild('rua').Text := qry.FieldByName('logradouro').AsString;
    endCliente.AddChild('bairro').Text := qry.FieldByName('bairro').AsString;
    endCliente.AddChild('cidade').Text := qry.FieldByName('cidade').AsString;
    endCliente.AddChild('cep').Text := qry.FieldByName('cep').AsString;
    endCliente.AddChild('email').Text := qry.FieldByName('email').AsString;
    endCliente.AddChild('fone').Text := qry.FieldByName('fone').AsString;

    cdsPedidoVenda.DisableControls;
    cdsPedidoVenda.First;
    while not cdsPedidoVenda.Eof do
    begin
      itens := venda.AddChild('item');
      itens.Attributes['numero'] := i;
      itens.AddChild('cProd').Text := cdsPedidoVenda.FieldByName('cd_produto').AsString;
      itens.AddChild('descricao').Text := cdsPedidoVenda.FieldByName('descricao').AsString;
      itens.AddChild('uUN').Text := cdsPedidoVenda.FieldByName('un_medida').AsString;
      itens.AddChild('qtVenda').Text := cdsPedidoVenda.FieldByName('qtd_venda').AsString;
      itens.AddChild('vlUni').Text := cdsPedidoVenda.FieldByName('vl_unitario').AsString;
      if cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency > 0 then
      begin
        impostoItem := itens.AddChild('impostoItem');
        impostoItem.AddChild('vBaseIcms').Text := FormatCurr('#,##0.00', cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency);
        impostoItem.AddChild('icmsAliq').Text := cdsPedidoVenda.FieldByName('icms_pc_aliq').AsString;
        impostoItem.AddChild('vIcms').Text := FormatCurr('#,##0.00', cdsPedidoVenda.FieldByName('icms_valor').AsCurrency);
      end;
      cdsPedidoVenda.Next;
      Inc(i);
    end;

    nrParcelas := getNumeroParcelas(StrToInt(edtCdCondPgto.Text));
    pagamento := venda.AddChild('pagamento');
    pagamento.AddChild('fPag').Text := edtNomeFormaPgto.Text;
    pagamento.AddChild('cPag').Text := edtNomeCondPgto.Text;
    pagamento.AddChild('vTotal').Text := edtVlTotalPedido.Text;

    if nrParcelas > 0 then
    begin
      parcelas := pagamento.AddChild('parcelas');
      for j := 1 to nrParcelas do
      begin
        parcelas.AddChild('nParcela').Text := j.ToString;
        parcelas.AddChild('vlrParcela').Text := FormatCurr('#,##0.00', (valorTotal / nrParcelas));
      end;
    end;

    document.SaveToFile('C:\Users\jovio\Documents\xml\notafiscal' + edtNrPedido.Text + '.xml');
  finally
    qry.Free;
    cdsPedidoVenda.EnableControls;
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
  cdsPedidoVenda.EmptyDataSet;
end;

function TfrmPedidoVenda.ProdutoJaLancado(CodProduto: Integer): Boolean;
begin
  Result := False;

  if cdsPedidoVenda.Locate('cd_produto', VarArrayOf([CodProduto]), []) then
    Result := True;
end;

function TfrmPedidoVenda.RetornaSequencia: Integer;
begin

  cdsPedidoVenda.Loop(
    procedure
    begin
      if cdsPedidoVenda.FieldByName('seq').AsInteger = seqItem then
        seqItem := seqItem + 1;
    end
  );

  Result := seqItem;
end;

procedure TfrmPedidoVenda.SalvaCabecalho;
const
  sql_Insert_pedido =
  'insert ' +
  '    into ' +
  'pedido_venda (id_geral, nr_pedido, cd_cliente, cd_forma_pag, cd_cond_pag, vl_desconto_pedido, '+
  '              vl_acrescimo, vl_total, fl_orcamento, dt_emissao, fl_cancelado) ' +
  'values (:id_geral, :nr_pedido, :cd_cliente, :cd_forma_pag, :cd_cond_pag, :vl_desconto_pedido, '+
  '        :vl_acrescimo, :vl_total, :fl_orcamento, :dt_emissao, :fl_cancelado)';
var
  qry: TFDQuery;
  idGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  idGeral := TGerador.Create;

  try
    FIdGeral := idGeral.GeraIdGeral;

    try
      //insert na pedido_venda
      qry.SQL.Add(sql_Insert_pedido);
      qry.ParamByName('id_geral').AsInteger := FIdGeral;
      qry.ParamByName('nr_pedido').AsInteger := NumeroPedido;
      qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
      qry.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
      qry.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
      qry.ParamByName('vl_desconto_pedido').AsCurrency := 0;
      qry.ParamByName('vl_acrescimo').AsCurrency := 0;
      qry.ParamByName('vl_total').AsCurrency := 0;
      qry.ParamByName('fl_orcamento').AsBoolean := edtFl_orcamento.Checked;
      qry.ParamByName('dt_emissao').AsDate := StrToDate(edtDataEmissao.Text);
      qry.ParamByName('fl_cancelado').AsString := 'N';
      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar o cabeçalho do pedido ' + edtNrPedido.Text + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
    FreeAndNil(idGeral);
  end;
end;

procedure TfrmPedidoVenda.SalvaItens(EhEdicao: Boolean);
const
  SQL_INSERT = 'insert '+
               '    into '+
               'pedido_venda_item (id_geral, id_pedido_venda, cd_produto, vl_unitario, vl_total_item, qtd_venda, ' +
               'vl_desconto, cd_tabela_preco, icms_vl_base, icms_pc_aliq, icms_valor, ipi_vl_base, ipi_pc_aliq, ' +
               'ipi_valor, pis_cofins_vl_base, pis_cofins_pc_aliq, pis_cofins_valor, un_medida, seq_item) ' +
               'values (:id_geral, :id_pedido_venda, :cd_produto, :vl_unitario, :vl_total_item, ' +
               ':qtd_venda, :vl_desconto, :cd_tabela_preco, :icms_vl_base, :icms_pc_aliq, :icms_valor, ' +
               ':ipi_vl_base, :ipi_pc_aliq, :ipi_valor, :pis_cofins_vl_base, :pis_cofins_pc_aliq, ' +
               ':pis_cofins_valor, :un_medida, :seq_item)';

  SQL_UPDATE = 'update    ' +
               'pedido_venda_item set cd_produto = :cd_produto, vl_unitario = :vl_unitario,   ' +
               'vl_total_item = :vl_total_item, qtd_venda = :qtd_venda, vl_desconto = :vl_desconto, cd_tabela_preco = :cd_tabela_preco, icms_vl_base = :icms_vl_base,  ' +
               'icms_pc_aliq = :icms_pc_aliq, icms_valor = :icms_valor, ipi_vl_base = :ipi_vl_base, ipi_pc_aliq = :ipi_pc_aliq, ipi_valor = :ipi_valor,              ' +
               'pis_cofins_vl_base = :pis_cofins_vl_base, pis_cofins_pc_aliq = :pis_cofins_pc_aliq, pis_cofins_valor = :pis_cofins_valor, un_medida = :un_medida, ' +
               'seq_item = :seq_item '+
               'where cd_produto = :cd_produto and ' +
               'id_pedido_venda = :id_pedido_venda';
var
  qry: TFDQuery;
  idGeral: TGerador;
//  idGeralItem: Int64;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  idGeral := TGerador.Create;

  //NÃO ESTÁ GRAVANDO CORRETAMENTE O SEQ_ITEM NA PEDIDO_VENDA_ITEM se lançado duas vezes o mesmo item
  try
    try
      if not EhEdicao then
      begin
//        idGeralItem := idGeral.GeraIdGeral;
        qry.SQL.Add(SQL_INSERT);
        qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
        qry.ParamByName('id_pedido_venda').AsInteger := FIdGeral;
        qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
        qry.ParamByName('vl_unitario').AsCurrency := cdsPedidoVenda.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('vl_total_item').AsCurrency := cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency;
        qry.ParamByName('qtd_venda').AsInteger := cdsPedidoVenda.FieldByName('qtd_venda').AsInteger;
        qry.ParamByName('vl_desconto').AsCurrency := cdsPedidoVenda.FieldByName('vl_desconto').AsCurrency;
        qry.ParamByName('cd_tabela_preco').AsInteger := cdsPedidoVenda.FieldByName('cd_tabela_preco').AsInteger;
        qry.ParamByName('icms_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency;
        qry.ParamByName('icms_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('icms_pc_aliq').AsCurrency;
        qry.ParamByName('icms_valor').AsCurrency := cdsPedidoVenda.FieldByName('icms_valor').AsCurrency;
        qry.ParamByName('ipi_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency;
        qry.ParamByName('ipi_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsCurrency;
        qry.ParamByName('ipi_valor').AsCurrency := cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency;
        qry.ParamByName('pis_cofins_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency;
        qry.ParamByName('pis_cofins_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsCurrency;
        qry.ParamByName('pis_cofins_valor').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency;
        qry.ParamByName('un_medida').AsString := cdsPedidoVenda.FieldByName('un_medida').AsString;
        qry.ParamByName('seq_item').AsInteger := cdsPedidoVenda.FieldByName('seq').AsInteger;
        qry.ExecSQL;
        qry.Connection.Commit;
        qry.SQL.Clear;
      end
      else
      begin
        qry.SQL.Clear;
        qry.SQL.Add(SQL_UPDATE);
//        qry.ParamByName('id_geral').AsInteger := FIdGeral;
        qry.ParamByName('cd_produto').AsInteger := cdsPedidoVenda.FieldByName('cd_produto').AsInteger;
        qry.ParamByName('id_pedido_venda').AsInteger := FIdGeral;
        qry.ParamByName('vl_unitario').AsCurrency := cdsPedidoVenda.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('vl_total_item').AsCurrency := cdsPedidoVenda.FieldByName('vl_total_item').AsCurrency;
        qry.ParamByName('qtd_venda').AsInteger := cdsPedidoVenda.FieldByName('qtd_venda').AsInteger;
        qry.ParamByName('vl_desconto').AsCurrency := cdsPedidoVenda.FieldByName('vl_desconto').AsCurrency;
        qry.ParamByName('cd_tabela_preco').AsInteger := cdsPedidoVenda.FieldByName('cd_tabela_preco').AsInteger;
        qry.ParamByName('icms_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('icms_vl_base').AsCurrency;
        qry.ParamByName('icms_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('icms_pc_aliq').AsCurrency;
        qry.ParamByName('icms_valor').AsCurrency := cdsPedidoVenda.FieldByName('icms_valor').AsCurrency;
        qry.ParamByName('ipi_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('ipi_vl_base').AsCurrency;
        qry.ParamByName('ipi_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('ipi_pc_aliq').AsCurrency;
        qry.ParamByName('ipi_valor').AsCurrency := cdsPedidoVenda.FieldByName('ipi_valor').AsCurrency;
        qry.ParamByName('pis_cofins_vl_base').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_vl_base').AsCurrency;
        qry.ParamByName('pis_cofins_pc_aliq').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_pc_aliq').AsCurrency;
        qry.ParamByName('pis_cofins_valor').AsCurrency := cdsPedidoVenda.FieldByName('pis_cofins_valor').AsCurrency;
        qry.ParamByName('un_medida').AsString := cdsPedidoVenda.FieldByName('un_medida').AsString;
        qry.ParamByName('seq_item').AsInteger := cdsPedidoVenda.FieldByName('seq').AsInteger;
        qry.ExecSQL;
        qry.Connection.Commit;
      end;

    except
    on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os itens do pedido ' + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.SetFIdGeral(const Value: Int64);
begin
  FFIdGeral := Value;
end;

end.
