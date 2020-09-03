unit uclPedidoVenda;

interface

uses
  uPedidoVenda, uDataModule, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.UITypes, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type TPedidoVenda = class

  private
  public
    function ValidaQtdadeItem(CodProduto: Integer; QtdPedido: Double): Boolean;
    function CalcValorTotalItem(valorUnitario, qtdadeItem: Double): Double;
    function ValidaFormaPgto(CdFormaPgto: Integer): Boolean;
    function ValidaCliente(CdCliente: Integer): Boolean;
    function ValidaCondPgto(CdCond, CdForma: Integer): Boolean;
    function ValidaCodProduto(CdProduto: Integer): Boolean;
    function ValidaTabelaPreco(CdTabela, CdProduto: Integer): Boolean;

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

function TPedidoVenda.ValidaCodProduto(CdProduto: Integer): Boolean;
const
  sql_produto = 'select '+
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
    qry.Close;
    qry.SQL.Add(sql_produto);
    qry.ParamByName('cd_produto').AsInteger := CdProduto;
    qry.Open(sql_produto);

    Result := qry.IsEmpty;
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

function TPedidoVenda.ValidaTabelaPreco(CdTabela, CdProduto: Integer): Boolean;
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
            'tpp.cd_produto = p.cd_produto  '+
        'where (tp.cd_tabela = :cd_tabela)  '+
        'and (p.cd_produto = :cd_produto)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.FDConnection1;

  try
    qry.Close;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_tabela').AsInteger := CdTabela;
    qry.ParamByName('cd_produto').AsInteger := CdProduto;
    qry.Open(sql);
    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

end.
