unit uclValidacoesEntrada;

interface

uses uDataModule, Data.DB, FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type TValidacoesEntrada = class
  private

  public
    function BuscaClienteFornecedor(CodCliente: Integer): Boolean;


end;

implementation

{ TValidacoesEntrada }

function TValidacoesEntrada.BuscaClienteFornecedor(CodCliente: Integer): Boolean;
const
  sql = 'select                       '+
          'cd_cliente,                '+
          'nome                       '+
        'from                         '+
           'cliente c2                '+
        'where                        '+
            'cd_cliente = :cd_cliente';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_cliente').AsInteger := CodCliente;
    qry.Open(sql);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

end.
