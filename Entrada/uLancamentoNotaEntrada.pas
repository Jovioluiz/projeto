unit uLancamentoNotaEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, uConexao, System.UITypes, uclValidacoesEntrada, uDataModule;

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
    dsEntrada: TDataSource;
    cdsEntrada: TClientDataSet;
    sqlIdGeral: TFDQuery;
    sqlInsert: TFDQuery;
    sqlInsertiNfi: TFDQuery;
    sqlUpdate: TFDQuery;
    cdsEntradaseq_item_nfi: TIntegerField;
    cdsEntradacd_produto: TIntegerField;
    cdsEntradadescricao: TStringField;
    cdsEntradaun_medida: TStringField;
    cdsEntradaqtd_estoque: TFloatField;
    cdsEntradafator_conversao: TFloatField;
    cdsEntradaqtd_total: TFloatField;
    cdsEntradavl_unitario: TCurrencyField;
    cdsEntradavl_total: TCurrencyField;
    cdsEntradaicms_vl_base: TCurrencyField;
    cdsEntradaicms_pc_aliq: TCurrencyField;
    cdsEntradaicms_valor: TCurrencyField;
    cdsEntradaipi_vl_base: TCurrencyField;
    cdsEntradaipi_pc_aliq: TCurrencyField;
    cdsEntradaipi_valor: TCurrencyField;
    cdsEntradapis_cofins_vl_base: TCurrencyField;
    cdsEntradapis_cofins_pc_aliq: TCurrencyField;
    cdsEntradapis_cofins_valor: TCurrencyField;
    cdsEntradaiss_vl_base: TCurrencyField;
    cdsEntradaiss_pc_aliq: TCurrencyField;
    cdsEntradaiss_valor: TCurrencyField;
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
  private
    { Private declarations }
    procedure validaValoresNota;
    procedure limpaCampos;
    procedure atualizaEstoqueProduto;
  public
    { Public declarations }
  end;

var
  frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada;
  seq : Integer = 1; //sequencia dos itens lan�ados na nota
  aliqIcms, aliqIpi, aliqPisCofins : Double; //guardar as aliquotas dos itens e mostrar no grid

implementation

{$R *.dfm}

//busca o fornecedor/cliente
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
  qry.Connection := dm.FDConnection1;

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
  cliente: TValidacoesEntrada;
  resposta : Boolean;
begin
  cliente := TValidacoesEntrada.Create;
  resposta := cliente.BuscaClienteFornecedor(StrToInt(edtCdFornecedor.Text));

  try
    if resposta then
    begin
      if (Application.MessageBox('Fornecedor/Cliente n�o Encontrado', 'Aten��o', MB_OK) = IDOK) then
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

  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select                 '+
                            '    cd_produto,        '+
                            '    desc_produto,      '+
                            '    un_medida,         '+
                            '    fator_conversao    '+
                            'from                   '+
                            '    produto            '+
                            'where                  '+
                            'cd_produto = :cd_produto';

  sqlCabecalho.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
  sqlCabecalho.Open();
  edtDescricaoProduto.Text := sqlCabecalho.FieldByName('desc_produto').AsString;
  edtUnMedida.Text := sqlCabecalho.FieldByName('un_medida').AsString;
  edtFatorConversao.Text := IntToStr(sqlCabecalho.FieldByName('fator_conversao').AsInteger);
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoEnter(Sender: TObject);
begin
  edtOperacao.Enabled := false;
  edtModelo.Enabled := false;
  edtCdFornecedor.Enabled := false;
  edtSerie.Enabled := false;
  edtNroNota.Enabled := false;
  edtDataEmissao.Enabled := false;
  edtDataRecebimento.Enabled := false;
  edtDataLancamento.Enabled := false;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text = '' then
    Exit;

  if sqlCabecalho.IsEmpty then
  begin
    ShowMessage('Produto n�o Encontrado');
    edtFatorConversao.Clear;
    Exit;
  end;

  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select                                                '+
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
                            '    pt.cd_produto = :cd_produto' ;
  sqlCabecalho.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
  sqlCabecalho.Open();

  aliqIcms := sqlCabecalho.FieldByName('aliquota_icms').AsFloat;
  aliqIpi := sqlCabecalho.FieldByName('aliquota_ipi').AsFloat;
  aliqPisCofins := sqlCabecalho.FieldByName('aliquota_pis_cofins').AsFloat;

end;

//busca o modelo da nota
procedure TfrmLancamentoNotaEntrada.edtModeloChange(Sender: TObject);
begin
  if edtModelo.Text = EmptyStr then
  begin
    edtNomeModelo.Clear;
    Exit;
  end;

  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select '                                     +
                          '    cd_modelo, '                              +
                          '    nm_modelo '                               +
                          'from '                                        +
                          '    modelo_nota_fiscal mfn '                  +
                          'where '                                       +
                          '    cd_modelo = :cd_modelo';

  sqlCabecalho.ParamByName('cd_modelo').AsString := edtModelo.Text;
  sqlCabecalho.Open();
  edtNomeModelo.Text := sqlCabecalho.FieldByName('nm_modelo').AsString;
end;

procedure TfrmLancamentoNotaEntrada.edtModeloExit(Sender: TObject);
begin
  if sqlCabecalho.IsEmpty then
  begin
    if (Application.MessageBox('Modelo n�o Encontrado', 'Aten��o', MB_OK) = IDOK) then
    begin
      edtModelo.SetFocus;
      edtNomeModelo.Clear;
    end;
  end;
end;


procedure TfrmLancamentoNotaEntrada.edtNroNotaExit(Sender: TObject);
Var nrNota, fornecedor : Integer;
    serie : String;
//valida se j� possui cadastrada uma nota com o mesmo n�mero, mesmo fornecedor e s�rie
begin
  if edtNroNota.Text = EmptyStr then
  begin
    if (Application.MessageBox('N�mero da Nota n�o pode ser Vazio', 'Aten��o', MB_OK) = IDOK) then
    begin
      edtNroNota.SetFocus;
    end;
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
      ShowMessage('N�mero da nota j� cadastrada no sistema');
      edtNroNota.SetFocus;
    end;
  end;
end;

//busca a opera��o da nota e modelo caso possua alguma vinculada
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
    if (Application.MessageBox('Opera��o n�o encontrada','Aten��o', MB_OK) = idOK) then
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
    if (Application.MessageBox('S�rie n�o encontrado','Aten��o', MB_OK) = idOK) then
      edtSerie.SetFocus;
  end;

end;

//valida se foi informado valor de servi�o ou produto ou os dois
procedure TfrmLancamentoNotaEntrada.edtVlProdutoExit(Sender: TObject);
begin
  if (edtVlServico.Text = '0,00') and (edtVlProduto.Text = '0,00') then
  begin
    ShowMessage('Valor de Servi�o ou Produto n�o pode ser igual a zero!');
    edtVlServico.SetFocus;
  end
  else if (edtVlServico.Text > '0,00') and (edtVlProduto.Text > '0,00') then
  begin
    ShowMessage('N�o pode ser lan�ado valores de servi�os e produtos na mesma nota!');
    edtVlServico.SetFocus;
  end
  else
    valorTotalNota;

end;

procedure TfrmLancamentoNotaEntrada.edtVlServicoExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmLancamentoNotaEntrada := nil;
end;

procedure TfrmLancamentoNotaEntrada.FormCreate(Sender: TObject);
begin
  edtDataEmissao.Date := now;
  edtDataRecebimento.Date := now;
  edtDataLancamento.Date := now;
  seq := 1;
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
  //cdsEntrada.EmptyDataSet;
  seq := 1;
end;

procedure TfrmLancamentoNotaEntrada.atualizaEstoqueProduto;
const
  sql_update =  'update '+
                    'produto '+
                'set '+
                    'qtd_estoque = :qtd_estoque '+
                'where cd_produto = :cd_produto';
  sql_select = 'select '+
                  'qtd_estoque '+
              'from '+
                  'produto '+
              'where '+
                  'cd_produto = :cd_produto';
var
  qry: TFDQuery;
  qtdade, qttotal: Double;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  dm.FDConnection1.StartTransaction;

  try
    cdsEntrada.DisableControls;
    cdsEntrada.First;
    while not cdsEntrada.Eof do
    begin
      qry.SQL.Clear;
      qry.SQL.Add(sql_select);
      qry.ParamByName('cd_produto').AsInteger := cdsEntrada.FieldByName('cd_produto').AsInteger;
      qry.Open(sql_select);
      qtdade := qry.FieldByName('qtd_estoque').AsFloat;
      qttotal := qtdade + cdsEntrada.FieldByName('qtd_total').AsFloat;

      qry.SQL.Clear;
      qry.SQL.Add(sql_update);
      qry.ParamByName('qtd_estoque').AsFloat := qttotal;
      qry.ParamByName('cd_produto').AsInteger := cdsEntrada.FieldByName('cd_produto').AsInteger;

      qry.ExecSQL;
      dm.FDConnection1.Commit;
      cdsEntrada.Next;
    end;
  finally
    qry.Free;
    dm.FDConnection1.Rollback;
    cdsEntrada.EnableControls
  end;
end;

procedure TfrmLancamentoNotaEntrada.btnAddItensClick(Sender: TObject);
begin
  try
    cdsEntrada.Append;
    cdsEntrada.FieldByName('seq_item_nfi').AsInteger := seq;
    cdsEntrada.FieldByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
    cdsEntrada.FieldByName('descricao').AsString := edtDescricaoProduto.Text;
    cdsEntrada.FieldByName('un_medida').AsString := edtUnMedida.Text;
    cdsEntrada.FieldByName('qtd_estoque').AsInteger := StrToInt(edtQuantidade.Text);
    cdsEntrada.FieldByName('fator_conversao').AsInteger := StrToInt(edtFatorConversao.Text);
    cdsEntrada.FieldByName('qtd_total').AsInteger := StrToInt(edtQuantidadeTotalProduto.Text);
    cdsEntrada.FieldByName('vl_unitario').AsCurrency := StrToCurr(edtValorUnitario.Text);
    cdsEntrada.FieldByName('vl_total').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    cdsEntrada.FieldByName('icms_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    cdsEntrada.FieldByName('icms_pc_aliq').AsFloat := aliqIcms;
    cdsEntrada.FieldByName('icms_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliqIcms) / 100;
    cdsEntrada.FieldByName('ipi_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    cdsEntrada.FieldByName('ipi_pc_aliq').AsFloat := aliqIpi;
    cdsEntrada.FieldByName('ipi_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliqIpi) / 100;
    cdsEntrada.FieldByName('pis_cofins_vl_base').AsCurrency := StrToCurr(edtValorTotalProduto.Text);
    cdsEntrada.FieldByName('pis_cofins_pc_aliq').AsFloat := aliqPisCofins;
    cdsEntrada.FieldByName('pis_cofins_valor').AsCurrency := (StrToCurr(edtValorTotalProduto.Text) * aliqPisCofins) / 100;
    cdsEntrada.Post;
  finally
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
end;

procedure TfrmLancamentoNotaEntrada.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Cancelar o Lan�amento?','Aten��o', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmLancamentoNotaEntrada.btnConfirmarClick(Sender: TObject);
var
  idGeralNfc, idGeralNfi : Integer;
  vlIcmsRateado, vlIpiRateado, vlIssRateado, vlFreteRateado,
  vlDescontoRateado, vlAcrescimoRateado, soma, qtdade, qtTotal: Currency;
begin
  try
    idGeralNfc := 0;
    validaValoresNota;
    frmConexao.conexao.StartTransaction;
    //id_geral nfc
    sqlIdGeral.Close;
    sqlIdGeral.SQL.Text := 'select *from func_id_geral()';
    try
      sqlIdGeral.Open();
      sqlIdGeral.First;
      while not sqlIdGeral.Eof do
      begin
        idGeralNfc := sqlIdGeral.FieldByName('func_id_geral').AsInteger;
        sqlIdGeral.Next;
      end;
    except
      on E:exception do
        begin
          raise Exception.Create('Erro ao criar o id_geral');
        end;
    end;

    sqlInsert.Close;
    sqlInsert.SQL.Text := 'insert                       '+
                          '    into                     '+
                          '    nfc (id_geral,           '+
                          '    dcto_numero,             '+
                          '    serie,                   '+
                          '    cd_fornecedor,           '+
                          '    dt_emissao,              '+
                          '    dt_recebimento,          '+
                          '    dt_lancamento,           '+
                          '    cd_operacao,             '+
                          '    cd_modelo,               '+
                          '    valor_servico,           '+
                          '    valor_produto,           '+
                          '    vl_base_icms,            '+
                          '    valor_icms,              '+
                          '    valor_frete,             '+
                          '    valor_ipi,               '+
                          '    valor_iss,               '+
                          '    valor_desconto,          '+
                          '    valor_acrescimo,         '+
                          '    valor_outras_despesas,   '+
                          '    valor_total_nota)        '+
                          'values(:id_geral,            '+
                          '    :dcto_numero,            '+
                          '    :serie,                  '+
                          '    :cd_fornecedor,          '+
                          '    :dt_emissao,             '+
                          '    :dt_recebimento,         '+
                          '    :dt_lancamento,          '+
                          '    :cd_operacao,            '+
                          '    :cd_modelo,              '+
                          '    :valor_servico,          '+
                          '    :valor_produto,          '+
                          '    :vl_base_icms,           '+
                          '    :valor_icms,             '+
                          '    :valor_frete,            '+
                          '    :valor_ipi,              '+
                          '    :valor_iss,              '+
                          '    :valor_desconto,         '+
                          '    :valor_acrescimo,        '+
                          '    :valor_outras_despesas,  '+
                          '    :valor_total_nota)' ;
    sqlInsert.ParamByName('id_geral').AsInteger := idGeralNfc;
    sqlInsert.ParamByName('dcto_numero').AsInteger := StrToInt(edtNroNota.Text);
    sqlInsert.ParamByName('serie').AsString := edtSerie.Text;
    sqlInsert.ParamByName('cd_fornecedor').AsInteger := StrToInt(edtCdFornecedor.Text);
    sqlInsert.ParamByName('dt_emissao').AsDate := edtDataEmissao.Date;
    sqlInsert.ParamByName('dt_recebimento').AsDate := edtDataRecebimento.Date;
    sqlInsert.ParamByName('dt_lancamento').AsDate := edtDataLancamento.Date;
    sqlInsert.ParamByName('cd_operacao').AsInteger := StrToInt(edtOperacao.Text);
    sqlInsert.ParamByName('cd_modelo').AsString := edtModelo.Text;
    sqlInsert.ParamByName('valor_servico').AsCurrency := StrToCurr(edtVlServico.Text);
    sqlInsert.ParamByName('valor_produto').AsCurrency := StrToCurr(edtVlProduto.Text);
    sqlInsert.ParamByName('vl_base_icms').AsCurrency := StrToCurr(edtBaseIcms.Text);
    sqlInsert.ParamByName('valor_icms').AsCurrency := StrToCurr(edtValorIcms.Text);
    sqlInsert.ParamByName('valor_frete').AsCurrency := StrToCurr(edtValorFrete.Text);
    sqlInsert.ParamByName('valor_ipi').AsCurrency := StrToCurr(edtValorIPI.Text);
    sqlInsert.ParamByName('valor_iss').AsCurrency := StrToCurr(edtValorISS.Text);
    sqlInsert.ParamByName('valor_desconto').AsCurrency := StrToCurr(edtValorDesconto.Text);
    sqlInsert.ParamByName('valor_acrescimo').AsCurrency := StrToCurr(edtValorAcrescimo.Text);
    sqlInsert.ParamByName('valor_outras_despesas').AsCurrency := StrToCurr(edtValorOutrasDespesas.Text);
    sqlInsert.ParamByName('valor_total_nota').AsCurrency := StrToCurr(edtValorTotalNota.Text);

    //soma a quantidade dos itens de todos os produtos lan�ados
    soma := 0;
    with cdsEntrada do
    begin
      cdsEntrada.DisableControls;
      cdsEntrada.First;
      while not cdsEntrada.Eof do
      begin
        soma := soma + cdsEntrada.FieldByName('qtd_total').AsCurrency;
        cdsEntrada.Next;
      end;
      cdsEntrada.EnableControls;
    end;

    //insert nfi
    with cdsEntrada do
    begin
      cdsEntrada.DisableControls;
      cdsEntrada.First;
      while not cdsEntrada.Eof do
      begin
        sqlIdGeral.Close;
        sqlIdGeral.SQL.Text := 'select '+
                                        '* '+
                                        'from func_id_geral()';
        sqlIdGeral.Open();
        idGeralNfi := sqlIdGeral.FieldByName('func_id_geral').AsInteger;

        sqlInsertiNfi.Close;
        sqlInsertiNfi.SQL.Text := 'insert                       '+
                                  '    into                     '+
                                  '    nfi (id_geral,           '+
                                  '    id_nfc,                  '+
                                  '    cd_produto,              '+
                                  '    qtd_estoque,             '+
                                  '    icms_vl_base,            '+
                                  '    icms_pc_aliq,            '+
                                  '    icms_valor,              '+
                                  '    ipi_vl_base,             '+
                                  '    ipi_pc_aliq,             '+
                                  '    ipi_valor,               '+
                                  '    pis_cofins_vl_base,      '+
                                  '    pis_cofins_pc_aliq,      '+
                                  '    pis_cofins_valor,        '+
                                  '    un_medida,               '+
                                  '    vl_unitario,             '+
                                  '    vl_frete_rateado,        '+
                                  '    vl_desconto_rateado,     '+
                                  '    vl_acrescimo_rateado,    '+
                                  '    seq_item_nfi)            '+
                                  'values(:id_geral,            '+
                                  '    :id_nfc,                 '+
                                  '    :cd_produto,             '+
                                  '    :qtd_estoque,            '+
                                  '    :icms_vl_base,           '+
                                  '    :icms_pc_aliq,           '+
                                  '    :icms_valor,             '+
                                  '    :ipi_vl_base,            '+
                                  '    :ipi_pc_aliq,            '+
                                  '    :ipi_valor,              '+
                                  '    :pis_cofins_vl_base,     '+
                                  '    :pis_cofins_pc_aliq,     '+
                                  '    :pis_cofins_valor,       '+
                                  '    :un_medida,              '+
                                  '    :vl_unitario,            '+
                                  '    :vl_frete_rateado,       '+
                                  '    :vl_desconto_rateado,    '+
                                  '    :vl_acrescimo_rateado,   '+
                                  '    :seq_item_nfi)';
        sqlInsertiNfi.ParamByName('id_geral').AsInteger := idGeralNfi;
        sqlInsertiNfi.ParamByName('id_nfc').AsInteger := idGeralNfc;
        sqlInsertiNfi.ParamByName('cd_produto').AsInteger := cdsEntrada.FieldByName('cd_produto').AsInteger;
        sqlInsertiNfi.ParamByName('qtd_estoque').AsCurrency := cdsEntrada.FieldByName('qtd_estoque').AsCurrency;
        sqlInsertiNfi.ParamByName('un_medida').AsString := cdsEntrada.FieldByName('un_medida').AsString;
        sqlInsertiNfi.ParamByName('vl_unitario').AsCurrency := cdsEntrada.FieldByName('vl_unitario').AsCurrency;
        if edtValorFrete.Text > '0,00' then
        begin
          vlFreteRateado := (StrToCurr(edtValorFrete.Text) / soma);
          sqlInsertiNfi.ParamByName('vl_frete_rateado').AsCurrency := vlFreteRateado;
        end
        else
        begin
          sqlInsertiNfi.ParamByName('vl_frete_rateado').AsCurrency := 0;
        end;
        if edtValorDesconto.Text > '0,00' then
        begin
          vlDescontoRateado := (StrToCurr(edtValorDesconto.Text) / soma);
          sqlInsertiNfi.ParamByName('vl_desconto_rateado').AsCurrency := vlDescontoRateado;
        end
        else
        begin
          sqlInsertiNfi.ParamByName('vl_desconto_rateado').AsCurrency := 0;
        end;
        if edtValorAcrescimo.Text > '0,00' then
        begin
          vlAcrescimoRateado := (StrToCurr(edtValorAcrescimo.Text) / soma);
          sqlInsertiNfi.ParamByName('vl_acrescimo_rateado').AsCurrency := vlAcrescimoRateado;
        end
        else
        begin
          sqlInsertiNfi.ParamByName('vl_acrescimo_rateado').AsCurrency := 0;
        end;
        sqlInsertiNfi.ParamByName('seq_item_nfi').AsInteger := cdsEntrada.FieldByName('seq_item_nfi').AsInteger;
        sqlInsertiNfi.ParamByName('icms_vl_base').AsCurrency := cdsEntrada.FieldByName('icms_vl_base').AsCurrency;
        sqlInsertiNfi.ParamByName('icms_pc_aliq').AsFloat := cdsEntrada.FieldByName('icms_pc_aliq').AsFloat;
        sqlInsertiNfi.ParamByName('icms_valor').AsCurrency := cdsEntrada.FieldByName('icms_valor').AsCurrency;
        sqlInsertiNfi.ParamByName('ipi_vl_base').AsCurrency := cdsEntrada.FieldByName('ipi_vl_base').AsCurrency;
        sqlInsertiNfi.ParamByName('ipi_pc_aliq').AsFloat := cdsEntrada.FieldByName('ipi_pc_aliq').AsFloat;
        sqlInsertiNfi.ParamByName('ipi_valor').AsFloat := cdsEntrada.FieldByName('ipi_valor').AsCurrency;
        sqlInsertiNfi.ParamByName('pis_cofins_vl_base').AsCurrency := cdsEntrada.FieldByName('pis_cofins_vl_base').AsCurrency;
        sqlInsertiNfi.ParamByName('pis_cofins_pc_aliq').AsFloat := cdsEntrada.FieldByName('pis_cofins_pc_aliq').AsFloat;
        sqlInsertiNfi.ParamByName('pis_cofins_valor').AsCurrency := cdsEntrada.FieldByName('pis_cofins_valor').AsCurrency;

        cdsEntrada.Next;
      end;
    end;

      //atualiza a quantidade em estoque
      atualizaEstoqueProduto;

      sqlInsert.ExecSQL;
      sqlInsertiNfi.ExecSQL;
      frmConexao.conexao.Commit;
      ShowMessage('Nota gravada com sucesso!');
      sqlInsert.Close;
      sqlInsertiNfi.Close;
      limpaCampos; //verificar que n�o est� limpando o grid
  except
    on E : exception do
      begin
        frmConexao.conexao.Rollback;
        ShowMessage('Erro ao gravar os dados da nota ' + edtNroNota.Text + E.Message);
        Exit;
      end;
  end;
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
  begin
   Exit;
  end;

  valor := (StrToCurr(edtQuantidade.Text) * StrToCurr(edtValorUnitario.Text));
  edtValorTotalProduto.Text := CurrToStr(valor);
end;

procedure TfrmLancamentoNotaEntrada.DBGridProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    if (Application.MessageBox('Deseja realmente Excluir?','Aten��o', MB_YESNO) = IDYES) then
    begin
      cdsEntrada.Delete;
      edtCodProduto.SetFocus;
      seq := seq - 1;
    end;
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtValorAcrescimoExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.edtValorDescontoExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.edtValorFreteExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.edtValorIPIExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.edtValorOutrasDespesasExit(Sender: TObject);
begin
  valorTotalNota;
end;

procedure TfrmLancamentoNotaEntrada.edtValorUnitarioChange(Sender: TObject);
begin
  calculaValorTotalItem;
end;


procedure TfrmLancamentoNotaEntrada.validaValoresNota;
var vlTotalItens : Double;
begin
  vlTotalItens := 0;

  with cdsEntrada do
  begin
    cdsEntrada.DisableControls;
    cdsEntrada.First;
    while not cdsEntrada.Eof do
    begin
      vlTotalItens := (vlTotalItens + cdsEntrada.FieldByName('vl_total').AsCurrency);
      cdsEntrada.Next;
    end;
    cdsEntrada.EnableControls;
  end;

  if (vlTotalItens <> StrToFloat(edtVlProduto.Text)) then
  begin
    raise Exception.Create(' O valor total dos itens n�o fecha com o valor total da nota! Verifique');
  end;

end;

procedure TfrmLancamentoNotaEntrada.valorTotalNota;
//calcula o valor total da nota
var vlTotal, vlServico, vlProduto, vlFrete, vlIpi, vlDesconto, vlAcrescimo, vlOutrasDespesas : Currency;
begin
  vlServico := StrToCurr(edtVlServico.Text);
  vlProduto := StrToCurr(edtVlProduto.Text);
  vlFrete := StrToCurr(edtValorFrete.Text);
  vlIpi := StrToCurr(edtValorIPI.Text);
  vlDesconto := StrToCurr(edtValorDesconto.Text);
  vlAcrescimo := StrToCurr(edtValorAcrescimo.Text);
  vlOutrasDespesas := StrToCurr(edtValorOutrasDespesas.Text);

  if vlServico > 0 then
  begin
    vlTotal := 0;
    vlTotal := vlTotal + vlServico;
    edtValorTotalNota.Text := CurrToStr(vlTotal);
  end
  else if vlProduto > 0 then
  begin
    vlTotal := 0;
    vlTotal := (vlTotal + vlProduto + vlFrete + vlIpi + vlAcrescimo + vlOutrasDespesas) - vlDesconto;
    edtValorTotalNota.Text := CurrToStr(vlTotal);
  end;

end;


end.