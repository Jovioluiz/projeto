unit uControleAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, System.UITypes;

type
  TfrmControleAcesso = class(TForm)
    Label3: TLabel;
    edtUsuario: TEdit;
    query: TFDQuery;
    edtNomeUsuario: TEdit;
    dbGridAcoes: TDBGrid;
    Label1: TLabel;
    edtCdAcao: TEdit;
    edtNomeAcao: TEdit;
    btnAdd: TSpeedButton;
    cbEdicao: TComboBox;
    Label2: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsuarioExit(Sender: TObject);
    procedure limpaCampos;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCdAcaoChange(Sender: TObject);
    procedure dbGridAcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbGridAcoesDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure listar;
    procedure excluir;
  public
    { Public declarations }
  end;

var
  frmControleAcesso: TfrmControleAcesso;
  edicao: Boolean;

implementation

{$R *.dfm}

uses uDataModule;

//realizar as validações de edição nos formulários de cadastro


procedure TfrmControleAcesso.btnAddClick(Sender: TObject);
begin
  if edtCdAcao.Text = EmptyStr then
  begin
    ShowMessage('Informe uma ação!');
    Exit;
  end;

//já salva os dados na tabela usuario_acao
  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Text := 'select '+
                       ' nm_acao '+
                       'from       '+
                       ' acoes_sistema '+
                       'where            '+
                       ' cd_acao = :cd_acao';
  dm.query.ParamByName('cd_acao').AsInteger := StrToInt(edtCdAcao.Text);
  dm.query.Open();
  if dm.query.IsEmpty then
    Exit;

  if edicao then
  begin
    dm.dsControleAcesso.DataSet.Edit;
    if cbEdicao.ItemIndex = 0 then
      dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean := True
    else
      dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean := False;

    dm.dsControleAcesso.DataSet.Post; //da erro, mas atualiza corretamente
  end
  else
  begin
    dm.dsControleAcesso.DataSet.Append;
    dm.dsControleAcesso.DataSet.FieldByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
    dm.dsControleAcesso.DataSet.FieldByName('cd_acao').AsInteger := StrToInt(edtCdAcao.Text);
    dm.dsControleAcesso.DataSet.FieldByName('nm_acao').AsString := edtNomeAcao.Text;
    dm.dsControleAcesso.DataSet.FieldByName('fl_permite_acesso').AsBoolean := True;

    if cbEdicao.ItemIndex = 0 then
      dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean := True
    else
      dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean := False;

    dm.dsControleAcesso.DataSet.Post;
  end;

  edtCdAcao.Clear;
  edtNomeAcao.Clear;
  cbEdicao.ItemIndex := 1;
  listar;

  edicao := False;
end;

procedure TfrmControleAcesso.dbGridAcoesDblClick(Sender: TObject);
begin
  edtCdAcao.Text := dbGridAcoes.Fields[0].AsString;
  edtNomeAcao.Text := dbGridAcoes.Fields[1].AsString;
  if dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean = True then
    cbEdicao.ItemIndex := 0
  else
    cbEdicao.ItemIndex := 1;

  edicao := True;
end;

procedure TfrmControleAcesso.dbGridAcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir a ação do usuário?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
         begin
            try
              dm.query.Close;
              dm.query.SQL.Clear;
              dm.query.SQL.Text := 'delete '+
                                   '  from '+
                                   'usuario_acao '+
                                   '  where '+
                                   'cd_acao = :cd_acao and '+
                                   'cd_usuario = :cd_usuario';
              dm.query.ParamByName('cd_acao').AsInteger := dbGridAcoes.Fields[0].Value;
              dm.query.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
              dm.query.ExecSQL;
              edtUsuario.SetFocus;
            except
                on E : exception do
              begin
                ShowMessage('Erro ' + E.Message);
                Exit;
              end;
            end;
         end;
    end;
    listar;
end;

procedure TfrmControleAcesso.edtCdAcaoChange(Sender: TObject);
begin
  if edtCdAcao.Text = EmptyStr then
  begin
    Exit;
    edtCdAcao.SetFocus;
  end;

  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Text := 'select '+
                       ' nm_acao '+
                       'from       '+
                       ' acoes_sistema '+
                       'where            '+
                       ' cd_acao = :cd_acao';
  dm.query.ParamByName('cd_acao').AsInteger := StrToInt(edtCdAcao.Text);
  dm.query.Open();

  edtNomeAcao.Text := dm.query.FieldByName('nm_acao').AsString;
end;

procedure TfrmControleAcesso.edtUsuarioExit(Sender: TObject);
//sql para trazer o usuario caso ainda não possua nenhuma ação vinculada na tabela usuario_acao
const
  sql_login = 'select id_usuario, '+
              '   upper(login) as login '+
              'from '+
              '   login_usuario '+
              'where id_usuario = :id_usuario';
begin
  dm.queryControleAcesso.Close;
  dm.queryControleAcesso.SQL.Clear;

  if edtUsuario.Text = '' then
  begin
    ShowMessage('Insira um Usuário!');
    Exit;
  end;

  query.Close;
  query.SQL.Clear;
  query.SQL.Add(sql_login);
  query.ParamByName('id_usuario').AsInteger := StrToInt(edtUsuario.Text);
  query.Open(sql_login);
  edtNomeUsuario.Text := query.FieldByName('login').AsString;
  listar;
end;

procedure TfrmControleAcesso.excluir;
begin
  if (Application.MessageBox('Deseja Excluir os dados do Usuário?','Atenção', MB_YESNO) = IDYES) then
    begin
      try
        dm.query.Close;
        dm.query.SQL.Clear;
        dm.query.SQL.Text := 'delete '+
                             '  from '+
                             'usuario_acao '+
                             '  where '+
                             'cd_usuario = :cd_usuario';
        dm.query.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
        dm.query.ExecSQL;
        edtUsuario.SetFocus;
      except
        on E:exception do
          begin
            ShowMessage('Erro ao excluir os dados' + E.Message);
          end;
      end;
    end
  else
    begin
      Exit;
    end;
    listar;
    edtUsuario.Clear;
    edtNomeUsuario.Clear;
end;

procedure TfrmControleAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dm.queryControleAcesso.Close;
end;

procedure TfrmControleAcesso.FormCreate(Sender: TObject);
begin
 cbEdicao.ItemIndex := 1;
end;

procedure TfrmControleAcesso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F3 then //F3
  begin
    limpaCampos;
  end
  else if key = VK_F4 then    //F4
  begin
    excluir;
  end
  else if key = VK_ESCAPE then //ESC
  begin
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
end;

procedure TfrmControleAcesso.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmControleAcesso.limpaCampos;
begin
  edtUsuario.Clear;
  edtNomeUsuario.Clear;
  edtUsuario.SetFocus;
  edtCdAcao.Clear;
  edtNomeAcao.Clear;
  cbEdicao.ItemIndex := 1;
  dm.queryControleAcesso.Close;
end;

procedure TfrmControleAcesso.listar;
const
    sql_acao = 'select '+
               '    *     '+
               'from '+
               '    usuario_acao ua '+
               'join acoes_sistema acs on '+
               '    ua.cd_acao = acs.cd_acao '+
               'where cd_usuario = :cd_usuario'+
               '    order by ua.cd_acao ';
begin
  dm.queryControleAcesso.Close;
  dm.queryControleAcesso.SQL.Clear;
  dm.queryControleAcesso.SQL.Add(sql_acao);
  dm.queryControleAcesso.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
  dm.queryControleAcesso.Open(sql_acao);
end;

end.
