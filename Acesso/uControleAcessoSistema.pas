unit uControleAcessoSistema;

interface

uses
  dControleAcesso, uUtil;

type TControleAcessoSistema = class
  private
    FDados: TdmControleAcesso;
    procedure SetDados(const Value: TdmControleAcesso);


  public

  procedure Listar(CdUsuario: Integer);
  procedure Excluir(CdAcao, CdUsuario: Integer);
  constructor Create;
  destructor Destroy; override;
  property Dados: TdmControleAcesso read FDados write SetDados;

end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils, Vcl.Dialogs, System.Math;

{ TControleAcessoSistema }

constructor TControleAcessoSistema.Create;
begin
  FDados := TdmControleAcesso.Create(nil);
end;

destructor TControleAcessoSistema.Destroy;
begin
  FDados.Free;
  inherited;
end;

procedure TControleAcessoSistema.Excluir(CdAcao, CdUsuario: Integer);
const
  SQL_DELETE = 'delete '+
               '  from '+
               'usuario_acao '+
               '  where '+
               'cd_acao = :cd_acao and '+
               'cd_usuario = :cd_usuario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    try
      qry.SQL.Add(SQL_DELETE);
      qry.ParamByName('cd_acao').AsInteger := CdAcao;
      qry.ParamByName('cd_usuario').AsInteger := CdUsuario;
      qry.ExecSQL;

    except
      on E: exception do
        raise Exception.Create('Erro ' + E.Message);
    end;
  finally
    qry.Free;
  end;
end;

procedure TControleAcessoSistema.Listar(CdUsuario: Integer);
const
    SQL =  'select '+
           '  ua.cd_usuario, '+
           '  acs.cd_acao, '+
           '  acs.nm_acao, '+
           '  fl_permite_acesso, '+
           '  fl_permite_edicao '+
           'from '+
           '  usuario_acao ua '+
           'join acoes_sistema acs on '+
           '  ua.cd_acao = acs.cd_acao '+
           'where cd_usuario = :cd_usuario'+
           '  order by ua.cd_acao ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    Dados.cds.EmptyDataSet;
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_usuario').AsInteger := CdUsuario;
    qry.Open();

    if not qry.IsEmpty then
    begin
      qry.loop(
      procedure
      begin
        FDados.cds.Append;
        FDados.cds.FieldByName('cd_acao').AsInteger := qry.FieldByName('cd_acao').AsInteger;
        FDados.cds.FieldByName('cd_usuario').AsInteger := qry.FieldByName('cd_usuario').AsInteger;
        FDados.cds.FieldByName('nm_acao').AsString := qry.FieldByName('nm_acao').AsString;
        FDados.cds.FieldByName('fl_permite_acesso').AsBoolean := qry.FieldByName('fl_permite_acesso').AsBoolean;
        FDados.cds.FieldByName('fl_permite_edicao').AsBoolean := qry.FieldByName('fl_permite_edicao').AsBoolean;
        FDados.cds.Post;
      end
      );
    end;

  finally
    qry.Free;
  end;
end;

procedure TControleAcessoSistema.SetDados(const Value: TdmControleAcesso);
begin
  FDados := Value;
end;

end.
