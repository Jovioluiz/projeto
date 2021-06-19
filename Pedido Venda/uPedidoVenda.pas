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
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, uclPedidoVenda, uGerador;

type
  TAliqItem = record
    AliqIcms,
    AliqIpi,
    AliqPisCofins: Currency
  end;

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
    edtFl_orcamento: TCheckBox;
    Label19: TLabel;
    document: TXMLDocument;
    edtDataEmissao: TDateTimePicker;
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
    procedure btnAdicionarClick(Sender: TObject);
  private
    FEdicaoItem: Boolean;
    FNumeroPedido: Integer;
    FRegras: TPedidoVenda;
    FFIdGeral: TGerador;
    { Private declarations }
    function GetAliquotasItem(IDItem: Int64): TAliqItem;
    procedure AtualizaCabecalho;
    procedure SetRegras(const Value: TPedidoVenda);
    procedure SetFIdGeral(const Value: TGerador);
    procedure LimpaCampos;
    procedure LimpaDados;
    procedure AtualizaEstoqueProduto;
    function ProdutoJaLancado(CodProduto: Integer): Boolean;
    function RetornaSequencia: Integer;
    procedure AlteraSequenciaItem;
    procedure SalvaCabecalho;

    procedure SalvaItens(EhEdicao: Boolean);
    procedure SetDadosNota;
    procedure CancelaPedidoVenda;
    procedure InsereWmsMvto;
    function GetNumeroParcelas(CdCondPgto: Integer): Integer;
    procedure CarregaItensEdicao;
    procedure PreencheCabecalhoPedido;
    procedure LancaItem;

    procedure GravaPedidoVenda;
  public
    { Public declarations }

    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property FIdGeral: TGerador read FFIdGeral write SetFIdGeral;
    property Regras: TPedidoVenda read FRegras write SetRegras;
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;
  seqItem: Integer = 1;

implementation

uses
  uDataModule, uConfiguracoes, uUtil, System.Math;

{$R *.dfm}


procedure TfrmPedidoVenda.AlteraSequenciaItem;
//ajusta a sequencia do item no pedido de venda
var
  i: Integer;
begin
  FRegras.Dados.cdsPedidoVendaItem.First;
  
  for i := 1 to FRegras.Dados.cdsPedidoVendaItem.RecordCount do
  begin
    if FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger <> i then
    begin
      FRegras.Dados.cdsPedidoVendaItem.Edit;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger := i;
    end;
    FRegras.Dados.cdsPedidoVendaItem.Next;
  end;
end;

procedure TfrmPedidoVenda.AtualizaEstoqueProduto;
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
                  'id_item = :id_item';
var
  qry: TFDQuery;
  qtdade, qttotal: Double;
  id: Int64;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      FRegras.Dados.cdsPedidoVendaItem.Loop(
      procedure
      begin
        qry.SQL.Clear;
        qry.SQL.Add(sql_select);
        qry.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
        qry.Open(sql_select);
        id := qry.FieldByName('id_wms_endereco_produto').AsInteger;
        qtdade := qry.FieldByName('qt_estoque').AsFloat;//quantidade no banco
        qttotal := qtdade - FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsInteger; //diminui com a informada no pedido

        qry.SQL.Clear;

        qry.SQL.Add(sql_update);
        qry.ParamByName('id').AsInteger := id;
        qry.ParamByName('qt_estoque').AsFloat := qttotal;
        qry.ExecSQL;
      end
      );
      dm.conexaoBanco.Commit;
    except
    on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ao gravar os dados do produto ' + FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.btnAdicionarClick(Sender: TObject);
begin
  LancaItem;
end;

procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente Cancelar o pedido?','Atenção', MB_YESNO) = IDYES) then
  begin
    CancelaPedidoVenda;
    LimpaDados;
  end;
end;

//grava os dados na pedido_venda e pedido_venda_item
procedure TfrmPedidoVenda.btnConfirmarPedidoClick(Sender: TObject);
begin
  GravaPedidoVenda;
  LimpaDados;
end;

procedure TfrmPedidoVenda.CancelaPedidoVenda;
const
  SQL = 'update pedido_venda set fl_cancelado = ''S'' where nr_pedido = :nr_pedido';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

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
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.CarregaItensEdicao;
begin
  edtCdProduto.Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString;
  edtDescProduto.Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('descricao').AsString;
  edtQtdade.Text := FloatToStr(FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsFloat);
  edtCdtabelaPreco.Text := IntToStr(FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_tabela_preco').AsInteger);
  edtUnMedida.Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString;
  edtVlUnitario.Text := CurrToStr(FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsCurrency);
  edtVlDescontoItem.Text := CurrToStr(FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_desconto').AsCurrency);
  edtVlTotal.Text := CurrToStr(FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency);
  FEdicaoItem := True;
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
  SQL_DELETE = 'delete from pedido_venda_item where id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir o item do pedido?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
      begin
        try
          qry.SQL.Add(SQL_DELETE);
          qry.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
          qry.ExecSQL;
          qry.Connection.Commit;
          FRegras.Dados.cdsPedidoVendaItem.Delete;
          edtCdProduto.SetFocus;
          seqItem := seqItem - 1;
        except
        on E : exception do
          begin
            qry.Connection.Rollback;
            ShowMessage('Erro ao excluir o item do pedido ' + FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString + E.Message);
            Exit;
          end;
        end;
      end;
    end;
  finally
    qry.Connection.Rollback;
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
  if FRegras.Dados.cdsPedidoVendaItem.IndexName = Column.FieldName + '_ASC' then
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
  if FRegras.Dados.cdsPedidoVendaItem.IndexDefs.IndexOf(sIndexName) < 0 then
    FRegras.Dados.cdsPedidoVendaItem.AddIndex(sIndexName, Column.FieldName, oOrdenacao);

  FRegras.Dados.cdsPedidoVendaItem.IndexDefs.Update;

  // formata o título da coluna em negrito
  Column.Title.Font.Style := [fsBold];

  // atribui a ordenação selecionada
  FRegras.Dados.cdsPedidoVendaItem.IndexName := sIndexName;

  FRegras.Dados.cdsPedidoVendaItem.First;
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
  cliente: TPedidoVenda;    //usar a property FRegras
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
  condicao: TPedidoVenda;  //usar a property FRegras
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
  condPgto: TPedidoVenda;  //usar a property FRegras
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
  forma: TPedidoVenda;//usar a property FRegras
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
  formaPgto: TPedidoVenda; //usar a property FRegras
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
//  if edtCdProduto.Text = EmptyStr then
//  begin
//    edtDescProduto.Text := '';
//    edtQtdade.Text := '';
//    edtUnMedida.Text := '';
//    edtCdtabelaPreco.Text := '';
//    edtDescTabelaPreco.Text := '';
//    edtVlUnitario.Text := '';
//    Exit;
//  end;
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

    PreencheCabecalhoPedido;

    if qry.FieldByName('nr_pedido').AsInteger <> NumeroPedido then
      SalvaCabecalho
    else
      AtualizaCabecalho;

  finally
    qry.Free;
    geraNrPedido.Free;
  end;
end;

procedure TfrmPedidoVenda.AtualizaCabecalho;
const
  SQL_UPDATE_CABECALHO = 'update pedido_venda set cd_cliente = :cd_cliente,  '+
                         ' cd_forma_pag = :cd_forma_pag, cd_cond_pag = :cd_cond_pag, vl_desconto_pedido = :vl_desconto_pedido,   '+
                         ' vl_acrescimo = :vl_acrescimo, vl_total = :vl_total, fl_orcamento = :fl_orcamento, dt_emissao = :dt_emissao,'+
                         ' fl_cancelado = :fl_cancelado where nr_pedido = :nr_pedido';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    try
      qry.SQL.Add(SQL_UPDATE_CABECALHO);
      qry.ParamByName('nr_pedido').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsInteger;
      qry.ParamByName('cd_cliente').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cliente').AsInteger;
      qry.ParamByName('cd_forma_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_forma_pag').AsInteger;
      qry.ParamByName('cd_cond_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cond_pag').AsInteger;
      qry.ParamByName('vl_desconto_pedido').AsCurrency :=  FRegras.Dados.cdsPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency;
      qry.ParamByName('vl_acrescimo').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_acrescimo').AsCurrency;
      qry.ParamByName('vl_total').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_total').AsCurrency;
      qry.ParamByName('fl_orcamento').AsBoolean := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_orcamento').AsBoolean;
      qry.ParamByName('dt_emissao').AsDate := FRegras.Dados.cdsPedidoVenda.FieldByName('dt_emissao').AsDateTime;
      qry.ParamByName('fl_cancelado').AsString := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_cancelado').AsString;
      qry.ExecSQL;

      qry.Connection.Commit;

    except
      on E : exception do
        begin
          qry.Connection.Rollback;
          ShowMessage('Erro ao gravar os dados do pedido ' + edtNrPedido.Text + E.Message);
          Exit;
        end;
    end;

  finally
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.edtCdProdutoExit(Sender: TObject);
var
  produto: TPedidoVenda; //usar a property FRegras
  resposta: Boolean;
  lista: TFDQuery;
begin
  produto := TPedidoVenda.Create;
  resposta := False;
//  lista := TList<string>.Create;

  try
    if (Trim(edtCdProduto.Text) = '') and (FRegras.Dados.cdsPedidoVendaItem.RecordCount > 0) then
    begin
      edtVlDescTotalPedido.SetFocus;
      Exit;
    end;

    if edtCdProduto.Text <> '' then
      resposta := produto.ValidaProduto(edtCdProduto.Text);

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
      produto.BuscaProdutoCodBarras(edtCdProduto.Text);

      lista := produto.BuscaProduto(edtCdProduto.Text);
      edtCdProduto.Text := lista.FieldByName('cd_produto').AsString;
      edtDescProduto.Text := lista.FieldByName('desc_produto').AsString;
      edtUnMedida.Text := lista.FieldByName('un_medida').AsString;
      edtCdtabelaPreco.Text := IntToStr(lista.FieldByName('cd_tabela').AsInteger);
      edtDescTabelaPreco.Text := lista.FieldByName('nm_tabela').AsString;
      edtVlUnitario.Text := CurrToStr(lista.FieldByName('valor').AsCurrency);
    end
    else
    begin
      lista := produto.BuscaProduto(edtCdProduto.Text);
      edtDescProduto.Text := lista.FieldByName('desc_produto').AsString;
      edtUnMedida.Text := lista.FieldByName('un_medida').AsString;
      edtCdtabelaPreco.Text := IntToStr(lista.FieldByName('cd_tabela').AsInteger);
      edtDescTabelaPreco.Text := lista.FieldByName('nm_tabela').AsString;
      edtVlUnitario.Text := CurrToStr(lista.FieldByName('valor').AsCurrency);
    end;

  finally
    FreeAndNil(produto);
    FreeAndNil(lista);
  end;
end;

//busca a tabela de preço
procedure TfrmPedidoVenda.edtCdtabelaPrecoChange(Sender: TObject);
var
  tabela: TPedidoVenda; //usar a property FRegras
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
    lista := tabela.BuscaTabelaPreco(StrToInt(edtCdtabelaPreco.Text), edtCdProduto.Text);

    edtDescTabelaPreco.Text := lista.Items[0];
    edtVlUnitario.Text := lista.Items[1];
  finally
    FreeAndNil(tabela);
    FreeAndNil(lista);
  end;
end;

procedure TfrmPedidoVenda.edtCdtabelaPrecoExit(Sender: TObject);
var
  tabela: TPedidoVenda; //usar a property FRegras
  resposta : Boolean;
begin
  if not edtCdtabelaPreco.isEmpty then
  begin
    tabela := TPedidoVenda.Create;
    resposta := tabela.ValidaTabelaPreco(StrToInt(edtCdtabelaPreco.Text), edtCdProduto.Text);

    try
      if resposta then
      begin
        if (Application.MessageBox('Tabela de Preço não encontrada', 'Atenção', MB_OK) = idOK) then
          edtCdtabelaPreco.SetFocus;
      end
      else
      begin
        //recalcula o valor total do item ao alterar a tabela de preço

        edtVlTotal.Text := FloatToStr(tabela.CalculaValorTotalItem(StrToFloat(edtVlUnitario.Text), StrToFloat(edtQtdade.Text)));
        edtVlDescontoItem.Enabled := True;
      end;
    finally
      FreeAndNil(tabela);
    end;
  end;
end;

//calcula o valor total do item ao alterar a quantidade
procedure TfrmPedidoVenda.edtQtdadeChange(Sender: TObject);
var
  pv: TPedidoVenda; //usar a property FRegras
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
      edtVlTotal.Text := FloatToStr(pv.CalculaValorTotalItem(StrToFloat(edtVlUnitario.Text), StrToFloat(edtQtdade.Text)));
      edtVlDescontoItem.Enabled := true;
    end;
  finally
    FreeAndNil(pv);
  end;
end;

procedure TfrmPedidoVenda.edtQtdadeExit(Sender: TObject);
var
  qtdadeEstoque: TPedidoVenda;//usar a property FRegras
begin
  qtdadeEstoque := TPedidoVenda.Create;

  try
    if edtQtdade.Text = '0' then
    begin
      ShowMessage('Informe uma quantidade maior que 0');
      edtQtdade.SetFocus;
    end;

    if edtQtdade.Text <> '' then
      if not qtdadeEstoque.ValidaQtdadeItem(edtCdProduto.Text, StrToFloat(edtQtdade.Text)) then
      begin
        ShowMessage('Item não possui quantidade. Verifique!');
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
  valorDesconto, vlTotalPedido, valorTotalItens: Currency;
begin
  if not edtVlDescTotalPedido.isEmpty then
  begin
    if (edtVlDescTotalPedido.Text = '0') or (edtVlDescTotalPedido.Text = '0,00') then
    begin
      edtVlDescTotalPedido.Text := CurrToStr(0);
      valorTotalItens := 0;

      //soma os valores totais dos itens
      FRegras.Dados.cdsPedidoVendaItem.Loop(
        procedure
        begin
          valorTotalItens := (valorTotalItens + FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency);
        end
      );

      edtVlTotalPedido.Text := CurrToStr(valorTotalItens);
    end
    else
    begin
      vlTotalPedido := 0;

      valorDesconto := StrToCurr(FormatCurr('#,##0.00', StrToCurr(edtVlDescTotalPedido.Text)));

      FRegras.Dados.cdsPedidoVendaItem.Loop(
        procedure
        begin
          vlTotalPedido := (vlTotalPedido + FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency);
        end
      );

      edtVlTotalPedido.Text := CurrToStr(vlTotalPedido - valorDesconto);
    end;
  end;
end;

procedure TfrmPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmPedidoVenda := nil;
  FRegras.Free;
  FIdGeral.Free;
end;

procedure TfrmPedidoVenda.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if (edtNrPedido.Text <> '') or (FRegras.Dados.cdsPedidoVendaItem.RecordCount > 0) then
  begin
    CanClose := False;
    if (Application.MessageBox('Deseja Cancelar o Pedido?','Atenção', MB_YESNO) = IDYES) then
    begin
      CancelaPedidoVenda;
      CanClose := True;
    end;
  end;
end;

procedure TfrmPedidoVenda.FormCreate(Sender: TObject);
begin
//seta a data atual na data de emissão
  edtDataEmissao.Date := Date();
  edtDataEmissao.Enabled := False;
  seqItem := 1;
  FRegras := TPedidoVenda.Create;
  dbGridProdutos.DataSource := FRegras.Dados.dsPedidoVendaItem;
  FIdGeral := TGerador.Create;
end;

procedure TfrmPedidoVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (edtNrPedido.Text = '') and (FRegras.Dados.cdsPedidoVendaItem.RecordCount = 0) then
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


function TfrmPedidoVenda.GetAliquotasItem(IDItem: Int64): TAliqItem;
const
  SQL_ALIQ = 'select '+
        '    pt.cd_tributacao_icms,'+
        '    gti.aliquota_icms,'+
        '    gtipi.aliquota_ipi,'+
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
        '    pt.id_item = :id_item';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(Self);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL_ALIQ, [IDItem]);

    if not query.IsEmpty then
    begin
      Result.AliqIcms := query.FieldByName('aliquota_icms').AsCurrency;
      Result.AliqIpi := query.FieldByName('aliquota_ipi').AsCurrency;
      Result.AliqPisCofins := query.FieldByName('aliquota_pis_cofins').AsCurrency;
    end
    else
    begin
      Result.AliqIcms := 0;
      Result.AliqIpi := 0;
      Result.AliqPisCofins := 0;
    end;

  finally
    query.Free;
  end;
end;

function TfrmPedidoVenda.GetNumeroParcelas(CdCondPgto: Integer): Integer;
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

procedure TfrmPedidoVenda.GravaPedidoVenda;
const
  SQL_UPDATE_CABECALHO = 'update pedido_venda set cd_cliente = :cd_cliente,  '+
                         ' cd_forma_pag = :cd_forma_pag, cd_cond_pag = :cd_cond_pag, vl_desconto_pedido = :vl_desconto_pedido,   '+
                         ' vl_acrescimo = :vl_acrescimo, vl_total = :vl_total, fl_orcamento = :fl_orcamento, dt_emissao = :dt_emissao,'+
                         ' fl_cancelado = :fl_cancelado where nr_pedido = :nr_pedido';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    try
      qry.SQL.Add(SQL_UPDATE_CABECALHO);
      qry.ParamByName('nr_pedido').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsInteger;
      qry.ParamByName('cd_cliente').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cliente').AsInteger;
      qry.ParamByName('cd_forma_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_forma_pag').AsInteger;
      qry.ParamByName('cd_cond_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cond_pag').AsInteger;
      qry.ParamByName('vl_desconto_pedido').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency;
      qry.ParamByName('vl_acrescimo').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_acrescimo').AsCurrency;
      qry.ParamByName('vl_total').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_total').AsCurrency;
      qry.ParamByName('fl_orcamento').AsBoolean := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_orcamento').AsBoolean;
      qry.ParamByName('dt_emissao').AsDate := FRegras.Dados.cdsPedidoVenda.FieldByName('dt_emissao').AsDateTime;
      qry.ParamByName('fl_cancelado').AsString := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_cancelado').AsString;
      qry.ExecSQL;

      AlteraSequenciaItem;

      //insert na pedido_venda_item

      FRegras.Dados.cdsPedidoVendaItem.Loop(
      procedure
      begin
        SalvaItens(True);
      end);

      //fazer o insert na wms_mvto_estoque
      InsereWmsMvto;
      AtualizaEstoqueProduto;

      //setDadosNota;

      qry.Connection.Commit;

      ShowMessage('Pedido ' + FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsString + ' Gravado Com Sucesso');
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do pedido ' + edtNrPedido.Text + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.InsereWmsMvto;
const
  SQL_INSERT =  'insert into ' +
                'wms_mvto_estoque(id_geral, '+
                'id_endereco_produto, '+
                'id_item, ' +
                'qt_estoque, ' +
                'un_estoque, ' +
                'fl_entrada_saida) values '+
                '(:id_geral, ' +
                ':id_endereco_produto, '+
                ':id_item, ' +
                ':qt_estoque, ' +
                ':un_estoque, ' +
                ':fl_entrada_saida)';

  SQL_SELECT = 'select ' +
               '   id_geral ' +
               'from        ' +
               '   wms_endereco_produto w    ' +
               'where                        ' +
               '   id_item = :id_item  ' +
               '   and ordem = (             ' +
               '   select                    ' +
               '       min(ordem)            ' +
               '   from                      ' +
               '       wms_endereco_produto wep ' +
               '   where                        ' +
               '       id_item = :id_item)';
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
      FRegras.Dados.cdsPedidoVendaItem.Loop(
        procedure
        begin
          qrySelect.SQL.Clear;
          qrySelect.SQL.Add(SQL_SELECT);
          qrySelect.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
          qrySelect.Open(SQL_SELECT);

          qry.SQL.Clear;
          qry.SQL.Add(SQL_INSERT);
          qry.ParamByName('id_geral').AsFloat := IdGeral.GeraIdGeral;
          qry.ParamByName('id_endereco_produto').AsInteger := qrySelect.FieldByName('id_geral').AsInteger;
          qry.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
          qry.ParamByName('qt_estoque').AsFloat := FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsFloat;
          qry.ParamByName('un_estoque').AsString := FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString;
          qry.ParamByName('fl_entrada_saida').AsString := 'S';

          qry.ExecSQL;
        end
      );
      dm.conexaoBanco.Commit;
    except
      on e:Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do movimento do produto ' + FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
    qrySelect.Free;
  end;
end;

procedure TfrmPedidoVenda.SetDadosNota;
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

    FRegras.Dados.cdsPedidoVendaItem.DisableControls;
    FRegras.Dados.cdsPedidoVendaItem.First;
    while not FRegras.Dados.cdsPedidoVendaItem.Eof do
    begin
      itens := venda.AddChild('item');
      itens.Attributes['numero'] := i;
      itens.AddChild('cProd').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString;
      itens.AddChild('descricao').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('descricao').AsString;
      itens.AddChild('uUN').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString;
      itens.AddChild('qtVenda').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsString;
      itens.AddChild('vlUni').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsString;
      if FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency > 0 then
      begin
        impostoItem := itens.AddChild('impostoItem');
        impostoItem.AddChild('vBaseIcms').Text := FormatCurr('#,##0.00', FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency);
        impostoItem.AddChild('icmsAliq').Text := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_pc_aliq').AsString;
        impostoItem.AddChild('vIcms').Text := FormatCurr('#,##0.00', FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_valor').AsCurrency);
      end;
      FRegras.Dados.cdsPedidoVendaItem.Next;
      Inc(i);
    end;

    nrParcelas := GetNumeroParcelas(StrToInt(edtCdCondPgto.Text));
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
    FRegras.Dados.cdsPedidoVendaItem.EnableControls;
  end;
end;

procedure TfrmPedidoVenda.SetFIdGeral(const Value: TGerador);
begin
  FFIdGeral := Value;
end;

procedure TfrmPedidoVenda.LancaItem;
//adiciona os produtos no grid
 var
  vl_total_itens: Currency;
  lancado: Boolean;
  lancaProduto: TfrmConfiguracoes;
  item: TPedidoVenda;  //usar a property FRegras
  aliq: TAliqItem;
begin
  lancaProduto := TfrmConfiguracoes.Create(Self);

  item := TPedidoVenda.Create;

  try
     aliq := GetAliquotasItem(item.GetIdItem(edtCdProduto.Text));

    if ProdutoJaLancado(StrToInt(edtCdProduto.Text))
       and (lancaProduto.cbbLancaItemPedido.ItemIndex = 1)
       and (not FEdicaoItem) then
      raise Exception.Create('O produto já está lançado');

      //passar o id_geral da pedidovendaitem pro dataset

    if FEdicaoItem then
    begin
      FRegras.Dados.cdsPedidoVendaItem.Edit;//entra em modo de edição
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString := edtCdProduto.Text;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsFloat := StrToFloat(edtQtdade.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString := edtUnMedida.Text;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtVlUnitario.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_desconto').AsCurrency := StrToCurr(edtVlDescontoItem.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency := StrToCurr(edtVlTotal.Text);
      FEdicaoItem := False;
    end
    else
    begin
      RetornaSequencia;
      FRegras.Dados.cdsPedidoVendaItem.Append;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_geral').AsLargeInt := FIdGeral.GeraIdGeral;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_pedido_venda').AsLargeInt := FRegras.Dados.cdsPedidoVenda.FieldByName('id_geral').AsLargeInt;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger := seqItem;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_produto').AsString := edtCdProduto.Text;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('descricao').AsString := edtDescProduto.Text;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsFloat := StrToFloat(edtQtdade.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_tabela_preco').AsInteger := StrToInt(edtCdtabelaPreco.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString := edtUnMedida.Text;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtVlUnitario.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_desconto').AsCurrency := StrToCurr(edtVlDescontoItem.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency := StrToCurr(edtVlTotal.Text);
    end;

    if aliq.AliqIcms = 0 then
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_pc_aliq').AsFloat := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_valor').AsCurrency := 0;
    end
    else
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_pc_aliq').AsFloat := aliq.AliqIcms;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq.AliqIcms) / 100;
    end;
    if aliq.AliqIpi = 0 then
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_vl_base').AsCurrency := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_pc_aliq').AsFloat := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_valor').AsCurrency := 0;
    end
    else
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_pc_aliq').AsFloat := aliq.AliqIpi;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq.AliqIpi) / 100;
    end;
    if aliq.AliqPisCofins = 0 then
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_vl_base').AsCurrency := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_pc_aliq').AsFloat := 0;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_valor').AsCurrency := 0;
    end
    else
    begin
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_vl_base').AsCurrency := StrToCurr(edtVlTotal.Text);
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_pc_aliq').AsFloat := aliq.AliqPisCofins;
      FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_valor').AsCurrency := (StrToCurr(edtVlTotal.Text) * aliq.AliqPisCofins) / 100;
    end;

    FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt := item.GetIdItem(edtCdProduto.Text);
    FRegras.Dados.cdsPedidoVendaItem.Post;

    SalvaItens(FEdicaoItem);

    //soma os valores totais dos itens e preenche o valor total do pedido
    vl_total_itens := 0;

    FRegras.Dados.cdsPedidoVendaItem.Loop(
    procedure
    begin
      vl_total_itens := (vl_total_itens + FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency);
    end);

    edtVlTotalPedido.Text := CurrToStr(vl_total_itens);

    seqItem := seqItem + 1;

    edtQtdade.Text := '0';
  finally
    LimpaCampos;
    lancaProduto.Free;
    item.Free;
  end;
end;

procedure TfrmPedidoVenda.LimpaCampos;
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

procedure TfrmPedidoVenda.LimpaDados;
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
  FRegras.Dados.cdsPedidoVendaItem.EmptyDataSet;
end;

procedure TfrmPedidoVenda.PreencheCabecalhoPedido;
begin

  if FRegras.Dados.cdsPedidoVenda.State in [dsEdit, dsBrowse] then
    FRegras.Dados.cdsPedidoVenda.Edit
  else
    FRegras.Dados.cdsPedidoVenda.Append;

  FRegras.Dados.cdsPedidoVenda.FieldByName('id_geral').AsLargeInt := ifthen(FRegras.Dados.cdsPedidoVenda.FieldByName('id_geral').AsLargeInt > 0,
                                                                            FRegras.Dados.cdsPedidoVenda.FieldByName('id_geral').AsLargeInt, FIdGeral.GeraIdGeral);
  FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsInteger := NumeroPedido;
  FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency := StrToCurr(edtVlDescTotalPedido.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('vl_acrescimo').AsCurrency := StrToCurr(edtVlAcrescimoTotalPedido.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('vl_total').AsCurrency := StrToCurr(edtVlTotalPedido.Text);
  FRegras.Dados.cdsPedidoVenda.FieldByName('fl_orcamento').AsBoolean := edtFl_orcamento.Checked;
  FRegras.Dados.cdsPedidoVenda.FieldByName('dt_emissao').AsDateTime := edtDataEmissao.Date;
  FRegras.Dados.cdsPedidoVenda.FieldByName('fl_cancelado').AsString := 'N';
  FRegras.Dados.cdsPedidoVenda.Post;
end;

function TfrmPedidoVenda.ProdutoJaLancado(CodProduto: Integer): Boolean;
begin
  Result := False;

  if FRegras.Dados.cdsPedidoVendaItem.Locate('cd_produto', VarArrayOf([CodProduto]), []) then
    Result := True;
end;

function TfrmPedidoVenda.RetornaSequencia: Integer;
begin

  FRegras.Dados.cdsPedidoVendaItem.Loop(
    procedure
    begin
      if FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger = seqItem then
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
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try

    try
      //insert na pedido_venda
      qry.SQL.Add(sql_Insert_pedido);
      qry.ParamByName('id_geral').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('id_geral').AsLargeInt;
      qry.ParamByName('nr_pedido').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsInteger;
      qry.ParamByName('cd_cliente').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cliente').AsInteger;
      qry.ParamByName('cd_forma_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_forma_pag').AsInteger;
      qry.ParamByName('cd_cond_pag').AsInteger := FRegras.Dados.cdsPedidoVenda.FieldByName('cd_cond_pag').AsInteger;
      qry.ParamByName('vl_desconto_pedido').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_desconto_pedido').AsCurrency;
      qry.ParamByName('vl_acrescimo').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_acrescimo').AsCurrency;
      qry.ParamByName('vl_total').AsCurrency := FRegras.Dados.cdsPedidoVenda.FieldByName('vl_total').AsCurrency;
      qry.ParamByName('fl_orcamento').AsBoolean := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_orcamento').AsBoolean;
      qry.ParamByName('dt_emissao').AsDate := FRegras.Dados.cdsPedidoVenda.FieldByName('dt_emissao').AsDateTime;
      qry.ParamByName('fl_cancelado').AsString := FRegras.Dados.cdsPedidoVenda.FieldByName('fl_cancelado').AsString;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar o cabeçalho do pedido ' + FRegras.Dados.cdsPedidoVenda.FieldByName('nr_pedido').AsString + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TfrmPedidoVenda.SalvaItens(EhEdicao: Boolean);
const
  SQL_INSERT = 'insert '+
               '    into '+
               'pedido_venda_item (id_geral, id_pedido_venda, id_item, vl_unitario, vl_total_item, qtd_venda, ' +
               'vl_desconto, cd_tabela_preco, icms_vl_base, icms_pc_aliq, icms_valor, ipi_vl_base, ipi_pc_aliq, ' +
               'ipi_valor, pis_cofins_vl_base, pis_cofins_pc_aliq, pis_cofins_valor, un_medida, seq_item) ' +
               'values (:id_geral, :id_pedido_venda, :id_item, :vl_unitario, :vl_total_item, ' +
               ':qtd_venda, :vl_desconto, :cd_tabela_preco, :icms_vl_base, :icms_pc_aliq, :icms_valor, ' +
               ':ipi_vl_base, :ipi_pc_aliq, :ipi_valor, :pis_cofins_vl_base, :pis_cofins_pc_aliq, ' +
               ':pis_cofins_valor, :un_medida, :seq_item)';

  SQL_UPDATE = 'update    ' +
               'pedido_venda_item set id_item = :id_item, vl_unitario = :vl_unitario,   ' +
               'vl_total_item = :vl_total_item, qtd_venda = :qtd_venda, vl_desconto = :vl_desconto, cd_tabela_preco = :cd_tabela_preco, icms_vl_base = :icms_vl_base,  ' +
               'icms_pc_aliq = :icms_pc_aliq, icms_valor = :icms_valor, ipi_vl_base = :ipi_vl_base, ipi_pc_aliq = :ipi_pc_aliq, ipi_valor = :ipi_valor,              ' +
               'pis_cofins_vl_base = :pis_cofins_vl_base, pis_cofins_pc_aliq = :pis_cofins_pc_aliq, pis_cofins_valor = :pis_cofins_valor, un_medida = :un_medida, ' +
               'seq_item = :seq_item '+
               'where id_item = :id_item and ' +
               'id_pedido_venda = :id_pedido_venda';
var
  qry: TFDQuery;
  idGeral: TGerador;
//  idGeralItem: Int64;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  idGeral := TGerador.Create;

  //NÃO ESTÁ GRAVANDO CORRETAMENTE O SEQ_ITEM NA PEDIDO_VENDA_ITEM se lançado duas vezes o mesmo item
  try
    try
      if not EhEdicao then
      begin
//        idGeralItem := idGeral.GeraIdGeral;
        qry.SQL.Add(SQL_INSERT);
        qry.ParamByName('id_geral').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_geral').AsLargeInt;
        qry.ParamByName('id_pedido_venda').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_pedido_venda').AsLargeInt;
        qry.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
        qry.ParamByName('vl_unitario').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('vl_total_item').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency;
        qry.ParamByName('qtd_venda').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsInteger;
        qry.ParamByName('vl_desconto').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_desconto').AsCurrency;
        qry.ParamByName('cd_tabela_preco').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_tabela_preco').AsInteger;
        qry.ParamByName('icms_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency;
        qry.ParamByName('icms_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_pc_aliq').AsCurrency;
        qry.ParamByName('icms_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_valor').AsCurrency;
        qry.ParamByName('ipi_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_vl_base').AsCurrency;
        qry.ParamByName('ipi_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_pc_aliq').AsCurrency;
        qry.ParamByName('ipi_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_valor').AsCurrency;
        qry.ParamByName('pis_cofins_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_vl_base').AsCurrency;
        qry.ParamByName('pis_cofins_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_pc_aliq').AsCurrency;
        qry.ParamByName('pis_cofins_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_valor').AsCurrency;
        qry.ParamByName('un_medida').AsString := FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString;
        qry.ParamByName('seq_item').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger;
        qry.ExecSQL;
//        dm.conexaoBanco.Commit;
//        qry.SQL.Clear;
      end
      else
      begin
        qry.SQL.Clear;
        qry.SQL.Add(SQL_UPDATE);
//        qry.ParamByName('id_geral').AsInteger := FIdGeral;
        qry.ParamByName('id_item').AsLargeInt := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_item').AsLargeInt;
        qry.ParamByName('id_pedido_venda').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('id_pedido_venda').AsLargeInt;
        qry.ParamByName('vl_unitario').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_unitario').AsCurrency;
        qry.ParamByName('vl_total_item').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_total_item').AsCurrency;
        qry.ParamByName('qtd_venda').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('qtd_venda').AsInteger;
        qry.ParamByName('vl_desconto').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('vl_desconto').AsCurrency;
        qry.ParamByName('cd_tabela_preco').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('cd_tabela_preco').AsInteger;
        qry.ParamByName('icms_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_vl_base').AsCurrency;
        qry.ParamByName('icms_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_pc_aliq').AsCurrency;
        qry.ParamByName('icms_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('icms_valor').AsCurrency;
        qry.ParamByName('ipi_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_vl_base').AsCurrency;
        qry.ParamByName('ipi_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_pc_aliq').AsCurrency;
        qry.ParamByName('ipi_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('ipi_valor').AsCurrency;
        qry.ParamByName('pis_cofins_vl_base').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_vl_base').AsCurrency;
        qry.ParamByName('pis_cofins_pc_aliq').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_pc_aliq').AsCurrency;
        qry.ParamByName('pis_cofins_valor').AsCurrency := FRegras.Dados.cdsPedidoVendaItem.FieldByName('pis_cofins_valor').AsCurrency;
        qry.ParamByName('un_medida').AsString := FRegras.Dados.cdsPedidoVendaItem.FieldByName('un_medida').AsString;
        qry.ParamByName('seq_item').AsInteger := FRegras.Dados.cdsPedidoVendaItem.FieldByName('seq').AsInteger;
        qry.ExecSQL;
//        dm.conexaoBanco.Commit;
      end;
      qry.Connection.Commit;

    except
    on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os itens do pedido' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;


procedure TfrmPedidoVenda.SetRegras(const Value: TPedidoVenda);
begin
  FRegras := Value;
end;

end.
