unit uConexao;

interface

uses
  FireDAC.Comp.Client;

type TConexao = class
  private
    conn: TFDConnection;
  public
    // construtor da classe
    constructor Create;

    //função que retorna a conexão com o banco de dados
    function getConexao: TFDConnection;
end;

implementation

uses
  System.IniFiles, System.SysUtils, Vcl.Dialogs;

{ TConexao }

constructor TConexao.Create;
var
  conexaoIni: TIniFile;
begin
  conexaoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');
  conn := TFDConnection.Create(nil);

  conn.DriverName := 'PG';

  conn.Params.Values['Server'] := conexaoIni.ReadString('configuracoes', 'servidor', conn.Params.Values['Server']);
  conn.Params.Database := conexaoIni.ReadString('configuracoes', 'banco', conn.Params.Database);
  conn.Params.UserName := conexaoIni.ReadString('configuracoes', 'usuario', conn.Params.UserName);
  conn.Params.Password := conexaoIni.ReadString('configuracoes', 'senha', conn.Params.Password);
  conn.Params.Values['Port'] := conexaoIni.ReadString('configuracoes', 'porta', conn.Params.Values['Port']);

  try
    conn.Open();
  except
    on e:Exception do
    begin
      ShowMessage('Não foi possível efetuar a conexão. Erro: ' + e.Message);
      conn := nil;
    end;
  end;
end;

function TConexao.getConexao: TFDConnection;
begin
  Result := conn;
end;

end.
