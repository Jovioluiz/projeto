unit FConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Datasnap.Provider, uConsultaProdutos, Vcl.Menus;

type
  TfrmConsultaProdutos = class(TForm)
    Panel1: TPanel;
    btnPesquisar: TButton;
    cbAtivo: TCheckBox;
    cbEstoque: TCheckBox;
    dbGridProduto: TDBGrid;
    cbCodigo: TCheckBox;
    cbDescricao: TCheckBox;
    StatusBar1: TStatusBar;
    edtPesquisa: TEdit;
    dbGridUltimasEntradas: TDBGrid;
    Label1: TLabel;
    dbgriPrecos: TDBGrid;
    dbGridEstoque: TDBGrid;
    popProduto: TPopupMenu;
    VisualizarProduto1: TMenuItem;
    VisualizarCdigodeBarras1: TMenuItem;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure VisualizarProduto1Click(Sender: TObject);
    procedure VisualizarCdigodeBarras1Click(Sender: TObject);
  private
    FConsulta: TConsultaProdutos;
    FThread: TThread;
  public
    { Public declarations }
  end;

var
  frmConsultaProdutos: TfrmConsultaProdutos;

implementation

{$R *.dfm}

uses uDataModule, dtmConsultaProduto, cPRODUTO, fVisualizaCodigoBarras;



procedure TfrmConsultaProdutos.btnPesquisarClick(Sender: TObject);
begin
  FConsulta.CarregaProdutos(edtPesquisa.Text,
                            cbCodigo.Checked,
                            cbDescricao.Checked,
                            cbAtivo.Checked,
                            cbEstoque.Checked);
end;

procedure TfrmConsultaProdutos.dbGridProdutoCellClick(Column: TColumn);
begin

  if FConsulta.Dados.cdsConsultaProduto.RecordCount > 0 then
  begin
    FThread.CreateAnonymousThread(
    procedure
    begin
      FThread.Synchronize(FThread.CurrentThread,
                          procedure
                          begin
                            FConsulta.CarregaUltimaEntrada(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
                            FConsulta.CarregaPrecos(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
                            FConsulta.CarregaEstoques(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
                          end);
    end).Start;
  end;
end;

procedure TfrmConsultaProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmConsultaProdutos := nil;
  FConsulta.Free;
end;

procedure TfrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  cbCodigo.Checked := True;
  cbDescricao.Checked := True;
  FConsulta := TConsultaProdutos.Create;
  dbGridUltimasEntradas.DataSource := FConsulta.Dados.dsUltimaEntrada;
  dbGridProduto.DataSource := FConsulta.Dados.dsConsultaProduto;
  dbgriPrecos.DataSource := FConsulta.Dados.dsPrecos;
  dbGridEstoque.DataSource := FConsulta.Dados.dsEstoque;
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

procedure TfrmConsultaProdutos.VisualizarCdigodeBarras1Click(Sender: TObject);
var
  visualizaCod: TfVisualizaCodBarras;
begin
  if FConsulta.Dados.cdsConsultaProduto.RecordCount = 0 then
    Exit;

  visualizaCod := TfVisualizaCodBarras.Create(nil);

  try
    visualizaCod.IDItem := FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsInteger;
    visualizaCod.CDItem := FConsulta.Dados.cdsConsultaProduto.FieldByName('cd_produto').AsString;
    visualizaCod.Caption := 'Código de barras do item: ' + FConsulta.Dados.cdsConsultaProduto.FieldByName('cd_produto').AsString;
    visualizaCod.ShowModal;
  finally
    visualizaCod.Free;
  end;
end;

procedure TfrmConsultaProdutos.VisualizarProduto1Click(Sender: TObject);
var
  cadProduto: TfrmCadProduto;
begin
  if FConsulta.Dados.cdsConsultaProduto.RecordCount = 0 then
    Exit;

  cadProduto := TfrmCadProduto.Create(nil);

  try
    cadProduto.edtPRODUTOCD_PRODUTO.Text := FConsulta.Dados.cdsConsultaProduto.FieldByName('cd_produto').AsString;
    cadProduto.ShowModal;
  finally
    cadProduto.Free;
  end;
end;

end.
