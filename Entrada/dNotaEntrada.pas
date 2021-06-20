unit dNotaEntrada;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmNotaEntrada = class(TDataModule)
    dsNfc: TDataSource;
    cdsNfc: TClientDataSet;
    dsNfi: TDataSource;
    cdsNfi: TClientDataSet;
    cdsNfcid_geral: TLargeintField;
    cdsNfcdcto_numero: TIntegerField;
    cdsNfcserie: TStringField;
    cdsNfccd_fornecedor: TIntegerField;
    cdsNfcdt_emissao: TSQLTimeStampField;
    cdsNfcdt_recebimento: TSQLTimeStampField;
    cdsNfcdt_lancamento: TSQLTimeStampField;
    cdsNfccd_operacao: TIntegerField;
    cdsNfccd_modelo: TStringField;
    cdsNfcvalor_total: TCurrencyField;
    cdsNfcvl_base_icms: TCurrencyField;
    cdsNfcpc_aliq_icms: TCurrencyField;
    cdsNfcvalor_icms: TCurrencyField;
    cdsNfcvalor_frete: TCurrencyField;
    cdsNfcvalor_ipi: TCurrencyField;
    cdsNfcvalor_iss: TCurrencyField;
    cdsNfcvalor_desconto: TCurrencyField;
    cdsNfcvalor_acrescimo: TCurrencyField;
    cdsNfcvalor_outras_despesas: TCurrencyField;
    cdsNfiid_geral: TLargeintField;
    cdsNfiid_nfc: TLargeintField;
    cdsNfiid_item: TIntegerField;
    cdsNfiqtd_estoque: TFloatField;
    cdsNfiun_medida: TStringField;
    cdsNfivl_unitario: TCurrencyField;
    cdsNfivl_frete_rateado: TCurrencyField;
    cdsNfivl_desconto_rateado: TCurrencyField;
    cdsNfivl_acrescimo_rateado: TCurrencyField;
    cdsNfiseq_item_nfi: TIntegerField;
    cdsNfiicms_vl_base: TCurrencyField;
    cdsNfiicms_pc_aliq: TCurrencyField;
    cdsNfiicms_valor: TCurrencyField;
    cdsNfiipi_vl_base: TCurrencyField;
    cdsNfiipi_pc_aliq: TCurrencyField;
    cdsNfiipi_valor: TCurrencyField;
    cdsNfipis_cofins_vl_base: TCurrencyField;
    cdsNfipis_cofins_pc_aliq: TCurrencyField;
    cdsNfipis_cofins_valor: TCurrencyField;
    cdsNfiiss_vl_base: TCurrencyField;
    cdsNfiiss_pc_aliq: TCurrencyField;
    cdsNfiiss_valor: TCurrencyField;
    cdsNfivalor_total: TCurrencyField;
    cdsNficd_produto: TStringField;
    cdsNfidescricao: TStringField;
    cdsNfifator_conversao: TIntegerField;
    cdsNfiqtd_total: TFloatField;
    cdsNfcvalor_servico: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmNotaEntrada: TdmNotaEntrada;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
