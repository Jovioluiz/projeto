unit uclNotaEntrada;

interface

uses uDataModule, Data.DB, FireDAC.Stan.Param, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, dNotaEntrada;

type TNotaEntrada = class
  private
    FDadosNota: TdmNotaEntrada;
    procedure SetDadosNota(const Value: TdmNotaEntrada);

  public
    function BuscaClienteFornecedor(CodCliente: Integer): Boolean;
    function GetIdItem(CdItem: string): Int64;
    function Pesquisar(CodItem: string): Boolean;
    function GravaCabecalho(Conexao: TFDConnection): Boolean;
    function GravaItens(Conexao: TFDConnection): Boolean;

    constructor Create;
    destructor Destroy; override;

    property DadosNota: TdmNotaEntrada read FDadosNota write SetDadosNota;
end;

implementation

uses
  System.SysUtils, Vcl.Dialogs, uUtil;

{ TValidacoesEntrada }

function TNotaEntrada.BuscaClienteFornecedor(CodCliente: Integer): Boolean;
const
  sql = 'select                       '+
          'cd_cliente,                '+
          'nome                       '+
        'from                         '+
           'cliente c2                '+
        'where                        '+
            'cd_cliente = :cd_cliente';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql);
    qry.ParamByName('cd_cliente').AsInteger := CodCliente;
    qry.Open(sql);

    Result := qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

constructor TNotaEntrada.Create;
begin
  FDadosNota := TdmNotaEntrada.Create(nil);
end;

destructor TNotaEntrada.Destroy;
begin
  FDadosNota.Free;
  inherited;
end;

function TNotaEntrada.GetIdItem(CdItem: string): Int64;
const
  SQL = 'select id_item from produto where cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_produto').AsString := CdItem;
    qry.Open();

    Result := qry.FieldByName('id_item').AsLargeInt;

  finally
    qry.Free;
  end;
end;

function TNotaEntrada.GravaCabecalho(Conexao: TFDConnection): Boolean;
{$REGION 'SQL'}
const
    SQL_INSERT_NFC =  'insert               '+
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
                '    vl_base_icms,          '+
                '    valor_icms,            '+
                '    valor_frete,           '+
                '    valor_ipi,             '+
                '    valor_iss,             '+
                '    valor_desconto,        '+
                '    valor_acrescimo,       '+
                '    valor_outras_despesas, '+
                '    valor_total)           '+
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
                '    :vl_base_icms,         '+
                '    :valor_icms,           '+
                '    :valor_frete,          '+
                '    :valor_ipi,            '+
                '    :valor_iss,            '+
                '    :valor_desconto,       '+
                '    :valor_acrescimo,      '+
                '    :valor_outras_despesas,'+
                '    :valor_total)' ;
{$ENDREGION}
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := Conexao;

  try
    //try
      query.SQL.Add(SQL_INSERT_NFC);
      query.ParamByName('id_geral').AsLargeInt := DadosNota.cdsNfc.FieldByName('id_geral').AsLargeInt;
      query.ParamByName('dcto_numero').AsInteger := DadosNota.cdsNfc.FieldByName('dcto_numero').AsInteger;
      query.ParamByName('serie').AsString := DadosNota.cdsNfc.FieldByName('serie').AsString;
      query.ParamByName('cd_fornecedor').AsInteger := DadosNota.cdsNfc.FieldByName('cd_fornecedor').AsInteger;
      query.ParamByName('dt_emissao').AsDateTime := DadosNota.cdsNfc.FieldByName('dt_emissao').AsDateTime;
      query.ParamByName('dt_recebimento').AsDateTime := DadosNota.cdsNfc.FieldByName('dt_recebimento').AsDateTime;
      query.ParamByName('dt_lancamento').AsDateTime := DadosNota.cdsNfc.FieldByName('dt_lancamento').AsDateTime;
      query.ParamByName('cd_operacao').AsInteger := DadosNota.cdsNfc.FieldByName('cd_operacao').AsInteger;
      query.ParamByName('cd_modelo').AsString := DadosNota.cdsNfc.FieldByName('cd_modelo').AsString;
      query.ParamByName('valor_servico').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_servico').AsCurrency;
      query.ParamByName('vl_base_icms').AsCurrency := DadosNota.cdsNfc.FieldByName('vl_base_icms').AsCurrency;
      query.ParamByName('valor_icms').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_icms').AsCurrency;
      query.ParamByName('valor_frete').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_frete').AsCurrency;
      query.ParamByName('valor_ipi').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_ipi').AsCurrency;
      query.ParamByName('valor_iss').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_iss').AsCurrency;
      query.ParamByName('valor_desconto').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_desconto').AsCurrency;
      query.ParamByName('valor_acrescimo').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_acrescimo').AsCurrency;
      query.ParamByName('valor_outras_despesas').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_outras_despesas').AsCurrency;
      query.ParamByName('valor_total').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_total').AsCurrency;

      query.ExecSQL;
//      query.Connection.Commit;
      Result := True;
//    except on E : exception do
//      begin
////        query.Connection.Rollback;
//        raise Exception.Create('Erro ao gravar os dados do pedido ' + DadosNota.cdsNfc.FieldByName('dcto_numero').ToString + E.Message);
//      end;
//    end;
  finally
    query.Free;
  end;
end;

function TNotaEntrada.GravaItens(Conexao: TFDConnection): Boolean;
{$REGION 'SQL'}
const
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
                  '    seq_item_nfi,         '+
                  '    valor_total)          '+
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
                  '    :seq_item_nfi,        '+
                  '    :valor_total)';
{$ENDREGION}
var
  qtTotalItens: Double;
  qryItens: TFDQuery;
begin
  qryItens := TFDQuery.Create(nil);
  qryItens.Connection := Conexao;
  qtTotalItens := 0;

  try
    //try
      //soma a quantidade dos itens de todos os produtos lançados

      DadosNota.cdsNfi.Loop(
      procedure
      begin
        qtTotalItens := qtTotalItens + DadosNota.cdsNfi.FieldByName('qtd_total').AsFloat;
      end
      );

      //insert nfi
      qryItens.SQL.Add(SQL_INSERT_NFI);

      qryItens.ParamByName('id_geral').AsInteger := DadosNota.cdsNfi.FieldByName('id_geral').AsLargeInt;
      qryItens.ParamByName('id_nfc').AsInteger := DadosNota.cdsNfc.FieldByName('id_geral').AsLargeInt;
      qryItens.ParamByName('id_item').AsLargeInt := DadosNota.cdsNfi.FieldByName('id_item').AsLargeInt;
      qryItens.ParamByName('qtd_estoque').AsFloat := DadosNota.cdsNfi.FieldByName('qtd_estoque').AsFloat;
      qryItens.ParamByName('un_medida').AsString := DadosNota.cdsNfi.FieldByName('un_medida').AsString;
      qryItens.ParamByName('vl_unitario').AsCurrency := DadosNota.cdsNfi.FieldByName('vl_unitario').AsCurrency;

      if DadosNota.cdsNfc.FieldByName('valor_frete').AsCurrency > 0 then
        qryItens.ParamByName('vl_frete_rateado').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_frete').AsCurrency / qtTotalItens
      else
        qryItens.ParamByName('vl_frete_rateado').AsCurrency := 0;

      if DadosNota.cdsNfc.FieldByName('valor_desconto').AsCurrency > 0 then
        qryItens.ParamByName('vl_desconto_rateado').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_desconto').AsCurrency / qtTotalItens
      else
        qryItens.ParamByName('vl_desconto_rateado').AsCurrency := 0;

      if DadosNota.cdsNfc.FieldByName('valor_acrescimo').AsCurrency > 0 then
        qryItens.ParamByName('vl_acrescimo_rateado').AsCurrency := DadosNota.cdsNfc.FieldByName('valor_acrescimo').AsCurrency / qtTotalItens
      else
        qryItens.ParamByName('vl_acrescimo_rateado').AsCurrency := 0;

      qryItens.ParamByName('seq_item_nfi').AsInteger := DadosNota.cdsNfi.FieldByName('seq_item_nfi').AsInteger;
      qryItens.ParamByName('icms_vl_base').AsCurrency := DadosNota.cdsNfi.FieldByName('icms_vl_base').AsCurrency;
      qryItens.ParamByName('icms_pc_aliq').AsFloat := DadosNota.cdsNfi.FieldByName('icms_pc_aliq').AsFloat;
      qryItens.ParamByName('icms_valor').AsCurrency := DadosNota.cdsNfi.FieldByName('icms_valor').AsCurrency;
      qryItens.ParamByName('ipi_vl_base').AsCurrency := DadosNota.cdsNfi.FieldByName('ipi_vl_base').AsCurrency;
      qryItens.ParamByName('ipi_pc_aliq').AsFloat := DadosNota.cdsNfi.FieldByName('ipi_pc_aliq').AsFloat;
      qryItens.ParamByName('ipi_valor').AsFloat := DadosNota.cdsNfi.FieldByName('ipi_valor').AsCurrency;
      qryItens.ParamByName('pis_cofins_vl_base').AsCurrency := DadosNota.cdsNfi.FieldByName('pis_cofins_vl_base').AsCurrency;
      qryItens.ParamByName('pis_cofins_pc_aliq').AsFloat := DadosNota.cdsNfi.FieldByName('pis_cofins_pc_aliq').AsFloat;
      qryItens.ParamByName('pis_cofins_valor').AsCurrency := DadosNota.cdsNfi.FieldByName('pis_cofins_valor').AsCurrency;
      qryItens.ParamByName('valor_total').AsCurrency := DadosNota.cdsNfi.FieldByName('qtd_estoque').AsFloat * DadosNota.cdsNfi.FieldByName('vl_unitario').AsCurrency;
      qryItens.ExecSQL;

      Result := True;

//    except on E: Exception do
//      begin
////        query.Connection.Rollback;
//        raise Exception.Create('Erro ao gravar os itens do pedido ' + E.Message);
//      end;
//
//    end;
  finally
    qryItens.Free;
  end;
end;

function TNotaEntrada.Pesquisar(CodItem: string): Boolean;
const
  SQL = 'select 1 from produto where cd_produto = :cd_produto';
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := dm.conexaoBanco;

  try
    query.Open(SQL, [CodItem]);
    Result := not query.IsEmpty;
  finally
    query.Free;
  end;
end;

procedure TNotaEntrada.SetDadosNota(const Value: TdmNotaEntrada);
begin
  FDadosNota := Value;
end;

end.
