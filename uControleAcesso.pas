unit uControleAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons;

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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsuarioExit(Sender: TObject);
    procedure limpaCampos;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure salvar;
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleAcesso: TfrmControleAcesso;

implementation

{$R *.dfm}

uses uDataModule;

//implementar m�todos salvar, excluir acesso a acao e excluir tudo
//realizar as valida��es de acesso nos formul�rios


procedure TfrmControleAcesso.btnAddClick(Sender: TObject);
begin
//implementar 
end;

procedure TfrmControleAcesso.edtUsuarioExit(Sender: TObject);
//sql para trazer o usuario caso ainda n�o possua nenhuma a��o vinculada na tabela usuario_acao
const sql_login = 'select id_usuario, login from login_usuario where id_usuario = :id_usuario';
      sql_acao = 'select '+
                 '    *     '+
	               'from '+
                 '    usuario_acao ua '+
                 'join acoes_sistema acs on '+
                 '    ua.cd_acao = acs.cd_acao '+
                 'where cd_usuario = :cd_usuario';

begin
  dm.queryControleAcesso.Close;
  dm.queryControleAcesso.SQL.Clear;

  if edtUsuario.Text = '' then
  begin
    ShowMessage('Insira um Usu�rio!');
    Exit;
  end;

  query.Close;
  query.SQL.Clear;
  query.SQL.Add(sql_login);
  query.ParamByName('id_usuario').AsInteger := StrToInt(edtUsuario.Text);
  query.Open(sql_login);
  edtNomeUsuario.Text := query.FieldByName('login').AsString;

  dm.queryControleAcesso.SQL.Add(sql_acao);
  dm.queryControleAcesso.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
  dm.queryControleAcesso.Open(sql_acao);
end;

procedure TfrmControleAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dm.queryControleAcesso.Close;
end;

procedure TfrmControleAcesso.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F3 then //F3
  begin
    limpaCampos;
  end
  else if key = VK_F2 then  //F2
  begin
    //salvar; acabar a implementa��o
  end
  else if key = VK_F4 then    //F4
  begin
    //excluir;
  end
  else if key = VK_ESCAPE then //ESC
  begin
  if (Application.MessageBox('Deseja Fechar?','Aten��o', MB_YESNO) = IDYES) then
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
  dm.queryControleAcesso.Close;
end;

procedure TfrmControleAcesso.salvar;
begin
  try
    dm.transacao.StartTransaction;

    query.Close;
    query.SQL.Text := 'select '+
                      '   * '+
                      'from '+
                      '   usuario_acao '+
                      'where '+
                      '   cd_usuario = :cd_usuario';
    query.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
    query.Open();

    if not query.IsEmpty then
    begin
      try
        query.Close;
        query.SQL.Text := 'update '+
                          '   usuario_acao '+
                          'set '+
                          '   cd_usuario = :cd_usuario, '+
                          '   cd_acao = :cd_acao, ' +
                          '   fl_permite_acesso = :fl_permite_acesso '+
                          'where '+
                          '   cd_usuario = :cd_usuario';
        query.ParamByName('cd_usuario').AsString := edtUsuario.Text;
        query.ParamByName('cd_acao').AsBoolean;

      

      except

      end;
    end;
    
  finally

  end;
end;

end.
