unit dControleAcesso;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmControleAcesso = class(TDataModule)
    ds: TDataSource;
    cds: TClientDataSet;
    cdscd_acao: TIntegerField;
    cdsnm_acao: TStringField;
    cdsfl_permite_acesso: TBooleanField;
    cdsfl_permite_edicao: TBooleanField;
    cdscd_usuario: TIntegerField;
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
