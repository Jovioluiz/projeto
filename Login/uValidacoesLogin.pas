unit uValidacoesLogin;

interface
type
  DadosEntrada = Record
      Nomeusuario: string;
      SenhaAcesso: string;
end;

type DadosRetorno = Record
      Usuariologado: string;
      Codigousuario: Integer;
      Senha: string;
end;

type TLogin = class

  public
    function Validausuario(Dados: DadosEntrada):DadosRetorno;
end;



implementation

uses
  FireDAC.Comp.Client, uDataModule;

{ TLogin }


function TLogin.Validausuario(Dados: DadosEntrada): DadosRetorno;
const
  SQL_LOGIN = 'select '+
              '  id_usuario, '+
              '  login, '+
              '  senha '+
              'from '+
              '  login_usuario '+
              'where '+
              '  login = :login';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL_LOGIN);
    qry.ParamByName('login').AsString := Dados.Nomeusuario;
    qry.Prepare;
    qry.Open(SQL_LOGIN);

    Result.Usuariologado := qry.FieldByName('login').AsString;
    Result.Codigousuario := qry.FieldByName('id_usuario').AsInteger;
    Result.Senha := qry.FieldByName('senha').AsString;
  finally
    qry.Free;
  end;
end;

end.
