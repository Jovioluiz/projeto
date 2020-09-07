unit uValidaDados;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param;

type TValidaDados = class
  private
    FnomeCliente: String;
    FcdCliente: Integer;
    Fcpf: String;
    procedure SetnomeCliente(const Value: String);
    procedure SetcdCliente(const Value: Integer);
    procedure Setcpf(const Value: String);



  public
    property nomeCliente : String read FnomeCliente write SetnomeCliente;
    property cdCliente : Integer read FcdCliente write SetcdCliente;
    property cpf : String read Fcpf write Setcpf;

    function validaNomeCpf(nome : String; cpf : String) : String;
    function validaCodigo(cod : Integer) : Integer;
    function validaAcessoAcao(cdUsuario : Integer; cdAcao : Integer) : Boolean; //valida se o usuário pode acessar a ação
    function validaEdicaoAcao(cdUsuario : Integer; cdAcao : Integer) : Boolean; //valida se o usuário pode editar um cadastro


end;

implementation

{ TValidaDados }

uses uDataModule;

procedure TValidaDados.SetcdCliente(const Value: Integer);
begin
  FcdCliente := Value;
end;

procedure TValidaDados.Setcpf(const Value: String);
begin
  Fcpf := Value;
end;

procedure TValidaDados.SetnomeCliente(const Value: String);
begin
  FnomeCliente := Value;
end;

function TValidaDados.validaAcessoAcao(cdUsuario, cdAcao: Integer): Boolean;
const
  sql = 'select '+
         '  fl_permite_acesso '+
         'from '+
         '  usuario_acao '+
         ' where '+
         '  cd_acao = :cd_acao and '+
         '  cd_usuario = :cd_usuario';
begin
  Result := False;

  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Add(sql);
  dm.query.ParamByName('cd_acao').AsInteger := cdAcao;
  dm.query.ParamByName('cd_usuario').AsInteger := cdUsuario;

  dm.query.Open();

  if not dm.query.IsEmpty then
    Result := True
  else
    begin
      ShowMessage('Usuário não possui permissão de acesso! Verifique!');
      Abort;
    end;
end;

function TValidaDados.validaCodigo(cod: Integer): Integer;
begin
  if cod = null then
    begin
      ShowMessage('Código não pode ser vazio');
      Abort;
    end;
    Result := 0;
end;

function TValidaDados.validaEdicaoAcao(cdUsuario, cdAcao: Integer): Boolean;
const
  sql = 'select '+
         '  fl_permite_edicao '+
         'from '+
         '  usuario_acao '+
         ' where '+
         '  cd_acao = :cd_acao and '+
         '  cd_usuario = :cd_usuario';
begin
  Result := False;

  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Add(sql);
  dm.query.ParamByName('cd_acao').AsInteger := cdAcao;
  dm.query.ParamByName('cd_usuario').AsInteger := cdUsuario;

  dm.query.Open();

  if dm.query.FieldByName('fl_permite_edicao').AsBoolean = True then
    Result := True;
end;

function TValidaDados.validaNomeCpf(nome: String; cpf : String): String;
begin
  if (Trim(nome) = '') or (Trim(cpf) = '') then
  begin
    ShowMessage('Nome e CPF não podem ser vazios');
    Abort;
  end;

end;

end.
