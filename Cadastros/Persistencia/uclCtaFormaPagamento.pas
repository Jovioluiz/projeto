unit uclCtaFormaPagamento;

interface

type TCtaFormaPagamento = class
  private
    Ftp_classificacao: Integer;
    Ffl_ativo: Boolean;
    Fnm_forma_pgto: string;
    Fcd_forma_pgto: Integer;
    procedure Setcd_forma_pgto(const Value: Integer);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setnm_forma_pgto(const Value: string);
    procedure Settp_classificacao(const Value: Integer);

  public
    function Pesquisar(CdForma: Integer): Boolean;
    procedure Atualizar;
    procedure Inserir;
    procedure Excluir;
    property cd_forma_pgto: Integer read Fcd_forma_pgto write Setcd_forma_pgto;
    property nm_forma_pgto: string read Fnm_forma_pgto write Setnm_forma_pgto;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;
    property tp_classificacao: Integer read Ftp_classificacao write Settp_classificacao;
end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils, FireDAC.Stan.Param, Data.DB;

{ TCtaFormaPagamento }

procedure TCtaFormaPagamento.Atualizar;
const
  SQL =
    'update                             ' +
    '   cta_forma_pagamento                ' +
    'set                                ' +
    '   nm_forma_pag = :nm_forma_pag,   ' +
    '   fl_ativo = :fl_ativo,            ' +
    '   tp_classificacao = :tp_classificacao ' +
    'where                                  ' +
    '   cd_forma_pag = :cd_forma_pag';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('nm_forma_pag').AsString := Fnm_forma_pgto;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('tp_classificacao').AsInteger := Ftp_classificacao;
      qry.ParamByName('cd_forma_pag').AsInteger := Fcd_forma_pgto;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da Forma de Pagamento' + Fcd_forma_pgto.ToString + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TCtaFormaPagamento.Excluir;
const
  SQL =
      'delete '+
      '   from '+
      '   cta_forma_pagamento '+
      'where '+
      '   cd_forma_pag = :cd_forma_pag';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_forma_pag').AsInteger := Fcd_forma_pgto;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir os dados da Forma de Pagamento ' + Fcd_forma_pgto.ToString + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TCtaFormaPagamento.Inserir;
const
  SQL =
    'insert                                '+
    '   into                              '+
    '   cta_forma_pagamento(cd_forma_pag, '+
    '   nm_forma_pag,                     '+
    '   fl_ativo,                         '+
    '   tp_classificacao)                 '+
    'values (:cd_forma_pag,                '+
    '   :nm_forma_pag,                    '+
    ' :fl_ativo,                        '+
    '   :tp_classificacao)';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('nm_forma_pag').AsString := Fnm_forma_pgto;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('tp_classificacao').AsInteger := Ftp_classificacao;
      qry.ParamByName('cd_forma_pag').AsInteger := Fcd_forma_pgto;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados da Forma de Pagamento ' + Fcd_forma_pgto.ToString + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TCtaFormaPagamento.Pesquisar(CdForma: Integer): Boolean;
const
  SQL =
      'select ' +
      '    * ' +
      'from ' +
      '    cta_forma_pagamento cfp ' +
      'where ' +
      '    cd_forma_pag = :cd_forma_pag ';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_forma_pag').AsInteger := CdForma;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TCtaFormaPagamento.Setcd_forma_pgto(const Value: Integer);
begin
  Fcd_forma_pgto := Value;
end;

procedure TCtaFormaPagamento.Setfl_ativo(const Value: Boolean);
begin
  Ffl_ativo := Value;
end;

procedure TCtaFormaPagamento.Setnm_forma_pgto(const Value: string);
begin
  Fnm_forma_pgto := Value;
end;

procedure TCtaFormaPagamento.Settp_classificacao(const Value: Integer);
begin
  Ftp_classificacao := Value;
end;

end.
