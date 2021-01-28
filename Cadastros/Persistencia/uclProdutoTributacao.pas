unit uclProdutoTributacao;

interface

uses
  uclPadrao, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB;

type TProdutoTributacao = class(TPadrao)
  private
    Fid_item: Int64;
    Fcd_tributacao_pis_cofins: Integer;
    Fcd_tributacao_ipi: Integer;
    Fcd_tributacao_icms: Integer;
    procedure Setid_item(const Value: Int64);
    procedure Setcd_tributacao_icms(const Value: Integer);
    procedure Setcd_tributacao_ipi(const Value: Integer);
    procedure Setcd_tributacao_pis_cofins(const Value: Integer);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(IdItem: Int64): Boolean;

    property id_item: Int64 read Fid_item write Setid_item;
    property cd_tributacao_icms: Integer read Fcd_tributacao_icms write Setcd_tributacao_icms;
    property cd_tributacao_ipi: Integer read Fcd_tributacao_ipi write Setcd_tributacao_ipi;
    property cd_tributacao_pis_cofins: Integer read Fcd_tributacao_pis_cofins write Setcd_tributacao_pis_cofins;
end;

implementation

uses
  uDataModule, System.SysUtils;

{ TProdutoTributacao }

procedure TProdutoTributacao.Atualizar;
const
  SQL = 'update                                                  '+
        '   produto_tributacao                                   '+
        'set                                                     '+
        '   cd_tributacao_icms = :cd_tributacao_icms,            '+
        '   cd_tributacao_ipi = :cd_tributacao_ipi,              '+
        '   cd_tributacao_pis_cofins = :cd_tributacao_pis_cofins '+
        'where                                   '+
        '   id_item = :id_item';
var
  qry: TFDQuery;
begin
  //inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('cd_tributacao_icms').AsInteger := Fcd_tributacao_icms;
      qry.ParamByName('cd_tributacao_ipi').AsInteger := Fcd_tributacao_ipi;
      qry.ParamByName('cd_tributacao_pis_cofins').AsInteger := Fcd_tributacao_pis_cofins;

      qry.ExecSQL;
      qry.Connection.Commit;

    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados da tributação do produto ' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TProdutoTributacao.Excluir;
begin
  inherited;

end;

procedure TProdutoTributacao.Inserir;
const
  SQL = 'insert into                            '+
                'produto_tributacao(id_item,    '+
                'cd_tributacao_icms,            '+
                'cd_tributacao_ipi,             '+
                'cd_tributacao_pis_cofins)      '+
        'values (:id_item,                      '+
                ':cd_tributacao_icms,           '+
                ':cd_tributacao_ipi,            '+
                ':cd_tributacao_pis_cofins)';
var
  qry: TFDQuery;
begin
  //inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('cd_tributacao_icms').AsInteger := Fcd_tributacao_icms;
      qry.ParamByName('cd_tributacao_ipi').AsInteger := Fcd_tributacao_ipi;
      qry.ParamByName('cd_tributacao_pis_cofins').AsInteger := Fcd_tributacao_pis_cofins;

      qry.ExecSQL;
      qry.Connection.Commit;

    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados da tributação do produto ' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

function TProdutoTributacao.Pesquisar(IdItem: Int64): Boolean;
const
  SQL = 'select id_item from produto_tributacao pt '+
                   'left join grupo_tributacao_icms gti on '+
                   '    pt.cd_tributacao_icms = gti.cd_tributacao '+
                   'left join grupo_tributacao_ipi gtipi on '+
                   '    pt.cd_tributacao_ipi = gtipi.cd_tributacao '+
                   'left join grupo_tributacao_pis_cofins gtpc on '+
                   '    pt.cd_tributacao_pis_cofins = gtpc.cd_tributacao '+
                   'where pt.id_item = :id_item';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('id_item').AsInteger := IdItem;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TProdutoTributacao.Setid_item(const Value: Int64);
begin
  Fid_item := Value;
end;

procedure TProdutoTributacao.Setcd_tributacao_icms(const Value: Integer);
begin
  Fcd_tributacao_icms := Value;
end;

procedure TProdutoTributacao.Setcd_tributacao_ipi(const Value: Integer);
begin
  Fcd_tributacao_ipi := Value;
end;

procedure TProdutoTributacao.Setcd_tributacao_pis_cofins(const Value: Integer);
begin
  Fcd_tributacao_pis_cofins := Value;
end;

end.
