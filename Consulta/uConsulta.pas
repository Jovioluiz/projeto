unit uConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Datasnap.DBClient,
  JvExControls, JvLabel, Vcl.StdCtrls, JvExStdCtrls, JvEdit;

type
  TfrmConsulta = class(TForm)
    pnl1: TPanel;
    dbgrd1: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    edtBusca: TJvEdit;
    JvLabel1: TJvLabel;
    rgFiltros: TRadioGroup;
    cdsConsultacd_cliente: TIntegerField;
    cdsConsultanm_cliente: TStringField;
    cdsConsultacpf_cnpj: TStringField;
    procedure dbgrd1DblClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function abreConsulta(consulta: String): string;
  end;

var
  frmConsulta: TfrmConsulta;

implementation

uses
  uDataModule, cCLIENTE;

{$R *.dfm}

//passa no sql os campos que quer retornar na consulta
//se adicionar mais campos na consulta, precisa adicionar esses campos no dataset
function TfrmConsulta.abreConsulta(consulta: String): string;
var
  qry: TFDQuery;
  //i: Integer;
  //campo: TField;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;

  //cdsConsulta.EmptyDataSet;

  //cdsConsulta.Create(Self);

  //qry.FieldList.Create(qry);

  try
    qry.SQL.Add(consulta);
    qry.Open();

   { for i := 0 to qry.FieldCount - 1 do
    begin
      campo := TField.Create(cdsConsulta);
      campo.FieldName := qry.Fields[i].FieldName;
      campo.SetFieldType(qry.Fields[i].DataType);
      cdsConsulta.Fields.Add(campo);
    end; }


    if qry.IsEmpty then
      cdsConsulta.EmptyDataSet
    else
    begin
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
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmConsulta.dbgrd1DblClick(Sender: TObject);
begin
  if chamada = 'cntCliente' then
  begin
    CodCliente := cdsConsulta.FieldByName('cd_cliente').AsInteger;
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
begin
  if edtBusca.Text <> EmptyStr then
  begin
    if Key = 13 then
    begin
      qry := TFDQuery.Create(Self);
      qry.Connection := dm.conexaoBanco;
      qry.SQL.Add(sql);

      try
        case rgFiltros.ItemIndex of
        0:
        begin
          qry.SQL.Add('where nome ilike '+ QuotedStr('%'+edtBusca.Text+'%'));
          qry.Open();
        end;
        1:
        begin
          qry.SQL.Add('where cd_cliente = :cd_cliente');
          qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtBusca.Text);
          qry.Open();
        end;
        2:
        begin
          qry.SQL.Add('where cpf_cnpj ilike'+ QuotedStr('%'+edtBusca.Text+'%'));
          qry.Open();
        end;
        end;

        cdsConsulta.EmptyDataSet; //limpa o dataset
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
  end;
end;

end.
