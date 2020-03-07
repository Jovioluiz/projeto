unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.XPMan,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uTelaInicial, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  Tfrm_Login = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TMaskEdit;
    btnEntrar: TButton;
    btnCancelar: TButton;
    sql_login: TFDQuery;
    Image1: TImage;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEntrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Login: Tfrm_Login;

implementation

{$R *.dfm}

procedure Tfrm_Login.btnCancelarClick(Sender: TObject);
begin
if MessageDlg('Deseja Fechar?', mtConfirmation, [mbYes, mbNo], 0) = 6
  then
  begin
    Close;
  end;
end;

procedure Tfrm_Login.btnEntrarClick(Sender: TObject);
var usuario, senha : String;
begin
sql_login.Close;
sql_login.SQL.Text := 'select login, senha from login_usuario where (login = :login) and (senha = :senha)';

sql_login.ParamByName('login').AsString := edtUsuario.Text;
sql_login.ParamByName('senha').AsString := edtSenha.Text;
sql_login.Open();

usuario := sql_login.FieldByName('login').Text;
senha :=  sql_login.FieldByName('senha').Text;

if (edtUsuario.Text = EmptyStr) or (edtSenha.Text = EmptyStr) then
  begin
   ShowMessage('Digite usuário e Senha');
   exit;
  end;
if (edtUsuario.Text = usuario) and (edtSenha.Text = senha) then
  begin
  try
    frm_Principal.lblusuarioLogado.Visible := true;
    frm_Principal.lblusuarioLogado.Caption := usuario;

    frm_Principal := Tfrm_Principal.Create(Self);
    frm_Principal.ShowModal;

  finally
    frm_Login.Close;
  end;

  end
else
  begin
   ShowMessage('Usuário ou Senha Inválidos');
  end;
end;

end.
