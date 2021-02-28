unit fControleAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, System.UITypes, uDataModule, uUtil, uControleAcessoSistema,
  Vcl.DBCtrls;

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
    procedure dbGridAcoesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

uses
  System.Math;

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
begin
  if edtCdAcao.Text = EmptyStr then
  begin
    ShowMessage('Informe uma ação!');
    Exit;
  end;

  if FRegras.Dados.cds.Locate('cd_acao', VarArrayOf([StrToInt(edtCdAcao.Text)]), [])
     and (not FEdicao) then
    raise Exception.Create('Usuário já possui a ação cadastrada');

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

procedure TfrmControleAcesso.dbGridAcoesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin
  inherited;

  if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;

  // Desenha um checkbox no dbgrid
  if (Column.FieldName = 'fl_permite_acesso') or (Column.FieldName = 'fl_permite_edicao') then
  begin
    if (Column.FieldName = 'fl_permite_acesso') then
    begin
      TDBGrid(Sender).Canvas.FillRect(Rect);

      if ((Sender as TDBGrid).DataSource.Dataset.FieldByName('fl_permite_acesso').AsBoolean) then
        Check := DFCS_CHECKED
      else
        Check := 0;
    end;

    if (Column.FieldName = 'fl_permite_edicao') then
    begin
      if ((Sender as TDBGrid).DataSource.Dataset.FieldByName('fl_permite_edicao').AsBoolean) then
        Check := DFCS_CHECKED
      else
        Check := 0;
    end;

    R := Rect;
    InflateRect(R, -2, -2); { Diminue o tamanho do CheckBox }
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON,
      DFCS_BUTTONCHECK or Check);
  end;

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
  qry: TFDQuery;
begin
  if edtUsuario.Text = '' then
    Exit;

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

  if edtUsuario.Text <> '' then
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
  FRegras.Dados.cds.EmptyDataSet;
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

  try
    try
      FRegras.Dados.cds.Loop(
      procedure
      begin
        if not Pesquisar(FRegras.Dados.cds.FieldByName('cd_usuario').AsInteger,
                       FRegras.Dados.cds.FieldByName('cd_acao').AsInteger) then
          qry.SQL.Add(SQL_INSERT)
        else
          qry.SQL.Add(SQL_UPDATE);

        qry.ParamByName('cd_usuario').AsInteger := FRegras.Dados.cds.FieldByName('cd_usuario').AsInteger;
        qry.ParamByName('cd_acao').AsInteger := FRegras.Dados.cds.FieldByName('cd_acao').AsInteger;
        if FRegras.Dados.cds.FieldByName('fl_permite_acesso').AsInteger = 1 then
          qry.ParamByName('fl_permite_acesso').AsBoolean := True
        else
          qry.ParamByName('fl_permite_acesso').AsBoolean := False;
        if FRegras.Dados.cds.FieldByName('fl_permite_edicao').AsInteger = 1 then
          qry.ParamByName('fl_permite_edicao').AsBoolean := True
        else
          qry.ParamByName('fl_permite_edicao').AsBoolean := False;
        qry.ExecSQL;
        qry.SQL.Clear;
      end
      );

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
    qry.Free;
    limpaCampos;
  end;
end;

procedure TfrmControleAcesso.SetRegras(const Value: TControleAcessoSistema);
begin
  FRegras := Value;
end;

end.
