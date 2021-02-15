unit fControleAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, System.UITypes, uDataModule, uUtil, uControleAcessoSistema;

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

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCdAcaoChange(Sender: TObject);
    procedure dbGridAcoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbGridAcoesDblClick(Sender: TObject);
    procedure edtUsuarioChange(Sender: TObject);
  private
    FRegras: TControleAcessoSistema;
    FEdicao: Boolean;
    { Private declarations }
    procedure listar;
    procedure excluir;
    function Pesquisar(CdUsuario, CdAcao: Integer): Boolean;
    procedure Salvar;
    procedure limpaCampos;
    procedure SetRegras(const Value: TControleAcessoSistema);
  public
    { Public declarations }
    property Regras: TControleAcessoSistema read FRegras write SetRegras;
    property Edicao: Boolean read FEdicao;
  end;

var
  frmControleAcesso: TfrmControleAcesso;
  edicao: Boolean;

implementation

{$R *.dfm}


//realizar as validações de edição nos formulários de cadastro


procedure TfrmControleAcesso.btnAddClick(Sender: TObject);
const
  SQL_ACAO = 'select '+
             '  nm_acao '+
             'from       '+
             '  acoes_sistema '+
             'where            '+
             '  cd_acao = :cd_acao';
var
  qry: TFDQuery;
begin
  if edtCdAcao.Text = EmptyStr then
  begin
    ShowMessage('Informe uma ação!');
    Exit;
  end;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try

    if FRegras.Dados.cds.Locate('cd_acao',
                            VarArrayOf([StrToInt(edtCdAcao.Text)]), [])
       and (not FEdicao) then
      raise Exception.Create('Usuário já possui a ação cadastrada');

    //já salva os dados na tabela usuario_acao
    qry.SQL.Add(SQL_ACAO);
    qry.ParamByName('cd_acao').AsInteger := StrToInt(edtCdAcao.Text);
    qry.Open();

    if qry.IsEmpty then
      Exit;

    if FEdicao then
    begin
      FRegras.Dados.cds.Edit;
      if cbEdicao.ItemIndex = 0 then
        FRegras.Dados.cds.FieldByName('fl_permite_edicao').AsBoolean := True
      else
        FRegras.Dados.cds.FieldByName('fl_permite_edicao').AsBoolean := False;

      FRegras.Dados.cds.Post;
    end
    else
    begin
      FRegras.Dados.cds.Append;
      FRegras.Dados.cds.FieldByName('cd_acao').AsInteger := StrToInt(edtCdAcao.Text);
      FRegras.Dados.cds.FieldByName('nm_acao').AsString := edtNomeAcao.Text;
      FRegras.Dados.cds.FieldByName('fl_permite_acesso').AsBoolean := True;

      if cbEdicao.ItemIndex = 0 then
        FRegras.Dados.cds.FieldByName('fl_permite_edicao').AsBoolean := True
      else
        FRegras.Dados.cds.FieldByName('fl_permite_edicao').AsBoolean := False;

      FRegras.Dados.cds.Post;
    end;

    edtCdAcao.Clear;
    edtNomeAcao.Clear;
    cbEdicao.ItemIndex := 1;

    FEdicao := False;
  finally
    qry.Free;
  end;
end;

procedure TfrmControleAcesso.dbGridAcoesDblClick(Sender: TObject);
begin
  edtCdAcao.Text := dbGridAcoes.Fields[0].AsString;
  edtNomeAcao.Text := dbGridAcoes.Fields[1].AsString;
  if dm.dsControleAcesso.DataSet.FieldByName('fl_permite_edicao').AsBoolean = True then
    cbEdicao.ItemIndex := 0
  else
    cbEdicao.ItemIndex := 1;

  FEdicao := True;
end;

procedure TfrmControleAcesso.dbGridAcoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if MessageDlg('Deseja excluir a ação do usuário?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
    begin
      FRegras.Excluir(FRegras.Dados.cds.FieldByName('cd_acao').AsInteger, StrToInt(edtUsuario.Text));
      edtUsuario.SetFocus;
    end;
  end;
  FRegras.Listar(StrToInt(edtUsuario.Text));
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

procedure TfrmControleAcesso.edtUsuarioChange(Sender: TObject);
//sql para trazer o usuario caso ainda não possua nenhuma ação vinculada na tabela usuario_acao
const
  sql_login = 'select id_usuario, '+
              '   upper(login) as login '+
              'from '+
              '   login_usuario '+
              'where id_usuario = :id_usuario';
var
  acesso: TControleAcessoSistema;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql_login);
    qry.ParamByName('id_usuario').AsInteger := StrToInt(edtUsuario.Text);
    qry.Open();

    if not qry.IsEmpty then
      edtNomeUsuario.Text := qry.FieldByName('login').AsString;

  finally
    qry.Free;
  end;
end;

procedure TfrmControleAcesso.edtUsuarioExit(Sender: TObject);
begin
  if edtUsuario.Text = '' then
  begin
    ShowMessage('Insira um Usuário!');
    Exit;
  end;

  FRegras.Listar(StrToInt(edtUsuario.Text));
  //listar;

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

procedure TfrmControleAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FRegras.Free;
end;

procedure TfrmControleAcesso.FormCreate(Sender: TObject);
begin
  cbEdicao.ItemIndex := 1;
  FRegras := TControleAcessoSistema.Create;
  dbGridAcoes.DataSource := FRegras.Dados.ds;
end;

procedure TfrmControleAcesso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
    Salvar
  else if key = VK_F3 then //F3
    limpaCampos
  else if key = VK_F4 then    //F4
    excluir
  else if key = VK_ESCAPE then //ESC
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
      Close;
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
  dm.cdsControleAcesso.EmptyDataSet;
end;

procedure TfrmControleAcesso.listar;
begin
//  dm.queryControleAcesso.Close;
//  dm.queryControleAcesso.SQL.Clear;
//  dm.queryControleAcesso.SQL.Add(sql_acao);
//  dm.queryControleAcesso.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
//  dm.queryControleAcesso.Open(sql_acao);
end;

function TfrmControleAcesso.Pesquisar(CdUsuario, CdAcao: Integer): Boolean;
const
  SQL = 'select ' +
        '    cd_usuario, ' +
        '    cd_acao ' +
        'from ' +
        '    usuario_acao ua ' +
        'where ' +
        '    cd_usuario = :cd_usuario ' +
        '    and cd_acao = :cd_acao ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_usuario').AsInteger := CdUsuario;
    qry.ParamByName('cd_acao').AsInteger := CdAcao;
    qry.Open();

    Result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

procedure TfrmControleAcesso.Salvar;
const
  SQL_INSERT = 'insert ' +
              '    into ' +
              '    usuario_acao (cd_usuario, ' +
              '    cd_acao, ' +
              '    fl_permite_acesso, ' +
              '    fl_permite_edicao) ' +
              'values(:cd_usuario, ' +
              ':cd_acao, ' +
              ':fl_permite_acesso, ' +
              ':fl_permite_edicao)';

  SQL_UPDATE = 'update ' +
              '    usuario_acao ' +
              'set ' +
              '    fl_permite_acesso = :fl_permite_acesso, ' +
              '    fl_permite_edicao = :fl_permite_edicao ' +
              'where ' +
              '    cd_usuario = :cd_usuario ' +
              '    and cd_acao = :cd_acao';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  dm.cdsControleAcesso.DisableControls;
  dm.cdsControleAcesso.First;

  try
    try
      while not dm.cdsControleAcesso.Eof do
      begin
        if not Pesquisar(dm.cdsControleAcesso.FieldByName('cd_usuario').AsInteger,
                         dm.cdsControleAcesso.FieldByName('cd_acao').AsInteger) then
          qry.SQL.Add(SQL_INSERT)
        else
          qry.SQL.Add(SQL_UPDATE);

        qry.ParamByName('cd_usuario').AsInteger := dm.cdsControleAcesso.FieldByName('cd_usuario').AsInteger;
        qry.ParamByName('cd_acao').AsInteger := dm.cdsControleAcesso.FieldByName('cd_acao').AsInteger;
        qry.ParamByName('fl_permite_acesso').AsBoolean := dm.cdsControleAcesso.FieldByName('fl_permite_acesso').AsBoolean;
        qry.ParamByName('fl_permite_edicao').AsBoolean := dm.cdsControleAcesso.FieldByName('fl_permite_edicao').AsBoolean;
        qry.ExecSQL;
        qry.SQL.Clear;
        dm.cdsControleAcesso.Next;
      end;

      dm.conexaoBanco.Commit;

    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ao gravar os dados ' + E.Message);
        Exit;
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    dm.cdsControleAcesso.EnableControls;
    qry.Free;
    limpaCampos;
  end;
end;

procedure TfrmControleAcesso.SetRegras(const Value: TControleAcessoSistema);
begin
  FRegras := Value;
end;

end.
