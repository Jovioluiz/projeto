unit uUtil;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Param, IdHashMessageDigest;

type TValidaDados = class
  private

  public

    function validaNomeCpf(nome : String; cpf : String) : String;
    function validaCodigo(cod : Integer) : Integer;
    function ValidaAcessoAcao(cdUsuario : Integer; cdAcao : Integer) : Boolean; //valida se o usuário pode acessar a ação
    function ValidaEdicaoAcao(cdUsuario : Integer; cdAcao : Integer) : Boolean; //valida se o usuário pode editar um cadastro
    function GetSenhaMD5(Senha: string): string;

end;

type TEditDocumento = class helper for TEdit
  public
    function isEmpty: Boolean;

end;

type TDataSetHelper = class helper for TDataSet
  public

    procedure Loop(Procedimento: TProc); overload;
end;

implementation

{ TValidaDados }

uses uDataModule, FireDAC.Comp.Client;


function TValidaDados.GetSenhaMD5(Senha: string): string;
var
  md5: TIdHashMessageDigest5;
begin
  md5 := TIdHashMessageDigest5.Create;

  try

    Result := md5.HashStringAsHex(Senha);

  finally
    md5.Free;
  end;
end;

function TValidaDados.ValidaAcessoAcao(cdUsuario, cdAcao: Integer): Boolean;
const
  sql = 'select '+
         '  fl_permite_acesso '+
         'from '+
         '  usuario_acao '+
         ' where '+
         '  cd_acao = :cd_acao and '+
         '  cd_usuario = :cd_usuario';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dm.conexaoBanco;

  try

    query.Open(sql, [cdAcao, cdUsuario]);

    if query.IsEmpty then
      raise Exception.Create('Usuário não possui permissão de acesso! Verifique!');

    Result := True;
  finally
    query.Free;
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

function TValidaDados.ValidaEdicaoAcao(cdUsuario, cdAcao: Integer): Boolean;
const
  sql = 'select '+
         '  fl_permite_edicao '+
         'from '+
         '  usuario_acao '+
         ' where '+
         '  cd_acao = :cd_acao and '+
         '  cd_usuario = :cd_usuario';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(sql, [cdAcao, cdUsuario]);

    Result := query.FieldByName('fl_permite_edicao').AsBoolean;

  finally
    query.Free;
  end;
end;

function TValidaDados.validaNomeCpf(nome: String; cpf : String): String;
begin
  if (Trim(nome) = '') or (Trim(cpf) = '') then
  begin
    ShowMessage('Nome e CPF não podem ser vazios');
    Abort;
  end;
end;

{ TEditDocumento }

function TEditDocumento.isEmpty: Boolean;
begin
  Result := Trim(Self.Text) = EmptyStr;
end;

{ TDataSetHelper }

procedure TDataSetHelper.Loop(Procedimento: TProc);
begin
  if Self.IsEmpty then
    Exit;

  Self.DisableControls;

  try
    Self.First;
    while not Self.Eof do
    begin
      Procedimento;
      Self.Next;
    end;
    Self.First;
  finally
    Self.EnableControls;
  end;
end;

end.
