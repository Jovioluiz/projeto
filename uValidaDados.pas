unit uValidaDados;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

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


end;

implementation

{ TValidaDados }

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

function TValidaDados.validaCodigo(cod: Integer): Integer;
begin
  if cod = null then
    begin
      ShowMessage('Código não pode ser vazio');
      Abort;
    end;
    Result := 0;
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
