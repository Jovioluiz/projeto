unit uclTabelaPrecoProduto;

interface

uses
  uclPadrao;

type TTabelaPrecoProduto = class(TPadrao)
  private
    Fvalor: Currency;
    Fcd_produto: Integer;
    Fun_medida: string;
    Fcd_tabela: Integer;
    procedure Setcd_produto(const Value: Integer);
    procedure Setcd_tabela(const Value: Integer);
    procedure Setun_medida(const Value: string);
    procedure Setvalor(const Value: Currency);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(CdTabela, CdProduto: Integer): Boolean;

    property cd_tabela: Integer read Fcd_tabela write Setcd_tabela;
    property cd_produto: Integer read Fcd_produto write Setcd_produto;
    property valor: Currency read Fvalor write Setvalor;
    property un_medida: string read Fun_medida write Setun_medida;

end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils;

{ TTabelaPrecoProduto }

procedure TTabelaPrecoProduto.Atualizar;
const
  SQL = 'update '+
        '   tabela_preco_produto '+
        'set '+
        '   cd_tabela = :cd_tabela, '+
        '   cd_produto = :cd_produto, '+
        '   valor = :valor, '+
        '   un_medida = :un_medida  '+
        'where '+
        '   (cd_tabela = :cd_tabela) and '+
        '   (cd_produto = :cd_produto)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('cd_produto').AsInteger := Fcd_produto;
      qry.ParamByName('valor').AsCurrency := Fvalor;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ExecSQL;
      qry.Connection.Commit;

    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao atualizar o produto ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TTabelaPrecoProduto.Excluir;
begin
  inherited;

end;

procedure TTabelaPrecoProduto.Inserir;
const
  SQL = 'insert '+
        '   into '+
        'tabela_preco_produto(cd_tabela, '+
        '   cd_produto, '+
        '   valor, '+
        '   un_medida)'+
        'values (:cd_tabela, '+
        '   :cd_produto, '+
        '   :valor, '+
        '   :un_medida)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('cd_produto').AsInteger := Fcd_produto;
      qry.ParamByName('valor').AsCurrency := Fvalor;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ExecSQL;
      qry.Connection.Commit;

    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao adicionar o produto na tabela de preço ' + Fcd_tabela.ToString + ' ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

function TTabelaPrecoProduto.Pesquisar(CdTabela, CdProduto: Integer): Boolean;
const
  SQL = 'select                                     '+
        ' tpp.cd_produto                            '+
        'from tabela_preco tp                       '+
        ' join tabela_preco_produto tpp on          '+
        'tp.cd_tabela = tpp.cd_tabela               '+
        ' where (tp.cd_tabela = :cd_tabela) and     '+
        '(tpp.cd_produto = :cd_produto)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := CdTabela;
    qry.ParamByName('cd_produto').AsInteger := CdProduto;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TTabelaPrecoProduto.Setcd_produto(const Value: Integer);
begin
  Fcd_produto := Value;
end;

procedure TTabelaPrecoProduto.Setcd_tabela(const Value: Integer);
begin
  Fcd_tabela := Value;
end;

procedure TTabelaPrecoProduto.Setun_medida(const Value: string);
begin
  Fun_medida := Value;
end;

procedure TTabelaPrecoProduto.Setvalor(const Value: Currency);
begin
  Fvalor := Value;
end;

end.
