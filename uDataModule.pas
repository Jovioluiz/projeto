unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.PG;// frxClass, frxServerClient, frxDBSet;

type
  Tdm = class(TDataModule)
    FDConnection1: TFDConnection;
    driver: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tbClientes: TFDTable;
    DataSource1: TDataSource;
    sqlCliente: TFDQuery;
    tbClientescd_cliente: TIntegerField;
    tbClientesnome: TWideStringField;
    tbClientestp_pessoa: TWideStringField;
    tbClientesfl_ativo: TBooleanField;
    tbClientestelefone: TWideStringField;
    tbClientescelular: TWideStringField;
    tbClientesemail: TWideStringField;
    tbClientescpf_cnpj: TWideStringField;
    tbClientesrg_ie: TWideStringField;
    tbClientesdt_nasc_fundacao: TDateField;
    tbClientesfl_fornecedor: TBooleanField;
    tbClientesdt_atz: TSQLTimeStampField;
    sqlPedidoVenda: TFDQuery;
    //dsRelPedidoVenda: TfrxDBDataset;
    //reportPedidoVenda: TfrxReport;
    tbProdutos: TFDTable;
    tbProdutoscd_produto: TIntegerField;
    tbProdutosfl_ativo: TBooleanField;
    tbProdutosdesc_produto: TWideStringField;
    tbProdutosun_medida: TWideStringField;
    tbProdutosfator_conversao: TBCDField;
    tbProdutospeso_liquido: TBCDField;
    tbProdutospeso_bruto: TBCDField;
    tbProdutosobservacao: TWideMemoField;
    tbProdutosdt_atz: TSQLTimeStampField;
    tbProdutosqtd_estoque: TBCDField;
    tbProdutostipo_cod_barras: TWideStringField;
    tbProdutoscodigo_barras: TWideStringField;
    tbProdutosimagem: TWideStringField;
    dsProduto: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Params.Database := 'trabalho_engenharia';
  FDConnection1.Params.UserName := 'postgres';
  FDConnection1.Params.Password := 'postgres';

  FDConnection1.Connected := true;

  driver.VendorLib := GetCurrentDir + '\lib\libpq.dll';

  tbClientes.TableName := 'cliente';
  tbClientes.Active := True;
end;

end.
