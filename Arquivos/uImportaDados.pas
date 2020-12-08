unit uImportaDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtDlgs, Vcl.ComCtrls,
  Vcl.Samples.Gauges, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TfrmImportaDados = class(TForm)
    btnGravar: TButton;
    Label1: TLabel;
    edtArquivo: TEdit;
    SpeedButton1: TSpeedButton;
    dlArquivo: TOpenTextFileDialog;
    Gauge1: TGauge;
    Button2: TButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    dsRegistros: TDataSource;
    cdsRegistros: TClientDataSet;
    cdsRegistroscd_produto: TIntegerField;
    cdsRegistrosdesc_produto: TStringField;
    cdsRegistrosun_medida: TStringField;
    cdsRegistrosfator_conversao: TIntegerField;
    cdsRegistrospeso_liquido: TFloatField;
    cdsRegistrospeso_bruto: TFloatField;
    cdsRegistrosseq: TIntegerField;
    procedure btnGravarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure ParseDelimited(const sl: TStrings; const value,
      delimiter: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImportaDados: TfrmImportaDados;

implementation

uses
  FireDAC.Comp.Client, uDataModule;

{$R *.dfm}

procedure TfrmImportaDados.btnGravarClick(Sender: TObject);
const
  SQL = 'insert into produto (cd_produto, fl_ativo, desc_produto, un_medida, fator_conversao, peso_liquido, peso_bruto)' +
        'values (:cd_produto, :fl_ativo, :desc_produto, :un_medida, :fator_conversao, :peso_liquido, :peso_bruto)';
var
  qry: TFDquery;
  stringListFile: TStringList;
  strinListLinha: TStringList;
  cont: Integer;
  caminho: string;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  // TStringList que carrega todo o conteúdo do arquivo
  stringListFile := TStringList.Create;

  // TStringList que carrega o conteúdo da linha
  strinListLinha := TStringList.Create;
  caminho := edtArquivo.Text;

  if not caminho.EndsWith('.csv') then
    raise Exception.Create('Formato de Arquivo Incorreto. Verifique');

  try
    try
      qry.SQL.Add(SQL);
      stringListFile.LoadFromFile(caminho);

      // Configura o tamanho do array de inserções
      qry.Params.ArraySize := stringListFile.Count;

      Gauge1.MaxValue := stringListFile.Count;

      for cont := 0 to Pred(stringListFile.Count) do
      begin
        Gauge1.Visible := True;
        Gauge1.Progress := Gauge1.Progress + 1;
        strinListLinha.StrictDelimiter := True;

        // TStringList recebe o conteúdo da linha atual
        strinListLinha.CommaText := stringListFile[cont];

        qry.ParamByName('cd_produto').AsIntegers[cont] := StrToInt(strinListLinha[0]);
        qry.ParamByName('fl_ativo').AsBooleans[cont] := True;
        qry.ParamByName('desc_produto').AsStrings[cont] := strinListLinha[1];
        qry.ParamByName('un_medida').AsStrings[cont] := strinListLinha[2];
        qry.ParamByName('fator_conversao').AsIntegers[cont] := StrToInt(strinListLinha[3]);
        qry.ParamByName('peso_liquido').AsFloats[cont] := StrToFloat(strinListLinha[4]);
        qry.ParamByName('peso_bruto').AsFloats[cont] := StrToFloat(strinListLinha[5]);
      end;

      // Executa as inserções em lote
      qry.Execute(stringListFile.Count, 0);
      qry.Connection.Commit;
      ShowMessage('Dados gravados com Sucesso');
    except
      on e:Exception do
      begin
        raise Exception.Create('Erro ao gravar os Dados ' + #13 + e.Message);
        qry.Connection.Rollback;
      end;
    end;

  finally
    Gauge1.Visible := False;
    stringListFile.Free;
    strinListLinha.Free;
    qry.Free;
  end;
end;

procedure TfrmImportaDados.Button2Click(Sender: TObject);
var
  arquivo: string;
  linhas, temp: TStringList;
  i: integer;
begin
  arquivo := edtArquivo.Text;
  linhas := TStringList.Create;
  temp := TStringList.Create;
  linhas.LoadFromFile(arquivo);

  for i := 0 to Pred(linhas.Count) do
  begin
    ParseDelimited(temp, linhas[i], ',');

    cdsRegistros.Append;
    cdsRegistros.FieldByName('seq').AsInteger := i + 1;
    cdsRegistros.FieldByName('cd_produto').AsInteger := StrToInt(temp[0]);
    cdsRegistros.FieldByName('desc_produto').AsString := temp[1];
    cdsRegistros.FieldByName('un_medida').AsString := temp[2];
    cdsRegistros.FieldByName('fator_conversao').AsInteger := StrToInt(temp[3]);
    cdsRegistros.FieldByName('peso_liquido').AsFloat := StrToFloat(temp[4]);
    cdsRegistros.FieldByName('peso_bruto').AsFloat := StrToFloat(temp[5]);
    cdsRegistros.Post;
  end;
end;

procedure TfrmImportaDados.SpeedButton1Click(Sender: TObject);
begin
  dlArquivo.Filter := ('*.csv*.CSV');
  if dlArquivo.Execute then
    edtArquivo.Text := dlArquivo.FileName;
end;

procedure TfrmImportaDados.ParseDelimited(const sl : TStrings;
const value : string; const delimiter : string);
var
  dx : integer;
  ns : string;
  txt : string;
  delta : integer;
begin
  delta := Length(delimiter) ;
  txt := value + delimiter;
  sl.BeginUpdate;
  sl.Clear;
  try
    while Length(txt) > 0 do
    begin
      dx := Pos(delimiter, txt) ;
      ns := Copy(txt,0,dx-1) ;
      sl.Add(ns) ;
      txt := Copy(txt,dx+delta,MaxInt);
    end;
  finally
    sl.EndUpdate;
  end;
end;

end.
