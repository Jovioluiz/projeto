unit uMovimentacaoEstoque;

interface

uses
  FireDAC.Stan.Param;

type TMovimentacaoEstoque = class

  type
    TInfProdutos = record
      IdItem: Integer;
      UnEstoque,
      EntradaSaida: string;
      QtEstoque: Double;
    end;


  public
    procedure InsereWmsMvto(IdItem: Integer; UnMedida: string; Qtdade: Double);
    procedure AtualizaEstoque(IdItem: Integer; Qtdade: Double);
end;

implementation

uses
  FireDAC.Comp.Client, uGerador, uDataModule, System.SysUtils, Vcl.Dialogs;

{ TMovimentacaoEstoque }

procedure TMovimentacaoEstoque.AtualizaEstoque(IdItem: Integer; Qtdade: Double);
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
  qtEstoque, qttotal: Double;
  id: Int64;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      qry.Open(SQL, [IdItem]);
      id := qry.FieldByName('id_wms_endereco_produto').AsLargeInt;
      qtEstoque := qry.FieldByName('qt_estoque').AsFloat;//quantidade no banco
      qttotal := qtEstoque + Qtdade;

      qry.SQL.Clear;

      qry.SQL.Add(SQL_UPDATE);
      qry.ParamByName('id').AsInteger := id;
      qry.ParamByName('qt_estoque').AsFloat := qttotal;

      qry.ExecSQL;

      qry.Connection.Commit;
    except
      on E : exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do produto ' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TMovimentacaoEstoque.InsereWmsMvto(IdItem: Integer; UnMedida: string; Qtdade: Double);
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

  try
    try
      qrySelect.Open(SQL_SELECT, [IdItem]);

      qry.SQL.Add(SQL_INSERT);
      qry.ParamByName('id_geral').AsFloat := IdGeral.GeraIdGeral;
      qry.ParamByName('id_endereco_produto').AsInteger := qrySelect.FieldByName('id_geral').AsInteger;
      qry.ParamByName('id_item').AsLargeInt := IdItem;
      qry.ParamByName('qt_estoque').AsFloat := Qtdade;
      qry.ParamByName('un_estoque').AsString := UnMedida;
      qry.ParamByName('fl_entrada_saida').AsString := 'E';

      qry.ExecSQL;
      qry.Connection.Commit;

    except
      on e:Exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro: ' + e.Message);
      end;
    end;

  finally
    qry.Connection.Rollback;
    qry.Free;
    qrySelect.Free;
    FreeAndNil(IdGeral);
  end;

end;

end.
