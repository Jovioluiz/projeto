unit uclTabelaPrecoProduto;

interface

uses
  uclPadrao, Data.DB;

type TTabelaPrecoProduto = class(TPadrao)
  private
    Fvalor: Currency;
    Fid_item: int64;
    Fun_medida: string;
    Fcd_tabela: Integer;
    procedure Setid_item(const Value: Int64);
    procedure Setcd_tabela(const Value: Integer);
    procedure Setun_medida(const Value: string);
    procedure Setvalor(const Value: Currency);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(CdTabela: Integer; IdItem: Int64): Boolean;

    property cd_tabela: Integer read Fcd_tabela write Setcd_tabela;
    property id_item: Int64 read Fid_item write Setid_item;
    property valor: Currency read Fvalor write Setvalor;
    property un_medida: string read Fun_medida write Setun_medida;

end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils, FireDAC.Stan.Param;

{ TTabelaPrecoProduto }

procedure TTabelaPrecoProduto.Atualizar;
const
  SQL = 'update '+
        '   tabela_preco_produto '+
        'set '+
        '   cd_tabela = :cd_tabela, '+
        '   id_item = :id_item, '+
        '   valor = :valor, '+
        '   un_medida = :un_medida  '+
        'where '+
        '   (cd_tabela = :cd_tabela) and '+
        '   (id_item = :id_item)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('valor').AsCurrency := Fvalor;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;

    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao atualizar o produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TTabelaPrecoProduto.Excluir;
const
  SQL = 'delete                   '+
        '   from                  '+
        'tabela_preco_produto     '+
        '   where                 '+
        '(id_item = :id_item) and '+
        '(cd_tabela = :cd_tabela)';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir o produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TTabelaPrecoProduto.Inserir;
const
  SQL = 'insert '+
        '   into '+
        'tabela_preco_produto(cd_tabela, '+
        '   id_item, '+
        '   valor, '+
        '   un_medida)'+
        'values (:cd_tabela, '+
        '   :id_item, '+
        '   :valor, '+
        '   :un_medida)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('valor').AsCurrency := Fvalor;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;

    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao adicionar o produto na tabela de preço ' + Fcd_tabela.ToString + ' ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TTabelaPrecoProduto.Pesquisar(CdTabela: Integer; IdItem: Int64): Boolean;
const
  SQL = 'select                                     '+
        ' tpp.id_item                               '+
        'from tabela_preco tp                       '+
        ' join tabela_preco_produto tpp on          '+
        'tp.cd_tabela = tpp.cd_tabela               '+
        ' where (tp.cd_tabela = :cd_tabela) and     '+
        '(tpp.id_item = :id_item)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := CdTabela;
    qry.ParamByName('id_item').AsInteger := IdItem;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TTabelaPrecoProduto.Setid_item(const Value: Int64);
begin
  fId_item := Value;
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
