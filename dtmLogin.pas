unit dtmLogin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Datasnap.DBClient, FireDAC.Comp.DataSet;

type
  TdmLogin = class(TDataModule)
    fConexao: TFDConnection;
    driver: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    queryLogin: TFDQuery;
    dsLogin: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmLogin: TdmLogin;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmLogin.DataModuleCreate(Sender: TObject);
begin
  fConexao.Params.Database := 'trabalho_engenharia';
  fConexao.Params.UserName := 'postgres';
  fConexao.Params.Password := 'postgres';

  fConexao.Connected := true;

  driver.VendorLib := GetCurrentDir + '\lib\libpq.dll';
end;

end.
