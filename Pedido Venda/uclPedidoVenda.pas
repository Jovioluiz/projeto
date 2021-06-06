unit uclPedidoVenda;

interface

uses
  uDataModule, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.UITypes, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections, dPedidoVenda;

type TPedidoVenda = class

  type
    TInfProdutosCodBarras = record
      CodItem,
      DescProduto,
      UnMedida,
      DescTabelaPreco: string;
      CdTabelaPreco: Integer;
      Valor: Currency;
    end;
  private
    FDados: TdmPedidoVenda;
    procedure SetDados(const Value: TdmPedidoVenda);

  public
    function ValidaQtdadeItem(CdItem: String; QtdPedido: Double): Boolean;
    function CalculaValorTotalItem(valorUnitario, qtdadeItem: Double): Double;
    function ValidaFormaPgto(CdFormaPgto: Integer): Boolean;
    function ValidaCliente(CdCliente: Integer): Boolean;
    function ValidaCondPgto(CdCond, CdForma: Integer): Boolean;
    function BuscaProduto(CodProduto: String): TFDQuery;
    procedure BuscaProdutoCodBarras(CodBarras: String);
    function ValidaProduto(CodProduto: String): Boolean;
    function BuscaTabelaPreco(CodTabela: Integer; CodProduto: String): TList<string>;
    function ValidaTabelaPreco(CodTabela: Integer; CodProduto: String): Boolean;
    function BuscaFormaPgto(CodForma: Integer): TList<string>;
    function BuscaCondicaoPgto(CodCond, CodForma: Integer): TList<string>;
    function isCodBarrasProduto(Cod: String): Boolean;
    function GetIdItem(CdItem: string): Int64;
    procedure PreencheDataSet(Info: TArray<TInfProdutosCodBarras>);

    property Dados: TdmPedidoVenda read FDados write SetDados;

    constructor Create;
    destructor Destroy; override;
end;

implementation

uses
  Datasnap.DBClient;


{ TPedidoVenda }

function TPedidoVenda.ValidaCliente(CdCliente: Integer): Boolean;
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
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;
  Result := True;

  try
    try
      qry.SQL.Add(sql_cliente);
      qry.ParamByName('cd_cliente').AsInteger := CdCliente;
      qry.Open(sql_cliente);

      if not qry.IsEmpty then
        Result := True
      else
        Result := False;
    except
      on E: Exception do
        ShowMessage(
        'Ocorreu um erro.' + #13 +
        'Mensagem de erro: ' + E.Message);
    end;
  finally
    qry.Free;
  end;
end;

function TPedidoVenda.ValidaCondPgto(CdCond, CdForma: Integer): Boolean;
const
  sql_condPgto = 'select                                         '+
                 '    ccp.cd_cond_pag,                           '+
                 '    ccp.nm_cond_pag                            '+
                 'from cta_cond_pagamento ccp                    '+
                 '    join cta_forma_pagamento cfp on            '+
                 'ccp.cd_cta_forma_pagamento = cfp.cd_forma_pag  '+
                 '    where (ccp.cd_cond_pag = :cd_cond_pag) and '+
                 '(cfp.cd_forma_pag = :cd_forma_pag) and         '+
                 '(ccp.fl_ativo = true)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add(sql_condPgto);
    qry.ParamByName('cd_cond_pag').AsInteger := CdCond;
    qry.ParamByName('cd_forma_pag').AsInteger := CdForma;
    qry.Open(sql_condPgto);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;


function TPedidoVenda.ValidaFormaPgto(CdFormaPgto: Integer): Boolean;
const
  sql_forma_pgto =  'select                                '+
                    '   cd_forma_pag                       '+
                    'from                                  '+
                    '   cta_forma_pagamento                '+
                    'where                                 '+
                    '   (cd_forma_pag = :cd_forma_pag) and '+
                    '   (fl_ativo = true)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  Result := True;

  try
    try
      qry.Close;
      qry.SQL.Clear;

      qry.SQL.Add(sql_forma_pgto);
      qry.ParamByName('cd_forma_pag').AsInteger := CdFormaPgto;
      qry.Open(sql_forma_pgto);

      Result := qry.IsEmpty;
    except
      on E: Exception do
        ShowMessage(
        'Ocorreu um erro.' + #13 +
        'Mensagem de erro: ' + E.Message);
    end;
  finally
    qry.Free;
  end;
end;

function TPedidoVenda.ValidaProduto(CodProduto: String): Boolean;
const
  SQL_COD = 'select '+
            '   p.cd_produto                  '+
            'from                             '+
            '   produto p                     '+
            'join tabela_preco_produto tpp on '+
            '   p.id_item = tpp.id_item       '+
            'join tabela_preco tp on          '+
            '   tpp.cd_tabela = tp.cd_tabela  '+
            'where (p.cd_produto = :cd_produto) '+
            '   and (p.fl_ativo = True)';

  SQL_BARRAS =
        'select ' +
        '    p.cd_produto ' +
        'from ' +
        '    produto p ' +
        'join tabela_preco_produto tpp on ' +
        '    p.id_item = tpp.id_item ' +
        'join tabela_preco tp on ' +
        '    tpp.cd_tabela = tp.cd_tabela ' +
        'join produto_cod_barras pcb on ' +
        '    pcb.id_item = p.id_item ' +
        'where ' +
        '    (pcb.codigo_barras = :codigo_barras) ' +
        '    and (p.fl_ativo = True) ' +
        'limit 1 ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL_COD);
    qry.ParamByName('cd_produto').AsString := CodProduto;
    qry.Open(SQL_COD);

    if not qry.IsEmpty then
      Exit(True);

    Result := True;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(SQL_BARRAS);
    qry.ParamByName('codigo_barras').AsString := CodProduto;
    qry.Open(SQL_BARRAS);

    if not qry.IsEmpty then
      Exit(True);

  finally
    qry.Free;
  end;
end;

function TPedidoVenda.BuscaCondicaoPgto(CodCond, CodForma: Integer): TList<string>;
const
  sql = 'select                                        '+
       '    ccp.cd_cond_pag,                           '+
       '    ccp.nm_cond_pag                            '+
       'from cta_cond_pagamento ccp                    '+
       '    join cta_forma_pagamento cfp on            '+
       'ccp.cd_cta_forma_pagamento = cfp.cd_forma_pag  '+
       '    where (ccp.cd_cond_pag = :cd_cond_pag) and '+
       '(cfp.cd_forma_pag = :cd_forma_pag) and         '+
       '    (ccp.fl_ativo = true)';
var
  qry: TFDQuery;
  lista: TList<string>;
  nmCond: string;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  lista := TList<string>.Create;

  try
    Result := nil;
    qry.Open(sql, [CodCond, CodForma]);

    if not qry.IsEmpty then
    begin
      nmCond := qry.FieldByName('nm_cond_pag').AsString;

      lista.Add(nmCond);
      Result := lista;
    end;

  finally
    qry.Free;
  end;
end;

function TPedidoVenda.BuscaFormaPgto(CodForma: Integer): TList<string>;
const
  sql = 'select                                '+
        '   cd_forma_pag,                      '+
        '   nm_forma_pag                       '+
        'from                                  '+
        '   cta_forma_pagamento                '+
        'where                                 '+
        '   (cd_forma_pag = :cd_forma_pag) and '+
        '   (fl_ativo = true)';
var
  qry: TFDQuery;
  lista: TList<string>;
  nmForma: string;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  lista := TList<string>.Create;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_forma_pag').AsInteger := CodForma;
    qry.Open(sql);

    nmForma := qry.FieldByName('nm_forma_pag').AsString;
    lista.Add(nmForma);
    Result := lista;
  finally
    qry.Free;
  end;
end;

procedure TPedidoVenda.BuscaProdutoCodBarras(CodBarras: String);
const
  sql = 'select ' +
        '    p.cd_produto, ' +
        '    p.desc_produto, ' +
        '    tpp.un_medida, ' +
        '    tpp.cd_tabela, ' +
        '    tp.nm_tabela, ' +
        '    tpp.valor ' +
        'from ' +
        '    produto p ' +
        'join tabela_preco_produto tpp on ' +
        '    p.id_item = tpp.id_item ' +
        'join tabela_preco tp on ' +
        '    tpp.cd_tabela = tp.cd_tabela ' +
        'join produto_cod_barras pcb on ' +
        '    pcb.id_item = p.id_item ' +
        'where ' +
        '    (pcb.codigo_barras = :codigo_barras) ' +
        '    and (p.fl_ativo = True) ' +
        'limit 1 ';
var
  qry: TFDQuery;
  j: Integer;
  infoProdutos: TArray<TInfProdutosCodBarras>;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('codigo_barras').AsString := CodBarras;
    qry.Open();

    SetLength(infoProdutos, qry.RecordCount);

    for j := 0 to Length(infoProdutos) - 1 do
    begin
      infoProdutos[j].CodItem := qry.FieldByName('cd_produto').AsString;
      infoProdutos[j].DescProduto :=  qry.FieldByName('desc_produto').AsString;
      infoProdutos[j].UnMedida := qry.FieldByName('un_medida').AsString;
      infoProdutos[j].CdTabelaPreco := qry.FieldByName('cd_tabela').AsInteger;
      infoProdutos[j].DescTabelaPreco := qry.FieldByName('nm_tabela').AsString;
      infoProdutos[j].Valor := qry.FieldByName('valor').AsCurrency;
    end;

    PreencheDataSet(infoProdutos);

  finally
    qry.Free;
  end;

end;

function TPedidoVenda.BuscaProduto(CodProduto: String): TFDQuery;
const
  sql = 'select '+
            'p.cd_produto,                  '+
            'p.desc_produto,                '+
            'tpp.un_medida,                 '+
            'tp.cd_tabela,                  '+
            'tp.nm_tabela,                  '+
            'tpp.valor                      '+
        'from                               '+
            'produto p                      '+
        'join tabela_preco_produto tpp on   '+
            'p.id_item = tpp.id_item        '+
        'join tabela_preco tp on            '+
            'tpp.cd_tabela = tp.cd_tabela   '+
        'where (p.cd_produto = :cd_produto::text) '+
        'and (p.fl_ativo = True)';
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := dm.conexaoBanco;

  Result.SQL.Add(sql);
  Result.Open(sql, [CodProduto]);

  if Result.RecordCount = 0 then
    raise Exception.Create('Produto não encontrado');

end;

function TPedidoVenda.BuscaTabelaPreco(CodTabela: Integer; CodProduto: String): TList<string>;
const
  sql = 'select                           '+
        '   tp.cd_tabela,                 '+
        '   tp.nm_tabela,                 '+
        '   tpp.valor                     '+
        'from                             '+
        '   tabela_preco tp               '+
        'join tabela_preco_produto tpp on '+
        '   tp.cd_tabela = tpp.cd_tabela  '+
        'join produto p on                '+
        '   tpp.id_item = p.id_item '+
        'where (tp.cd_tabela = :cd_tabela)'+
        '   and (p.cd_produto = :cd_produto)';
var
  qry: TFDQuery;
  lista: TList<string>;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  lista := TList<string>.Create;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_tabela').AsInteger := CodTabela;
    qry.ParamByName('cd_produto').AsString := CodProduto;
    qry.Open(sql);

    lista.Add(qry.FieldByName('nm_tabela').AsString);
    lista.Add(qry.FieldByName('valor').AsString);

    Result := lista;
  finally
    qry.Free;
  end;
end;

function TPedidoVenda.CalculaValorTotalItem(valorUnitario, qtdadeItem: Double): Double;
begin
  Result := valorUnitario * qtdadeItem;
end;

constructor TPedidoVenda.Create;
begin
  FDados := TdmPedidoVenda.Create(nil);
end;

destructor TPedidoVenda.Destroy;
begin
  FDados.Free;
  inherited;
end;

function TPedidoVenda.GetIdItem(CdItem: string): Int64;
const
  SQL = 'select id_item from produto where cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_produto').AsString := CdItem;
    qry.Open();

    Result := qry.FieldByName('id_item').AsLargeInt;

  finally
    qry.Free;
  end;
end;

function TPedidoVenda.isCodBarrasProduto(Cod: String): Boolean;
const
  SQL =
    'select ' +
    '    * ' +
    'from ' +
    '    produto_cod_barras pcb ' +
    'where ' +
    '    codigo_barras = :codigo_barras ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('codigo_barras').AsString := Cod;
    qry.Open();

    Result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

procedure TPedidoVenda.PreencheDataSet(Info: TArray<TInfProdutosCodBarras>);
var
  dataset: TClientDataSet;
  dataSource: TDataSource;
begin
  dataset := TClientDataSet.Create(nil);
  dataSource := TDataSource.Create(nil);

  //fiz isso somente para praticar
  try
    dataSource.DataSet := dataset;

    dataset.FieldDefs.Clear;
    dataset.FieldDefs.Add('cd_produto', ftString, 50);
    dataset.FieldDefs.Add('desc_produto', ftString, 50);
    dataset.FieldDefs.Add('un_medida', ftString, 5);
    dataset.FieldDefs.Add('cd_tabela', ftInteger);
    dataset.FieldDefs.Add('nm_tabela', ftString, 50);
    dataset.FieldDefs.Add('valor', ftCurrency);
    dataset.CreateDataSet;

    for var i := 0 to Length(Info) - 1 do
    begin
      dataset.Append;
      dataset.FieldByName('cd_produto').AsString := Info[i].CodItem;
      dataset.FieldByName('desc_produto').AsString := Info[i].DescProduto;
      dataset.FieldByName('un_medida').AsString := Info[i].UnMedida;
      dataset.FieldByName('cd_tabela').AsInteger := Info[i].CdTabelaPreco;
      dataset.FieldByName('nm_tabela').AsString := Info[i].DescTabelaPreco;
      dataset.FieldByName('valor').AsCurrency := Info[i].Valor;
      dataset.Post;
    end;

  finally
    dataset.Free;
    dataSource.Free;
  end;
end;

procedure TPedidoVenda.SetDados(const Value: TdmPedidoVenda);
begin
  FDados := Value;
end;

function TPedidoVenda.ValidaQtdadeItem(CdItem: String; QtdPedido: Double): Boolean;
const
  SQL = 'select               '+
        '  qt_estoque         '+
        'from                 '+
        '  wms_estoque        '+
        'where                '+
        '  id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  Result := True;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('id_item').AsLargeInt := GetIdItem(CdItem);
    qry.Open();

    if qry.IsEmpty then
      Exit(False);

    if QtdPedido > qry.FieldByName('qt_estoque').AsFloat then
    begin
      ShowMessage('Quantidade informada maior que a disponível.'
                  + #13 + 'Quantidade disponível: ' + FloatToStr(qry.FieldByName('qt_estoque').AsFloat));
      Result := False;
    end;

  finally
    qry.Free;
  end;
end;

function TPedidoVenda.ValidaTabelaPreco(CodTabela: Integer; CodProduto: String): Boolean;
const
  sql = 'select                             '+
             'tp.cd_tabela,                 '+
             'tp.nm_tabela,                 '+
             'tpp.valor                     '+
        'from                               '+
            'tabela_preco tp                '+
        'join tabela_preco_produto tpp on   '+
            'tp.cd_tabela = tpp.cd_tabela   '+
        'join produto p on                  '+
            'tpp.id_item = p.id_item  '+
        'where (tp.cd_tabela = :cd_tabela)  '+
        'and (p.cd_produto = :cd_produto::text)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_tabela').AsInteger := CodTabela;
    qry.ParamByName('cd_produto').AsString := CodProduto;
    qry.Open(sql);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

end.
