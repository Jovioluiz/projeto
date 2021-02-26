unit uConsultaProdutos;

interface

uses
  dtmConsultaProduto, uUtil;

type TConsultaProdutos = class

  private
    FDados: TdmConsultaProduto;
    procedure SetDados(const Value: TdmConsultaProduto);



  public
    constructor Create;
    procedure CarregaUltimaEntrada;
    procedure CarregaProdutos(Descricao: string; bolCodigo, bolDescricao, bolAtivo, bolEstoque: Boolean);
    destructor Destroy; override;

    property Dados: TdmConsultaProduto read FDados write SetDados;
end;

implementation

uses
  FireDAC.Comp.Client, uDataModule, System.SysUtils, Vcl.Dialogs;

{ TConsultaProdutos }

procedure TConsultaProdutos.CarregaProdutos(Descricao: string; bolCodigo, bolDescricao, bolAtivo, bolEstoque: Boolean);
const
  sql_produto =  'select ' +
                 '  p.cd_produto,  ' +
                 '  p.id_item,     ' +
                 '  p.desc_produto,' +
                 '  p.un_medida,   ' +
                 '  p.fator_conversao, ' +
                 '  we.qt_estoque      ' +
                 'from                 ' +
                 '  produto p           ' +
                 'left join wms_estoque we on  ' +
                 '  we.id_item = p.id_item ';
var
  qry: TFDQuery;
begin
  FDados.cdsConsultaProduto.EmptyDataSet;

  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.SQL.Add(sql_produto);

  try
    if Trim(Descricao) = '' then
    begin
      ShowMessage('Informe algo para pesquisar');
      Exit;
    end;

    if Descricao = '*' then
      qry.Open(sql_produto);

    if bolCodigo then
      qry.SQL.Add(' where p.cd_produto ilike ' + QuotedStr('%'+Descricao+'%'));

    if bolDescricao then
      qry.SQL.Add(' or desc_produto ilike ' + QuotedStr('%'+Descricao+'%'));

    if bolAtivo then
      qry.SQL.Add(' and fl_ativo = true');

    if bolEstoque then
      qry.SQL.Add(' and qt_estoque > 0');

    qry.Open();
    FDados.dsConsultaProduto.DataSet.Active := True;

    qry.Loop(
    procedure
    begin
      FDados.cdsConsultaProduto.Append;
      FDados.cdsConsultaProduto.FieldByName('cd_produto').AsString := qry.FieldByName('cd_produto').AsString;
      FDados.cdsConsultaProduto.FieldByName('desc_produto').AsString := qry.FieldByName('desc_produto').AsString;
      FDados.cdsConsultaProduto.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
      FDados.cdsConsultaProduto.FieldByName('fator_conversao').AsInteger := qry.FieldByName('fator_conversao').AsInteger;
      FDados.cdsConsultaProduto.FieldByName('qtd_estoque').AsFloat := qry.FieldByName('qt_estoque').AsFloat;
      FDados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt := qry.FieldByName('id_item').AsLargeInt;
      FDados.cdsConsultaProduto.Post;
    end
    );

  finally
    qry.Free;
  end;
end;

procedure TConsultaProdutos.CarregaUltimaEntrada;
const
  sql = 'select                                  '+
        '    nfc.dcto_numero,                    '+
        '    c.nome as fornecedor,               '+
        '    nfc.dt_lancamento,                  '+
        '    nfi.un_medida,                      '+
        '    nfi.vl_unitario,                    '+
        '    nfi.qtd_estoque as quantidade       '+
        'from                                    '+
        '    produto p                           '+
        'join nfi on                             '+
        '    p.id_item = nfi.id_item             '+
        'join nfc on                             '+
        '    nfc.id_geral = nfi.id_nfc           '+
        'join cliente c on                       '+
        '    nfc.cd_fornecedor = c.cd_cliente    '+
        'where                                   '+
        '    p.id_item in (                      '+
        '    select                              '+
        '        nfi.id_item                     '+
        '    from                                '+
        '        nfc                             '+
        '    join nfi on                         '+
        '        nfc.id_geral = nfi.id_nfc       '+
        '    where                               '+
        '        nfc.dcto_numero > 0             '+
        '        and p.id_item = :id_item)';
var
  qry: TFDQuery;
begin
  FDados.cdsUltimasEntradas.EmptyDataSet;

  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sql);
    qry.ParamByName('id_item').AsLargeInt := FDados.cdsConsultaProduto.FieldByName('id_item').AsLargeInt;
    qry.Open();

    if qry.IsEmpty then
      FDados.cdsUltimasEntradas.EmptyDataSet
    else
    begin
      qry.Loop(
      procedure
      begin
        FDados.cdsUltimasEntradas.Append;
        FDados.cdsUltimasEntradas.FieldByName('dcto_numero').AsInteger := qry.FieldByName('dcto_numero').AsInteger;
        FDados.cdsUltimasEntradas.FieldByName('fornecedor').AsString := qry.FieldByName('fornecedor').AsString;
        FDados.cdsUltimasEntradas.FieldByName('dt_lancamento').AsDateTime := qry.FieldByName('dt_lancamento').AsDateTime;
        FDados.cdsUltimasEntradas.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
        FDados.cdsUltimasEntradas.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
        FDados.cdsUltimasEntradas.FieldByName('quantidade').AsFloat := qry.FieldByName('quantidade').AsFloat;
        FDados.cdsUltimasEntradas.Post;
      end
      );
    end;
  finally
    qry.Free;
  end;
end;

constructor TConsultaProdutos.Create;
begin
  FDados := TdmConsultaProduto.Create(nil);
end;

destructor TConsultaProdutos.Destroy;
begin
  FDados.Free;
  inherited;
end;

procedure TConsultaProdutos.SetDados(const Value: TdmConsultaProduto);
begin
  FDados := Value;
end;

end.
