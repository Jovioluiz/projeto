unit uControleAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmControleAcesso = class(TForm)
    Label3: TLabel;
    edtUsuario: TEdit;
    cbCadCliente: TCheckBox;
    GroupBox1: TGroupBox;
    cbCadProduto: TCheckBox;
    cbCadCtaFormaPag: TCheckBox;
    cbCadCtaCondPag: TCheckBox;
    cbCadTributacao: TCheckBox;
    cbCadTabelaPreco: TCheckBox;
    cbCadTabelaPrecoProduto: TCheckBox;
    cbCadConfig: TCheckBox;
    cbConsultaProduto: TCheckBox;
    cbCadAcesso: TCheckBox;
    cbPedidoVenda: TCheckBox;
    cbEdicaoPedido: TCheckBox;
    cbRel: TCheckBox;
    cbNotaEntrada: TCheckBox;
    cbVisualizaPedido: TCheckBox;
    cbCadUsuario: TCheckBox;
    query: TFDQuery;
    edtNomeUsuario: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsuarioExit(Sender: TObject);
    procedure limpaCampos;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

//implementar métodos salvar e limpar
//realizar as validações de acesso nos formulários


procedure TfrmControleAcesso.edtUsuarioExit(Sender: TObject);
//var qtd : integer;
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
    //edtNomeUsuario.Text := query.FieldByName('login').Text;
    ShowMessage('Usuário não encontrado');
    edtUsuario.SetFocus;
    Exit;
  end;
  edtNomeUsuario.Text := query.FieldByName('login').AsString;

  query.First;

  while not query.Eof do
  begin
    if query.FieldByName('cd_acao').AsInteger = 1 then
    begin
      cbCadCliente.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 2 then
    begin
      cbCadProduto.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 3 then
    begin
      cbCadCtaFormaPag.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 4  then
    begin
      cbCadCtaCondPag.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 5 then
    begin
      cbCadTabelaPreco.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 6 then
    begin
      cbCadTabelaPrecoProduto.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 7 then
    begin
      cbConsultaProduto.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 8 then
    begin
      cbPedidoVenda.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 9 then
    begin
      cbVisualizaPedido.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 10 then
    begin
      cbEdicaoPedido.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 11 then
    begin
      cbRel.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 12 then
    begin
      cbNotaEntrada.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 13 then
    begin
      cbCadTributacao.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 14 then
    begin
      cbCadConfig.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 15 then
    begin
      cbCadUsuario.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
      if query.FieldByName('cd_acao').AsInteger = 16 then
    begin
      cbCadAcesso.Checked := query.FieldByName('fl_permite_acesso').AsBoolean;
    end;
    query.Next;
  end;
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
    //salvar;
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
  cbCadCliente.Checked := False;
  cbCadProduto.Checked := False;
  cbCadCtaFormaPag.Checked := False;
  cbCadCtaCondPag.Checked := False;
  cbCadTabelaPreco.Checked := False;
  cbCadTabelaPrecoProduto.Checked := False;
  cbConsultaProduto.Checked := False;
  cbPedidoVenda.Checked := False;
  cbVisualizaPedido.Checked := False;
  cbEdicaoPedido.Checked := False;
  cbRel.Checked := False;
  cbNotaEntrada.Checked := False;
  cbCadTributacao.Checked := False;
  cbCadConfig.Checked := False;
  cbCadUsuario.Checked := False;
  cbCadAcesso.Checked := False;
  edtUsuario.SetFocus;
end;

end.
