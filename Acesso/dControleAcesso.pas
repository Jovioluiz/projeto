unit dControleAcesso;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmControleAcesso = class(TDataModule)
    ds: TDataSource;
    cds: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmControleAcesso: TdmControleAcesso;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
