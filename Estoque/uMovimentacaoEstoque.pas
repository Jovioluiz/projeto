unit uMovimentacaoEstoque;

interface

type TMovimentacaoEstoque = class

  type
    TInfProdutos = record
      IdItem: Integer;
      UnEstoque,
      EntradaSaida: string;
      QtEstoque: Double;
    end;


  public
    procedure InsereWmsMvto;
    procedure AtualizaEstoque;
end;

implementation

uses
  FireDAC.Comp.Client, uGerador, uDataModule;

{ TMovimentacaoEstoque }

procedure TMovimentacaoEstoque.AtualizaEstoque;
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
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  {
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

      dm.conexaoBanco.Commit;
    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ao gravar os dados do produto ' + cdsEntrada.FieldByName('cd_produto').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
    cdsEntrada.EnableControls;
  end;}

end;

procedure TMovimentacaoEstoque.InsereWmsMvto;
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
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qrySelect := TFDQuery.Create(nil);
  qrySelect.Connection := dm.conexaoBanco;
  IdGeral := TGerador.Create;
  dm.conexaoBanco.StartTransaction;
  {
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
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ' + E.Message);
      end;
    end;

    dm.conexaoBanco.Commit;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
    qrySelect.Free;
    FreeAndNil(IdGeral);
    cdsEntrada.EnableControls
  end; }

end;

end.
