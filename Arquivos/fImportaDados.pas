unit fImportaDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtDlgs, Vcl.ComCtrls,
  Vcl.Samples.Gauges, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  dImportaDados, uImportacaoDados;

type
  TfrmImportaDados = class(TForm)
    btnGravar: TButton;
    Label1: TLabel;
    edtArquivo: TEdit;
    btnBuscarArquivoProduto: TSpeedButton;
    dlArquivo: TOpenTextFileDialog;
    btnVisualizarProdutos: TButton;
    Panel1: TPanel;
    dbGridProdutos: TDBGrid;
    pnlFundo: TPanel;
    PageControl1: TPageControl;
    tbProdutos: TTabSheet;
    tbClientes: TTabSheet;
    Label2: TLabel;
    edtArquivoCliente: TEdit;
    btnBuscaArquivoCliente: TSpeedButton;
    btnVisualizarCliente: TButton;
    btnGravarCliente: TButton;
    dbGridClientes: TDBGrid;
    gaugeClientes: TGauge;
    gaugeProdutos: TGauge;
    procedure btnBuscarArquivoProdutoClick(Sender: TObject);
    procedure btnVisualizarProdutosClick(Sender: TObject);
    procedure btnGravarClienteClick(Sender: TObject);
    procedure btnBuscaArquivoClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnVisualizarClienteClick(Sender: TObject);
    procedure tbProdutosHide(Sender: TObject);
    procedure tbClientesHide(Sender: TObject);
  private
    FRegras: TImportacaoDados;

    { Private declarations }
  public
    { Public declarations }
    procedure LimpaCampos;
    property Regra: TImportacaoDados read FRegras;
  end;

var
  frmImportaDados: TfrmImportaDados;

implementation

uses
  FireDAC.Comp.Client, uDataModule, uclProduto;

{$R *.dfm}

procedure TfrmImportaDados.btnBuscaArquivoClienteClick(Sender: TObject);
begin
  dlArquivo.Filter := '*.csv|*.csv';
  if dlArquivo.Execute then
    edtArquivoCliente.Text := dlArquivo.FileName;

  btnGravarCliente.Enabled := True;
end;

procedure TfrmImportaDados.btnGravarClick(Sender: TObject);
begin
  if edtArquivo.Text <> '' then
    if FRegras.SalvarProduto(dlArquivo.FileName) then
      LimpaCampos;
end;

procedure TfrmImportaDados.btnGravarClienteClick(Sender: TObject);
begin
  if edtArquivoCliente.Text <> '' then
    FRegras.SalvarCliente(dlArquivo.FileName);
end;

procedure TfrmImportaDados.btnVisualizarClienteClick(Sender: TObject);
begin
  if edtArquivoCliente.Text = '' then
  begin
    ShowMessage('Informe um arquivo');
    Exit;
  end
  else
    FRegras.ListaClientes(dlArquivo.FileName);
end;

procedure TfrmImportaDados.btnVisualizarProdutosClick(Sender: TObject);
begin
  if edtArquivo.Text = '' then
  begin
    ShowMessage('Informe um arquivo');
    Exit;
  end
  else
    FRegras.ListaProdutos(dlArquivo.FileName);
end;

procedure TfrmImportaDados.FormCreate(Sender: TObject);
begin
  FRegras := TImportacaoDados.Create;
  dbGridProdutos.DataSource := FRegras.Dados.dsProdutos;
  dbGridClientes.DataSource := FRegras.Dados.dsClientes;
  PageControl1.ActivePage := tbProdutos;
  btnGravar.Enabled := False;
  btnGravarCliente.Enabled := False;
end;

procedure TfrmImportaDados.FormDestroy(Sender: TObject);
begin
  FRegras.Free;
end;

procedure TfrmImportaDados.LimpaCampos;
begin
  edtArquivo.Clear;
  FRegras.Dados.cdsProdutos.EmptyDataSet;
end;

procedure TfrmImportaDados.tbClientesHide(Sender: TObject);
begin
  edtArquivoCliente.Clear;
end;

procedure TfrmImportaDados.tbProdutosHide(Sender: TObject);
begin
  edtArquivo.Clear;
end;

procedure TfrmImportaDados.btnBuscarArquivoProdutoClick(Sender: TObject);
begin
  dlArquivo.Filter := '*.csv|*.csv';
  if dlArquivo.Execute then
    edtArquivo.Text := dlArquivo.FileName;

  btnGravar.Enabled := True;
end;

end.
