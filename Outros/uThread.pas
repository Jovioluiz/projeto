unit uThread;

interface

uses
  System.Classes, Datasnap.DBClient, FireDAC.Comp.Client, Data.DB;

type
  TThreadTeste = class(TThread)
  private
    FArquivo: TStringList;
    FQuery: TFDQuery;
    FCaminho: string;
  protected
    procedure Execute; override;

  public

    procedure GravaArquivo;
    constructor Create(const Query: TFDQuery; Caminho: String);
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{ TThread }

constructor TThreadTeste.Create(const Query: TFDQuery; Caminho: String);
begin
  FQuery := Query;
  FCaminho := Caminho;
  inherited Create(False);
end;

procedure TThreadTeste.Execute;
begin
  NameThreadForDebugging('uThread');
  GravaArquivo;
end;

procedure TThreadTeste.GravaArquivo;
begin

  FArquivo := TStringList.Create;

  try

    FArquivo.Add('Pedido|Cliente|Valor Total|Acrescimo|Desconto Pedido|Data Emissão|Cód. Produto|Qtdade Venda|Un. Medida|Valor Unitário|Desconto '+
                              '|Valor Total Item|ICMS Base|ICMS Aliq|ICMS Valor|IPI Base|IPI Aliq|IPI Valor|PIS/Cofins Base|PIS/Cofins Aliq|PIS/Cofins Valor');

    FQuery.First;

    if not FQuery.IsEmpty then
    begin
      while not FQuery.Eof do
      begin

        FArquivo.Add(FQuery.FieldByName('nr_pedido').AsString +
                    '|' + FQuery.FieldByName('nome').AsString +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_total').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_acrescimo').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_desconto_pedido').AsCurrency) +
                    '|'+ FormatDateTime('dd/MM/yyyy', FQuery.FieldByName('dt_emissao').AsDateTime) +
                    '|'+ FQuery.FieldByName('cd_produto').AsString +
                    '|'+ FQuery.FieldByName('desc_produto').AsString +
                    '|'+ FormatFloat('#,##0.00', FQuery.FieldByName('qtd_venda').AsFloat) +
                    '|'+ FQuery.FieldByName('un_medida').AsString +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_unitario').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_desconto').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('vl_total_item').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('icms_vl_base').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('icms_pc_aliq').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('icms_valor').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('ipi_vl_base').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('ipi_pc_aliq').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('ipi_valor').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('pis_cofins_vl_base').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('pis_cofins_pc_aliq').AsCurrency) +
                    '|'+ FormatCurr('#,##0.00', FQuery.FieldByName('pis_cofins_valor').AsCurrency));
        FQuery.Next;
      end;

      FArquivo.SaveToFile(FCaminho);
    end;
  finally
    FArquivo.Free;
  end
end;

end.
