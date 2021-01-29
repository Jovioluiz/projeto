unit uEnderecoWMS;

interface

uses
  FireDAC.Stan.Param;

type TEnderecoWMS = class
  private

  public
    function GetIdItem(CdItem: string): Int64;
    function GetIdEndereco(NomeEndereco: String): Int64;
end;

implementation

uses
  FireDAC.Comp.Client, uDataModule;

function TEnderecoWMS.GetIdEndereco(NomeEndereco: String): Int64;
const
  SQL = 'select ' +
        '   id_geral    ' +
        'from            ' +
        '   wms_endereco we ' +
        'where               ' +
        '   concat(cd_deposito, ''-'', ala, ''-'', rua) = :nm_endereco ' +
        'limit 1';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('nm_endereco').AsString := NomeEndereco;
    qry.Open(SQL);

    Result := qry.FieldByName('id_geral').AsInteger;
  finally
    qry.Free;
  end;
end;

function TEnderecoWMS.GetIdItem(CdItem: string): Int64;
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

end.
