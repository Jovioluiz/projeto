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
  Tfrm_Login = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtUsuario: TEdit;
    edtSenha: TMaskEdit;
    btnEntrar: TButton;
    btnCancelar: TButton;
    sqlLogin: TFDQuery;
    Image1: TImage;
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
  frm_Login: Tfrm_Login;

implementation

{$R *.dfm}

uses uTelaInicial, uDataModule;

procedure Tfrm_Login.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Login.btnEntrarClick(Sender: TObject);
var usuario, senha : String;
begin
sqlLogin.Close;
sqlLogin.SQL.Text := 'select '+
                            'login, '+
                            'senha '+
                      'from '+
                            'login_usuario '+
                      'where '+
                          '(login = :login) and (senha = :senha)';

sqlLogin.ParamByName('login').AsString := edtUsuario.Text;
sqlLogin.ParamByName('senha').AsString := edtSenha.Text;
sqlLogin.Open();


usuario := sqlLogin.FieldByName('login').Text;
senha :=  sqlLogin.FieldByName('senha').Text;

if (edtUsuario.Text = EmptyStr) or (edtSenha.Text = EmptyStr) then
  begin
   ShowMessage('Digite Usuário e Senha válidos');
   exit;
  end;
if (edtUsuario.Text = usuario) and (edtSenha.Text = senha) then
  begin
  try
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

procedure Tfrm_Login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 frm_Login := nil;
end;

procedure Tfrm_Login.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

end.
