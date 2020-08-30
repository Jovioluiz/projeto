unit uConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, FireDAC.DApt,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Datasnap.DBClient,
  JvExControls, JvLabel, Vcl.StdCtrls, JvExStdCtrls, JvEdit;

type
  TfrmConsulta = class(TForm)
    pnl1: TPanel;
    dbgrd1: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    intgrfldConsultacd_cliente: TIntegerField;
    cdsConsultanm_cliente: TStringField;
    cdsConsultacpf_cnpj: TStringField;
    edtBusca: TJvEdit;
    JvLabel1: TJvLabel;
    rgFiltros: TRadioGroup;
    procedure dbgrd1DblClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  uDataModule, cCLIENTE;

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

procedure TfrmConsulta.dbgrd1DblClick(Sender: TObject);
var
  cliente: TfrmCadCliente;
begin
  cliente := TfrmCadCliente.Create(Self);

  if chamada = 'cntCliente' then
  begin
    cliente.cdCliente := cdsConsulta.FieldByName('cd_cliente').AsInteger;
    Close;
    chamada := '';
  end;
end;

procedure TfrmConsulta.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  sql = 'select    ' +
        '    cd_cliente, ' +
        '    nome,       ' +
        '    cpf_cnpj    ' +
        'from            ' +
        '    cliente ';
var
  qry: TFDQuery;
  sqlTemp: string;
begin
  if Key = 13 then
  begin
    qry := TFDQuery.Create(Self);
    qry.Connection := dm.FDConnection1;

    try
      case rgFiltros.ItemIndex of
      0:
      begin
        sqlTemp := 'where nome ilike '+ QuotedStr('%'+edtBusca.Text+'%');
        qry.SQL.Add(sqlTemp);
      end;
      1:
      begin
        qry.SQL.Add('where cd_cliente = :cd_cliente');
        qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtBusca.Text);
      end;
      2:
      begin
        qry.SQL.Add('where cpf_cnpj ilike'+ QuotedStr('%'+edtBusca.Text+'%'));
      end;
      end;

      qry.Open(sql);
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

    end;
  end;
end;

end.
