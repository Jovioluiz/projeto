unit uCadTabelaPrecoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.UITypes,
  FireDAC.Comp.Client, uConexao, Vcl.Buttons;

type
  TfrmCadTabelaPrecoProduto = class(TfrmConexao)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodProduto: TEdit;
    edtValor: TEdit;
    edtUNMedida: TEdit;
    edtNomeProduto: TEdit;
    sqlTabelaPrecoProduto: TFDQuery;
    Label5: TLabel;
    edtCodTabela: TEdit;
    edtNomeTabela: TEdit;
    btnFechar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnLimpar: TSpeedButton;
    btnSalvar: TSpeedButton;
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodTabelaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LimpaCampos;

  end;

var
  frmCadTabelaPrecoProduto: TfrmCadTabelaPrecoProduto;
  implementation

{$R *.dfm}


procedure TfrmCadTabelaPrecoProduto.btnFecharClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      close;
    end;
end;

procedure TfrmCadTabelaPrecoProduto.btnLimparClick(Sender: TObject);
begin
  inherited;
  LimpaCampos;
end;

procedure TfrmCadTabelaPrecoProduto.btnSalvarClick(Sender: TObject);
//ajustar isso daqui como nos outros forms
begin
  inherited;
  sqlTabelaPrecoProduto.Close;
  frmConexao.conexao.StartTransaction;
  sqlTabelaPrecoProduto.SQL.Text := 'insert '+
                                        'into '+
                                        'tabela_preco_produto(cd_tabela, '+
                                        'cd_produto, '+
                                        'valor, '+
                                        'un_medida)'+
                                    'values (:cd_tabela, '+
                                        ':cd_produto, '+
                                        ':valor, '+
                                        ':un_medida)';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
  sqlTabelaPrecoProduto.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
  sqlTabelaPrecoProduto.ParamByName('un_medida').AsString := edtUNMedida.Text;

  try
    sqlTabelaPrecoProduto.ExecSQL;
    frmConexao.conexao.Commit;
    ShowMessage('Dados Gravados com Sucesso');
    sqlTabelaPrecoProduto.Close;
    edtCodProduto.Text := '';
    edtValor.Text := '';
    edtNomeProduto.Text := '';
    edtUNMedida.Text := '';

  except
    on E:exception do
        begin
          frmConexao.conexao.Rollback;
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
  end;
  frmConexao.conexao.Close;
end;

procedure TfrmCadTabelaPrecoProduto.edtCodProdutoChange(Sender: TObject);
begin
  if edtCodProduto.Text = '' then
    begin
      edtNomeProduto.Text := '';
      Exit;
    end
  else
    begin
      sqlTabelaPrecoProduto.Close;
      sqlTabelaPrecoProduto.SQL.Text := 'select               '+
                                              'desc_produto,  '+
                                              'un_medida      '+
                                        'from                 '+
                                              'produto        '+
                                        'where                '+
                                              'cd_produto = :cd_produto';
      sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sqlTabelaPrecoProduto.Open();
      edtNomeProduto.Text := sqlTabelaPrecoProduto.FieldByName('desc_produto').AsString;
      edtUNMedida.Text := sqlTabelaPrecoProduto.FieldByName('un_medida').AsString;
    end;
end;

procedure TfrmCadTabelaPrecoProduto.edtCodTabelaChange(Sender: TObject);
begin
  //retorna a tabela de preço
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select '+
                                        'cd_tabela, '+
                                        'nm_tabela '+
                                    'from '+
                                        'tabela_preco '+
                                    'where '+
                                        'cd_tabela = :cd_tabela';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.Open();
  edtNomeTabela.Text := sqlTabelaPrecoProduto.FieldByName('nm_tabela').AsString;
end;

procedure TfrmCadTabelaPrecoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadTabelaPrecoProduto := nil;
end;

procedure TfrmCadTabelaPrecoProduto.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadTabelaPrecoProduto.LimpaCampos;
begin
  edtCodProduto.Clear;
  edtValor.Clear;
  edtUNMedida.Clear;
  edtNomeProduto.Clear;
  edtCodTabela.Clear;
  edtNomeTabela.Clear;
  edtCodProduto.SetFocus;
end;

end.
