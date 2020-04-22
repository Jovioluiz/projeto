unit uConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, uConexao;

type
  TfrmConsultaProdutos = class(TfrmConexao)
    Panel1: TPanel;
    edtPesquisa: TEdit;
    btnPesquisar: TButton;
    edtAtivo: TCheckBox;
    edtEstoque: TCheckBox;
    dbGridProduto: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    sqlConsulta: TFDQuery;
    edtCodigo: TCheckBox;
    edtDescricao: TCheckBox;
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaProdutos: TfrmConsultaProdutos;

implementation

{$R *.dfm}



procedure TfrmConsultaProdutos.btnPesquisarClick(Sender: TObject);
var sql : String;
begin
  sqlConsulta.Close;
  sqlConsulta.SQL.Text := 'select               '+
                          'cd_produto,      '+
                          'desc_produto,    '+
                          'un_medida,       '+
                          'fator_conversao, '+
                          'qtd_estoque,     '+
                          'codigo_barras    '+
                     'from                  '+
                          'produto ';
  if edtPesquisa.Text = EmptyStr then
    Exit;
  if edtPesquisa.Text = '*' then
    sqlConsulta.Open();
  if edtCodigo.Checked then
    begin
      sqlConsulta.SQL.Add(' where cd_produto = :cd_produto');
      sqlConsulta.ParamByName('cd_produto').AsInteger := StrToInt(edtPesquisa.Text);
      sqlConsulta.SQL.Add(sql);
      sqlConsulta.Open();
    end;
  if edtDescricao.Checked then
    sqlConsulta.SQL.Add(' where desc_produto ilike '+QuotedStr('%'+edtPesquisa.Text+'%'));
  if edtAtivo.Checked then
    sqlConsulta.SQL.Add(' and fl_ativo = true');
  if edtEstoque.Checked then
    sqlConsulta.SQL.Add(' and qtd_estoque > 0');

  sqlConsulta.SQL.Add(sql);
  sqlConsulta.Open();

  dbGridProduto.DataSource := DataSource1;
  dbGridProduto.Columns[0].Title.Caption := 'Código';
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
end;

end.
