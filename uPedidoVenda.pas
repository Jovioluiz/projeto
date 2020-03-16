unit uPedidoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uConexao, Vcl.Mask;

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
    sqlPedidoVendaCliente: TFDQuery;
    sqlPedidoVendaFormaPgto: TFDQuery;
    sqlPedidoVendaCondPgto: TFDQuery;
    sqlPedidoVendaProduto: TFDQuery;
    sqlPedidoVendaTabPreco: TFDQuery;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    sqlPedidoVendaInsert: TFDQuery;
    sqlNrPedido: TFDQuery;
    sqlIdGeral: TFDQuery;
    sqlIdGeralPVI: TFDQuery;
    FDQuery1: TFDQuery;
    edtFl_orcamento: TCheckBox;
    edtDataEmissao: TMaskEdit;
    Label19: TLabel;
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
    procedure valida_qtdade_item();
    procedure edtQtdadeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPedidoVenda: TfrmPedidoVenda;

implementation

{$R *.dfm}

//adiciona os produtos no grid
procedure TfrmPedidoVenda.btnAdicionarClick(Sender: TObject);
 var
  vl_total_itens : Currency;
begin
  if ClientDataSet1.FieldCount = 0 then
    begin
      ClientDataSet1.FieldDefs.Clear;
      ClientDataSet1.FieldDefs.Add('C�d. Produto',ftInteger);
      ClientDataSet1.FieldDefs.Add('Descri��o',ftString,40,false);
      ClientDataSet1.FieldDefs.Add('Qtdade', ftInteger);
      ClientDataSet1.FieldDefs.Add('Tabela Pre�o', ftInteger);
      ClientDataSet1.FieldDefs.Add('UN Medida', ftString,10,false);
      ClientDataSet1.FieldDefs.Add('Valor Unit�rio', ftCurrency);
      ClientDataSet1.FieldDefs.Add('Valor Desconto', ftCurrency);
      ClientDataSet1.FieldDefs.Add('Valor Total', ftCurrency);

      ClientDataSet1.CreateDataSet;
    end;

    ClientDataSet1.Append;
    ClientDataSet1.FieldByName('C�d. Produto').AsInteger := StrToInt(edtCdProduto.Text);
    ClientDataSet1.FieldByName('Descri��o').AsString := edtDescProduto.Text;
    ClientDataSet1.FieldByName('Qtdade').AsInteger := StrToInt(edtQtdade.Text);
    ClientDataSet1.FieldByName('Tabela Pre�o').AsInteger := StrToInt(edtCdtabelaPreco.Text);
    ClientDataSet1.FieldByName('UN Medida').AsString := edtUnMedida.Text;
    ClientDataSet1.FieldByName('Valor Unit�rio').AsCurrency := StrToCurr(edtVlUnitario.Text);
    ClientDataSet1.FieldByName('Valor Desconto').AsCurrency := StrToCurr(edtVlDescontoItem.Text);
    ClientDataSet1.FieldByName('Valor Total').AsCurrency := StrToCurr(edtVlTotal.Text);

    ClientDataSet1.Post;

    //soma os valores totais dos itens e preenche o valor total do pedido
    vl_total_itens := 0;
    with ClientDataSet1 do
      begin
        ClientDataSet1.DisableControls;
        ClientDataSet1.First;
        while not ClientDataSet1.Eof do
          begin
            vl_total_itens := (vl_total_itens + ClientDataSet1.FieldByName('Valor Total').AsCurrency);
            ClientDataSet1.Next;
          end;
          edtVlTotalPedido.Text := CurrToStr(vl_total_itens);
          ClientDataSet1.EnableControls;
      end;

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
    edtDataEmissao.Text := DateToStr(Date());
end;


procedure TfrmPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

//grava os dados na pedido_venda e pedido_venda_item
procedure TfrmPedidoVenda.btnConfirmarPedidoClick(Sender: TObject);
var   nr_pedido, id_geral, id_geral_pvi, qtdade, qttotal : Integer;
begin
    //id_geral do pedido_venda
  sqlIdGeral.Close;
  sqlIdGeral.SQL.Text := 'select *from func_id_geral()';

  sqlNrPedido.Close;
  sqlNrPedido.SQL.Text := 'select *from func_nr_pedido()';
  try
      //id_geral do pedido_venda
    sqlIdGeral.Open();
    sqlIdGeral.First;
    while not sqlIdGeral.Eof do
      begin
        id_geral := sqlIdGeral.FieldByName('func_id_geral').AsInteger;
        sqlIdGeral.Next;
      end;

    //gera o n�mero do pedido
    sqlNrPedido.Open();
    sqlNrPedido.First;
    while not sqlNrPedido.Eof do
      begin
        nr_pedido := sqlNrPedido.FieldByName('func_nr_pedido').AsInteger;
        edtNrPedido.Text := IntToStr(nr_pedido);
        sqlNrPedido.Next;
      end;
  except
    on E:exception do
    begin
       ShowMessage('Erro ao criar o n�mero do pedido'+ E.Message);
       exit;
    end;
  end;

  //insert na pedido_venda
  sqlPedidoVendaInsert.Close;
  sqlPedidoVendaInsert.SQL.Text := 'insert into pedido_venda (id_geral, nr_pedido, cd_cliente, cd_forma_pag, cd_cond_pag, '+
                        ' vl_desconto_pedido, vl_acrescimo, vl_total, fl_orcamento, dt_emissao)'+
                        ' values (:id_geral, :nr_pedido, :cd_cliente, :cd_forma_pag, :cd_cond_pag, '+
                        ':vl_desconto_pedido, :vl_acrescimo, :vl_total, :fl_orcamento, :dt_emissao)';

  sqlPedidoVendaInsert.ParamByName('id_geral').AsInteger := id_geral;
  sqlPedidoVendaInsert.ParamByName('nr_pedido').AsInteger := nr_pedido;
  sqlPedidoVendaInsert.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);
  sqlPedidoVendaInsert.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
  sqlPedidoVendaInsert.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
  sqlPedidoVendaInsert.ParamByName('vl_desconto_pedido').AsCurrency := StrToCurr(edtVlDescTotalPedido.Text);
  sqlPedidoVendaInsert.ParamByName('vl_acrescimo').AsCurrency := StrToCurr(edtVlAcrescimoTotalPedido.Text);
  sqlPedidoVendaInsert.ParamByName('vl_total').AsCurrency := StrToCurr(edtVlTotalPedido.Text);
  sqlPedidoVendaInsert.ParamByName('fl_orcamento').AsBoolean := edtFl_orcamento.Checked;
  sqlPedidoVendaInsert.ParamByName('dt_emissao').AsDate := StrToDate(edtDataEmissao.Text);


  try
    sqlPedidoVendaInsert.ExecSQL;
    sqlPedidoVendaInsert.Close;
    ShowMessage('Pedido nr� ' + edtNrPedido.Text + ' Gravado com sucesso');

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
    dbGridProdutos.DataSource.Destroy;

  except
    on E : exception do
    begin
      ShowMessage('Erro ao gravar os dados do pedido ' + edtNrPedido.Text + E.Message);
      exit;
    end;

  end;

  //insert na pedido_venda_item
  sqlPedidoVendaInsert.Close;

  with ClientDataSet1 do
    begin
      ClientDataSet1.DisableControls;
      ClientDataSet1.First;
      while not ClientDataSet1.Eof do
        begin
           //id_geral da pedido_venda_item
          sqlIdGeralPVI.Close;
          sqlIdGeralPVI.SQL.Text := 'select *from func_id_geral()';
          sqlIdGeralPVI.Open;
          id_geral_pvi := sqlIdGeralPVI.FieldByName('func_id_geral').AsInteger;

          sqlPedidoVendaInsert.SQL.Text := 'insert into pedido_venda_item (id_geral,id_pedido_venda,cd_produto,vl_unitario,vl_total_item,'+
                                'qtd_venda,vl_desconto,cd_tabela_preco) values (:id_geral,:id_pedido_venda,:cd_produto,'+
                                ':vl_unitario,:vl_total_item,:qtd_venda,:vl_desconto,:cd_tabela_preco)';

          sqlPedidoVendaInsert.ParamByName('id_geral').AsInteger := id_geral_pvi;
          sqlPedidoVendaInsert.ParamByName('id_pedido_venda').AsInteger := id_geral;
          sqlPedidoVendaInsert.ParamByName('cd_produto').AsInteger := ClientDataSet1.FieldByName('C�d. Produto').AsInteger;
          sqlPedidoVendaInsert.ParamByName('vl_unitario').AsCurrency := ClientDataSet1.FieldByName('Valor Unit�rio').AsCurrency;
          sqlPedidoVendaInsert.ParamByName('vl_total_item').AsCurrency := ClientDataSet1.FieldByName('Valor Total').AsCurrency;
          sqlPedidoVendaInsert.ParamByName('qtd_venda').AsInteger := ClientDataSet1.FieldByName('Qtdade').AsInteger;
          sqlPedidoVendaInsert.ParamByName('vl_desconto').AsCurrency := ClientDataSet1.FieldByName('Valor Desconto').AsCurrency;
          sqlPedidoVendaInsert.ParamByName('cd_tabela_preco').AsInteger := ClientDataSet1.FieldByName('Tabela Pre�o').AsInteger;

          //atualiza a qtd_estoque do produto na tabela produto
          sqlPedidoVendaProduto.Close;
          sqlPedidoVendaProduto.SQL.Text := 'select qtd_estoque from produto where cd_produto = :cd_produto';
          sqlPedidoVendaProduto.ParamByName('cd_produto').AsInteger := ClientDataSet1.FieldByName('C�d. Produto').AsInteger;
          sqlPedidoVendaProduto.Open();
          qtdade := sqlPedidoVendaProduto.Fields[0].Value;//quantidade no banco
          qttotal := qtdade - ClientDataSet1.FieldByName('Qtdade').AsInteger; //diminui com a informada no pedido
          sqlPedidoVendaProduto.SQL.Text := 'update produto set qtd_estoque = :qtd_estoque where cd_produto = :cd_produto';
          sqlPedidoVendaProduto.ParamByName('cd_produto').AsInteger := ClientDataSet1.FieldByName('C�d. Produto').AsInteger;
          sqlPedidoVendaProduto.ParamByName('qtd_estoque').AsInteger := qttotal;
          sqlPedidoVendaProduto.ExecSQL;

          ClientDataSet1.Next;
          sqlPedidoVendaInsert.ExecSQL;
        end;

      try
        //sqlPedidoVendaInsert.Close;
        ShowMessage('Itens Gravados Com Sucesso');
      except
        on E : exception do
          begin
            ShowMessage('Erro ao gravar os itens do pedido ' + edtNrPedido.Text + E.Message);
            exit;
          end;

      end;

    end;

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
      if MessageDlg('Deseja excluir o item do pedido?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
         begin
              ClientDataSet1.Delete;
              edtCdProduto.SetFocus;
         end;
    end;
end;

//busca o cliente
procedure TfrmPedidoVenda.edtCdClienteChange(Sender: TObject);
var
  tempC, tempU : String;
begin

if edtCdCliente.Text = EmptyStr then
  begin
    edtNomeCliente.Text := '';
    edtCidadeCliente.Text := '';
    exit;
  end;

  sqlPedidoVendaCliente.Close;
  sqlPedidoVendaCliente.SQL.Text := 'select '+
                                        'c.cd_cliente, '+
                                        'c.nome, '+
                                        'e.cidade, '+
                                        'e.uf '+
                                   'from '+
                                      'cliente c '+
                                   'join endereco e on '+
                                      'c.cd_cliente = e.cd_cliente '+
                                   'where '+
                                      '(c.cd_cliente = :cd_cliente) and (c.fl_ativo = true)';

  sqlPedidoVendaCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdCliente.Text);


  sqlPedidoVendaCliente.Open();
  edtNomeCliente.Text := sqlPedidoVendaCliente.FieldByName('nome').AsString;
  tempC := sqlPedidoVendaCliente.FieldByName('cidade').Text;
  tempU := sqlPedidoVendaCliente.FieldByName('uf').Text;
  edtCidadeCliente.Text := Concat(tempC + '/' + tempU);
  end;

//valida se n�o foi encontrado nenhum cliente
procedure TfrmPedidoVenda.edtCdClienteExit(Sender: TObject);
begin
  if sqlPedidoVendaCliente.IsEmpty then
    begin
    if (Application.MessageBox('Cliente n�o encontrado ou Inativo','Aten��o', MB_OK) = idOK) then
       begin
        edtCdCliente.SetFocus;
       end;
    end;
end;

//busca a condi��o de pgto
procedure TfrmPedidoVenda.edtCdCondPgtoChange(Sender: TObject);
begin
  if edtCdCondPgto.Text = EmptyStr then
    begin
      edtNomeCondPgto.Text := '';
      exit;
    end;

    sqlPedidoVendaCondPgto.Close;
    sqlPedidoVendaCondPgto.SQL.Text := 'select '+
                                            'ccp.cd_cond_pag, '+
                                            'ccp.nm_cond_pag '+
                                            'from cta_cond_pagamento ccp '+
                                        'join cta_forma_pagamento cfp on '+
                                            'ccp.cd_cta_forma_pagamento = cfp.cd_forma_pag '+
                                        'where (ccp.cd_cond_pag = :cd_cond_pag) and (cfp.cd_forma_pag = :cd_forma_pag) and (ccp.fl_ativo = true)';


    sqlPedidoVendaCondPgto.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCdCondPgto.Text);
    sqlPedidoVendaCondPgto.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
    sqlPedidoVendaCondPgto.Open();
    edtNomeCondPgto.Text := sqlPedidoVendaCondPgto.FieldByName('nm_cond_pag').AsString;

end;

//valida se n�o foi encontrado nenhuma condi��o de pagamento
procedure TfrmPedidoVenda.edtCdCondPgtoExit(Sender: TObject);
begin
  if sqlPedidoVendaCondPgto.IsEmpty then
  begin
    if (Application.MessageBox('Condi��o n�o encontrada', 'Aten��o', MB_OK) = idOK) then
      begin
        edtCdCondPgto.SetFocus;
      end;
  end;

end;

//busca a forma pgto
procedure TfrmPedidoVenda.edtCdFormaPgtoChange(Sender: TObject);
begin
  if edtCdFormaPgto.Text = EmptyStr then
    begin
      edtNomeFormaPgto.Text := '';
      exit;
    end;

  sqlPedidoVendaFormaPgto.Close;
  sqlPedidoVendaFormaPgto.SQL.Text := 'select '+
                                            'cd_forma_pag, '+
                                            'nm_forma_pag '+
                                        'from '+
                                            'cta_forma_pagamento '+
                                        'where '+
                                            '(cd_forma_pag = :cd_forma_pag) and (fl_ativo = true)';

  sqlPedidoVendaFormaPgto.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCdFormaPgto.Text);
  sqlPedidoVendaFormaPgto.Open();
  edtNomeFormaPgto.Text := sqlPedidoVendaFormaPgto.FieldByName('nm_forma_pag').AsString;
end;

//valida se n�o foi encontrado nenhuma forma de pagamento
procedure TfrmPedidoVenda.edtCdFormaPgtoExit(Sender: TObject);
begin
  if sqlPedidoVendaFormaPgto.IsEmpty then
  begin
    if (Application.MessageBox('Forma de Pagamento n�o encontrada', 'Aten��o', MB_OK) = idOK) then
      begin
        edtCdFormaPgto.SetFocus;
      end;
  end;
end;

//fazer tratamento ao trocar a tabela de pre�o, trocar os valores e a un_medida(se for diferente)
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

  sqlPedidoVendaProduto.Close;
  sqlPedidoVendaProduto.SQL.Text := 'select '+
                                          'p.cd_produto,    '+
                                          'p.desc_produto,  '+
                                          'tpp.un_medida,   '+
                                          'tpp.cd_tabela,   '+
                                          'tp.nm_tabela,    '+
                                          'tpp.valor        '+
                                      'from                 '+
                                          'produto p        '+
                                      'join tabela_preco_produto tpp on   '+
                                          'p.cd_produto = tpp.cd_produto  '+
                                      'join tabela_preco tp on            '+
                                          'tpp.cd_tabela = tp.cd_tabela   '+
                                      'where (p.cd_produto = :cd_produto) and (p.fl_ativo = true)';

  sqlPedidoVendaProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  sqlPedidoVendaProduto.Open();
  edtDescProduto.Text := sqlPedidoVendaProduto.FieldByName('desc_produto').AsString;
  edtUnMedida.Text := sqlPedidoVendaProduto.FieldByName('un_medida').AsString;
  edtCdtabelaPreco.Text := IntToStr(sqlPedidoVendaProduto.FieldByName('cd_tabela').AsInteger);
  edtDescTabelaPreco.Text := sqlPedidoVendaProduto.FieldByName('nm_tabela').AsString;
  edtVlUnitario.Text := CurrToStr(sqlPedidoVendaProduto.FieldByName('valor').AsCurrency);
end;

procedure TfrmPedidoVenda.edtCdProdutoExit(Sender: TObject);
begin
 if sqlPedidoVendaProduto.IsEmpty then
  begin
    ShowMessage('Produto sem pre�o Cadastrado ou Inativo! Verifique');
    edtCdtabelaPreco.Text := '';
    edtCdProduto.SetFocus;
  end;
end;

//busca a tabela de pre�o
procedure TfrmPedidoVenda.edtCdtabelaPrecoChange(Sender: TObject);
begin
  if edtCdtabelaPreco.Text = EmptyStr then
    begin
      edtDescTabelaPreco.Text := '';
      edtVlUnitario.Text := '';
      Exit;
    end;


  sqlPedidoVendaTabPreco.Close;
  sqlPedidoVendaTabPreco.SQL.Text := 'select '+
                                           'tp.cd_tabela, '+
                                           'tp.nm_tabela, '+
                                           'tpp.valor '+
                                      'from '+
                                          'tabela_preco tp '+
                                      'join tabela_preco_produto tpp on '+
                                          'tp.cd_tabela = tpp.cd_tabela '+
                                      'join produto p on '+
                                          'tpp.cd_produto = p.cd_produto '+
                                      'where (tp.cd_tabela = :cd_tabela) and (p.cd_produto = :cd_produto)';

  sqlPedidoVendaTabPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCdtabelaPreco.Text);
  sqlPedidoVendaTabPreco.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  sqlPedidoVendaTabPreco.Open();
  edtDescTabelaPreco.Text:= sqlPedidoVendaTabPreco.FieldByName('nm_tabela').AsString;
  edtVlUnitario.Text := CurrToStr(sqlPedidoVendaTabPreco.FieldByName('valor').AsCurrency);
end;

procedure TfrmPedidoVenda.edtCdtabelaPrecoExit(Sender: TObject);
var valor_total, vl_unitario, qtdade : Currency;
begin
  if sqlPedidoVendaTabPreco.IsEmpty then
    begin
      if (Application.MessageBox('Tabela de Pre�o n�o encontrada', 'Aten��o', MB_OK) = idOK) then
        begin
          edtCdtabelaPreco.SetFocus;
        end;
    end
  else
    begin
    //recalcula o valor total do item ao alterar a tabela de pre�o
      vl_unitario := StrToCurr(edtVlUnitario.Text);
      qtdade := StrToCurr(edtQtdade.Text);
      valor_total := qtdade * vl_unitario;
      edtVlTotal.Text := CurrToStr(valor_total);
      edtVlDescontoItem.Enabled := true;
    end;
end;

//calcula o valor total do item ao alterar a quantidade
procedure TfrmPedidoVenda.edtQtdadeChange(Sender: TObject);
var valor_total, vl_unitario, qtdade : Currency;
begin
  if edtQtdade.Text = EmptyStr then
    begin
      edtVlTotal.Text := '';
      Exit;
    end
  else
    begin
      vl_unitario := StrToCurr(edtVlUnitario.Text);
      qtdade := StrToCurr(edtQtdade.Text);
      valor_total := qtdade * vl_unitario;
      edtVlTotal.Text := CurrToStr(valor_total);
      edtVlDescontoItem.Enabled := true;
    end;
end;


procedure TfrmPedidoVenda.edtQtdadeExit(Sender: TObject);
begin
  valida_qtdade_item;
end;

procedure TfrmPedidoVenda.edtVlAcrescimoTotalPedidoExit(Sender: TObject);
var
  vl_total_com_acrescimo, vl_acrescimo, vl_total_pedido, valor_total, valor_desconto : Currency;
begin
//fazer o calculo para adicionar o valor de acrescimo ao valor total do pedido
  if (edtVlAcrescimoTotalPedido.Text = '0') or (edtVlAcrescimoTotalPedido.Text = '0,00') then
    begin
      edtVlAcrescimoTotalPedido.Text := CurrToStr(0);
      valor_total := 0;
      with ClientDataSet1 do
        begin
          ClientDataSet1.DisableControls;
          ClientDataSet1.First;
          while not ClientDataSet1.Eof do
            begin
              valor_total := (valor_total + ClientDataSet1.FieldByName('Valor Total').AsCurrency);
              ClientDataSet1.Next;
            end;
            edtVlTotalPedido.Text := CurrToStr(valor_total);
            ClientDataSet1.EnableControls;
        end;
    end
  else
    begin
      valor_desconto := StrToCurr(edtVlDescTotalPedido.Text); //desconto no total do pedido
      vl_total_pedido := 0;
      vl_acrescimo := StrToCurr(edtVlAcrescimoTotalPedido.Text);
      with ClientDataSet1 do
        begin
          ClientDataSet1.DisableControls;
          ClientDataSet1.First;
          while not ClientDataSet1.Eof do
            begin
              vl_total_pedido := (vl_total_pedido + ClientDataSet1.FieldByName('Valor Total').AsCurrency);
              ClientDataSet1.Next;
            end;
            ClientDataSet1.EnableControls;
        end;

        vl_total_com_acrescimo := (vl_total_pedido + vl_acrescimo) - valor_desconto;
        edtVlTotalPedido.Text := CurrToStr(vl_total_com_acrescimo);
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
          with ClientDataSet1 do
            begin
              ClientDataSet1.DisableControls;
              ClientDataSet1.First;
              while not ClientDataSet1.Eof do
                begin
                  valor_total := (valor_total + ClientDataSet1.FieldByName('Valor Total').AsCurrency);
                  ClientDataSet1.Next;
                end;
                edtVlTotalPedido.Text := CurrToStr(valor_total);
                ClientDataSet1.EnableControls;
            end;
        end
      else
        begin
          vl_total_pedido := 0;
          vl_desconto := StrToCurr(edtVlDescTotalPedido.Text);
          with ClientDataSet1 do
            begin
              ClientDataSet1.DisableControls;
              ClientDataSet1.First;
              while not ClientDataSet1.Eof do
                begin
                  vl_total_pedido := (vl_total_pedido + ClientDataSet1.FieldByName('Valor Total').AsCurrency);
                  ClientDataSet1.Next;
                end;
                //edtVlTotalPedido.Text := CurrToStr(valor_total);
                ClientDataSet1.EnableControls;
            end;

          vl_total_com_desconto := vl_total_pedido - vl_desconto;
          edtVlTotalPedido.Text := CurrToStr(vl_total_com_desconto);
        end;
    end;

//passa pelos campos com enter (n�o t� funcionando)
procedure TfrmPedidoVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;


procedure TfrmPedidoVenda.valida_qtdade_item;
var
  qtdade : Integer;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select qtd_estoque from produto where cd_produto = :cd_produto';
  FDQuery1.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  FDQuery1.Open();
  qtdade := FDQuery1.Fields[0].Value;

  if edtQtdade.Text = '0' then
    begin
      ShowMessage('Informe uma quantidade maior que 0');
      edtQtdade.SetFocus;
    end;
  
  if (edtQtdade.Text > IntToStr(qtdade)) then
    begin
      ShowMessage('Quantidade informada maior que a dispon�vel.' + #13 +'Quantidade dispon�vel: ' + IntToStr(qtdade));
      edtQtdade.SetFocus;
      Exit;
    end;
end;
end.
