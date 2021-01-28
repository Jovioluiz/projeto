unit uCadTABELAPRECO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCadTabelaPrecoProduto, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uUtil,
  uDataModule;

type
  TfrmcadTabelaPreco = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtFl_ativo: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    edtCodTabela: TEdit;
    edtNomeTabela: TEdit;
    edtDtInicial: TMaskEdit;
    edtDtFinal: TMaskEdit;
    DBGridProduto: TDBGrid;
    btnAdicionarProduto: TButton;
    sqlTabelaPreco: TFDQuery;
    sqlTabelaPrecoProduto: TFDQuery;
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutosnm_produto: TStringField;
    cdsProdutosvalor: TCurrencyField;
    cdsProdutosun_medida: TStringField;
    cdsProdutoscd_produto: TStringField;
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure edtCodTabelaExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure limpaCampos;
    procedure Salvar;
    procedure Excluir;
    function GetIdItem(CdItem: string): Int64;
  public
    { Public declarations }

  end;

var
  frmcadTabelaPreco: TfrmcadTabelaPreco;
  temPermissao : Boolean;
  cliente : TValidaDados;


implementation

{$R *.dfm}

uses uLogin, uclTabelaPreco, uclTabelaPrecoProduto;

procedure TfrmcadTabelaPreco.btnAdicionarProdutoClick(Sender: TObject);
begin
  //aberto := True;arrumar
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, 6);

  if temPermissao then
  begin
    frmCadTabelaPrecoProduto := TfrmCadTabelaPrecoProduto.Create(Self);
    frmCadTabelaPrecoProduto.Show;
  end;
end;

function TfrmcadTabelaPreco.GetIdItem(CdItem: string): Int64;
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

procedure TfrmcadTabelaPreco.DBGridProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  produto: TTabelaPrecoProduto;
begin
  if KEY = VK_DELETE then
  begin
    if (Application.MessageBox('Deseja Excluir o produto da Tabela?', 'Atenção', MB_YESNO) = IDYES) then
    begin
      produto := TTabelaPrecoProduto.Create;

      try
        produto.cd_tabela := StrToInt(edtCodTabela.Text);
        produto.id_item := GetIdItem(cdsProdutos.FieldByName('cd_produto').AsString);
        produto.Excluir;
      finally
        produto.Free;
      end;
    end;
    cdsProdutos.Delete;
  end;
end;

procedure TfrmcadTabelaPreco.edtCodTabelaExit(Sender: TObject);
const
  SQL = 'select                           '+
        '   p.cd_produto,                 '+
        '   p.desc_produto,               '+
        '   valor,                        '+
        '   p.un_medida                   '+
        'from                             '+
        '   produto p                     '+
        'join tabela_preco_produto tpp on '+
        '   p.id_item = tpp.id_item       '+
        'where                            '+
        '   tpp.cd_tabela = :cd_tabela';
var
  tabela: TTabelaPreco;
  qry: TFDQuery;
begin
  if edtCodTabela.Text = EmptyStr then
  begin
    btnAdicionarProduto.Enabled := False;
    Exit;
  end;

  tabela := TTabelaPreco.Create;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    tabela.Buscar(StrToInt(edtCodTabela.Text));

    edtNomeTabela.Text := tabela.nm_tabela;
    edtFl_ativo.Checked := tabela.fl_ativo;
    edtDtInicial.Text := DateToStr(tabela.dt_inicio);
    edtDtFinal.Text := DateToStr(tabela.dt_fim);

  finally
    tabela.Free;
  end;

  btnAdicionarProduto.Enabled := True;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
    qry.Open();

    qry.Loop(
    procedure
    begin
      cdsProdutos.Append;
      cdsProdutos.FieldByName('cd_produto').AsString := qry.FieldByName('cd_produto').AsString;
      cdsProdutos.FieldByName('nm_produto').AsString := qry.FieldByName('desc_produto').AsString;
      cdsProdutos.FieldByName('valor').AsCurrency := qry.FieldByName('valor').AsCurrency;
      cdsProdutos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      cdsProdutos.Post;
    end);

  finally
    qry.Free;
  end;
end;

procedure TfrmcadTabelaPreco.Excluir;
var
  tabelaPreco: TTabelaPreco;
begin
  if (Application.MessageBox('Deseja Excluir a Tabela de Preço?', 'Atenção', MB_YESNO) <> IDYES) then
    Exit;

  tabelaPreco := TTabelaPreco.Create;

  try
    tabelaPreco.cd_tabela := StrToInt(edtCodTabela.Text);
    tabelaPreco.Excluir;
    limpaCampos;
  finally
    tabelaPreco.Free;
  end;
end;

procedure TfrmcadTabelaPreco.FormActivate(Sender: TObject);
{quando fechar o formulario (uCadTabelaPrecoProduto) de adicionar o produto na tabela de preço,
sempre vai executar o sql abaixo, para atualizar os valores dos produtos no grid}
begin
  inherited;
  //arrumar
//  if aberto = False then
//  begin
//    sqlTabelaPrecoProduto.Close;
//    sqlTabelaPrecoProduto.SQL.Text := 'select                         '+
//                                        'p.cd_produto,                '+
//                                        'p.desc_produto,              '+
//                                        'valor,                       '+
//                                        'p.un_medida                  '+
//                                    'from                             '+
//                                        'produto p                    '+
//                                    'join tabela_preco_produto tpp on '+
//                                        'p.cd_produto = tpp.cd_produto '+
//                                    'where                            '+
//                                        'tpp.cd_tabela = :cd_tabela';
//    sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
//    sqlTabelaPrecoProduto.Open();
//
//    DBGridProduto.DataSource := DataSource1;
//    DBGridProduto.Columns[0].Title.Caption := 'Produto';
//    DBGridProduto.Columns[0].FieldName := 'cd_produto';
//    DBGridProduto.Columns[1].Title.Caption := 'Nome Produto';
//    DBGridProduto.Columns[1].FieldName := 'desc_produto';
//    DBGridProduto.Columns[2].Title.Caption := 'Valor';
//    DBGridProduto.Columns[2].FieldName := 'valor';
//    DBGridProduto.Columns[3].Title.Caption := 'UN Medida';
//    DBGridProduto.Columns[3].FieldName := 'un_medida';
//  end;
end;

procedure TfrmcadTabelaPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmcadTabelaPreco := nil;
end;

procedure TfrmcadTabelaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  //aberto := True;
end;

procedure TfrmcadTabelaPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F3 then //F3
    limpaCampos
  else if key = VK_F2 then  //F2
    Salvar
  else if key = VK_F4 then    //F4
    Excluir
  else if key = VK_ESCAPE then //ESC
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmcadTabelaPreco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmcadTabelaPreco.limpaCampos;
begin
  edtFl_ativo.Checked := false;
  edtCodTabela.Clear;
  edtNomeTabela.Clear;
  edtDtInicial.Clear;
  edtDtFinal.Clear;
  cdsProdutos.EmptyDataSet;
  edtCodTabela.SetFocus;
end;

procedure TfrmcadTabelaPreco.Salvar;
var
  tabelaPreco: TTabelaPreco;
begin
  tabelaPreco := TTabelaPreco.Create;

  tabelaPreco.cd_tabela := StrToInt(edtCodTabela.Text);
  tabelaPreco.nm_tabela := edtNomeTabela.Text;
  tabelaPreco.fl_ativo := edtFl_ativo.Checked;
  tabelaPreco.dt_inicio := StrToDate(edtDtInicial.Text);
  tabelaPreco.dt_fim := StrToDate(edtDtFinal.Text);

  try
    if not tabelaPreco.Pesquisar(StrToInt(edtCodTabela.Text)) then
      tabelaPreco.Inserir
    else
      tabelaPreco.Atualizar;

    limpaCampos;
  finally
    tabelaPreco.Free;
  end
end;

end.
