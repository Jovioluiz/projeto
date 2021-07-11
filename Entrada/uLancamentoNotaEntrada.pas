unit uLancamentoNotaEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, System.UITypes, uclNotaEntrada, uDataModule, uUtil;

type
  TfrmLancamentoNotaEntrada = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtNroNota: TEdit;
    edtSerie: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCdFornecedor: TEdit;
    edtOperacao: TEdit;
    edtModelo: TEdit;
    edtNomeOperacao: TEdit;
    edtNomeFornecedor: TEdit;
    edtNomeModelo: TEdit;
    Label6: TLabel;
    edtDataEmissao: TDateTimePicker;
    Label7: TLabel;
    edtDataRecebimento: TDateTimePicker;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    edtVlServico: TEdit;
    edtVlProduto: TEdit;
    edtBaseIcms: TEdit;
    edtValorIcms: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtValorFrete: TEdit;
    edtValorIPI: TEdit;
    edtValorISS: TEdit;
    edtValorDesconto: TEdit;
    edtValorAcrescimo: TEdit;
    edtValorTotalNota: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtCodProduto: TEdit;
    edtDescricaoProduto: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    edtUnMedida: TEdit;
    edtQuantidade: TEdit;
    edtFatorConversao: TEdit;
    edtValorUnitario: TEdit;
    edtValorTotalProduto: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    edtQuantidadeTotalProduto: TEdit;
    edtDataLancamento: TDateTimePicker;
    Label29: TLabel;
    edtValorOutrasDespesas: TEdit;
    btnAddItens: TButton;
    DBGridProdutos: TDBGrid;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    sqlCabecalho: TFDQuery;
    procedure edtOperacaoChange(Sender: TObject);
    procedure edtOperacaoExit(Sender: TObject);
    procedure edtModeloChange(Sender: TObject);
    procedure edtModeloExit(Sender: TObject);
    procedure edtCdFornecedorChange(Sender: TObject);
    procedure edtCdFornecedorExit(Sender: TObject);
    procedure edtSerieExit(Sender: TObject);
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtVlProdutoExit(Sender: TObject);
    procedure edtNroNotaExit(Sender: TObject);
    procedure edtVlServicoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorFreteExit(Sender: TObject);
    procedure valorTotalNota;
    procedure calculaQuantidadeTotalItem();
    procedure edtValorIPIExit(Sender: TObject);
    procedure edtValorDescontoExit(Sender: TObject);
    procedure edtValorAcrescimoExit(Sender: TObject);
    procedure edtValorOutrasDespesasExit(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure calculaValorTotalItem;
    procedure btnAddItensClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridProdutosDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtBaseIcmsExit(Sender: TObject);
    procedure edtValorIcmsExit(Sender: TObject);
    procedure edtValorISSExit(Sender: TObject);

  type
    TInfoProdutos = record
      CodItem,
      DescProduto,
      UnMedida: string;
      FatorConersao: Integer;
    end;

  type
    TAliqProduto = record
     AliqIcms,
     AliqIPI,
     AliqPisCofins: Double;
  end;

  private
    FIdGeralNFC: Integer;
    FEdicaoItem: Boolean;
    FIdGeralNFI: Integer;
    FRegras: TNotaEntrada;
    { Private declarations }
    procedure validaValoresNota;
    procedure limpaCampos;
    procedure LancaFinanceiro;
    procedure SetIdGeralNFC(const Value: Integer);
    procedure CarregaItensEdicao;
    procedure SetEdicaoItem(const Value: Boolean);
    procedure SetIdGeralNFI(const Value: Integer);
    procedure SetRegras(const Value: TNotaEntrada);
    procedure AdicionaItem;
    procedure LimpaOutrosCampos;
    function GetInfoProduto(CodItem: String): TInfoProdutos;
    function GetAliqProduto(IdItem: Integer): TAliqProduto;
    function CalculaImposto(ValorBase, Aliquota: Currency): Currency;
    procedure PreencheDatasetNFC;
  public
    { Public declarations }
    destructor Destroy; override;
    property IdGeralNFC: Integer read FIdGeralNFC write SetIdGeralNFC;
    property EdicaoItem: Boolean read FEdicaoItem write SetEdicaoItem;
    property IdGeralNFI: Integer read FIdGeralNFI write SetIdGeralNFI;
    property Regras: TNotaEntrada read FRegras write SetRegras;
  end;

var
  frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada;
  seq : Integer = 1; //sequencia dos itens lançados na nota

implementation

uses
  uGerador, uLogin, uMovimentacaoEstoque;

{$R *.dfm}


procedure TfrmLancamentoNotaEntrada.edtBaseIcmsExit(Sender: TObject);
begin
  edtBaseIcms.Text := FormatCurr('#,##0.00', StrToCurr(edtBaseIcms.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtCdFornecedorChange(Sender: TObject);
const
  sql = 'select                       '+
          'cd_cliente,                '+
          'nome                       '+
        'from                         '+
           'cliente                   '+
        'where                        '+
            'cd_cliente = :cd_cliente';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    if edtCdFornecedor.Text = EmptyStr then
    begin
      edtNomeFornecedor.Clear;
      Exit;
    end;

    qry.SQL.Add(sql);
    qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdFornecedor.Text);
    qry.Open(sql);
    edtNomeFornecedor.Text := qry.FieldByName('nome').AsString;
  finally
    qry.Free;
  end;
end;


procedure TfrmLancamentoNotaEntrada.edtCdFornecedorExit(Sender: TObject);
var
  cliente: TNotaEntrada;
  resposta : Boolean;
begin
  if edtCdFornecedor.Text = EmptyStr then
  begin
    ShowMessage('Informe um Fornecedor');
    edtCdFornecedor.SetFocus;
    Exit;
  end;

  cliente := TNotaEntrada.Create;
  resposta := cliente.BuscaClienteFornecedor(StrToInt(edtCdFornecedor.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Fornecedor/Cliente não Encontrado', 'Atenção', MB_OK) = IDOK) then
      begin
        edtCdFornecedor.SetFocus;
        edtNomeFornecedor.Clear;
      end;
    end;
  finally
    FreeAndNil(cliente);
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoChange(Sender: TObject);
var
  produto: TInfoProdutos;
begin
  if edtCodProduto.Text = EmptyStr then
  begin
    edtDescricaoProduto.Clear;
    edtUnMedida.Clear;
    edtFatorConversao.Clear;
    edtValorUnitario.Clear;
    edtValorTotalProduto.Clear;
    Exit;
  end;

  produto := GetInfoProduto(edtCodProduto.Text);

  if not produto.CodItem.IsEmpty then
  begin
    edtDescricaoProduto.Text := produto.DescProduto;
    edtUnMedida.Text := produto.UnMedida;
    edtFatorConversao.Text := produto.FatorConersao.ToString;
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoEnter(Sender: TObject);
begin
  edtOperacao.Enabled := False;
  edtModelo.Enabled := False;
  edtCdFornecedor.Enabled := False;
  edtSerie.Enabled := False;
  edtNroNota.Enabled := False;
  edtDataEmissao.Enabled := False;
  edtDataRecebimento.Enabled := False;
  edtDataLancamento.Enabled := False;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoExit(Sender: TObject);
var
  aliq: TAliqProduto;
begin

  if (Trim(edtCodProduto.Text) = '') and (FRegras.DadosNota.cdsNfi.RecordCount > 0) then
  begin
    btnConfirmar.SetFocus;
    Exit;
  end;

  if (edtCodProduto.Text = '') and (FRegras.DadosNota.cdsNfi.IsEmpty) then
  begin
    ShowMessage('Informe um Produto.');
    edtCodProduto.SetFocus;
    Exit;
  end;

  if not Regras.Pesquisar(edtCodProduto.Text) then
  begin
    edtCodProduto.SetFocus;
    raise Exception.Create('Produto não Encontrado');
  end;

  aliq := GetAliqProduto(FRegras.GetIdItem(edtCodProduto.Text));

  if aliq.AliqIcms = 0 then
  begin
    ShowMessage('Produto sem tributação ICMS.');
    edtCodProduto.SetFocus;
    Exit;
  end;
end;

//busca o modelo da nota
procedure TfrmLancamentoNotaEntrada.edtModeloChange(Sender: TObject);
const
  SQL = 'select '                    +
        '    cd_modelo, '            +
        '    nm_modelo '             +
        'from '                      +
        '    modelo_nota_fiscal mfn '+
        'where '                     +
        '    cd_modelo = :cd_modelo';
var
  query: TFDQuery;
begin
  if edtModelo.Text = EmptyStr then
  begin
    edtNomeModelo.Clear;
    Exit;
  end;

  query := TFDQuery.Create(Self);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL, [edtModelo.Text]);
    edtNomeModelo.Text := query.FieldByName('nm_modelo').AsString;
  finally
    query.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtModeloExit(Sender: TObject);
begin
  if sqlCabecalho.IsEmpty then
  begin
    if (Application.MessageBox('Modelo não Encontrado', 'Atenção', MB_OK) = IDOK) then
    begin
      edtModelo.SetFocus;
      edtNomeModelo.Clear;
    end;
  end;
end;


procedure TfrmLancamentoNotaEntrada.edtNroNotaExit(Sender: TObject);
var
  nrNota, fornecedor: Integer;
  serie: String;
//valida se já possui cadastrada uma nota com o mesmo número, mesmo fornecedor e série
begin
  if edtNroNota.Text = EmptyStr then
  begin
    if (Application.MessageBox('Número da Nota não pode ser Vazio', 'Atenção', MB_OK) = IDOK) then
      edtNroNota.SetFocus;
  end
  else
  begin
    sqlCabecalho.Close;
    sqlCabecalho.SQL.Text := 'select              '+
                                  'dcto_numero,   '+
                                  'cd_fornecedor, '+
                                  'serie          '+
                              'from               '+
                                  'nfc            '+
                              'where              '+
                                  '(dcto_numero = :dcto_numero) '+
                                  'and (cd_fornecedor = :cd_fornecedor) '+
                                  'and (serie = :serie)';

    sqlCabecalho.ParamByName('dcto_numero').AsInteger := StrToInt(edtNroNota.Text);
    sqlCabecalho.ParamByName('cd_fornecedor').AsInteger := StrToInt(edtCdFornecedor.Text);
    sqlCabecalho.ParamByName('serie').AsString := edtSerie.Text;
    sqlCabecalho.Open();
    nrNota := sqlCabecalho.FieldByName('dcto_numero').AsInteger;
    fornecedor := sqlCabecalho.FieldByName('cd_fornecedor').AsInteger;
    serie := sqlCabecalho.FieldByName('serie').AsString;

    if (IntToStr(nrNota) = edtNroNota.Text) and (IntToStr(fornecedor) = edtCdFornecedor.Text) and (serie = edtSerie.Text) then
    begin
      ShowMessage('Número da nota já cadastrada no sistema');
      edtNroNota.SetFocus;
    end;
  end;
end;

//busca a operação da nota e modelo caso possua alguma vinculada
procedure TfrmLancamentoNotaEntrada.edtOperacaoChange(Sender: TObject);
begin
  if edtOperacao.Text = EmptyStr then
  begin
    edtNomeOperacao.Text := '';
    Exit;
  end;
  if ((edtOperacao.Text = EmptyStr) and (edtModelo.Text = EmptyStr)) then
  begin
    edtNomeOperacao.Clear;
    edtNomeModelo.Clear;
    Exit;
  end;

  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select                          '+
                                'op.cd_operacao,            '+
                                'op.nm_operacao,            '+
                                'op.cd_modelo_nota_fiscal,  '+
                                'mnf.nm_modelo              '+
                          'from                             '+
                                'operacao op                '+
                          'left join modelo_nota_fiscal mnf on   '+
                                'op.cd_modelo_nota_fiscal = mnf.cd_modelo ' +
                          'where              '+
                                '(op.cd_operacao = :cd_operacao) '+
                                'and (op.fl_ent_sai = ''E'')';

  sqlCabecalho.ParamByName('cd_operacao').AsInteger := StrToInt(edtOperacao.Text);
  sqlCabecalho.Open();
  edtNomeOperacao.Text := sqlCabecalho.FieldByName('nm_operacao').AsString;
  edtModelo.Text := sqlCabecalho.FieldByName('cd_modelo_nota_fiscal').AsString;
  edtNomeModelo.Text := sqlCabecalho.FieldByName('nm_modelo').AsString;

end;

procedure TfrmLancamentoNotaEntrada.edtOperacaoExit(Sender: TObject);
begin
  if btnCancelar.MouseInClient then
    Exit;

  if sqlCabecalho.IsEmpty then
  begin
    if (Application.MessageBox('Operação não encontrada','Atenção', MB_OK) = idOK) then
    begin
      edtOperacao.SetFocus;
      edtNomeOperacao.Clear;
      edtModelo.Clear;
      edtNomeModelo.Clear;
    end;
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtQuantidadeChange(Sender: TObject);
begin
  if edtQuantidade.Text = EmptyStr then
   Exit;

  calculaQuantidadeTotalItem;
  calculaValorTotalItem;
end;

procedure TfrmLancamentoNotaEntrada.edtQuantidadeExit(Sender: TObject);
begin
  calculaQuantidadeTotalItem;
end;

procedure TfrmLancamentoNotaEntrada.edtSerieExit(Sender: TObject);
begin
  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select nr_serie from serie_nf where nr_serie = :nr_serie';
  sqlCabecalho.ParamByName('nr_serie').AsString := edtSerie.Text;
  sqlCabecalho.Open();

  if sqlCabecalho.IsEmpty then
  begin
    if (Application.MessageBox('Série não encontrado','Atenção', MB_OK) = idOK) then
      edtSerie.SetFocus;
  end;
end;

//valida se foi informado valor de serviço ou produto ou os dois
procedure TfrmLancamentoNotaEntrada.edtVlProdutoExit(Sender: TObject);
begin
  if (edtVlServico.Text = '0,00') and (edtVlProduto.Text = '0,00') then
  begin
    ShowMessage('Valor de Serviço ou Produto não pode ser igual a zero!');
    edtVlServico.SetFocus;
  end
  else if (edtVlServico.Text > '0,00') and (edtVlProduto.Text > '0,00') then
  begin
    ShowMessage('Não pode ser lançado valores de serviços e produtos na mesma nota!');
    edtVlServico.SetFocus;
  end
  else
    valorTotalNota;
  edtVlProduto.Text := FormatCurr('#,##0.00', StrToCurr(edtVlProduto.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtVlServicoExit(Sender: TObject);
begin
  valorTotalNota;
  edtVlServico.Text := FormatCurr('#,##0.00', StrToCurr(edtVlServico.Text));
end;

procedure TfrmLancamentoNotaEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmLancamentoNotaEntrada := nil;
end;

procedure TfrmLancamentoNotaEntrada.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (edtNroNota.Text <> '') or (FRegras.DadosNota.cdsNfi.RecordCount > 0) then
  begin
    CanClose := False;
    if (Application.MessageBox('Deseja Cancelar o lançamento da Nota?','Atenção', MB_YESNO) = IDYES) then
      CanClose := True;
  end;
end;

procedure TfrmLancamentoNotaEntrada.FormCreate(Sender: TObject);
begin
  FRegras := TNotaEntrada.Create;
  DBGridProdutos.DataSource := FRegras.DadosNota.dsNfi;
  edtDataEmissao.Date := now;
  edtDataRecebimento.Date := now;
  edtDataLancamento.Date := now;
  seq := 1;
  FEdicaoItem := False;
  IdGeralNFC := 0;
  IdGeralNFI := 0;
end;

procedure TfrmLancamentoNotaEntrada.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

function TfrmLancamentoNotaEntrada.GetAliqProduto(IdItem: Integer): TAliqProduto;
const
  SQL = 'select                                               '+
        '    gti.aliquota_icms,                               '+
        '    ipi.aliquota_ipi,                                '+
        '    gtpc.aliquota_pis_cofins                         '+
        '    from produto_tributacao pt                       '+
        'join grupo_tributacao_icms gti on                    '+
        '    pt.cd_tributacao_icms = gti.cd_tributacao        '+
        'join grupo_tributacao_ipi ipi on                     '+
        '    pt.cd_tributacao_ipi = ipi.cd_tributacao         '+
        'join grupo_tributacao_pis_cofins gtpc on             '+
        '    pt.cd_tributacao_pis_cofins = gtpc.cd_tributacao '+
        'where                                                '+
        '    pt.id_item = :id_item';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(Self);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL, [IdItem]);

    if not query.IsEmpty then
    begin
      Result.AliqIcms := query.FieldByName('aliquota_icms').AsFloat;
      Result.AliqIPI := query.FieldByName('aliquota_ipi').AsFloat;
      Result.AliqPisCofins := query.FieldByName('aliquota_pis_cofins').AsFloat;
    end;

  finally
    query.Free;
  end;
end;

function TfrmLancamentoNotaEntrada.GetInfoProduto(CodItem: String): TInfoProdutos;
const
  SQL = 'select                 '+
        '    cd_produto,        '+
        '    desc_produto,      '+
        '    un_medida,         '+
        '    fator_conversao    '+
        'from                   '+
        '    produto            '+
        'where                  '+
        'cd_produto = :cd_produto';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(Self);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL, [CodItem]);

    if not query.IsEmpty then
    begin
      Result.CodItem := query.FieldByName('cd_produto').AsString;
      Result.DescProduto := query.FieldByName('desc_produto').AsString;
      Result.UnMedida := query.FieldByName('un_medida').AsString;
      Result.FatorConersao := query.FieldByName('fator_conversao').AsInteger;
    end;
  finally
    query.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.limpaCampos;
begin
  edtOperacao.Clear;
  edtOperacao.Enabled := true;
  edtNomeOperacao.Clear;
  edtModelo.Clear;
  edtModelo.Enabled := true;
  edtNomeModelo.Clear;
  edtCdFornecedor.Clear;
  edtCdFornecedor.Enabled := true;
  edtNomeFornecedor.Clear;
  edtSerie.Clear;
  edtSerie.Enabled := true;
  edtNroNota.Clear;
  edtNroNota.Enabled := true;
  edtDataEmissao.Enabled := true;
  edtDataRecebimento.Enabled := true;
  edtDataLancamento.Enabled := true;
  edtVlServico.Text := '0,00';
  edtVlProduto.Text := '0,00';
  edtBaseIcms.Text := '0,00';
  edtValorIcms.Text := '0,00';
  edtValorFrete.Text := '0,00';
  edtValorIPI.Text := '0,00';
  edtValorISS.Text := '0,00';
  edtValorDesconto.Text := '0,00';
  edtValorAcrescimo.Text := '0,00';
  edtValorOutrasDespesas.Text := '0,00';
  edtValorTotalNota.Text := '0,00';
  FRegras.DadosNota.cdsNfi.EmptyDataSet;
  seq := 1;
end;

procedure TfrmLancamentoNotaEntrada.LimpaOutrosCampos;
begin
  edtCodProduto.Clear;
  edtDescricaoProduto.Clear;
  edtQuantidade.Clear;
  edtUnMedida.Clear;
  edtFatorConversao.Clear;
  edtQuantidadeTotalProduto.Clear;
  edtValorUnitario.Clear;
  edtValorTotalProduto.Clear;
  edtCodProduto.SetFocus;
  seq := seq + 1;
end;

procedure TfrmLancamentoNotaEntrada.PreencheDatasetNFC;
var
  idGeral: TGerador;
begin
  idGeral := TGerador.Create;

  try
    FRegras.DadosNota.cdsNfc.Append;
    FRegras.DadosNota.cdsNfc.FieldByName('id_geral').AsLargeInt := idGeral.GeraIdGeral;
    FRegras.DadosNota.cdsNfc.FieldByName('dcto_numero').AsInteger := StrToInt(edtNroNota.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('serie').AsString := edtSerie.Text;
    FRegras.DadosNota.cdsNfc.FieldByName('cd_fornecedor').AsInteger := StrToInt(edtCdFornecedor.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('dt_emissao').AsDateTime := edtDataEmissao.DateTime;
    FRegras.DadosNota.cdsNfc.FieldByName('dt_recebimento').AsDateTime := edtDataRecebimento.DateTime;
    FRegras.DadosNota.cdsNfc.FieldByName('dt_lancamento').AsDateTime := edtDataLancamento.DateTime;
    FRegras.DadosNota.cdsNfc.FieldByName('cd_operacao').AsInteger := StrToInt(edtOperacao.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('cd_modelo').AsString := edtModelo.Text;
    FRegras.DadosNota.cdsNfc.FieldByName('valor_servico').AsCurrency := StrToCurr(edtVlServico.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('vl_base_icms').AsCurrency := StrToCurr(edtBaseIcms.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_icms').AsCurrency := StrToCurr(edtValorIcms.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_frete').AsCurrency := StrToCurr(edtValorFrete.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_ipi').AsCurrency := StrToCurr(edtValorIPI.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_iss').AsCurrency := StrToCurr(edtValorISS.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_desconto').AsCurrency := StrToCurr(edtValorDesconto.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_acrescimo').AsCurrency := StrToCurr(edtValorAcrescimo.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_outras_despesas').AsCurrency := StrToCurr(edtValorOutrasDespesas.Text);
    FRegras.DadosNota.cdsNfc.FieldByName('valor_total').AsCurrency := StrToCurr(edtValorTotalNota.Text);
    FRegras.DadosNota.cdsNfc.Post;

  finally
    idGeral.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.SetEdicaoItem(const Value: Boolean);
begin
  FEdicaoItem := Value;
end;

procedure TfrmLancamentoNotaEntrada.SetIdGeralNFC(const Value: Integer);
begin
  FidGeralNFC := Value;
end;

procedure TfrmLancamentoNotaEntrada.SetIdGeralNFI(const Value: Integer);
begin
  FIdGeralNFI := Value;
end;

procedure TfrmLancamentoNotaEntrada.SetRegras(const Value: TNotaEntrada);
begin
  FRegras := Value;
end;

procedure TfrmLancamentoNotaEntrada.LancaFinanceiro;
const
  SQL = 'insert into cxa_financeiro(' +
        '   id_geral,' +
        '   id_nota_entrada,' +
        '   cd_forma_pgto,' +
        '   cd_cond_pgto,' +
        '   valor,' +
        '   cd_usuario,' +
        '   fl_entrada_saida,' +
        '   dt_pgto)' +
        'values(:id_geral,' +
        '   :id_nota_entrada,' +
        '   :cd_forma_pgto,' +
        '   :cd_cond_pgto,' +
        '   :valor,' +
        '   :cd_usuario,' +
        '   :fl_entrada_saida,' +
        '   :dt_pgto)';
var
  qry: TFDQuery;
  msg: string;
  idGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  idGeral := TGerador.Create;
  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
      qry.ParamByName('id_nota_entrada').AsInteger := FidGeralNFC;
      qry.ParamByName('cd_forma_pgto').AsInteger := 1;  //criar campos para informar forma e condição
      qry.ParamByName('cd_cond_pgto').AsInteger := 1;
      qry.ParamByName('valor').AsCurrency := StrToCurr(edtValorTotalNota.Text);
      qry.ParamByName('cd_usuario').AsInteger := idUsuario;
      qry.ParamByName('fl_entrada_saida').AsString := 'E';
      qry.ParamByName('dt_pgto').AsDateTime := Now;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E : exception do
      begin
        msg := 'Erro ao gravar o financeiro da nota fiscal '
               + edtNroNota.Text + E.Message;
        dm.conexaoBanco.Rollback;
        ShowMessage(msg);
        Exit;
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
    idGeral.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.AdicionaItem;
var
  aliquotas: TAliqProduto;
  idGeral: TGerador;
begin
  idGeral := TGerador.Create;

  try

    aliquotas := GetAliqProduto(FRegras.GetIdItem(edtCodProduto.Text));

    if FEdicaoItem then
      FRegras.DadosNota.cdsNfi.Edit
    else
      FRegras.DadosNota.cdsNfi.Append;

    FRegras.DadosNota.cdsNfi.FieldByName('id_geral').AsLargeInt := idGeral.GeraIdGeral;
    FRegras.DadosNota.cdsNfi.FieldByName('seq_item_nfi').AsInteger := seq;
    FRegras.DadosNota.cdsNfi.FieldByName('cd_produto').AsString := edtCodProduto.Text;
    FRegras.DadosNota.cdsNfi.FieldByName('descricao').AsString := edtDescricaoProduto.Text;
    FRegras.DadosNota.cdsNfi.FieldByName('un_medida').AsString := edtUnMedida.Text;
    FRegras.DadosNota.cdsNfi.FieldByName('qtd_estoque').AsInteger := StrToInt(edtQuantidade.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('fator_conversao').AsInteger := StrToInt(edtFatorConversao.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('qtd_total').AsInteger := StrToInt(edtQuantidadeTotalProduto.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtValorUnitario.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('valor_total').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('icms_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('icms_pc_aliq').AsFloat := aliquotas.AliqIcms;
    FRegras.DadosNota.cdsNfi.FieldByName('icms_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliquotas.AliqIcms) / 100;
    FRegras.DadosNota.cdsNfi.FieldByName('ipi_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('ipi_pc_aliq').AsFloat := aliquotas.AliqIPI;
    FRegras.DadosNota.cdsNfi.FieldByName('ipi_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliquotas.AliqIPI) / 100;
    FRegras.DadosNota.cdsNfi.FieldByName('pis_cofins_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    FRegras.DadosNota.cdsNfi.FieldByName('pis_cofins_pc_aliq').AsFloat := aliquotas.AliqPisCofins;
    FRegras.DadosNota.cdsNfi.FieldByName('pis_cofins_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliquotas.AliqPisCofins) / 100;
    FRegras.DadosNota.cdsNfi.FieldByName('id_item').AsLargeInt := FRegras.GetIdItem(edtCodProduto.Text);
    FRegras.DadosNota.cdsNfi.Post;
    FEdicaoItem := False;

  finally
    idGeral.Free;
    LimpaOutrosCampos;
  end;
end;

procedure TfrmLancamentoNotaEntrada.btnAddItensClick(Sender: TObject);
begin
  AdicionaItem;
end;

procedure TfrmLancamentoNotaEntrada.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Cancelar o Lançamento?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmLancamentoNotaEntrada.btnConfirmarClick(Sender: TObject);
var
  estoque: TMovimentacaoEstoque;
begin
  estoque := TMovimentacaoEstoque.Create;
  dm.conexaoBanco.StartTransaction;

  try
    try
      validaValoresNota;

      if FRegras.GravaCabecalho(dm.conexaoBanco) then
      begin
        FRegras.DadosNota.cdsNfi.Loop(
        procedure
        begin
          if FRegras.GravaItens(dm.conexaoBanco) then
            dm.conexaoBanco.Commit;

          //insere na wms_mvto e atualiza a quantidade em estoque
          estoque.InsereWmsMvto(FRegras.DadosNota.cdsNfi.FieldByName('id_item').AsInteger,
                                FRegras.DadosNota.cdsNfi.FieldByName('un_medida').AsString,
                                FRegras.DadosNota.cdsNfi.FieldByName('qtd_estoque').AsCurrency,
                                'E');

          estoque.AtualizaEstoque(FRegras.DadosNota.cdsNfi.FieldByName('id_item').AsInteger,
                                  FRegras.DadosNota.cdsNfi.FieldByName('qtd_estoque').AsCurrency,
                                  'E');
        end
        );
      end;

      LancaFinanceiro;

      ShowMessage('Nota gravada com sucesso!');
      limpaCampos; //verificar que não está limpando o grid

    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ao gravar os dados da nota ' + edtNroNota.Text + E.Message);
        Exit;
      end;
    end;
  finally
    estoque.Free;
    dm.conexaoBanco.Rollback;
  end;
end;

function TfrmLancamentoNotaEntrada.CalculaImposto(ValorBase, Aliquota: Currency): Currency;
begin
  Result := (ValorBase * Aliquota) / 100;
end;

procedure TfrmLancamentoNotaEntrada.calculaQuantidadeTotalItem;
var
  qtTotal : Integer;
begin
  if edtQuantidade.Text = EmptyStr then
    Exit;

  qtTotal := StrToInt(edtQuantidade.Text) * StrToInt(edtFatorConversao.Text);
  edtQuantidadeTotalProduto.Text := IntToStr(qtTotal);
end;

procedure TfrmLancamentoNotaEntrada.calculaValorTotalItem;
var
  valor : Currency;
begin
  if edtValorUnitario.Text = EmptyStr then
    Exit;

  valor := (StrToCurr(edtQuantidade.Text) * StrToCurr(edtValorUnitario.Text));
  edtValorTotalProduto.Text := CurrToStr(valor);
end;

procedure TfrmLancamentoNotaEntrada.CarregaItensEdicao;
begin
  edtCodProduto.Text := FRegras.DadosNota.cdsNfi.FieldByName('cd_produto').AsString;
  edtDescricaoProduto.Text := FRegras.DadosNota.cdsNfi.FieldByName('descricao').AsString;
  edtUnMedida.Text := FRegras.DadosNota.cdsNfi.FieldByName('un_medida').AsString;
  edtQuantidade.Text := FRegras.DadosNota.cdsNfi.FieldByName('qtd_estoque').AsString;
  edtFatorConversao.Text := FRegras.DadosNota.cdsNfi.FieldByName('fator_conversao').AsString;
  edtQuantidadeTotalProduto.Text := FRegras.DadosNota.cdsNfi.FieldByName('qtd_total').AsString;
  edtValorUnitario.Text := FRegras.DadosNota.cdsNfi.FieldByName('vl_unitario').AsString;
  edtValorTotalProduto.Text := FRegras.DadosNota.cdsNfi.FieldByName('vl_total').AsString;
  FEdicaoItem := True;
end;

procedure TfrmLancamentoNotaEntrada.DBGridProdutosDblClick(Sender: TObject);
begin
  CarregaItensEdicao;
end;

procedure TfrmLancamentoNotaEntrada.DBGridProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if (Application.MessageBox('Deseja realmente Excluir?','Atenção', MB_YESNO) = IDYES) then
    begin
      FRegras.DadosNota.cdsNfi.Delete;
      edtCodProduto.SetFocus;
      seq := seq - 1;
    end;
  end;
end;

destructor TfrmLancamentoNotaEntrada.Destroy;
begin
  FRegras.Free;
  inherited;
end;

procedure TfrmLancamentoNotaEntrada.edtValorAcrescimoExit(Sender: TObject);
begin
  valorTotalNota;
  edtValorAcrescimo.Text := FormatCurr('#,##0.00', StrToCurr(edtValorAcrescimo.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorDescontoExit(Sender: TObject);
begin
  valorTotalNota;
  edtValorDesconto.Text := FormatCurr('#,##0.00', StrToCurr(edtValorDesconto.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorFreteExit(Sender: TObject);
begin
  valorTotalNota;
  edtValorFrete.Text := FormatCurr('#,##0.00', StrToCurr(edtValorFrete.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorIcmsExit(Sender: TObject);
begin
  edtValorIcms.Text := FormatCurr('#,##0.00', StrToCurr(edtValorIcms.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorIPIExit(Sender: TObject);
begin
  valorTotalNota;
  edtValorIPI.Text := FormatCurr('#,##0.00', StrToCurr(edtValorIPI.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorISSExit(Sender: TObject);
begin
  edtValorISS.Text := FormatCurr('#,##0.00', StrToCurr(edtValorISS.Text));
end;

procedure TfrmLancamentoNotaEntrada.edtValorOutrasDespesasExit(Sender: TObject);
begin
  valorTotalNota;
  edtValorOutrasDespesas.Text := FormatCurr('#,##0.00', StrToCurr(edtValorOutrasDespesas.Text));
  PreencheDatasetNFC;
end;

procedure TfrmLancamentoNotaEntrada.edtValorUnitarioChange(Sender: TObject);
begin
  calculaValorTotalItem;
end;


procedure TfrmLancamentoNotaEntrada.validaValoresNota;
var vlTotalItens : Double;
begin
  vlTotalItens := 0;

  FRegras.DadosNota.cdsNfi.Loop(
  procedure
  begin
    vlTotalItens := vlTotalItens + FRegras.DadosNota.cdsNfi.FieldByName('valor_total').AsCurrency;
  end
  );

  if vlTotalItens <> StrToFloat(edtVlProduto.Text) then
    raise Exception.Create(' O valor total dos itens não fecha com o valor total da nota! Verifique');
end;

procedure TfrmLancamentoNotaEntrada.valorTotalNota;
//calcula o valor total da nota
var vlTotal: Currency;
begin

  if StrToCurr(edtVlServico.Text) > 0 then
  begin
    vlTotal := 0;
    vlTotal := vlTotal + StrToCurr(edtVlServico.Text);
    edtValorTotalNota.Text := CurrToStr(vlTotal);
  end
  else if StrToCurr(edtVlProduto.Text) > 0 then
  begin
    vlTotal := 0;
    vlTotal := (vlTotal + StrToCurr(edtVlProduto.Text)
                        + StrToCurr(edtValorFrete.Text)
                        + StrToCurr(edtValorIPI.Text)
                        + StrToCurr(edtValorAcrescimo.Text)
                        + StrToCurr(edtValorOutrasDespesas.Text))
                        - StrToCurr(edtValorDesconto.Text);
    edtValorTotalNota.Text := FormatCurr('#,##0.00', vlTotal);;
  end;
end;

end.
