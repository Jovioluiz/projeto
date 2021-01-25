unit uclTabelaPreco;

interface

uses
  uclPadrao, Data.DB;

type TTabelaPreco = class(TPadrao)
  private
    Fnm_tabela: string;
    Ffl_ativo: Boolean;
    Fdt_fim: TDateTime;
    Fdt_inicio: TDateTime;
    Fcd_tabela: Integer;
    procedure Setcd_tabela(const Value: Integer);
    procedure Setdt_fim(const Value: TDateTime);
    procedure Setdt_inicio(const Value: TDateTime);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setnm_tabela(const Value: string);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(CdTabela: Integer): Boolean;
    procedure Buscar(CdTabela: Integer);

    property cd_tabela: Integer read Fcd_tabela write Setcd_tabela;
    property nm_tabela: string read Fnm_tabela write Setnm_tabela;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;
    property dt_inicio: TDateTime read Fdt_inicio write Setdt_inicio;
    property dt_fim: TDateTime read Fdt_fim write Setdt_fim;

end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils, FireDAC.Stan.Param;

{ TTabelaPreco }

procedure TTabelaPreco.Atualizar;
const
  SQL = 'update                        '+
              'tabela_preco            '+
        'set                           '+
              'nm_tabela = :nm_tabela, '+
              'fl_ativo = :fl_ativo,   '+
              'dt_inicio = :dt_inicio, '+
              'dt_fim = :dt_fim        '+
        'where cd_tabela = :cd_tabela';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('nm_tabela').AsString := Fnm_tabela;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('dt_inicio').AsDateTime := Fdt_inicio;
      qry.ParamByName('dt_fim').AsDateTime := Fdt_fim;
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados da tabela de preço ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TTabelaPreco.Buscar(CdTabela: Integer);
const
  SQL = 'select              '+
        '   cd_tabela,       '+
        '   nm_tabela,       '+
        '   fl_ativo,        '+
        '   dt_inicio,       '+
        '   dt_fim           '+
        'from                '+
        '   tabela_preco     '+
        'where               '+
        '   cd_tabela = :cd_tabela';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := CdTabela;
    qry.Open();

    if not qry.IsEmpty then
    begin
      Fcd_tabela := qry.FieldByName('cd_tabela').AsInteger;
      Fnm_tabela := qry.FieldByName('nm_tabela').AsString;
      Ffl_ativo := qry.FieldByName('fl_ativo').AsBoolean;
      Fdt_inicio := qry.FieldByName('dt_inicio').AsDateTime;
      Fdt_fim := qry.FieldByName('dt_fim').AsDateTime;
    end;
  finally
    qry.Free;
  end;
end;

procedure TTabelaPreco.Excluir;
const
    SQL =  'delete                  '+
           '   from                 '+
           'tabela_preco            '+
           '   where                '+
           'cd_tabela = :cd_tabela';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ExecSQL;
      qry.Connection.Commit;

    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao excluir a tabela de preço ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TTabelaPreco.Inserir;
const
  SQL = 'insert                       '+
            'into                     '+
            'tabela_preco (cd_tabela, '+
            'nm_tabela,               '+
            'fl_ativo,                '+
            'dt_inicio,               '+
            'dt_fim)                  '+
        'values (:cd_tabela,          '+
            ':nm_tabela,              '+
            ':fl_ativo,               '+
            ':dt_inicio,              '+
            ':dt_fim)';
var
  qry: TFDquery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_tabela').AsInteger := Fcd_tabela;
      qry.ParamByName('nm_tabela').AsString := Fnm_tabela;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('dt_inicio').AsDateTime := Fdt_inicio;
      qry.ParamByName('dt_fim').AsDateTime := Fdt_fim;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados da tabela de preço ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

function TTabelaPreco.Pesquisar(CdTabela: Integer): Boolean;
const
  SQL = 'select '+
            'cd_tabela '+
        'from '+
            'tabela_preco '+
        'where '+
              'cd_tabela = :cd_tabela';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := CdTabela;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TTabelaPreco.Setcd_tabela(const Value: Integer);
begin
  Fcd_tabela := Value;
end;

procedure TTabelaPreco.Setdt_fim(const Value: TDateTime);
begin
  Fdt_fim := Value;
end;

procedure TTabelaPreco.Setdt_inicio(const Value: TDateTime);
begin
  Fdt_inicio := Value;
end;

procedure TTabelaPreco.Setfl_ativo(const Value: Boolean);
begin
  Ffl_ativo := Value;
end;

procedure TTabelaPreco.Setnm_tabela(const Value: string);
begin
  Fnm_tabela := Value;
end;

end.
