unit fGridsThread;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TfThreads = class(TForm)
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    ds1: TDataSource;
    ds2: TDataSource;
    ds3: TDataSource;
    ds4: TDataSource;
    cds1: TClientDataSet;
    cds2: TClientDataSet;
    cds3: TClientDataSet;
    cds4: TClientDataSet;
    btnListar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure CarregaPedidoVenda;
    procedure CarregaPedidoVendaItem;
    procedure CarregaProdutos;
    procedure CarregaProdutosCodBarras;
    procedure PreencheDataSets;
  private
    FThread: TThread;
    FCDs1: TFDQuery;
    FCDs2: TFDQuery;
    FCDs3: TFDQuery;
    FCDs4: TFDQuery;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fThreads: TfThreads;

implementation

uses
  uDataModule, uUtil;

{$R *.dfm}

procedure TfThreads.btnListarClick(Sender: TObject);
begin
  CarregaProdutos;
  CarregaPedidoVenda;
  CarregaPedidoVendaItem;
  CarregaProdutosCodBarras;

  FThread.CreateAnonymousThread(
  procedure
  begin
      FThread.Synchronize(FThread.CurrentThread,
                      procedure
                      begin
                        PreencheDataSets;
                      end);
  end
  ).Start;



//
//  FThread.CreateAnonymousThread(
//  procedure
//  begin
//    PreencheDataSets;
//  end).Start;

end;

procedure TfThreads.CarregaPedidoVenda;
const
  SQL = 'select id_geral, nr_pedido, vl_total from pedido_venda';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    cds3.DisableControls;
    cds3.EmptyDataSet;
    qry.Open(SQL);

    FCDs3 := qry;
//    qry.Loop(
//    procedure
//    begin
//      cds3.Append;
//      cds3.FieldByName('id_geral').AsLargeInt := qry.FieldByName('id_geral').AsLargeInt;
//      cds3.FieldByName('nr_pedido').AsInteger := qry.FieldByName('nr_pedido').AsInteger;
//      cds3.FieldByName('vl_total').AsCurrency := qry.FieldByName('vl_total').AsCurrency;
//      cds3.Post;
//    end
//    );

  finally
    cds3.EnableControls;
    qry.Free;
  end;
end;

procedure TfThreads.CarregaPedidoVendaItem;
const
  SQL = 'select id_geral, id_pedido_venda, id_item, qtd_venda, vl_unitario, vl_total_item from pedido_venda_item';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    cds4.DisableControls;
    cds4.EmptyDataSet;
    qry.Open(SQL);

    FCDs4 := qry;

//    qry.Loop(
//    procedure
//    begin
//      cds4.Append;
//      cds4.FieldByName('id_geral').AsLargeInt := qry.FieldByName('id_geral').AsLargeInt;
//      cds4.FieldByName('id_pedido_venda').AsLargeInt := qry.FieldByName('id_pedido_venda').AsLargeInt;
//      cds4.FieldByName('id_item').AsInteger := qry.FieldByName('id_item').AsInteger;
//      cds4.FieldByName('qt_venda').AsFloat := qry.FieldByName('qtd_venda').AsFloat;
//      cds4.FieldByName('vl_unitario').AsCurrency := qry.FieldByName('vl_unitario').AsCurrency;
//      cds4.FieldByName('vl_total').AsCurrency := qry.FieldByName('vl_total_item').AsCurrency;
//      cds4.Post;
//    end
//    );

  finally
    cds4.EnableControls;
    qry.Free;
  end;
end;

procedure TfThreads.CarregaProdutos;
const
  SQL = 'select cd_produto, desc_produto from produto';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    cds1.DisableControls;
    cds1.EmptyDataSet;
    qry.Open(SQL);

    FCDs1 := qry;
//    qry.Loop(
//    procedure
//    begin
//      cds1.Append;
//      cds1.FieldByName('cd_produto').AsString := qry.FieldByName('cd_produto').AsString;
//      cds1.FieldByName('desc_produto').AsString := qry.FieldByName('desc_produto').AsString;
//      cds1.Post;
//    end
//    );

  finally
    cds1.EnableControls;
    qry.Free;
  end;
end;

procedure TfThreads.CarregaProdutosCodBarras;
const
  SQL = 'select id_item, un_medida, tipo_cod_barras, codigo_barras from produto_cod_barras';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    cds2.DisableControls;
    cds2.EmptyDataSet;
    qry.Open(SQL);

    FCDs2 := qry;

//    qry.Loop(
//    procedure
//    begin
//      cds2.Append;
//      cds2.FieldByName('id_item').AsInteger := qry.FieldByName('id_item').AsInteger;
//      cds2.FieldByName('un_medida').AsString := qry.FieldByName('un_medida').AsString;
//      cds2.FieldByName('tipo_cod_barras').AsInteger := qry.FieldByName('tipo_cod_barras').AsInteger;
//      cds2.FieldByName('codigo_barras').AsString := qry.FieldByName('codigo_barras').AsString;
//      cds2.Post;
//    end
//    );

  finally
    cds2.EnableControls;
    qry.Free;
  end;
end;

procedure TfThreads.FormCreate(Sender: TObject);
begin
  DBGrid1.DataSource := ds1;
  DBGrid2.DataSource := ds2;
  DBGrid3.DataSource := ds3;
  DBGrid4.DataSource := ds4;
end;

procedure TfThreads.PreencheDataSets;
begin

    FCDs2.Loop(
    procedure
    begin
      cds2.Append;
      cds2.FieldByName('id_item').AsInteger := FCDs2.FieldByName('id_item').AsInteger;
      cds2.FieldByName('un_medida').AsString := FCDs2.FieldByName('un_medida').AsString;
      cds2.FieldByName('tipo_cod_barras').AsInteger := FCDs2.FieldByName('tipo_cod_barras').AsInteger;
      cds2.FieldByName('codigo_barras').AsString := FCDs2.FieldByName('codigo_barras').AsString;
      cds2.Post;
    end
    );

    FCDs1.Loop(
    procedure
    begin
      cds1.Append;
      cds1.FieldByName('cd_produto').AsString := FCDs1.FieldByName('cd_produto').AsString;
      cds1.FieldByName('desc_produto').AsString := FCDs1.FieldByName('desc_produto').AsString;
      cds1.Post;
    end
    );

    FCDs4.Loop(
    procedure
    begin
      cds4.Append;
      cds4.FieldByName('id_geral').AsLargeInt := FCDs4.FieldByName('id_geral').AsLargeInt;
      cds4.FieldByName('id_pedido_venda').AsLargeInt := FCDs4.FieldByName('id_pedido_venda').AsLargeInt;
      cds4.FieldByName('id_item').AsInteger := FCDs4.FieldByName('id_item').AsInteger;
      cds4.FieldByName('qt_venda').AsFloat := FCDs4.FieldByName('qtd_venda').AsFloat;
      cds4.FieldByName('vl_unitario').AsCurrency := FCDs4.FieldByName('vl_unitario').AsCurrency;
      cds4.FieldByName('vl_total').AsCurrency := FCDs4.FieldByName('vl_total_item').AsCurrency;
      cds4.Post;
    end
    );

    FCDs3.Loop(
    procedure
    begin
      cds3.Append;
      cds3.FieldByName('id_geral').AsLargeInt := FCDs3.FieldByName('id_geral').AsLargeInt;
      cds3.FieldByName('nr_pedido').AsInteger := FCDs3.FieldByName('nr_pedido').AsInteger;
      cds3.FieldByName('vl_total').AsCurrency := FCDs3.FieldByName('vl_total').AsCurrency;
      cds3.Post;
    end
    );

end;

end.
