unit uConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, uConexao, Vcl.ComCtrls,
  Datasnap.Provider;

type
  TfrmConsultaProdutos = class(TfrmConexao)
    Panel1: TPanel;
    btnPesquisar: TButton;
    edtAtivo: TCheckBox;
    edtEstoque: TCheckBox;
    dbGridProduto: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    sqlConsulta: TFDQuery;
    edtCodigo: TCheckBox;
    edtDescricao: TCheckBox;
    StatusBar1: TStatusBar;
    edtPesquisa: TEdit;
    dbGridUltimasEntradas: TDBGrid;
    Label1: TLabel;
    DataSourceUltEntradas: TDataSource;
    ClientDataSetUltEntradas: TClientDataSet;
    sqlUltEntrada: TFDQuery;
    dbgriPrecos: TDBGrid;
    dsPrecos: TDataSource;
    cdPrecos: TClientDataSet;
    sqlPrecos: TFDQuery;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaProdutos: TfrmConsultaProdutos;

implementation

{$R *.dfm}

uses uDataModule;



procedure TfrmConsultaProdutos.btnPesquisarClick(Sender: TObject);
var sql : String;
begin
  sqlConsulta.Close;
  sqlConsulta.SQL.Text := 'select           '+
                          'cd_produto,      '+
                          'desc_produto,    '+
                          'un_medida,       '+
                          'fator_conversao, '+
                          'qtd_estoque,     '+
                          'codigo_barras    '+
                     'from                  '+
                          'produto ';

  //if edtPesquisa.Text = '' then
   // ShowMessage('Informe algo para pesquisar');
   // Exit;
  if edtPesquisa.Text = '*' then
    sqlConsulta.Open();
  if edtCodigo.Checked then
    begin
      sqlConsulta.SQL.Add(' where cast(cd_produto as varchar) ilike '+QuotedStr('%'+edtPesquisa.Text+'%'));
      sqlConsulta.SQL.Add(sql);
      //sqlConsulta.Open();
    end;
  if edtDescricao.Checked then
    sqlConsulta.SQL.Add(' or desc_produto ilike '+QuotedStr('%'+edtPesquisa.Text+'%'));
  if edtAtivo.Checked then
    sqlConsulta.SQL.Add(' and fl_ativo = true');
  if edtEstoque.Checked then
    sqlConsulta.SQL.Add(' and qtd_estoque > 0');

  sqlConsulta.SQL.Add(sql);
  sqlConsulta.Open();

  dbGridProduto.DataSource := DataSource1;
  dbGridProduto.Columns[0].Title.Caption := 'Codigo';
  dbGridProduto.Columns[0].FieldName := 'cd_produto';
  dbGridProduto.Columns[1].Title.Caption := 'Descrição';
  dbGridProduto.Columns[1].FieldName := 'desc_produto';
  dbGridProduto.Columns[2].Title.Caption := 'Un. Medida';
  dbGridProduto.Columns[2].FieldName := 'un_medida';
  dbGridProduto.Columns[3].Title.Caption := 'Fator Conversão';
  dbGridProduto.Columns[3].FieldName := 'fator_conversao';
  dbGridProduto.Columns[4].Title.Caption := 'Qtdade Estoque';
  dbGridProduto.Columns[4].FieldName := 'qtd_estoque';
  dbGridProduto.Columns[5].Title.Caption := 'Código de Barras';
  dbGridProduto.Columns[5].FieldName := 'codigo_barras';

  dbGridUltimasEntradas.DataSource := nil;

end;

procedure TfrmConsultaProdutos.dbGridProdutoCellClick(Column: TColumn);
begin
//dados da última compra do item
  sqlUltEntrada.Close;
  sqlUltEntrada.SQL.Text := 'select                                  '+
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

  sqlUltEntrada.ParamByName('cd_produto').AsInteger := StrToInt(dbGridProduto.Columns[0].Field.Text);
  sqlUltEntrada.Open();

  if sqlUltEntrada.IsEmpty then
    begin
      dbGridUltimasEntradas.DataSource := nil;
    end
  else
    begin
      dbGridUltimasEntradas.DataSource := DataSourceUltEntradas;
      dbGridUltimasEntradas.Columns[0].Title.Caption := 'Nota';
      dbGridUltimasEntradas.Columns[0].FieldName :=  'dcto_numero';
      dbGridUltimasEntradas.Columns[1].Title.Caption := 'Fornecedor';
      dbGridUltimasEntradas.Columns[1].FieldName :=  'fornecedor';
      dbGridUltimasEntradas.Columns[2].Title.Caption := 'Data Lançamento';
      dbGridUltimasEntradas.Columns[2].FieldName :=  'dt_lancamento';
      dbGridUltimasEntradas.Columns[3].Title.Caption := 'Quantidade';
      dbGridUltimasEntradas.Columns[3].FieldName :=  'quantidade';
      dbGridUltimasEntradas.Columns[4].Title.Caption := 'Valor Unitário';
      dbGridUltimasEntradas.Columns[4].FieldName :=  'vl_unitario';
      dbGridUltimasEntradas.Columns[5].Title.Caption := 'Un Medida';
      dbGridUltimasEntradas.Columns[5].FieldName :=  'un_medida';
    end;

   sqlPrecos.Close;
   sqlPrecos.SQL.Text := 'select                             '+
                          '    tpp.cd_tabela,                '+
                          '    tp.nm_tabela,                 '+
                          '    tpp.valor,                    '+
                          '    tpp.un_medida                 '+
                          '    from tabela_preco_produto tpp '+
                          'join tabela_preco tp on           '+
                          '    tpp.cd_tabela = tp.cd_tabela  '+
                          'where tpp.cd_produto = :cd_produto';
   sqlPrecos.ParamByName('cd_produto').AsInteger := StrToInt(dbGridProduto.Columns[0].Field.Text);
   sqlPrecos.Open();

   if sqlPrecos.IsEmpty then
   begin
     dbgriPrecos.DataSource := nil;
   end
   else
   begin
     dbgriPrecos.DataSource := dsPrecos;
     dbgriPrecos.Columns[0].Title.Caption := 'Tabela';
     dbgriPrecos.Columns[0].FieldName := 'cd_tabela';
     dbgriPrecos.Columns[1].Title.Caption := 'Desc. Tabela';
     dbgriPrecos.Columns[1].FieldName := 'nm_tabela';
     dbgriPrecos.Columns[2].Title.Caption := 'Valor';
     dbgriPrecos.Columns[2].FieldName := 'valor';
     dbgriPrecos.Columns[3].Title.Caption := 'Un. Medida';
     dbgriPrecos.Columns[3].FieldName := 'un_medida';
   end;



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

procedure TfrmConsultaProdutos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

end.
