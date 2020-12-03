unit uImportaDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmImportaDados = class(TForm)
    btnGravar: TButton;
    procedure btnGravarClick(Sender: TObject);
  private
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
  SQL = 'insert into teste (id, nome, email, empresa, ocupacao, cidade, universidade) ' +
        'values (:id, :nome, :email, :empresa, :ocupacao, :cidade, :universidade)' ;
var
  qry: TFDquery;
  stringListFile: TStringList;
  strinListLinha: TStringList;
  cont: Integer;
  inicio, fim: TDateTime;
begin
  inicio := Now;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  // TStringList que carrega todo o conteúdo do arquivo
  stringListFile := TStringList.Create;

  // TStringList que carrega o conteúdo da linha
  strinListLinha := TStringList.Create;

  try
    qry.SQL.Add(SQL);
    stringListFile.LoadFromFile('C:\Users\jovio\OneDrive\Documentos\dados.csv');

    // Configura o tamanho do array de inserções
    qry.Params.ArraySize := stringListFile.Count;

    for cont := 0 to Pred(stringListFile.Count) do
    begin
      strinListLinha.StrictDelimiter := True;

      // TStringList recebe o conteúdo da linha atual
      strinListLinha.CommaText := stringListFile[cont];

      qry.ParamByName('id').AsIntegers[cont] := StrToInt(strinListLinha[0]);
      qry.ParamByName('nome').AsStrings[cont] := strinListLinha[1];
      qry.ParamByName('email').AsStrings[cont] := strinListLinha[2];
      qry.ParamByName('empresa').AsStrings[cont] := strinListLinha[3];
      qry.ParamByName('ocupacao').AsStrings[cont] := strinListLinha[4];
      qry.ParamByName('cidade').AsStrings[cont] := strinListLinha[5];
      qry.ParamByName('universidade').AsStrings[cont] := strinListLinha[6];
    end;

    // Executa as inserções em lote
    qry.Execute(stringListFile.Count, 0);

  finally
    stringListFile.Free;
    strinListLinha.Free;
    qry.Free;
  end;

  fim := Now;

  ShowMessage('Tempo: ' + FormatDateTime('hh:nn:ss:zzz', fim - inicio));
end;

end.
