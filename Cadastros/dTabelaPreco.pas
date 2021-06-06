unit dTabelaPreco;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmProdutosTabelaPreco = class(TDataModule)
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutoscd_produto: TStringField;
    cdsProdutosnm_produto: TStringField;
    cdsProdutosvalor: TCurrencyField;
    cdsProdutosun_medida: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProdutosTabelaPreco: TdmProdutosTabelaPreco;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
