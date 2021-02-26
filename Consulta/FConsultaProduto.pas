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
    dsPrecos: TDataSource;
    cdsPrecos: TClientDataSet;
    intgrfldPrecoscd_tabela: TIntegerField;
    cdsPrecosnm_tabela: TStringField;
    cdsPrecosvalor: TCurrencyField;
    cdsPrecosun_medida: TStringField;
    dbGridEstoque: TDBGrid;
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbGridProdutoCellClick(Column: TColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FConsulta: TConsultaProdutos;
    procedure CarregaPrecos;
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

procedure TfrmConsultaProdutos.CarregaPrecos;
const
  sql = 'select                            '+
        '    tpp.cd_tabela,                '+
        '    tp.nm_tabela,                 '+
        '    tpp.valor,                    '+
        '    tpp.un_medida                 '+
        '    from tabela_preco_produto tpp '+
        'join tabela_preco tp on           '+
        '    tpp.cd_tabela = tp.cd_tabela  '+
        'where tpp.id_item = :id_item';
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
//    qry.ParamByName('id_item').AsLargeInt := cdsConsultaProduto.FieldByName('id_item').AsLargeInt;
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

procedure TfrmConsultaProdutos.dbGridProdutoCellClick(Column: TColumn);
begin
  //dados da última compra do item
//  if cdsConsultaProduto.RecordCount > 0 then
//  begin
//    FConsulta.CarregaUltimaEntrada;
//    CarregaPrecos;
//  end;
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
