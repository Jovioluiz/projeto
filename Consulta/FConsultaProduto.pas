unit FConsultaProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Datasnap.Provider, uConsultaProdutos;

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
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FConsulta: TConsultaProdutos;
  public
    { Public declarations }
  end;

var
  frmConsultaProdutos: TfrmConsultaProdutos;

implementation

{$R *.dfm}

uses uDataModule, dtmConsultaProduto;



procedure TfrmConsultaProdutos.btnPesquisarClick(Sender: TObject);
begin
  FConsulta.CarregaProdutos(edtPesquisa.Text, cbCodigo.Checked, cbDescricao.Checked, cbAtivo.Checked, cbEstoque.Checked);
end;

procedure TfrmConsultaProdutos.dbGridProdutoCellClick(Column: TColumn);
begin
  //dados da �ltima compra do item
  if FConsulta.Dados.cdsConsultaProduto.RecordCount > 0 then
  begin
    FConsulta.CarregaUltimaEntrada(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
    FConsulta.CarregaPrecos(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
    FConsulta.CarregaEstoques(FConsulta.Dados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt);
  end;
end;

procedure TfrmConsultaProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
    if (Application.MessageBox('Deseja Fechar?','Aten��o', MB_YESNO) = IDYES) then
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
