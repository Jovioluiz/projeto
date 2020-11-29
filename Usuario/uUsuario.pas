unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmUsuario = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtIdUsuario: TEdit;
    edtNomeUsuario: TEdit;
    edtSenhaUsuario: TMaskEdit;
    query: TFDQuery;
    sql: TFDQuery;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtIdUsuarioExit(Sender: TObject);
    procedure edtIdUsuarioChange(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure limpaCampos;
    procedure validaCampos;
    procedure salvar;
    procedure excluir;

  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}

uses uDataModule, uUtil;

procedure TfrmUsuario.edtIdUsuarioChange(Sender: TObject);
begin
  if edtIdUsuario.Text = '' then
    Exit;
end;

procedure TfrmUsuario.edtIdUsuarioExit(Sender: TObject);
const
  SQL_SELECT = 'select '+
        '   login, '+
        '   senha  '+
        'from login_usuario '+
        'where '+
            'id_usuario = :id_usuario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    if edtIdUsuario.Text = EmptyStr then
    begin
      validaCampos;
      Exit;
    end;

    qry.SQL.Add(SQL_SELECT);
    qry.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
    qry.Open();

    if not sql.IsEmpty then
    begin
      edtNomeUsuario.Text := qry.FieldByName('login').AsString;
      edtSenhaUsuario.Text := qry.FieldByName('senha').AsString;
    end
    else
      edtNomeUsuario.SetFocus;
  except
    on E: Exception do
    ShowMessage(
      'Ocorreu um erro.' + #13 +
      'Mensagem de erro: ' + E.Message);
  end;
end;

procedure TfrmUsuario.excluir;
begin
  if (Application.MessageBox('Deseja Excluir o Usuário?','Atenção', MB_YESNO) = IDYES) then
  begin
    try
      //dm.FDConnection1.StartTransaction;
      sql.Close;
      sql.SQL.Text := 'delete                   '+
                          'from                    '+
                      'login_usuario            '+
                          'where                   '+
                      'id_usuario = :id_usuario';
      sql.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);

      sql.ExecSQL;
      ShowMessage('Usuário excluído com sucesso!');
      //dm.FDConnection1.Commit;
      limpaCampos;
      //sql.Free;
    except
      on E:exception do
        begin
          //dm.FDConnection1.Rollback;
          ShowMessage('Erro ao excluir os dados do usuário ' +edtIdUsuario.Text + E.Message);
        end;
    end;
  end
  else
    Exit;
end;

procedure TfrmUsuario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F3 then //F3
    limpaCampos
  else if key = VK_F2 then  //F2
    salvar
  else if key = VK_F4 then    //F4
    excluir
  else if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
      Close;
  end;
end;

procedure TfrmUsuario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmUsuario.limpaCampos;
begin
  edtIdUsuario.Clear;
  edtNomeUsuario.Clear;
  edtSenhaUsuario.Clear;
  //edtIdUsuario.SetFocus;
end;

procedure TfrmUsuario.salvar;
var
  cripto: TValidaDados;
begin
  try
    cripto := TValidaDados.Create;
    //dm.transacao.StartTransaction;
    validaCampos;

    query.Close;
    query.SQL.Clear;
    query.SQL.Text := 'select             '+
                          '*              '+
                      'from               '+
                          'login_usuario  '+
                      'where              '+
                          'id_usuario = :id_usuario';
    query.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);

    query.Open();

    if not query.IsEmpty then
    begin
      try
        sql.Close;
        sql.SQL.Text := 'update '+
                          'login_usuario set '+
                          'id_usuario = :id_usuario, '+
                          'login = :login, '+
                          'senha = :senha ' +
                        'where '+
                          'id_usuario = :id_usuario';

          sql.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
          sql.ParamByName('login').AsString := edtNomeUsuario.Text;
          sql.ParamByName('senha').AsString := cripto.criptografaSenha(edtSenhaUsuario.Text);

          sql.ExecSQL;
          //dm.transacao.Commit;
          ShowMessage('Salvo');
      except
        on E:exception do
          begin
            //dm.transacao.Rollback;
            ShowMessage('Erro '+ E.Message);
          end;
        end;
    end
    else
    begin
      try
        sql.Close;
        sql.SQL.Text := 'insert '+
                          'into '+
                        'login_usuario (id_usuario, '+
                          'login,                     '+
                          'senha) '+
                        'values '+
                          '(:id_usuario, '+
                          ':login, '+
                          ':senha)';

          sql.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
          sql.ParamByName('login').AsString := edtNomeUsuario.Text;
          sql.ParamByName('senha').AsString := cripto.criptografaSenha(edtSenhaUsuario.Text);

          sql.ExecSQL;
          //dm.transacao.Commit;
          ShowMessage('Salvo');
      except
        on E:exception do
          begin
            //dm.transacao.Rollback;
            ShowMessage('Erro '+ E.Message);
          end;
        end;
      end;
  finally
    limpaCampos;
    FreeAndNil(cripto);
  end;
end;

procedure TfrmUsuario.validaCampos;
var
  usuario : TValidaDados;
begin
  try
    try
      usuario := TValidaDados.Create;
      usuario.validaCodigo(StrToInt(edtIdUsuario.Text));
    except
      on E: Exception do
      ShowMessage(
        'Ocorreu um erro.' + #13 +
        'Mensagem de erro: ' + E.Message);
    end;
  finally
    FreeAndNil(usuario);
  end;
end;
end.
