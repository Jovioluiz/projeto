unit UFuncoes;



interface

uses

System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uConexao, uPedidoVenda;

type

sqlPedidoVendaProduto: TFDQuery;

procedure valida_qtdade_item();


implementation

procedure TfrmPedidoVenda.valida_qtdade_item;
var
  qtdade : Integer;
begin
  sqlPedidoVendaProduto.Close;
  sqlPedidoVendaProduto.SQL.Text := 'select qtd_estoque from produto where cd_produto = :cd_produto';
  sqlPedidoVendaProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCdProduto.Text);
  sqlPedidoVendaProduto.Open();
  qtdade := sqlPedidoVendaProduto.Fields[0].Value;
  sqlPedidoVendaProduto.Close;

  if qtdade <= 0 then
    begin
      if (Application.MessageBox('Quantidade informada maior que a disponível', 'Estoque Indisponivel', MB_OK) = idOK) then
        begin
          edtQtdade.SetFocus;
        end;
    end;

end;

end.
