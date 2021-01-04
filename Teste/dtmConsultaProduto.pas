unit dtmConsultaProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmConsultaProduto = class(TDataModule)
    query: TFDQuery;
    dsUltimaEntrada: TDataSource;
    cdsUltEntrada: TClientDataSet;
    cdsUltEntradanota: TIntegerField;
    cdsUltEntradafornecedor: TStringField;
    cdsUltEntradadataLancamento: TDateField;
    cdsUltEntradaquantidade: TFloatField;
    cdsUltEntradavalor_unitario: TCurrencyField;
    cdsUltEntradaun_medida: TStringField;
    DataSetProvider1: TDataSetProvider;
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
