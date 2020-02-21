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
  TfConexao = class(TForm)
    conexao: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    transacao: TFDTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConexao: TfConexao;

implementation

{$R *.dfm}

end.