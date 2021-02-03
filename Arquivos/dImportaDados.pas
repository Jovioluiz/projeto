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
