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

//implementar métodos salvar, excluir acesso a acao e excluir tudo
//realizar as validações de acesso nos formulários


procedure TfrmControleAcesso.btnAddClick(Sender: TObject);
begin
//implementar 
end;

procedure TfrmControleAcesso.edtUsuarioExit(Sender: TObject);
const sql = 'select id_usuario, login from login_usuario where id_usuario = :id_usuario';
begin
  if edtUsuario.Text = '' then
  begin
    ShowMessage('Insira um Usuário!');
    Exit;
  end;
  
  //verificar esse sql para trazer o usuario que está cadastrado na tabela login_usuario
  //pois se o usuario estiver cadastrado somente na tabela login_usuario não vai dar certo quando tentar adicionar uma ação ao usuario
  query.Close;
  query.SQL.Clear;
  query.SQL.Text := 'select                           '+
                    '	  fl_permite_acesso,            '+
                    '	  cd_acao, 			                '+
                    '	  login    		                  '+
                    'from 				                  	'+
                    '	  usuario_acao ua               '+
                    'join login_usuario lu on         '+
                    '	  ua.cd_usuario = lu.id_usuario '+
                    'where							            	'+
                    '	  cd_usuario = :cd_usuario';
  query.ParamByName('cd_usuario').AsInteger := StrToInt(edtUsuario.Text);
  query.Open();

  if query.IsEmpty then
  begin
    dm.query.Close;
    dm.query.SQL.Clear;
    dm.query.SQL.Add(sql);
    dm.query.ParamByName('id_usuario').AsInteger := StrToInt(edtUsuario.Text);
    dm.query.Open(sql);
    edtNomeUsuario.Text := dm.query.FieldByName('login').AsString;
    Exit;
  end;
  edtNomeUsuario.Text := query.FieldByName('login').AsString;

  dm.queryControleAcesso.Open();

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
    //salvar; acabar a implementação
  end
  else if key = VK_F4 then    //F4
  begin
    //excluir;
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
