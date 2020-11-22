unit uConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Datasnap.Provider;

type
  TfrmConsultaProdutos = class(TForm)
    Panel1: TPanel;
    btnPesquisar: TButton;
    edtAtivo: TCheckBox;
    edtEstoque: TCheckBox;
    dbGridProduto: TDBGrid;
    dsConsultaProduto: TDataSource;
    cdsConsultaProduto: TClientDataSet;
    edtCodigo: TCheckBox;
    edtDescricao: TCheckBox;
    StatusBar1: TStatusBar;
    edtPesquisa: TEdit;
    dbGridUltimasEntradas: TDBGrid;
    Label1: TLabel;
    dsUltimaEntradas: TDataSource;
    cdsUltimasEntradas: TClientDataSet;
    dbgriPrecos: TDBGrid;
    dsPrecos: TDataSource;
    cdsPrecos: TClientDataSet;
    intgrfldConsultaProdutocd_produto: TIntegerField;
    cdsConsultaProdutodesc_produto: TStringField;
    cdsConsultaProdutoun_medida: TStringField;
    intgrfldConsultaProdutofator_conversao: TIntegerField;
    cdsConsultaProdutoqtd_estoque: TFloatField;
    intgrfldUltimasEntradasdcto_numero: TIntegerField;
    cdsUltimasEntradasfornecedor: TStringField;
    cdsUltimasEntradasdt_lancamento: TDateField;
    cdsUltimasEntradasun_medida: TStringField;
    cdsUltimasEntradasvl_unitario: TFloatField;
    cdsUltimasEntradasquantidade: TFloatField;
    intgrfldPrecoscd_tabela: TIntegerField;
    cdsPrecosnm_tabela: TStringField;
    cdsPrecosvalor: TCurrencyField;
    cdsPrecosun_medida: TStringField;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure carregaUltimaEntrada;
    procedure carregaPrecos;
  public
    { Public declarations }
  end;

var
  frmConsultaProdutos: TfrmConsultaProdutos;

implementation

{$R *.dfm}

uses uDataModule, dtmConsultaProduto;



procedure TfrmConsultaProdutos.btnPesquisarClick(Sender: TObject);
const
  sql_produto =  'select           '+
                      'cd_produto,      '+
                      'desc_produto,    '+
                      'un_medida,       '+
                      'fator_conversao, '+
                      'qtd_estoque      '+
                 'from                  '+
                      'produto ';
var
  qry: TFDQuery;
begin
  cdsConsultaProduto.EmptyDataSet;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.SQL.Add(sql_produto);

  try
    if Trim(edtPesquisa.Text) = '' then
    begin
      ShowMessage('Informe algo para pesquisar');
      Exit;
    end;

    if edtPesquisa.Text = '*' then
      qry.Open(sql_produto);

    if edtCodigo.Checked then
      qry.SQL.Add(' where cast(cd_produto as varchar) ilike '+QuotedStr('%'+edtPesquisa.Text+'%'));

    if edtDescricao.Checked then
      qry.SQL.Add(' or desc_produto ilike '+QuotedStr('%'+edtPesquisa.Text+'%'));
    if edtAtivo.Checked then
      qry.SQL.Add(' and fl_ativo = true');
    if edtEstoque.Checked then
      qry.SQL.Add(' and qtd_estoque > 0');

    qry.Open();
    dsConsultaProduto.DataSet.Active := True;
    qry.First;

    while not qry.Eof do
    begin
      cdsConsultaProduto.Append;
      cdsConsultaProduto.FieldByName('cd_produto').AsInteger := qry.FieldByName('cd_produto').AsInteger;
      cdsConsultaProduto.FieldByName('desc_produto').AsString := qry.FieldByName('desc_produto').AsString;
      cdsConsultaProduto.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      cdsConsultaProduto.FieldByName('fator_conversao').AsInteger := qry.FieldByName('fator_conversao').AsInteger;
      cdsConsultaProduto.FieldByName('qtd_estoque').AsFloat := qry.FieldByName('qtd_estoque').AsFloat;
      cdsConsultaProduto.Post;
      qry.Next;
    end;
  finally
    qry.Free;
  end;

end;

procedure TfrmConsultaProdutos.carregaPrecos;
const
  sql = 'select                            '+
        '    tpp.cd_tabela,                '+
        '    tp.nm_tabela,                 '+
        '    tpp.valor,                    '+
        '    tpp.un_medida                 '+
        '    from tabela_preco_produto tpp '+
        'join tabela_preco tp on           '+
        '    tpp.cd_tabela = tp.cd_tabela  '+
        'where tpp.cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  cdsPrecos.EmptyDataSet;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := cdsConsultaProduto.FieldByName('cd_produto').AsInteger;
    qry.Open();

    if qry.IsEmpty then
      cdsPrecos.EmptyDataSet
    else
    begin
      qry.First;
      while not qry.Eof do
      begin
        cdsPrecos.Append;
        cdsPrecos.FieldByName('cd_tabela').AsInteger := qry.FieldByName('cd_tabela').AsInteger;
        cdsPrecos.FieldByName('nm_tabela').AsString := qry.FieldByName('nm_tabela').AsString;
        cdsPrecos.FieldByName('valor').AsCurrency := qry.FieldByName('valor').AsCurrency;
        cdsPrecos.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
        cdsPrecos.Post;
        qry.Next;
      end;
    end;

  finally
    qry.Free;
  end;
end;

procedure TfrmConsultaProdutos.carregaUltimaEntrada;
const
  sql = 'select                                  '+
        '    nfc.dcto_numero,                    '+
        '    c.nome as fornecedor,               '+
        '    nfc.dt_lancamento,                  '+
        '    nfi.un_medida,                      '+
        '    nfi.vl_unitario,                    '+
        '    nfi.qtd_estoque as quantidade       '+
        'from                                    '+
        '    produto p                           '+
        'join nfi on                             '+
        '    p.cd_produto = nfi.cd_produto       '+
        'join nfc on                             '+
        '    nfc.id_geral = nfi.id_nfc           '+
        'join cliente c on                       '+
        '    nfc.cd_fornecedor = c.cd_cliente    '+
        'where                                   '+
        '    p.cd_produto in (                   '+
        '    select                              '+
        '        nfi.cd_produto                  '+
        '    from                                '+
        '        nfc                             '+
        '    join nfi on                         '+
        '        nfc.id_geral = nfi.id_nfc       '+
        '    where                               '+
        '        nfc.dcto_numero > 0             '+
        '        and p.cd_produto = :cd_produto)';
var
  qry: TFDQuery;
begin
  cdsUltimasEntradas.EmptyDataSet;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := cdsConsultaProduto.FieldByName('cd_produto').AsInteger;
    qry.Open();

    if qry.IsEmpty then
      cdsUltimasEntradas.EmptyDataSet
    else
    begin
      qry.First;
      while not qry.Eof do
      begin
        cdsUltimasEntradas.Append;
        cdsUltimasEntradas.FieldByName('dcto_numero').AsInteger := qry.FieldByName('dcto_numero').AsInteger;
        cdsUltimasEntradas.FieldByName('fornecedor').AsString := qry.FieldByName('fornecedor').AsString;
        cdsUltimasEntradas.FieldByName('dt_lancamento').AsDateTime := qry.FieldByName('dt_lancamento').AsDateTime;
        cdsUltimasEntradas.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
        cdsUltimasEntradas.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
        cdsUltimasEntradas.FieldByName('quantidade').AsFloat := qry.FieldByName('quantidade').AsFloat;
        cdsUltimasEntradas.Post;
        qry.Next;
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmConsultaProdutos.dbGridProdutoCellClick(Column: TColumn);
begin
  //dados da última compra do item
  carregaUltimaEntrada;
  carregaPrecos;
end;

procedure TfrmConsultaProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmConsultaProdutos := nil;
end;

procedure TfrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodigo.Checked := True;
  edtDescricao.Checked := True;
  //edtPesquisa.SetFocus;
end;

procedure TfrmConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
      Close;
  end;
end;

procedure TfrmConsultaProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

end.
