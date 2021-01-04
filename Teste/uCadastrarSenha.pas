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
  SQL_TEMP = 'select nextval(''usuario_seq'') as codigo';

  SQL = 'insert '+
          'into '+
        'login_usuario (id_usuario, '+
          'login,                     '+
          'senha) '+
        'values '+
          '(:id_usuario, '+
          ':login, '+
          ':senha)';

  SQL_SELECT = 'select      ' +
               '  id_usuario, ' +
               '  login, ' +
               '  senha ' +
               'from        ' +
               '  login_usuario ' +
               'where login = :login ';

  SQL_UPDATE = 'update ' +
               '  login_usuario ' +
               'set senha = :senha ' +
               'where id_usuario = :id_usuario';
var
  qry, qrySeq: TFDQuery;
  cdUsuario: Integer;
  usuario: string;
  criptoSenha: TValidaDados;
begin
  qry := TFDQuery.Create(Self);
  qrySeq := TFDQuery.Create(Self);
  qrySeq.Connection := dm.conexaoBanco;
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  criptoSenha := TValidaDados.Create();

  try
    try
      qry.SQL.Add(SQL_SELECT);
      qry.ParamByName('login').AsString := edtUsuario.Text;
      qry.Open();
      cdUsuario := qry.FieldByName('id_usuario').AsInteger;
      usuario := qry.FieldByName('login').AsString;

      if (usuario <> '') and (qry.FieldByName('senha').AsString = '') then
      begin
        qry.SQL.Clear;
        qry.SQL.Add(SQL_UPDATE);
        qry.ParamByName('senha').AsString := criptoSenha.criptografaSenha(edtSenha.Text);
        qry.ParamByName('id_usuario').AsInteger := cdUsuario;
        qry.ExecSQL;
      end
      else
      begin
        qry.SQL.Clear;
        qrySeq.SQL.Add(SQL_TEMP);
        qrySeq.Open();
        qry.SQL.Add(SQL);
        qry.ParamByName('id_usuario').AsInteger := qrySeq.FieldByName('codigo').AsInteger;
        qry.ParamByName('login').AsString := edtUsuario.Text;
        qry.ParamByName('senha').AsString := criptoSenha.criptografaSenha(edtSenha.Text);
        qry.ExecSQL;
      end;
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
    qrySeq.Free;
    FreeAndNil(criptoSenha);
    frmCadastraSenha.Close;
  end;
end;

end.
