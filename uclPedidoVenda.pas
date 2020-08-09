unit uclPedidoVenda;

interface

uses
  uPedidoVenda, uDataModule, Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.UITypes, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param;

type TPedidoVenda = class

  private


  public
    function ValidaQtdadeItem(CodProduto: Integer; QtdPedido: Double) : Boolean;

end;

implementation


{ TPedidoVenda }

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
