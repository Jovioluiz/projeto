unit fVisualizaCodigoBarras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, System.Generics.Collections;

type
  TfVisualizaCodBarras = class(TForm)
    dbGridCodBarras: TDBGrid;
    ds: TDataSource;
    cds: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FIDItem: Integer;
    FDicionarioCod: TDictionary<string, string>;
    { Private declarations }
    procedure ListaCodBarras;
    procedure SetIDItem(const Value: Integer);
  public
    { Public declarations }
    property IDItem: Integer read FIDItem write SetIDItem;
    property DicionarioCod: TDictionary<string, string> read FDicionarioCod;
  end;

var
  fVisualizaCodBarras: TfVisualizaCodBarras;

implementation

uses
  FireDAC.Comp.Client, uDataModule, uUtil;

{$R *.dfm}

procedure TfVisualizaCodBarras.FormCreate(Sender: TObject);
begin
  dbGridCodBarras.DataSource := ds;
  FDicionarioCod := TDictionary<string, string>.Create;
end;

procedure TfVisualizaCodBarras.FormDestroy(Sender: TObject);
begin
  FDicionarioCod.Free;
end;

procedure TfVisualizaCodBarras.FormShow(Sender: TObject);
begin
  ListaCodBarras;

  dbGridCodBarras.Columns[0].Title.Caption := StringReplace(cds.FieldDefs[0].Name, '_', ' ',  [rfReplaceAll, rfIgnoreCase]);
  dbGridCodBarras.Columns[1].Title.Caption := StringReplace(cds.FieldDefs[1].Name, '_', ' ',  [rfReplaceAll, rfIgnoreCase]);

  for var i in FDicionarioCod.Keys do
  begin
    cds.Append;
    cds.FieldByName('cd_barras').AsString :=  i;
    cds.FieldByName('un_medida').AsString :=  FDicionarioCod.Items[i];
    cds.Post;
  end;
end;

procedure TfVisualizaCodBarras.ListaCodBarras;
const
  SQL = 'select ' +
        '    codigo_barras, ' +
        '    un_medida ' +
        'from ' +
        '    produto_cod_barras pcb ' +
        'where ' +
        '    id_item = :id_item ';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL, [FIDItem]);

    query.Loop(
    procedure
    begin
      if not FDicionarioCod.ContainsKey(query.FieldByName('codigo_barras').AsString) then
        FDicionarioCod.Add(query.FieldByName('codigo_barras').AsString, query.FieldByName('un_medida').AsString);
    end
    );
  finally
    query.Free;
  end;
end;

procedure TfVisualizaCodBarras.SetIDItem(const Value: Integer);
begin
  FIDItem := Value;
end;

end.
