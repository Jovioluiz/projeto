unit UfrmRelVendaDiaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmRelVendaDiaria = class(TForm)
    Label1: TLabel;
    dbGridProdutosVendas: TDBGrid;
    btnPesquisar: TButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    sqlListaVendaDiaria: TFDQuery;
    edtDtemissaoInicial: TMaskEdit;
    Splitter1: TSplitter;
    edtValorTotal: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtDtemissaoFinal: TMaskEdit;
    sqlSoma: TFDQuery;
    edtValorDesconto: TEdit;
    edtValorAcrescimo: TEdit;
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelVendaDiaria: TfrmRelVendaDiaria;

implementation

{$R *.dfm}

procedure TfrmRelVendaDiaria.btnPesquisarClick(Sender: TObject);
begin
  sqlListaVendaDiaria.Close;
  sqlListaVendaDiaria.SQL.Text := 'select *from view_lista_venda_diaria where dt_emissao between :dt_emissaoI and :dt_emissaoF order by nr_pedido asc';

  sqlListaVendaDiaria.ParamByName('dt_emissaoI').AsDate := StrToDate(edtDtemissaoInicial.Text);
  sqlListaVendaDiaria.ParamByName('dt_emissaoF').AsDate := StrToDate(edtDtemissaoFinal.Text);
  sqlListaVendaDiaria.Open();

  if sqlListaVendaDiaria.IsEmpty then
    begin
      ShowMessage('Nenhuma venda realizada no período informado ');
    end
  else
    begin
    //lista os pedidos

        dbGridProdutosVendas.DataSource := DataSource1;
        dbGridProdutosVendas.Columns[0].Title.Caption := 'Cd. Cliente';
        dbGridProdutosVendas.Columns[0].FieldName := 'cd_cliente';
        dbGridProdutosVendas.Columns[1].Title.Caption := 'Nr. Pedido';
        dbGridProdutosVendas.Columns[1].FieldName := 'nr_pedido';
        dbGridProdutosVendas.Columns[2].Title.Caption := 'Valor Acréscimo';
        dbGridProdutosVendas.Columns[2].FieldName := 'acrescimo';
        dbGridProdutosVendas.Columns[3].Title.Caption := 'Valor Desconto';
        dbGridProdutosVendas.Columns[3].FieldName := 'desconto';
        dbGridProdutosVendas.Columns[4].Title.Caption := 'Valor Total';
        dbGridProdutosVendas.Columns[4].FieldName := 'vl_total';
        dbGridProdutosVendas.Columns[5].Title.Caption := 'Data Emissão';
        dbGridProdutosVendas.Columns[5].FieldName := 'dt_emissao';
    end;

    //mostra os valores de desconto, acrescimo e total de todos os pedidos
    sqlSoma.SQL.Text := 'select                                       '+
                            'sum(pv.vl_desconto_pedido) as desconto,  '+
                            'sum(pv.vl_acrescimo) as acrescimo,       '+
                            'sum(pv.vl_total) as total                '+
                        'from                                         '+
                            'pedido_venda pv                          '+
                        'where                                        '+
                            'dt_emissao between :dt_emissaoI and :dt_emissaoF';

  sqlSoma.ParamByName('dt_emissaoI').AsDate := StrToDate(edtDtemissaoInicial.Text);
  sqlSoma.ParamByName('dt_emissaoF').AsDate := StrToDate(edtDtemissaoFinal.Text);
  sqlSoma.Open();

  edtValorTotal.Text := CurrToStr(sqlSoma.FieldByName('total').AsCurrency);
  edtValorAcrescimo.Text := CurrToStr(sqlSoma.FieldByName('acrescimo').AsCurrency);
  edtValorDesconto.Text := CurrToStr(sqlSoma.FieldByName('desconto').AsCurrency);
end;

end.
