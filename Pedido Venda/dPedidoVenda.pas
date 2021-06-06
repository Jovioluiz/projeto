unit dPedidoVenda;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmPedidoVenda = class(TDataModule)
    dsPedidoVendaItem: TDataSource;
    cdsPedidoVendaItem: TClientDataSet;
    dsPedidoVenda: TDataSource;
    cdsPedidoVenda: TClientDataSet;
    cdsPedidoVendaItemid_geral: TLargeintField;
    cdsPedidoVendaItemid_item: TLargeintField;
    cdsPedidoVendaItemid_pedido_venda: TLargeintField;
    cdsPedidoVendaItemcd_produto: TStringField;
    cdsPedidoVendaItemdescricao: TStringField;
    cdsPedidoVendaItemqtd_venda: TFloatField;
    cdsPedidoVendaItemcd_tabela_preco: TIntegerField;
    cdsPedidoVendaItemun_medida: TStringField;
    cdsPedidoVendaItemvl_unitario: TCurrencyField;
    cdsPedidoVendaItemvl_desconto: TCurrencyField;
    cdsPedidoVendaItemvl_total_item: TCurrencyField;
    cdsPedidoVendaItemicms_vl_base: TCurrencyField;
    cdsPedidoVendaItemicms_pc_aliq: TCurrencyField;
    cdsPedidoVendaItemicms_valor: TCurrencyField;
    cdsPedidoVendaItemipi_vl_base: TCurrencyField;
    cdsPedidoVendaItemipi_pc_aliq: TCurrencyField;
    cdsPedidoVendaItemipi_valor: TCurrencyField;
    cdsPedidoVendaItempis_cofins_vl_base: TCurrencyField;
    cdsPedidoVendaItempis_cofins_pc_aliq: TCurrencyField;
    cdsPedidoVendaItempis_cofins_valor: TCurrencyField;
    cdsPedidoVendaItemseq: TIntegerField;
    cdsPedidoVendaid_geral: TLargeintField;
    cdsPedidoVendanr_pedido: TIntegerField;
    cdsPedidoVendacd_cliente: TIntegerField;
    cdsPedidoVendacd_forma_pag: TIntegerField;
    cdsPedidoVendacd_cond_pag: TIntegerField;
    cdsPedidoVendavl_desconto_pedido: TCurrencyField;
    cdsPedidoVendavl_acrescimo: TCurrencyField;
    cdsPedidoVendavl_total: TCurrencyField;
    cdsPedidoVendafl_orcamento: TBooleanField;
    cdsPedidoVendadt_emissao: TDateField;
    cdsPedidoVendafl_cancelado: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPedidoVenda: TdmPedidoVenda;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
