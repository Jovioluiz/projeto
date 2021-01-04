unit uConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Stan.Param,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Datasnap.DBClient, Vcl.StdCtrls, System.StrUtils,
  System.Classes;

type
  TfrmConsulta = class(TForm)
    pnl1: TPanel;
    dbgrd1: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    rgFiltros: TRadioGroup;
    cdsConsultacd_cliente: TIntegerField;
    cdsConsultanm_cliente: TStringField;
    cdsConsultacpf_cnpj: TStringField;
    edtBusca: TEdit;
    cds: TClientDataSet;
    ds: TDataSource;
    procedure dbgrd1DblClick(Sender: TObject);
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function MontaDataset(consulta: string): string;
  end;

var
  frmConsulta: TfrmConsulta;
  Matriz: array of array of Integer;

implementation

uses
  uDataModule, cCLIENTE, System.Math, System.UITypes,
  System.Generics.Collections;

{$R *.dfm}



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

function TfrmConsulta.MontaDataset(consulta: string): string;
var
  linha, coluna: Integer;
  qry: TFDQuery;
  campo: TField;
  tamanhoCampo: Integer;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(consulta);
    qry.Open();

  campo := TField.Create(cds);
    for var i := 0 to Pred(qry.FieldCount) do
    begin
      //monta os fields de acordo com os campos da consulta
      campo.FieldName := qry.Fields[i].FieldName;

      case qry.Fields[i].DataType of
        ftString: tamanhoCampo := 30;
        ftInteger: tamanhoCampo := 0;
        ftFloat: tamanhoCampo := 0;
        ftCurrency: tamanhoCampo := 0;
        ftWideString: tamanhoCampo := 30;
        ftBCD: tamanhoCampo := 0;
        ftWideMemo: tamanhoCampo := 100;
      end;
      campo.SetFieldType(qry.Fields[i].DataType);
      cds.FieldDefs.Add(UpperCase(campo.FieldName), qry.Fields[i].DataType, tamanhoCampo, false);
    end;

    cds.CreateDataSet;

//  for i := 0 to Pred(cds.FieldCount) do
//  begin
//    qry.First;
//    while not qry.Eof do
//    begin
//      cds.Append;
//      cds.Fields[j].Value := qry.Fields[j].Value;
//      cds.Post;
//      qry.Next;
//    end;
//  end;

    qry.First;
      cds.First;
    for linha := 0 to cds.Fields.Count do
    begin
      for coluna := 0 to qry.RecordCount -1 do
      begin
        cds.Append;
        cds.Fields[linha].Value := qry.Fields[coluna].Value;
        cds.Post;
      end;
      qry.Next;
      cds.Next;
    end;

  finally
    qry.Free;
  end;
end;

end.
