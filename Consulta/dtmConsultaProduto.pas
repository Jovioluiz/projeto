unit dtmConsultaProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmConsultaProduto = class(TDataModule)
    dsUltimaEntrada: TDataSource;
    cdsUltimasEntradas: TClientDataSet;
    cdsUltimasEntradasnota: TIntegerField;
    cdsUltimasEntradasfornecedor: TStringField;
    cdsUltimasEntradasdataLancamento: TDateField;
    cdsUltimasEntradasquantidade: TFloatField;
    cdsUltimasEntradasvalor_unitario: TCurrencyField;
    cdsUltimasEntradasun_medida: TStringField;
    dsConsultaProduto: TDataSource;
    cdsConsultaProduto: TClientDataSet;
    cdsConsultaProdutocd_produto: TStringField;
    cdsConsultaProdutodesc_produto: TStringField;
    cdsConsultaProdutoun_medida: TStringField;
    cdsConsultaProdutofator_conversao: TIntegerField;
    cdsConsultaProdutoid_item: TLargeintField;
    dsPrecos: TDataSource;
    cdsPrecos: TClientDataSet;
    cdsPrecoscd_tabela: TIntegerField;
    cdsPrecosnm_tabela: TStringField;
    cdsPrecosvalor: TCurrencyField;
    cdsPrecosun_medida: TStringField;
    dsEstoque: TDataSource;
    cdsEstoque: TClientDataSet;
    cdsEstoquenm_endereco: TStringField;
    cdsEstoqueordem: TIntegerField;
    cdsEstoqueqt_estoque: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConsultaProduto: TdmConsultaProduto;

implementation

uses
  uDataModule;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
