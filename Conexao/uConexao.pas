unit uConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef;

type
  TfrmConexao = class(TForm)
    conexao: TFDConnection;
    drive: TFDPhysPgDriverLink;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConexao: TfrmConexao;
  aberto : Boolean;

implementation

{$R *.dfm}

procedure TfrmConexao.FormCreate(Sender: TObject);
begin
  conexao.Params.Database := 'trabalho_engenharia';
  conexao.Params.UserName := 'postgres';
  conexao.Params.Password := 'postgres';

  conexao.Connected := true;

  drive.VendorLib := GetCurrentDir + '\lib\libpq.dll';

end;

end.
