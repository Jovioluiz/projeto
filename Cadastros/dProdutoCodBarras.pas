unit dProdutoCodBarras;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmProdutoCodBarras = class(TDataModule)
    dsBarras: TDataSource;
    cdsBarras: TClientDataSet;
    cdsBarrasun_medida: TStringField;
    cdsBarrastipo_cod_barras: TStringField;
    cdsBarrascodigo_barras: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmProdutoCodBarras: TdmProdutoCodBarras;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
