unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConexao;

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
    procedure LimpaCampos;
    procedure ValidaCampos;
    procedure Salvar;
    procedure Excluir;

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
  SQL_SELECT = 'select ' +
              '   login, ' +
              '   senha  ' +
              'from login_usuario ' +
              'where ' +
                  'id_usuario = :id_usuario';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  try
    try
      if edtIdUsuario.Text = EmptyStr then
      begin
        ValidaCampos;
        Exit;
      end;

      qry.SQL.Add(SQL_SELECT);
      qry.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
      qry.Open();

      if not qry.IsEmpty then
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
  finally
    qry.Free;
  end;
end;

procedure TfrmUsuario.Excluir;
begin
  if (Application.MessageBox('Deseja Excluir o Usu�rio?','Aten��o', MB_YESNO) = IDYES) then
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
      ShowMessage('Usu�rio exclu�do com sucesso!');
      //dm.FDConnection1.Commit;
      LimpaCampos;
      //sql.Free;
    except
      on E:exception do
        begin
          //dm.FDConnection1.Rollback;
          ShowMessage('Erro ao excluir os dados do usu�rio ' +edtIdUsuario.Text + E.Message);
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
    LimpaCampos
  else if key = VK_F2 then  //F2
    Salvar
  else if key = VK_F4 then    //F4
    Excluir
  else if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Fechar?','Aten��o', MB_YESNO) = IDYES) then
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

procedure TfrmUsuario.LimpaCampos;
begin
  edtIdUsuario.Clear;
  edtNomeUsuario.Clear;
  edtSenhaUsuario.Clear;
  //edtIdUsuario.SetFocus;
end;

procedure TfrmUsuario.Salvar;
const
  SQL_UPDATE =  'update '+
                '   login_usuario set '+
                '   id_usuario = :id_usuario, '+
                '   login = :login, '+
                '   senha = :senha ' +
                'where '+
                '   id_usuario = :id_usuario';

  SQL_SELECT =  'select             '+
                    '*              '+
                'from               '+
                    'login_usuario  '+
                'where              '+
                    'id_usuario = :id_usuario';

  SQL_INSERT ='insert '+
                'into '+
              'login_usuario (id_usuario, '+
                'login,                   '+
                'senha) '+
              'values '+
                '(:id_usuario, '+
                ':login, '+
                ':senha)';
var
  cripto: TValidaDados;
  qry, qrySelect: TFDQuery;
  conexao: TConexao;
begin
  cripto := TValidaDados.Create;
  conexao := TConexao.Create;
  qry := TFDQuery.Create(Self);
  qry.Connection := conexao.getConexao;
  qrySelect := TFDQuery.Create(Self);
  qrySelect.Connection := conexao.getConexao;

  try
    ValidaCampos;

    qrySelect.SQL.Add(SQL_SELECT);
    qrySelect.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);

    qrySelect.Open;

    if not qrySelect.IsEmpty then
    begin
      try
        qry.SQL.Add(SQL_UPDATE);
        qry.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
        qry.ParamByName('login').AsString := edtNomeUsuario.Text;
        qry.ParamByName('senha').AsString := cripto.GetSenhaMD5(edtSenhaUsuario.Text);
        qry.ExecSQL;
      except
        on E:exception do
        begin
          qry.Connection.Rollback;
          ShowMessage('Erro ' + E.Message);
        end;
      end;
    end
    else
    begin
      try
        qry.SQL.Add(SQL_INSERT);
        qry.ParamByName('id_usuario').AsInteger := StrToInt(edtIdUsuario.Text);
        qry.ParamByName('login').AsString := edtNomeUsuario.Text;
        qry.ParamByName('senha').AsString := cripto.GetSenhaMD5(edtSenhaUsuario.Text);
        qry.ExecSQL;
      except
        on E:exception do
        begin
          qry.Connection.Rollback;
          ShowMessage('Erro ' + E.Message);
        end;
      end;
    end;

    qry.Connection.Commit;
  finally
    qry.Connection.Rollback;
    LimpaCampos;
    FreeAndNil(cripto);
    qry.Free;
    qrySelect.Free;
  end;
end;

procedure TfrmUsuario.ValidaCampos;
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
