unit uConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, FireDAC.DApt,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TfrmConsulta = class(TForm)
    pnl1: TPanel;
    dbgrd1: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    intgrfldConsultacd_cliente: TIntegerField;
    cdsConsultanm_cliente: TStringField;
    cdsConsultacpf_cnpj: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function abreConsultaCliente(consulta: String): string;
  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses
  uDataModule;

{$R *.dfm}

//passa no sql os campos que quer retornar na consulta
//se adicionar mais campos na consulta, precisa adicionar esses campos no dataset
function TfrmConsulta.abreConsultaCliente(consulta: String): string;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  qry.Close;
  qry.SQL.Clear;

  try
    qry.SQL.Add(consulta);
    qry.Open(consulta);

    qry.First;
    while not qry.Eof do
    begin
      cdsConsulta.Append;
      cdsConsulta.FieldByName('cd_cliente').AsInteger := qry.FieldByName('cd_cliente').AsInteger;
      cdsConsulta.FieldByName('nm_cliente').AsString := qry.FieldByName('nome').AsString;
      cdsConsulta.FieldByName('cpf_cnpj').AsString := qry.FieldByName('cpf_cnpj').AsString;
      cdsConsulta.Post;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

end.
