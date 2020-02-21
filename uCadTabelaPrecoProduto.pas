unit uCadTabelaPrecoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.UITypes,
  FireDAC.Comp.Client;

type
  TfrmCadTabelaPrecoProduto = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodProduto: TEdit;
    edtValor: TEdit;
    edtUNMedida: TEdit;
    btnAdicionar: TButton;
    btnCancelar: TButton;
    edtNomeProduto: TEdit;
    sqlTabelaPrecoProduto: TFDQuery;
    Label5: TLabel;
    edtCodTabela: TEdit;
    edtNomeTabela: TEdit;
    procedure edtCodProdutoChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure edtCodTabelaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadTabelaPrecoProduto: TfrmCadTabelaPrecoProduto;

implementation

{$R *.dfm}

procedure TfrmCadTabelaPrecoProduto.btnAdicionarClick(Sender: TObject);
begin
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'insert into tabela_preco_produto(cd_tabela,cd_produto,valor,un_medida) '+
                                    'values (:cd_tabela, :cd_produto, :valor, :un_medida)';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
  sqlTabelaPrecoProduto.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
  sqlTabelaPrecoProduto.ParamByName('un_medida').AsString := edtUNMedida.Text;

  try
    sqlTabelaPrecoProduto.ExecSQL;
    sqlTabelaPrecoProduto.Close;
    //FreeAndNil(sqlTabelaPrecoProduto);
    ShowMessage('Dados Gravados com Sucesso');

    edtCodProduto.Text := '';
    edtValor.Text := '';
    edtNomeProduto.Text := '';
    edtUNMedida.Text := '';

  except
    on E:exception do
        begin
           ShowMessage('Erro ao gravar os dados'+ E.Message);
            exit;
        end;
  end;
end;

procedure TfrmCadTabelaPrecoProduto.btnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja fechar?', mtConfirmation, [mbYes,mbNo],0) = 6 then
    begin
      close;
    end;

end;

procedure TfrmCadTabelaPrecoProduto.edtCodProdutoChange(Sender: TObject);
begin
  begin
    if edtCodProduto.Text = '' then
      begin
        edtNomeProduto.Text := '';
        exit;
      end
    else

      sqlTabelaPrecoProduto.Close;
      sqlTabelaPrecoProduto.SQL.Text := 'select desc_produto, un_medida from produto where cd_produto = :cd_produto';
      sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sqlTabelaPrecoProduto.Open();
      edtNomeProduto.Text := sqlTabelaPrecoProduto.FieldByName('desc_produto').AsString;
      edtUNMedida.Text := sqlTabelaPrecoProduto.FieldByName('un_medida').AsString;
      //FreeAndNil(sqlTabelaPrecoProduto);
  end;


end;

procedure TfrmCadTabelaPrecoProduto.edtCodTabelaChange(Sender: TObject);
begin
  //retorna a tabela de preço
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select cd_tabela, nm_tabela from tabela_preco where cd_tabela = :cd_tabela';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.Open();
  edtNomeTabela.Text := sqlTabelaPrecoProduto.FieldByName('nm_tabela').AsString;
  //FreeAndNil(sqlTabelaPrecoProduto);
end;

procedure TfrmCadTabelaPrecoProduto.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;

end.
