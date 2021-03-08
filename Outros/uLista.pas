unit uLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uDataModule, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TfrmLista = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    btnAdd: TButton;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    cds: TClientDataSet;
    cdscd_cliente: TIntegerField;
    cdsnome: TStringField;
    cdstp_pessoa: TStringField;
    cdstelefone: TStringField;
    cdscelular: TStringField;
    cdsemail: TStringField;
    cdscpf_cnpj: TStringField;
    Button1: TButton;
    edtCont: TEdit;
    procedure btnAddClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLista: TfrmLista;

implementation

uses
  FireDAC.Comp.Client, System.Generics.Collections, uUtil;

{$R *.dfm}

procedure TfrmLista.btnAddClick(Sender: TObject);
const
  SQL = 'select * from cliente where cd_cliente in %s';

var
  qry: TFDQuery;
  lista: TList<String>;
  parametro: String;
  texto: TStringList;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  lista := TList<string>.Create;
  texto := TStringList.Create;

  lista.Add('1,2');

//  for var k in lista do
//    lista.Add(k);


  lista.Add(Edit1.Text);
  lista.Add(Edit2.Text);
  //texto.CommaText := ',';

  for var j := 0 to Pred(lista.Count) do
    texto.Text := texto.Text + lista.Items[j];

  parametro := '(';

  for var i := 0 to Pred(texto.Count) do
    parametro := parametro + texto[i] + ',';

  parametro[Length(parametro)] := ')';



  try
//    for var i:= 0 to Pred(lista.Count) do
//      p := parametro.Add(lista.Items[i]);

    qry.SQL.Add(Format(SQL, [parametro]));

    qry.Open();
    qry.First;

    while not qry.Eof do
    begin
      cds.Append;
      cds.FieldByName('cd_cliente').AsInteger := qry.FieldByName('cd_cliente').AsInteger;
      cds.FieldByName('nome').AsString := qry.FieldByName('nome').AsString;
      cds.FieldByName('tp_pessoa').AsString := qry.FieldByName('tp_pessoa').AsString;
      cds.FieldByName('telefone').AsString := qry.FieldByName('telefone').AsString;
      cds.FieldByName('celular').AsString := qry.FieldByName('celular').AsString;
      cds.FieldByName('email').AsString := qry.FieldByName('email').AsString;
      cds.FieldByName('cpf_cnpj').AsString := qry.FieldByName('cpf_cnpj').AsString;
      cds.Post;
      qry.Next;
    end;

  finally
    qry.Free;
    texto.Free;
  end;

end;

procedure TfrmLista.Button1Click(Sender: TObject);
const
  SQL = 'select * from cliente';
var
  dicio: TDictionary<Integer, String>;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dicio := TDictionary<Integer, String>.Create;

  try
    qry.SQL.Add(SQL);
    qry.Open();

    qry.Loop(
    procedure
    begin
      if not dicio.ContainsKey(qry.FieldByName('cd_cliente').AsInteger) then
        dicio.Add(qry.FieldByName('cd_cliente').AsInteger, qry.FieldByName('nome').AsString);
    end
    );

    edtCont.Text := dicio.Count.ToString;

    for var i in dicio.Keys do
    begin
      cds.Append;
      cds.FieldByName('cd_cliente').AsInteger := i;
      cds.FieldByName('nome').AsString := dicio.Items[i];
      cds.Post;
    end;

  finally
    qry.Free;
    dicio.Free;
  end;
end;

end.
