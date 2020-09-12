unit uclPedidoVenda;

interface

uses
  uPedidoVenda, uDataModule, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.UITypes, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Generics.Collections;

type TPedidoVenda = class

  private
  public
    function ValidaQtdadeItem(CodProduto: Integer; QtdPedido: Double): Boolean;
    function CalcValorTotalItem(valorUnitario, qtdadeItem: Double): Double;
    function ValidaFormaPgto(CdFormaPgto: Integer): Boolean;
    function ValidaCliente(CdCliente: Integer): Boolean;
    function ValidaCondPgto(CdCond, CdForma: Integer): Boolean;
    function BuscaProduto(CodProduto: Integer): TList<String>;
    function ValidaProduto(CodProduto: Integer): Boolean;

end;

implementation


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
  qry.Connection := dm.FDConnection1;
  qry.Close;
  qry.SQL.Clear;

  qry.SQL.Add(sql_cliente);
  qry.ParamByName('cd_cliente').AsInteger := CdCliente;
  qry.Open(sql_cliente);

  if not qry.IsEmpty then
    Result := True
  else
    Result := False;
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
  qry.Connection := dm.FDConnection1;

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
  qry.Connection := dm.FDConnection1;

  try
    qry.Close;
    qry.SQL.Clear;

    qry.SQL.Add(sql_forma_pgto);
    qry.ParamByName('cd_forma_pag').AsInteger := CdFormaPgto;
    qry.Open(sql_forma_pgto);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TPedidoVenda.ValidaProduto(CodProduto: Integer): Boolean;
const
  sql = 'select '+
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
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := CodProduto;
    qry.Open(sql);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

function TPedidoVenda.BuscaProduto(CodProduto: Integer): TList<String>;
const
  sql = 'select '+
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
var
  qry: TFDQuery;
  lista: TList<string>;
  desc_produto,
  un_medida, cd_tabela, nm_tabela, valor: string;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.FDConnection1;
  lista := TList<string>.Create;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := CodProduto;
    qry.Open(sql);

    desc_produto := qry.FieldByName('desc_produto').AsString;
    un_medida := qry.FieldByName('un_medida').AsString;
    cd_tabela := qry.FieldByName('cd_tabela').AsString;
    nm_tabela := qry.FieldByName('nm_tabela').AsString;
    valor := qry.FieldByName('valor').AsString;

    //retorna em uma lista
    lista.Add(desc_produto);
    lista.Add(un_medida);
    lista.Add(cd_tabela);
    lista.Add(nm_tabela);
    lista.Add(valor);

    Result := lista;
  finally
    qry.Free;
  end;

end;

function TPedidoVenda.CalcValorTotalItem(valorUnitario,
  qtdadeItem: Double): Double;
var
  vlTotal, vlUnitario, qtdade: Double;
begin
  vlUnitario := valorUnitario;
  qtdade := qtdadeItem;
  vlTotal := vlUnitario * qtdade;

  Result := vlTotal;
end;

function TPedidoVenda.ValidaQtdadeItem(CodProduto: Integer; QtdPedido: Double): Boolean;
const
  qry = 'select               '+
        '  qtd_estoque        '+
        'from                 '+
        '  produto            '+
        'where                '+
        '  cd_produto = :cd_produto';
var
  qtPedido, qtEstoque: Double;
begin
  Result := False;
  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Add(qry);
  dm.query.ParamByName('cd_produto').AsInteger := CodProduto;
  dm.query.Open(qry);

  if dm.query.IsEmpty then
    Exit;

  qtPedido := QtdPedido;
  qtEstoque := dm.query.FieldByName('qtd_estoque').AsFloat;

  if qtPedido > qtEstoque then
  begin
    Result := True;
  end;
end;

end.
