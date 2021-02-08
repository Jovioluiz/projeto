unit uImportacaoDados;

interface

uses
  System.Classes, dImportaDados;

type TImportacaoDados = class

  private
    FDados: TdmImportaDados;


  public

  constructor Create;
  procedure SalvarProduto(Caminho: String);

  property Dados: TdmImportaDados read FDados;
end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, uclProduto, System.SysUtils, Vcl.Dialogs;

{ TImportacaoDados }

constructor TImportacaoDados.Create;
begin
  inherited;
  FDados := TdmImportaDados.Create(nil);
end;

procedure TImportacaoDados.SalvarProduto(Caminho: String);
const
  SQL_INSERT = 'insert ' +
        ' into  ' +
        '   produto ' +
        '(cd_produto, ' +
        '   fl_ativo,    ' +
        '   desc_produto, ' +
        '   un_medida,    ' +
        '   fator_conversao, ' +
        '   peso_liquido,    ' +
        '   peso_bruto,      ' +
        '   id_item)' +
        'values (:cd_produto, ' +
        '   :fl_ativo,        ' +
        '   :desc_produto,    ' +
        '   :un_medida,       ' +
        '   :fator_conversao, ' +
        '   :peso_liquido,    ' +
        '   :peso_bruto,      ' +
        '   :id_item)';
var
  qry: TFDquery;
  stringListFile: TStringList;
  strinListLinha: TStringList;
  cont: Integer;
  produto: TProduto;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  produto := TProduto.Create;

  // TStringList que carrega todo o conteúdo do arquivo
  stringListFile := TStringList.Create;

  // TStringList que carrega o conteúdo da linha
  strinListLinha := TStringList.Create;

  try
    try
      qry.SQL.Add(SQL_INSERT);
      stringListFile.LoadFromFile(Caminho);

      // Configura o tamanho do array de inserções
      qry.Params.ArraySize := stringListFile.Count;

      for cont := 0 to Pred(stringListFile.Count) do
      begin
        strinListLinha.StrictDelimiter := True;

        // TStringList recebe o conteúdo da linha atual
        strinListLinha.CommaText := stringListFile[cont];

        qry.ParamByName('cd_produto').AsStrings[cont] := strinListLinha[0];
        qry.ParamByName('fl_ativo').AsBooleans[cont] := True;
        qry.ParamByName('desc_produto').AsStrings[cont] := strinListLinha[1];
        qry.ParamByName('un_medida').AsStrings[cont] := strinListLinha[2];
        qry.ParamByName('fator_conversao').AsIntegers[cont] := StrToInt(strinListLinha[3]);
        qry.ParamByName('peso_liquido').AsFloats[cont] := StrToFloat(strinListLinha[4]);
        qry.ParamByName('peso_bruto').AsFloats[cont] := StrToFloat(strinListLinha[5]);
        qry.ParamByName('id_item').AsLargeInts[cont] := produto.GeraIdItem;
      end;

      // Executa as inserções em lote
      qry.Execute(stringListFile.Count, 0);
      dm.conexaoBanco.Commit;
      ShowMessage('Dados gravados com Sucesso');
    except
      on e:Exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os Dados ' + #13 + e.Message);
      end;
    end;

  finally
    dm.conexaoBanco.Rollback;
    stringListFile.Free;
    strinListLinha.Free;
    qry.Free;
    produto.Free;
  end;
end;

end.
