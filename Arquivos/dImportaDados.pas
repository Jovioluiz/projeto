unit dImportaDados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmImportaDados = class(TDataModule)
    dsProdutos: TDataSource;
    dsClientes: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsClientes: TClientDataSet;
    cdsProdutosseq: TIntegerField;
    cdsProdutoscd_produto: TStringField;
    cdsProdutosdesc_produto: TStringField;
    cdsProdutosun_medida: TStringField;
    cdsProdutosfator_conversao: TIntegerField;
    cdsProdutospeso_liquido: TFloatField;
    cdsProdutospeso_bruto: TFloatField;
    cdsClientesseq: TIntegerField;
    cdsClientescd_cliente: TIntegerField;
    cdsClientesnm_cliente: TStringField;
    cdsClientestp_pessoa: TBooleanField;
    cdsClientescelular: TStringField;
    cdsClientesemail: TStringField;
    cdsClientestelefone: TStringField;
    cdsClientescpf_cnpj: TStringField;
    cdsClientesrg_ie: TStringField;
    cdsClientesdt_nasc_fundacao: TDateField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmImportaDados: TdmImportaDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
