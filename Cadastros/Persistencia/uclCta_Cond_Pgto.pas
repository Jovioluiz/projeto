unit uclCta_Cond_Pgto;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, Data.DB;

type TCtaCondPgto = class
  private
    Fnr_parcelas: Integer;
    Ffl_ativo: Boolean;
    Fnm_cond_pgto: string;
    Fcd_cta_forma_pgto: Integer;
    Fvl_minimo_parcela: Currency;
    Fcd_cond_pgto: Integer;
    procedure Setcd_cond_pgto(const Value: Integer);
    procedure Setcd_cta_forma_pgto(const Value: Integer);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setnm_cond_pgto(const Value: string);
    procedure Setnr_parcelas(const Value: Integer);
    procedure Setvl_minimo_parcela(const Value: Currency);

  public
    function Pesquisar(CdCond: Integer): Boolean;
    procedure Atualizar;
    procedure Inserir;
    procedure Excluir;

    property cd_cond_pgto: Integer read Fcd_cond_pgto write Setcd_cond_pgto;
    property nm_cond_pgto: string read Fnm_cond_pgto write Setnm_cond_pgto;
    property cd_cta_forma_pgto: Integer read Fcd_cta_forma_pgto write Setcd_cta_forma_pgto;
    property nr_parcelas: Integer read Fnr_parcelas write Setnr_parcelas;
    property vl_minimo_parcela: Currency read Fvl_minimo_parcela write Setvl_minimo_parcela;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;

end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils;

{ TCtaCondPgto }

procedure TCtaCondPgto.Atualizar;
const
  SQL =
    'update ' +
    '    cta_cond_pagamento ' +
    'set ' +
    '    nm_cond_pag = :nm_cond_pag, ' +
    '    cd_cta_forma_pagamento = :cd_cta_forma_pagamento, ' +
    '    nr_parcelas = :nr_parcelas, ' +
    '    vl_minimo_parcela = :vl_minimo_parcela, ' +
    '    fl_ativo = :fl_ativo ' +
    'where ' +
    '    cd_cond_pag = :cd_cond_pag';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('nm_cond_pag').AsString := Fnm_cond_pgto;
      qry.ParamByName('cd_cta_forma_pagamento').AsInteger := Fcd_cta_forma_pgto;
      qry.ParamByName('nr_parcelas').AsInteger := Fnr_parcelas;
      qry.ParamByName('vl_minimo_parcela').AsCurrency := Fvl_minimo_parcela;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('cd_cond_pag').AsInteger := Fcd_cond_pgto;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da condição' + Fcd_cond_pgto.ToString + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TCtaCondPgto.Excluir;
const
  SQL =
    'delete ' +
    'from ' +
    '    cta_cond_pagamento ' +
    'where ' +
    '    cd_cond_pag = :cd_cond_pag ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cond_pag').AsInteger := Fcd_cond_pgto;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir os dados da condição ' + Fcd_cond_pgto.ToString + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TCtaCondPgto.Inserir;
const
  SQL =
      'insert ' +
      '    into ' +
      '    cta_cond_pagamento (cd_cond_pag, ' +
      '    nm_cond_pag, ' +
      '    cd_cta_forma_pagamento, ' +
      '    nr_parcelas, ' +
      '    vl_minimo_parcela, ' +
      '    fl_ativo) ' +
      'values (:cd_cond_pag, ' +
      ':nm_cond_pag, ' +
      ':cd_cta_forma_pagamento, ' +
      ':nr_parcelas, ' +
      ':vl_minimo_parcela, ' +
      ':fl_ativo) ';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cond_pag').AsInteger := Fcd_cond_pgto;
      qry.ParamByName('nm_cond_pag').AsString := Fnm_cond_pgto;
      qry.ParamByName('cd_cta_forma_pagamento').AsInteger := Fcd_cta_forma_pgto;
      qry.ParamByName('nr_parcelas').AsInteger := Fnr_parcelas;
      qry.ParamByName('vl_minimo_parcela').AsCurrency := Fvl_minimo_parcela;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da condição de pagamento ' + Fcd_cond_pgto.ToString + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TCtaCondPgto.Pesquisar(CdCond: Integer): Boolean;
const
  SQL = 'select       '+
            '*        '+
        'from         '+
            'cta_cond_pagamento  '+
        'where        '+
            'cd_cond_pag = :cd_cond_pag';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_cond_pag').AsInteger := CdCond;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TCtaCondPgto.Setcd_cond_pgto(const Value: Integer);
begin
  Fcd_cond_pgto := Value;
end;

procedure TCtaCondPgto.Setcd_cta_forma_pgto(const Value: Integer);
begin
  Fcd_cta_forma_pgto := Value;
end;

procedure TCtaCondPgto.Setfl_ativo(const Value: Boolean);
begin
  Ffl_ativo := Value;
end;

procedure TCtaCondPgto.Setnm_cond_pgto(const Value: string);
begin
  Fnm_cond_pgto := Value;
end;

procedure TCtaCondPgto.Setnr_parcelas(const Value: Integer);
begin
  Fnr_parcelas := Value;
end;

procedure TCtaCondPgto.Setvl_minimo_parcela(const Value: Currency);
begin
  Fvl_minimo_parcela := Value;
end;

end.
