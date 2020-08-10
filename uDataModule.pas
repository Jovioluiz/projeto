unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.PG;// frxClass, frxServerClient, frxDBSet;

type
  Tdm = class(TDataModule)
    FDConnection1: TFDConnection;
    driver: TFDPhysPgDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    sqlCliente: TFDQuery;
    transacao: TFDTransaction;
    queryControleAcesso: TFDQuery;
    tbControleAcesso: TFDTable;
    dsControleAcesso: TDataSource;
    query: TFDQuery;
    queryControleAcessocd_acao: TIntegerField;
    queryControleAcessonm_acao: TWideStringField;
    queryControleAcessonm_formulario: TWideStringField;
    queryControleAcessodt_atz: TSQLTimeStampField;
    queryControleAcessocd_usuario: TIntegerField;
    queryControleAcessocd_acao_1: TIntegerField;
    queryControleAcessofl_permite_acesso: TBooleanField;
    queryControleAcessodt_atz_1: TSQLTimeStampField;
    tbCodBarraProduto: TFDTable;
    queryCodBarraProduto: TFDQuery;
    dsCodBarraProduto: TDataSource;
    queryCodBarraProdutocd_produto: TIntegerField;
    queryCodBarraProdutoun_medida: TWideStringField;
    queryCodBarraProdutocodigo_barras: TWideStringField;
    queryCodBarraProdutodt_atz: TSQLTimeStampField;
    queryCodBarraProdutotipo_cod_barras: TSmallintField;
    queryControleAcessofl_permite_edicao: TBooleanField;
    sqlPedidoVenda: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Params.Database := 'trabalho_engenharia';
  FDConnection1.Params.UserName := 'postgres';
  FDConnection1.Params.Password := 'postgres';

  FDConnection1.Connected := true;

  driver.VendorLib := GetCurrentDir + '\lib\libpq.dll';
end;

end.
