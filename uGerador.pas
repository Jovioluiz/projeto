unit uGerador;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type TGerador = class
  private

  public

  function GeraIdGeral: Int64;
end;

implementation

uses
  uDataModule;

{ TGerador }

function TGerador.GeraIdGeral: Int64;
const
  sqlIdGeral = 'select '+
                '* '+
                'from func_id_geral()';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sqlIdGeral);
    qry.Open(sqlIdGeral);

    Result := qry.FieldByName('func_id_geral').AsLargeInt;
  finally
    qry.Free;
  end;
end;

end.
