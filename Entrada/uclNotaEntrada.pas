unit uclNotaEntrada;

interface

uses uDataModule, Data.DB, FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dNotaEntrada;

type TNotaEntrada = class
  private
    FDadosNota: TdmNotaEntrada;
    procedure SetDadosNota(const Value: TdmNotaEntrada);

  public
    function BuscaClienteFornecedor(CodCliente: Integer): Boolean;
    function GetIdItem(CdItem: string): Int64;

    constructor Create;
    destructor Destroy; override;

    property DadosNota: TdmNotaEntrada read FDadosNota write SetDadosNota;
end;

implementation

{ TValidacoesEntrada }

function TNotaEntrada.BuscaClienteFornecedor(CodCliente: Integer): Boolean;
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

constructor TNotaEntrada.Create;
begin
  FDadosNota := TdmNotaEntrada.Create(nil);
end;

destructor TNotaEntrada.Destroy;
begin
  FDadosNota.Free;
  inherited;
end;

function TNotaEntrada.GetIdItem(CdItem: string): Int64;
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

procedure TNotaEntrada.SetDadosNota(const Value: TdmNotaEntrada);
begin
  FDadosNota := Value;
end;

end.
