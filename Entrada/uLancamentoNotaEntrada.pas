unit uLancamentoNotaEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, System.UITypes, uclValidacoesEntrada, uDataModule, uUtil;

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
    cdsEntradaid_item: TLargeintField;
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
  private
    FIdGeralNFC: Integer;
    FEdicaoItem: Boolean;
    FIdGeralNFI: Integer;
    FRegras: TValidacoesEntrada;
    { Private declarations }
    procedure validaValoresNota;
    procedure limpaCampos;
    procedure InsereWmsMvto;
    procedure AtualizaEstoque;
    procedure LancaFinanceiro;
    procedure SetIdGeralNFC(const Value: Integer);
    procedure CarregaItensEdicao;
    procedure SetEdicaoItem(const Value: Boolean);
    procedure SetIdGeralNFI(const Value: Integer);
  public
    { Public declarations }
    property IdGeralNFC: Integer read FIdGeralNFC write SetIdGeralNFC;
    property EdicaoItem: Boolean read FEdicaoItem write SetEdicaoItem;
    property IdGeralNFI: Integer read FIdGeralNFI write SetIdGeralNFI;
  end;

var
  frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada;
  seq : Integer = 1; //sequencia dos itens lançados na nota
  aliqIcms, aliqIpi, aliqPisCofins : Double; //guardar as aliquotas dos itens e mostrar no grid

implementation

uses
  uGerador, uLogin;

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
  cliente: TValidacoesEntrada;
  resposta : Boolean;
begin
  if edtCdFornecedor.Text = EmptyStr then
  begin
    ShowMessage('Informe um Fornecedor');
    edtCdFornecedor.SetFocus;
    Exit;
  end;

  cliente := TValidacoesEntrada.Create;
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

  sqlCabecalho.ParamByName('cd_produto').AsString := edtCodProduto.Text;
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
  FRegras := TValidacoesEntrada.Create;

  try
    if (Trim(edtCodProduto.Text) = '') and (cdsEntrada.RecordCount > 0) then
    begin
      btnConfirmar.SetFocus;
      Exit;
    end;

    if (edtCodProduto.Text = '') and (cdsEntrada.IsEmpty) then
    begin
      ShowMessage('Informe um Produto.');
      edtCodProduto.SetFocus;
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
                              '    pt.id_item = :id_item';
    sqlCabecalho.ParamByName('id_item').AsLargeInt := FRegras.GetIdItem(edtCodProduto.Text);
    sqlCabecalho.Open();

    if sqlCabecalho.IsEmpty then
    begin
      ShowMessage('Produto não Encontrado');
      edtFatorConversao.Clear;
      Exit;
    end;

    aliqIcms := sqlCabecalho.FieldByName('aliquota_icms').AsFloat;
    aliqIpi := sqlCabecalho.FieldByName('aliquota_ipi').AsFloat;
    aliqPisCofins := sqlCabecalho.FieldByName('aliquota_pis_cofins').AsFloat;
  finally
    FRegras.Free;
  end;
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
    if (Application.MessageBox('Modelo não Encontrado', 'Atenção', MB_OK) = IDOK) then
    begin
      edtModelo.SetFocus;
      edtNomeModelo.Clear;
    end;
  end;
end;


procedure TfrmLancamentoNotaEntrada.edtNroNotaExit(Sender: TObject);
Var nrNota, fornecedor : Integer;
    serie : String;
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

procedure TfrmLancamentoNotaEntrada.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (edtNroNota.Text <> '') or (cdsEntrada.RecordCount > 0) then
  begin
    CanClose := False;
    if (Application.MessageBox('Deseja Cancelar o lançamento da Nota?','Atenção', MB_YESNO) = IDYES) then
      CanClose := True;
  end;
end;

procedure TfrmLancamentoNotaEntrada.FormCreate(Sender: TObject);
begin
  edtDataEmissao.Date := now;
  edtDataRecebimento.Date := now;
  edtDataLancamento.Date := now;
  seq := 1;
  EdicaoItem := False;
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
  cdsEntrada.EmptyDataSet;
  seq := 1;
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

procedure TfrmLancamentoNotaEntrada.InsereWmsMvto;
const
  SQL_INSERT =  'insert into ' +
                'wms_mvto_estoque(id_geral, '+
                'id_endereco_produto, '+
                'id_item, ' +
                'qt_estoque, ' +
                'un_estoque, ' +
                'fl_entrada_saida) values '+
                '(:id_geral, ' +
                ':id_endereco_produto, '+
                ':id_item, ' +
                ':qt_estoque, ' +
                ':un_estoque, ' +
                ':fl_entrada_saida)';

  SQL_SELECT = 'select ' +
               '   id_geral ' +
               'from        ' +
               '   wms_endereco_produto w    ' +
               'where                        ' +
               '   id_item = :id_item  ' +
               '   and ordem = (             ' +
               '   select                    ' +
               '       min(ordem)            ' +
               '   from                      ' +
               '       wms_endereco_produto wep ' +
               '   where                        ' +
               '       id_item = :id_item)';
var
  qry, qrySelect: TFDQuery;
  IdGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qrySelect := TFDQuery.Create(Self);
  qrySelect.Connection := dm.conexaoBanco;
  IdGeral := TGerador.Create;
  qry.Connection.StartTransaction;

  try
    try
      cdsEntrada.Loop(
      procedure
      begin
        qrySelect.SQL.Clear;
        qrySelect.SQL.Add(SQL_SELECT);
        qrySelect.ParamByName('id_item').AsLargeInt := cdsEntrada.FieldByName('id_item').AsLargeInt;
        qrySelect.Open(SQL_SELECT);

        qry.SQL.Clear;
        qry.SQL.Add(SQL_INSERT);
        qry.ParamByName('id_geral').AsFloat := IdGeral.GeraIdGeral;
        qry.ParamByName('id_endereco_produto').AsInteger := qrySelect.FieldByName('id_geral').AsInteger;
        qry.ParamByName('id_item').AsLargeInt := cdsEntrada.FieldByName('id_item').AsLargeInt;
        qry.ParamByName('qt_estoque').AsFloat := cdsEntrada.FieldByName('qtd_estoque').AsFloat;
        qry.ParamByName('un_estoque').AsString := cdsEntrada.FieldByName('un_medida').AsString;
        qry.ParamByName('fl_entrada_saida').AsString := 'E';

        qry.ExecSQL;
      end
      );
    except
      on e:Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ' + E.Message);
      end;
    end;

    qry.Connection.Commit;
  finally
    qry.Connection.Rollback;
    qry.Free;
    qrySelect.Free;
    FreeAndNil(IdGeral);
    cdsEntrada.EnableControls
  end;
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
      qry.Connection.Commit;
    except
      on E : exception do
      begin
        msg := 'Erro ao gravar o financeiro da nota fiscal '
               + edtNroNota.Text + E.Message;
        qry.Connection.Rollback;
        ShowMessage(msg);
        Exit;
      end;
    end;
  finally
    qry.Free;
    idGeral.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.AtualizaEstoque;
const
  SQL_UPDATE = 'update '+
                    'wms_estoque '+
              'set '+
                    'qt_estoque = :qt_estoque '+
              'where id_wms_endereco_produto = :id';

  SQL = 'select ' +
            'qt_estoque, ' +
            'id_wms_endereco_produto ' +
        'from ' +
            'wms_estoque ' +
        'where ' +
            'id_item = :id_item';
var
  qry: TFDQuery;
  qtdade, qttotal: Double;
  id: Int64;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      cdsEntrada.Loop(
      procedure
      begin
        qry.SQL.Clear;
        qry.SQL.Add(SQL);
        qry.ParamByName('id_item').AsLargeInt := cdsEntrada.FieldByName('id_item').AsLargeInt;
        qry.Open(SQL);
        id := qry.FieldByName('id_wms_endereco_produto').AsInteger;
        qtdade := qry.FieldByName('qt_estoque').AsFloat;//quantidade no banco
        qttotal := qtdade + cdsEntrada.FieldByName('qtd_total').AsInteger;

        qry.SQL.Clear;

        qry.SQL.Add(SQL_UPDATE);
        qry.ParamByName('id').AsInteger := id;
        qry.ParamByName('qt_estoque').AsFloat := qttotal;

        qry.ExecSQL;
      end
      );

      qry.Connection.Commit;
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados do produto ' + cdsEntrada.FieldByName('cd_produto').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
    cdsEntrada.EnableControls;
  end;
end;

procedure TfrmLancamentoNotaEntrada.btnAddItensClick(Sender: TObject);
begin
  FRegras := TValidacoesEntrada.Create;
  try
    if EdicaoItem then
    begin
      try
        cdsEntrada.Edit;
        cdsEntrada.FieldByName('seq_item_nfi').AsInteger := seq;
        cdsEntrada.FieldByName('cd_produto').AsString := edtCodProduto.Text;
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
        cdsEntrada.FieldByName('id_item').AsLargeInt := FRegras.GetIdItem(edtCodProduto.Text);
        cdsEntrada.Post;
      finally
        EdicaoItem := False;
      end;
    end
    else
    begin
      try
        cdsEntrada.Append;
        cdsEntrada.FieldByName('seq_item_nfi').AsInteger := seq;
        cdsEntrada.FieldByName('cd_produto').AsString := edtCodProduto.Text;
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
        cdsEntrada.FieldByName('id_item').AsLargeInt := FRegras.GetIdItem(edtCodProduto.Text);
        cdsEntrada.Post;
      finally
        EdicaoItem := False;
      end;
    end;
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
    FRegras.Free;
  end;
end;

procedure TfrmLancamentoNotaEntrada.btnCancelarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Cancelar o Lançamento?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmLancamentoNotaEntrada.btnConfirmarClick(Sender: TObject);
const
  SQL_INSERT_NFC =  'insert                 '+
                '    into                   '+
                '    nfc (id_geral,         '+
                '    dcto_numero,           '+
                '    serie,                 '+
                '    cd_fornecedor,         '+
                '    dt_emissao,            '+
                '    dt_recebimento,        '+
                '    dt_lancamento,         '+
                '    cd_operacao,           '+
                '    cd_modelo,             '+
                '    valor_servico,         '+
                '    valor_produto,         '+
                '    vl_base_icms,          '+
                '    valor_icms,            '+
                '    valor_frete,           '+
                '    valor_ipi,             '+
                '    valor_iss,             '+
                '    valor_desconto,        '+
                '    valor_acrescimo,       '+
                '    valor_outras_despesas, '+
                '    valor_total_nota)      '+
                'values(:id_geral,          '+
                '    :dcto_numero,          '+
                '    :serie,                '+
                '    :cd_fornecedor,        '+
                '    :dt_emissao,           '+
                '    :dt_recebimento,       '+
                '    :dt_lancamento,        '+
                '    :cd_operacao,          '+
                '    :cd_modelo,            '+
                '    :valor_servico,        '+
                '    :valor_produto,        '+
                '    :vl_base_icms,         '+
                '    :valor_icms,           '+
                '    :valor_frete,          '+
                '    :valor_ipi,            '+
                '    :valor_iss,            '+
                '    :valor_desconto,       '+
                '    :valor_acrescimo,      '+
                '    :valor_outras_despesas,'+
                '    :valor_total_nota)' ;

  SQL_INSERT_NFI = 'insert                   '+
                  '    into                  '+
                  '    nfi (id_geral,        '+
                  '    id_nfc,               '+
                  '    id_item,              '+
                  '    qtd_estoque,          '+
                  '    icms_vl_base,         '+
                  '    icms_pc_aliq,         '+
                  '    icms_valor,           '+
                  '    ipi_vl_base,          '+
                  '    ipi_pc_aliq,          '+
                  '    ipi_valor,            '+
                  '    pis_cofins_vl_base,   '+
                  '    pis_cofins_pc_aliq,   '+
                  '    pis_cofins_valor,     '+
                  '    un_medida,            '+
                  '    vl_unitario,          '+
                  '    vl_frete_rateado,     '+
                  '    vl_desconto_rateado,  '+
                  '    vl_acrescimo_rateado, '+
                  '    seq_item_nfi)         '+
                  'values(:id_geral,         '+
                  '    :id_nfc,              '+
                  '    :id_item,             '+
                  '    :qtd_estoque,         '+
                  '    :icms_vl_base,        '+
                  '    :icms_pc_aliq,        '+
                  '    :icms_valor,          '+
                  '    :ipi_vl_base,         '+
                  '    :ipi_pc_aliq,         '+
                  '    :ipi_valor,           '+
                  '    :pis_cofins_vl_base,  '+
                  '    :pis_cofins_pc_aliq,  '+
                  '    :pis_cofins_valor,    '+
                  '    :un_medida,           '+
                  '    :vl_unitario,         '+
                  '    :vl_frete_rateado,    '+
                  '    :vl_desconto_rateado, '+
                  '    :vl_acrescimo_rateado,'+
                  '    :seq_item_nfi)';

var
  vlIcmsRateado,
  vlIpiRateado,
  vlIssRateado,
  vlFreteRateado,
  vlDescontoRateado,
  vlAcrescimoRateado,
  soma,
  qtdade,
  qtTotal: Currency;
  qry, qryItens: TFDQuery;
  geraIdGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qryItens := TFDQuery.Create(Self);
  qryItens.Connection := dm.conexaoBanco;
  qryItens.Connection.StartTransaction;
  geraIdGeral := TGerador.Create;
  try
    try
      validaValoresNota;
      IdGeralNFC := geraIdGeral.GeraIdGeral;

      qry.SQL.Add(SQL_INSERT_NFC);
      qry.ParamByName('id_geral').AsInteger := IdGeralNFC;
      qry.ParamByName('dcto_numero').AsInteger := StrToInt(edtNroNota.Text);
      qry.ParamByName('serie').AsString := edtSerie.Text;
      qry.ParamByName('cd_fornecedor').AsInteger := StrToInt(edtCdFornecedor.Text);
      qry.ParamByName('dt_emissao').AsDate := edtDataEmissao.Date;
      qry.ParamByName('dt_recebimento').AsDate := edtDataRecebimento.Date;
      qry.ParamByName('dt_lancamento').AsDate := edtDataLancamento.Date;
      qry.ParamByName('cd_operacao').AsInteger := StrToInt(edtOperacao.Text);
      qry.ParamByName('cd_modelo').AsString := edtModelo.Text;
      qry.ParamByName('valor_servico').AsCurrency := StrToCurr(edtVlServico.Text);
      qry.ParamByName('valor_produto').AsCurrency := StrToCurr(edtVlProduto.Text);
      qry.ParamByName('vl_base_icms').AsCurrency := StrToCurr(edtBaseIcms.Text);
      qry.ParamByName('valor_icms').AsCurrency := StrToCurr(edtValorIcms.Text);
      qry.ParamByName('valor_frete').AsCurrency := StrToCurr(edtValorFrete.Text);
      qry.ParamByName('valor_ipi').AsCurrency := StrToCurr(edtValorIPI.Text);
      qry.ParamByName('valor_iss').AsCurrency := StrToCurr(edtValorISS.Text);
      qry.ParamByName('valor_desconto').AsCurrency := StrToCurr(edtValorDesconto.Text);
      qry.ParamByName('valor_acrescimo').AsCurrency := StrToCurr(edtValorAcrescimo.Text);
      qry.ParamByName('valor_outras_despesas').AsCurrency := StrToCurr(edtValorOutrasDespesas.Text);
      qry.ParamByName('valor_total_nota').AsCurrency := StrToCurr(edtValorTotalNota.Text);
      qry.ExecSQL;

      //soma a quantidade dos itens de todos os produtos lançados
      soma := 0;
      cdsEntrada.Loop(
      procedure
      begin
        soma := soma + cdsEntrada.FieldByName('qtd_total').AsCurrency;
      end
      );

      //insert nfi
      qryItens.SQL.Add(SQL_INSERT_NFI);
      cdsEntrada.Loop(
      procedure
      begin
        IdGeralNFI := geraIdGeral.GeraIdGeral;

        qryItens.ParamByName('id_geral').AsInteger := IdGeralNFI;
        qryItens.ParamByName('id_nfc').AsInteger := IdGeralNFC;
        qryItens.ParamByName('id_item').AsLargeInt := cdsEntrada.FieldByName('id_item').AsLargeInt;
        qryItens.ParamByName('qtd_estoque').AsCurrency := cdsEntrada.FieldByName('qtd_estoque').AsCurrency;
        qryItens.ParamByName('un_medida').AsString := cdsEntrada.FieldByName('un_medida').AsString;
        qryItens.ParamByName('vl_unitario').AsCurrency := cdsEntrada.FieldByName('vl_unitario').AsCurrency;
        if edtValorFrete.Text > '0,00' then
        begin
          vlFreteRateado := (StrToCurr(edtValorFrete.Text) / soma);
          qryItens.ParamByName('vl_frete_rateado').AsCurrency := vlFreteRateado;
        end
        else
          qryItens.ParamByName('vl_frete_rateado').AsCurrency := 0;
        if edtValorDesconto.Text > '0,00' then
        begin
          vlDescontoRateado := (StrToCurr(edtValorDesconto.Text) / soma);
          qryItens.ParamByName('vl_desconto_rateado').AsCurrency := vlDescontoRateado;
        end
        else
          qryItens.ParamByName('vl_desconto_rateado').AsCurrency := 0;
        if edtValorAcrescimo.Text > '0,00' then
        begin
          vlAcrescimoRateado := (StrToCurr(edtValorAcrescimo.Text) / soma);
          qryItens.ParamByName('vl_acrescimo_rateado').AsCurrency := vlAcrescimoRateado;
        end
        else
          qryItens.ParamByName('vl_acrescimo_rateado').AsCurrency := 0;

        qryItens.ParamByName('seq_item_nfi').AsInteger := cdsEntrada.FieldByName('seq_item_nfi').AsInteger;
        qryItens.ParamByName('icms_vl_base').AsCurrency := cdsEntrada.FieldByName('icms_vl_base').AsCurrency;
        qryItens.ParamByName('icms_pc_aliq').AsFloat := cdsEntrada.FieldByName('icms_pc_aliq').AsFloat;
        qryItens.ParamByName('icms_valor').AsCurrency := cdsEntrada.FieldByName('icms_valor').AsCurrency;
        qryItens.ParamByName('ipi_vl_base').AsCurrency := cdsEntrada.FieldByName('ipi_vl_base').AsCurrency;
        qryItens.ParamByName('ipi_pc_aliq').AsFloat := cdsEntrada.FieldByName('ipi_pc_aliq').AsFloat;
        qryItens.ParamByName('ipi_valor').AsFloat := cdsEntrada.FieldByName('ipi_valor').AsCurrency;
        qryItens.ParamByName('pis_cofins_vl_base').AsCurrency := cdsEntrada.FieldByName('pis_cofins_vl_base').AsCurrency;
        qryItens.ParamByName('pis_cofins_pc_aliq').AsFloat := cdsEntrada.FieldByName('pis_cofins_pc_aliq').AsFloat;
        qryItens.ParamByName('pis_cofins_valor').AsCurrency := cdsEntrada.FieldByName('pis_cofins_valor').AsCurrency;
        qryItens.ExecSQL;
      end
      );

      qry.Connection.Commit;
      qryItens.Connection.Commit;
      //insere na wms_mvto e atualiza a quantidade em estoque
      InsereWmsMvto;
      AtualizaEstoque;
      LancaFinanceiro;

      ShowMessage('Nota gravada com sucesso!');
      limpaCampos; //verificar que não está limpando o grid
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        qryItens.Connection.Rollback;
        ShowMessage('Erro ao gravar os dados da nota ' + edtNroNota.Text + E.Message);
        Exit;
      end;
    end;
  finally
    qry.Free;
    FreeAndNil(geraIdGeral);
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
    Exit;

  valor := (StrToCurr(edtQuantidade.Text) * StrToCurr(edtValorUnitario.Text));
  edtValorTotalProduto.Text := CurrToStr(valor);
end;

procedure TfrmLancamentoNotaEntrada.CarregaItensEdicao;
begin
  edtCodProduto.Text := cdsEntrada.FieldByName('cd_produto').AsString;
  edtDescricaoProduto.Text := cdsEntrada.FieldByName('descricao').AsString;
  edtUnMedida.Text := cdsEntrada.FieldByName('un_medida').AsString;
  edtQuantidade.Text := cdsEntrada.FieldByName('qtd_estoque').AsString;
  edtFatorConversao.Text := cdsEntrada.FieldByName('fator_conversao').AsString;
  edtQuantidadeTotalProduto.Text := cdsEntrada.FieldByName('qtd_total').AsString;
  edtValorUnitario.Text := cdsEntrada.FieldByName('vl_unitario').AsString;
  edtValorTotalProduto.Text := cdsEntrada.FieldByName('vl_total').AsString;
  EdicaoItem := True;
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
    edtValorTotalNota.Text := CurrToStr(vlTotal);
  end;
end;

end.
