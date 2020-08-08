unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.XPMan,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TMaskEdit;
    btnEntrar: TButton;
    btnCancelar: TButton;
    Image1: TImage;
    lblInfo: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  idUsuario : Integer;

implementation

{$R *.dfm}

uses uTelaInicial, uDataModule, dtmLogin;

procedure TfrmLogin.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
const
  SQL_LOGIN = 'select '+
              '  id_usuario, '+
              '  login, '+
              '  senha '+
              'from '+
              '  login_usuario '+
              'where '+
              '  login = :login and senha = :senha';

var usuario, senha : String;
login : TdmLogin;
begin
  try
    login := TdmLogin.Create(nil);
    login.queryLogin.SQL.Add(SQL_LOGIN);
    login.queryLogin.ParamByName('login').AsString := edtUsuario.Text;
    login.queryLogin.ParamByName('senha').AsString := edtSenha.Text;
    login.queryLogin.Prepare;
    login.queryLogin.Open(SQL_LOGIN);

    idUsuario := login.queryLogin.FieldByName('id_usuario').AsInteger;
    usuario := login.queryLogin.FieldByName('login').Text;
    senha :=  login.queryLogin.FieldByName('senha').Text;

    if (Trim(edtUsuario.Text) = EmptyStr) or (Trim(edtSenha.Text) = EmptyStr) then
    begin
      lblInfo.Font.Color := clRed;
      lblInfo.Caption := 'Usuário ou Senha Inválidos! Verifique!';
      edtUsuario.Clear;
      edtSenha.Clear;
      edtUsuario.SetFocus;
      Exit;
    end;
    if (Trim(edtUsuario.Text) = usuario) and (Trim(edtSenha.Text) = senha) then
    begin
      try
        frmPrincipal := TfrmPrincipal.Create(Self);
        frmPrincipal.ShowModal;
      finally
        frmLogin.Close;
      end;
    end
    else
    begin
      lblInfo.Font.Color := clRed;
      lblInfo.Caption := 'Usuário ou Senha Inválidos! Verifique!';
      edtUsuario.Clear;
      edtSenha.Clear;
      edtUsuario.SetFocus;
      Exit;
    end;
  finally
    FreeAndNil(login);
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 frmLogin := nil;
end;

procedure TfrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

end.
