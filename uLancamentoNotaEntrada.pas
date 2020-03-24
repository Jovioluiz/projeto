unit uLancamentoNotaEntrada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient;

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
    Label11: TLabel;
    Label12: TLabel;
    edtVlServico: TEdit;
    edtVlProduto: TEdit;
    edtBaseIcms: TEdit;
    edtAliqIcms: TEdit;
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
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    FDQuery1: TFDQuery;
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
    procedure edtAliqIcmsExit(Sender: TObject);
    procedure edtValorFreteExit(Sender: TObject);
    procedure valorTotalNota();
    procedure edtValorIPIExit(Sender: TObject);
    procedure edtValorDescontoExit(Sender: TObject);
    procedure edtValorAcrescimoExit(Sender: TObject);
    procedure edtValorOutrasDespesasExit(Sender: TObject);
    procedure edtCodProdutoEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada;

implementation

{$R *.dfm}

//busca o fornecedor/cliente
procedure TfrmLancamentoNotaEntrada.edtCdFornecedorChange(Sender: TObject);
begin
if edtCdFornecedor.Text = EmptyStr then
  begin
    edtCdFornecedor.Clear;
    exit;
  end;

  sqlCabecalho.Close;
  sqlCabecalho.SQL.Text := 'select                        '+
                              'cd_cliente,                '+
                              'nome                       '+
                            'from                         '+
                               'cliente c2                '+
                            'where                        '+
                                'cd_cliente = :cd_cliente';
  sqlCabecalho.ParamByName('cd_cliente').AsInteger := StrToInt(edtCdFornecedor.Text);
  sqlCabecalho.Open();
  edtNomeFornecedor.Text := sqlCabecalho.FieldByName('nome').AsString;
end;


procedure TfrmLancamentoNotaEntrada.edtCdFornecedorExit(Sender: TObject);
begin
  if sqlCabecalho.IsEmpty then
    begin
      if (Application.MessageBox('Fornecedor/Cliente não Encontrado', 'Atenção', MB_OK) = IDOK) then
        begin
          edtCdFornecedor.SetFocus;
          edtNomeFornecedor.Clear;
        end;
    end;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoChange(Sender: TObject);
begin
  if edtCodProduto.Text = EmptyStr then
    begin
      edtDescricaoProduto.Clear;
      edtUnMedida.Clear;
      edtFatorConversao.Clear;
      exit;
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
  edtVlServico.Enabled := false;
  edtVlProduto.Enabled := false;
  edtBaseIcms.Enabled := false;
  edtAliqIcms.Enabled := false;
  edtValorIcms.Enabled := false;
  edtValorFrete.Enabled := false;
  edtValorIPI.Enabled := false;
  edtValorISS.Enabled := false;
  edtValorDesconto.Enabled := false;
  edtValorAcrescimo.Enabled := false;
  edtValorOutrasDespesas.Enabled := false;
end;

procedure TfrmLancamentoNotaEntrada.edtCodProdutoExit(Sender: TObject);
begin
 if sqlCabecalho.IsEmpty then
  begin
    ShowMessage('Produto não Encontrado');
    edtFatorConversao.Clear;
    edtCodProduto.SetFocus;
  end;

end;

//busca o modelo da nota
procedure TfrmLancamentoNotaEntrada.edtModeloChange(Sender: TObject);
begin
  if edtModelo.Text = EmptyStr then
    begin
      edtNomeModelo.Clear;
      exit;
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

//valida se já possui cadastrada uma nota com o mesmo número, mesmo fornecedor e série
procedure TfrmLancamentoNotaEntrada.edtNroNotaExit(Sender: TObject);
Var nr_nota, fornecedor, serie : Integer;
begin
  if edtNroNota.Text = EmptyStr then
    begin
      ShowMessage('Número da Nota não pode ser Vazio');
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
      sqlCabecalho.ParamByName('serie').AsInteger := StrToInt(edtSerie.Text);
      sqlCabecalho.Open();
      nr_nota := sqlCabecalho.FieldByName('dcto_numero').AsInteger;
      fornecedor := sqlCabecalho.FieldByName('cd_fornecedor').AsInteger;
      serie := sqlCabecalho.FieldByName('serie').AsInteger;
        if (IntToStr(nr_nota) = edtNroNota.Text) and (IntToStr(fornecedor) = edtCdFornecedor.Text) and (IntToStr(serie) = edtSerie.Text) then
          begin
            ShowMessage('Número da nota já cadastrada no sistema');
            edtNroNota.SetFocus;
          end;
    end;

end;

//busca a operação da nota e modelo caso possua alguma vinculada
procedure TfrmLancamentoNotaEntrada.edtOperacaoChange(Sender: TObject);
begin
if ((edtOperacao.Text = EmptyStr) and (edtModelo.Text = EmptyStr)) then
  begin
    edtNomeOperacao.Clear;
    edtNomeModelo.Clear;
    exit;
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
  if sqlCabecalho.IsEmpty then
    begin
    if (Application.MessageBox('Operação não encontrado','Atenção', MB_OK) = idOK) then
       begin
        edtOperacao.SetFocus;
        edtNomeOperacao.Clear;
        edtModelo.Clear;
        edtNomeModelo.Clear;
       end;
    end;
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
     begin
      edtSerie.SetFocus;
     end;
  end;

end;

//valida se foi informado valor de serviço ou produto ou os dois
procedure TfrmLancamentoNotaEntrada.edtVlProdutoExit(Sender: TObject);
begin
 if (edtVlServico.Text = '0,00') and (edtVlProduto.Text = '0,00') then
  begin
    ShowMessage('Valor de Serviço ou Produto não pode ser igual a 0');
    edtVlServico.SetFocus;
  end
 else if (edtVlServico.Text > '0,00') and (edtVlProduto.Text > '0,00') then
  begin
    ShowMessage('Não pode ser lançado valores de serviços e produtos na mesma nota!');
    edtVlServico.SetFocus;
  end
 else
  begin
    valorTotalNota();
  end;
end;

procedure TfrmLancamentoNotaEntrada.edtVlServicoExit(Sender: TObject);
begin
  valorTotalNota();
end;

procedure TfrmLancamentoNotaEntrada.FormCreate(Sender: TObject);
begin
edtDataEmissao.Date := now;
edtDataRecebimento.Date := now;
edtDataLancamento.Date := now;
end;


procedure TfrmLancamentoNotaEntrada.edtAliqIcmsExit(Sender: TObject);
var base_icms, aliq_icms, vl_icms : Currency;
begin
  if edtBaseIcms.Text > '0,00' then
    begin
      base_icms := StrToCurr(edtBaseIcms.Text);
      aliq_icms := StrToCurr(edtAliqIcms.Text);
      vl_icms := (base_icms * aliq_icms) / 100;
      edtValorIcms.Text := FormatCurr('#,,.00', vl_icms);//formata para duas casas decimais após virgula
    end;
end;

procedure TfrmLancamentoNotaEntrada.edtValorAcrescimoExit(Sender: TObject);
begin
  valorTotalNota();
end;

procedure TfrmLancamentoNotaEntrada.edtValorDescontoExit(Sender: TObject);
begin
  valorTotalNota();
end;

procedure TfrmLancamentoNotaEntrada.edtValorFreteExit(Sender: TObject);
begin
  valorTotalNota();
end;

procedure TfrmLancamentoNotaEntrada.edtValorIPIExit(Sender: TObject);
begin
  valorTotalNota();
end;

procedure TfrmLancamentoNotaEntrada.edtValorOutrasDespesasExit(Sender: TObject);
begin
  valorTotalNota();
end;

//calcula o valor total da nota
procedure TfrmLancamentoNotaEntrada.valorTotalNota();
var vl_total, vl_servico, vl_produto, vl_frete, vl_ipi, vl_desconto, vl_acrescimo, vl_outras_despesas : Currency;
begin
 vl_servico := StrToCurr(edtVlServico.Text);
 vl_produto := StrToCurr(edtVlProduto.Text);
 vl_frete := StrToCurr(edtValorFrete.Text);
 vl_ipi := StrToCurr(edtValorIPI.Text);
 vl_desconto := StrToCurr(edtValorDesconto.Text);
 vl_acrescimo := StrToCurr(edtValorAcrescimo.Text);
 vl_outras_despesas := StrToCurr(edtValorOutrasDespesas.Text);

 if vl_servico > 0 then
  begin
    vl_total := 0;
    vl_total := vl_total + vl_servico;
    edtValorTotalNota.Text := FormatCurr('#,,.00', vl_total);//formata para duas casas decimais após virgula
  end
 else if vl_produto > 0 then
  begin
    vl_total := 0;
    vl_total := (vl_total + vl_produto + vl_frete + vl_ipi + vl_acrescimo + vl_outras_despesas) - vl_desconto;
    edtValorTotalNota.Text := FormatCurr('#,,.00', vl_total);//formata para duas casas decimais após virgula
  end;

end;


end.
