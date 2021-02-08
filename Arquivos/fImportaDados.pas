unit fImportaDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.Buttons, Vcl.ExtDlgs, Vcl.ComCtrls,
  Vcl.Samples.Gauges, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  dImportaDados, uImportacaoDados;

type
  TfrmImportaDados = class(TForm)
    btnGravar: TButton;
    Label1: TLabel;
    edtArquivo: TEdit;
    btnBuscarArquivoProduto: TSpeedButton;
    dlArquivo: TOpenTextFileDialog;
    btnVisualizarProdutos: TButton;
    Panel1: TPanel;
    dbGridProdutos: TDBGrid;
    pnlFundo: TPanel;
    PageControl1: TPageControl;
    tbProdutos: TTabSheet;
    tbClientes: TTabSheet;
    Label2: TLabel;
    edtArquivoCliente: TEdit;
    btnBuscaArquivoCliente: TSpeedButton;
    btnVisualizarCliente: TButton;
    btnGravarCliente: TButton;
    dbGridClientes: TDBGrid;
    gaugeClientes: TGauge;
    gaugeProdutos: TGauge;
    procedure btnBuscarArquivoProdutoClick(Sender: TObject);
    procedure btnVisualizarProdutosClick(Sender: TObject);
    procedure btnGravarClienteClick(Sender: TObject);
    procedure btnBuscaArquivoClienteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    FRegras: TImportacaoDados;

    procedure ParseDelimited(const sl: TStrings; const value, delimiter: string);

    { Private declarations }
  public
    { Public declarations }
    property Regra: TImportacaoDados read FRegras;
  end;

var
  frmImportaDados: TfrmImportaDados;

implementation

uses
  FireDAC.Comp.Client, uDataModule, uclProduto;

{$R *.dfm}

procedure TfrmImportaDados.btnBuscaArquivoClienteClick(Sender: TObject);
begin
  dlArquivo.Filter := '*.csv|*.csv';
  if dlArquivo.Execute then
    edtArquivoCliente.Text := dlArquivo.FileName;
end;

procedure TfrmImportaDados.btnGravarClick(Sender: TObject);
var
  importacao: TImportacaoDados;
begin
  importacao := TImportacaoDados.Create;

  try
    if edtArquivo.Text <> '' then
      importacao.SalvarProduto(dlArquivo.FileName);
  finally
    importacao.Free;
  end;
end;

procedure TfrmImportaDados.btnGravarClienteClick(Sender: TObject);
const
  SQL = 'insert into cliente (cd_cliente, nome, tp_pessoa, fl_ativo, telefone, celular, email, cpf_cnpj, rg_ie, dt_nasc_fundacao)' +
        'values (:cd_cliente, :nome, :tp_pessoa, :fl_ativo, :telefone, :celular, :email, :cpf_cnpj, :rg_ie, :dt_nasc_fundacao)';
var
  qry: TFDquery;
  stringListFile: TStringList;
  strinListLinha: TStringList;
  cont: Integer;
  caminho: string;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  // TStringList que carrega todo o conteúdo do arquivo
  stringListFile := TStringList.Create;

  // TStringList que carrega o conteúdo da linha
  strinListLinha := TStringList.Create;
  caminho := edtArquivoCliente.Text;

  if not caminho.EndsWith('.csv') then
    raise Exception.Create('Formato de Arquivo Incorreto. Verifique');

  try
    try
      qry.SQL.Add(SQL);
      stringListFile.LoadFromFile(caminho);

      // Configura o tamanho do array de inserções
      qry.Params.ArraySize := stringListFile.Count;

      gaugeClientes.MaxValue := stringListFile.Count;

      for cont := 0 to Pred(stringListFile.Count) do
      begin
        gaugeClientes.Visible := True;
        gaugeClientes.Progress := gaugeClientes.Progress + 1;
        strinListLinha.StrictDelimiter := True;

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
    dm.conexaoBanco.Rollback;
    gaugeClientes.Visible := False;
    stringListFile.Free;
    strinListLinha.Free;
    qry.Free;
  end;
end;

procedure TfrmImportaDados.btnVisualizarProdutosClick(Sender: TObject);
var
  arquivo: string;
  linhas, temp: TStringList;
  i: integer;
begin
  if edtArquivo.Text = '' then
  begin
    ShowMessage('Informe um arquivo');
    Exit;
  end;

  arquivo := edtArquivo.Text;
  linhas := TStringList.Create;
  temp := TStringList.Create;
  linhas.LoadFromFile(arquivo);
  gaugeProdutos.MaxValue := Pred(linhas.Count);
  FRegras.Dados.cdsProdutos.DisableControls;
  try
    for i := 0 to Pred(linhas.Count) do
    begin
      ParseDelimited(temp, linhas[i], ',');
      gaugeProdutos.Visible := True;
      gaugeProdutos.Progress := gaugeProdutos.Progress + 1;

      FRegras.Dados.cdsProdutos.Append;
      FRegras.Dados.cdsProdutos.FieldByName('seq').AsInteger := i + 1;
      FRegras.Dados.cdsProdutos.FieldByName('cd_produto').AsInteger := StrToInt(temp[0]);
      FRegras.Dados.cdsProdutos.FieldByName('desc_produto').AsString := temp[1];
      FRegras.Dados.cdsProdutos.FieldByName('un_medida').AsString := temp[2];
      FRegras.Dados.cdsProdutos.FieldByName('fator_conversao').AsInteger := StrToInt(temp[3]);
      FRegras.Dados.cdsProdutos.FieldByName('peso_liquido').AsFloat := StrToFloat(temp[4]);
      FRegras.Dados.cdsProdutos.FieldByName('peso_bruto').AsFloat := StrToFloat(temp[5]);
      FRegras.Dados.cdsProdutos.Post;
    end;
  finally
    FRegras.Dados.cdsProdutos.EnableControls;
    gaugeProdutos.Visible := False;
  end;
end;

procedure TfrmImportaDados.FormCreate(Sender: TObject);
begin
  FRegras := TImportacaoDados.Create;
  dbGridProdutos.DataSource := FRegras.Dados.dsProdutos;
end;

procedure TfrmImportaDados.FormDestroy(Sender: TObject);
begin
  FRegras.Free;
end;

procedure TfrmImportaDados.btnBuscarArquivoProdutoClick(Sender: TObject);
begin
  dlArquivo.Filter := '*.csv|*.csv';
  if dlArquivo.Execute then
    edtArquivo.Text := dlArquivo.FileName;
end;

procedure TfrmImportaDados.ParseDelimited(const sl: TStrings;
const value: string; const delimiter: string);
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
