unit uImportacaoDados;

interface

uses
  System.Classes, dImportaDados;

type TImportacaoDados = class

  private
    FDados: TdmImportaDados;
    procedure ParseDelimited(const sl: TStrings; const value, delimiter: string);

  public

  constructor Create;
  procedure SalvarProduto(Caminho: String);
  procedure ListaProdutos(Caminho: String);
  procedure SalvarCliente(Caminho: String);
  procedure ListaClientes(Caminho: String);
  destructor Destroy; override;

  property Dados: TdmImportaDados read FDados;
end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, uclProduto, System.SysUtils, Vcl.Dialogs,
  Vcl.Samples.Gauges;

{ TImportacaoDados }

constructor TImportacaoDados.Create;
begin
  inherited;
  FDados := TdmImportaDados.Create(nil);
end;

destructor TImportacaoDados.Destroy;
begin
  FDados.Free;
end;

procedure TImportacaoDados.ListaClientes(Caminho: String);
var
  linhas, temp: TStringList;
  i: integer;
begin
  linhas := TStringList.Create;
  temp := TStringList.Create;
  linhas.LoadFromFile(Caminho);
  Dados.cdsClientes.EmptyDataSet;
  Dados.cdsClientes.DisableControls;

  try
    for i := 0 to Pred(linhas.Count) do
    begin
      ParseDelimited(temp, linhas[i], ',');
      Dados.cdsClientes.Append;
      Dados.cdsClientes.FieldByName('seq').AsInteger := i + 1;
      Dados.cdsClientes.FieldByName('cd_cliente').AsInteger := StrToInt(temp[0]);
      Dados.cdsClientes.FieldByName('nm_cliente').AsString := temp[1];
      Dados.cdsClientes.FieldByName('tp_pessoa').AsString := temp[2];
      Dados.cdsClientes.FieldByName('celular').AsString := temp[3];
      Dados.cdsClientes.FieldByName('email').AsString := temp[4];
      Dados.cdsClientes.FieldByName('telefone').AsString := temp[5];
      Dados.cdsClientes.FieldByName('cpf_cnpj').AsString := temp[6];
      Dados.cdsClientes.FieldByName('rg_ie').AsString := temp[7];
      Dados.cdsClientes.FieldByName('dt_nasc_fundacao').AsDateTime := StrToDate(temp[8]);
      Dados.cdsClientes.Post;
    end;
  finally
    Dados.cdsClientes.EnableControls;
  end;
end;

procedure TImportacaoDados.ListaProdutos(Caminho: String);
var
  linhas, temp: TStringList;
  i: integer;
begin
  linhas := TStringList.Create;
  temp := TStringList.Create;
  linhas.LoadFromFile(Caminho);
  Dados.cdsProdutos.EmptyDataSet;
  Dados.cdsProdutos.DisableControls;

  try
    for i := 0 to Pred(linhas.Count) do
    begin
      ParseDelimited(temp, linhas[i], ',');
      Dados.cdsProdutos.Append;
      Dados.cdsProdutos.FieldByName('seq').AsInteger := i + 1;
      Dados.cdsProdutos.FieldByName('cd_produto').AsInteger := StrToInt(temp[0]);
      Dados.cdsProdutos.FieldByName('desc_produto').AsString := temp[1];
      Dados.cdsProdutos.FieldByName('un_medida').AsString := temp[2];
      Dados.cdsProdutos.FieldByName('fator_conversao').AsInteger := StrToInt(temp[3]);
      Dados.cdsProdutos.FieldByName('peso_liquido').AsFloat := StrToFloat(temp[4]);
      Dados.cdsProdutos.FieldByName('peso_bruto').AsFloat := StrToFloat(temp[5]);
      Dados.cdsProdutos.Post;
    end;
  finally
    Dados.cdsProdutos.EnableControls;
  end;
end;

procedure TImportacaoDados.SalvarCliente(Caminho: String);
const
  SQL = 'insert ' +
        '   into         ' +
        '     cliente    ' +
        '   (cd_cliente, ' +
        '    nome,       ' +
        '   tp_pessoa,   ' +
        '   fl_ativo,    ' +
        '   telefone,    ' +
        '   celular,     ' +
        '   email,       ' +
            'cpf_cnpj,   ' +
        '   rg_ie,       ' +
        '   dt_nasc_fundacao)' +
        'values (:cd_cliente,' +
        '   :nome,           ' +
        '   :tp_pessoa,      ' +
        '   :fl_ativo,       ' +
        '   :telefone,       ' +
        '   :celular,        ' +
        '   :email,          ' +
        '   :cpf_cnpj,       ' +
        '   :rg_ie,          ' +
        '   :dt_nasc_fundacao)';
var
  qry: TFDquery;
  stringListFile: TStringList;
  strinListLinha: TStringList;
  cont: Integer;
  gauge: TGauge;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  gauge := TGauge.Create(nil);
  // TStringList que carrega todo o conteúdo do arquivo
  stringListFile := TStringList.Create;

  // TStringList que carrega o conteúdo da linha
  strinListLinha := TStringList.Create;

  if not caminho.EndsWith('.csv') then
    raise Exception.Create('Formato de Arquivo Incorreto. Verifique');

  try
    try
      qry.SQL.Add(SQL);
      stringListFile.LoadFromFile(Caminho);

      // Configura o tamanho do array de inserções
      qry.Params.ArraySize := stringListFile.Count;

      gauge.MaxValue := stringListFile.Count;

      for cont := 0 to Pred(stringListFile.Count) do
      begin
        strinListLinha.StrictDelimiter := True;

        gauge.Visible := True;
        gauge.Progress := gauge.Progress + 1;

        // TStringList recebe o conteúdo da linha atual
        strinListLinha.CommaText := stringListFile[cont];

        qry.ParamByName('cd_cliente').AsIntegers[cont] := StrToInt(strinListLinha[0]);
        qry.ParamByName('nome').AsStrings[cont] := strinListLinha[1];
        qry.ParamByName('tp_pessoa').AsStrings[cont] := strinListLinha[2];
        qry.ParamByName('fl_ativo').AsBooleans[cont] := True;
        qry.ParamByName('telefone').AsStrings[cont] := strinListLinha[3];
        qry.ParamByName('celular').AsStrings[cont] := strinListLinha[4];
        qry.ParamByName('email').AsStrings[cont] := strinListLinha[5];
        qry.ParamByName('cpf_cnpj').AsStrings[cont] := strinListLinha[6];
        qry.ParamByName('rg_ie').AsStrings[cont] := strinListLinha[7];
        qry.ParamByName('dt_nasc_fundacao').AsDateTimes[cont] := StrToDateTime(strinListLinha[8]);
      end;

      // Executa as inserções em lote
      qry.Execute(stringListFile.Count, 0);
      dm.conexaoBanco.Commit;
      ShowMessage('Dados gravados com Sucesso');
    except
      on e:Exception do
      begin
        raise Exception.Create('Erro ao gravar os Dados ' + #13 + e.Message);
        dm.conexaoBanco.Rollback;
      end;
    end;

  finally
    gauge.Visible := False;
    dm.conexaoBanco.Rollback;
    stringListFile.Free;
    strinListLinha.Free;
    qry.Free;
  end;
end;

procedure TImportacaoDados.SalvarProduto(Caminho: String);
const
  SQL_INSERT =  'insert ' +
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

procedure TImportacaoDados.ParseDelimited(const sl: TStrings; const value: string; const delimiter: string);
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
      ns := Copy(txt, 0, dx-1) ;
      sl.Add(ns) ;
      txt := Copy(txt, dx+delta, MaxInt);
    end;
  finally
    sl.EndUpdate;
  end;
end;

end.
