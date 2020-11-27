unit uCadastrarSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  TfrmCadastraSenha = class(TForm)
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaExit(Sender: TObject);
  private
    { Private declarations }
    procedure Salvar;
  public
    { Public declarations }
  end;

var
  frmCadastraSenha: TfrmCadastraSenha;

implementation

{$R *.dfm}

uses uDataModule, uUtil;

{ TfrmCadastraSenha }

procedure TfrmCadastraSenha.edtSenhaExit(Sender: TObject);
begin
  Salvar;
end;

procedure TfrmCadastraSenha.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F2 then //F2
    Salvar;
end;

procedure TfrmCadastraSenha.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0)
  end;
end;

procedure TfrmCadastraSenha.Salvar;
const
  SQL = 'insert '+
          'into '+
        'login_usuario (id_usuario, '+
          'login,                     '+
          'senha) '+
        'values '+
          '(:id_usuario, '+
          ':login, '+
          ':senha)';

  SQL_SELECT = 'select      '+
               '  max(id_usuario) as id_usuario  '+
               'from                     '+
               '  login_usuario';
var
  qry: TFDQuery;
  idUsuario: Integer;
  criptoSenha: TValidaDados;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  criptoSenha := TValidaDados.Create();

  try
    try
      qry.SQL.Add(SQL_SELECT);
      qry.Open();
      idUsuario := qry.FieldByName('id_usuario').AsInteger + 1;
      qry.SQL.Clear;

      qry.SQL.Add(SQL);
      qry.ParamByName('id_usuario').AsInteger := idUsuario;
      qry.ParamByName('login').AsString := edtUsuario.Text;
      qry.ParamByName('senha').AsString := criptoSenha.criptografaSenha(edtSenha.Text);
      qry.ExecSQL;
      dm.conexaoBanco.Commit
    except
      on E:exception do
        begin
          dm.conexaoBanco.Rollback;
          ShowMessage('Erro '+ E.Message);
        end;
    end;
  finally
    qry.Free;
    FreeAndNil(criptoSenha);
    frmCadastraSenha.Close;
  end;
end;

end.
