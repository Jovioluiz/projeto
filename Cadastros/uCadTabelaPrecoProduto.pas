unit uCadTabelaPrecoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.UITypes,
  FireDAC.Comp.Client, Vcl.Buttons;

type
  TfrmCadTabelaPrecoProduto = class(TForm)
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
    sql: TFDQuery;
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodTabelaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodProdutoExit(Sender: TObject);
  private
    FIdItem: Int64;
    procedure LimpaCampos;
    procedure Salvar;
    procedure Excluir;
    function GetIdItem(CdItem: string): Int64;
  public
    { Public declarations }
  end;

var
  frmCadTabelaPrecoProduto: TfrmCadTabelaPrecoProduto;
  implementation

uses
  uDataModule, uclTabelaPrecoProduto;

{$R *.dfm}

procedure TfrmCadTabelaPrecoProduto.edtCodProdutoChange(Sender: TObject);
const
  SQL = 'select            '+
        '   desc_produto,  '+
        '   un_medida      '+
        'from              '+
        '   produto        '+
        'where             '+
        '   id_item = :id_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    if edtCodProduto.Text = '' then
    begin
      edtNomeProduto.Text := '';
      Exit;
    end
    else
    begin
      qry.SQL.Add(SQL);
      qry.ParamByName('id_item').AsInteger := GetIdItem(edtCodProduto.Text);
      qry.Open();
      edtNomeProduto.Text := qry.FieldByName('desc_produto').AsString;
      edtUNMedida.Text := qry.FieldByName('un_medida').AsString;
    end;
  finally
    qry.Free;
  end;
end;

function TfrmCadTabelaPrecoProduto.GetIdItem(CdItem: string): Int64;
const
  SQL = 'select id_item from produto where cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_produto').AsString := CdItem;
    qry.Open();

    Result := qry.FieldByName('id_item').AsLargeInt;

  finally
    qry.Free;
  end;
end;

procedure TfrmCadTabelaPrecoProduto.edtCodProdutoExit(Sender: TObject);
begin
  FIdItem := GetIdItem(edtCodProduto.Text);
end;

procedure TfrmCadTabelaPrecoProduto.edtCodTabelaChange(Sender: TObject);
const
  SQL = 'select '+
        '   nm_tabela '+
        'from '+
        '   tabela_preco '+
        'where '+
        '   cd_tabela = :cd_tabela';
var
  qry: TFDQuery;
begin
  if edtCodTabela.Text = EmptyStr then
    Exit;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
    qry.Open();
    edtNomeTabela.Text := qry.FieldByName('nm_tabela').AsString;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadTabelaPrecoProduto.Excluir;
var
  produto: TTabelaPrecoProduto;
begin
  if (Application.MessageBox('Deseja Excluir o produto da Tabela de Preço?', 'Atenção', MB_YESNO) = IDYES) then
  begin
    produto := TTabelaPrecoProduto.Create;

    try
      produto.cd_tabela := StrToInt(edtCodTabela.Text);
      produto.id_item := FIdItem;
      produto.Excluir;
    finally
      produto.Free;
    end;
  end;
end;

procedure TfrmCadTabelaPrecoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadTabelaPrecoProduto := nil;
end;

procedure TfrmCadTabelaPrecoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F3 then //F3
    LimpaCampos
  else if key = VK_F2 then  //F2
    Salvar
  else if key = VK_F4 then    //F4
    Excluir
  else if key = VK_ESCAPE then //ESC
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    Close;
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
  edtNomeTabela.Clear;
  edtCodTabela.Clear;
  edtCodTabela.SetFocus;
end;

procedure TfrmCadTabelaPrecoProduto.Salvar;
var
  produto: TTabelaPrecoProduto;
begin
  produto := TTabelaPrecoProduto.Create;

  try
    produto.cd_tabela := StrToInt(edtCodTabela.Text);
    produto.id_item := FIdItem;
    produto.valor := StrToCurr(edtValor.Text);
    produto.un_medida := edtUNMedida.Text;

    if not produto.Pesquisar(StrToInt(edtCodTabela.Text), FIdItem) then
      produto.Inserir
    else
      produto.Atualizar;

    LimpaCampos;

  finally
    produto.Free;
  end;
end;

end.
