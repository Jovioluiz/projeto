unit uGravaArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ComCtrls, System.Math, Data.DB,
  Vcl.Buttons;

type
  TfrmGravaArquivo = class(TForm)
    btnPedidoVenda: TButton;
    edtDataIni: TDateTimePicker;
    edtDataFim: TDateTimePicker;
    edtArquivo: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    opArquivo: TOpenTextFileDialog;
    procedure btnPedidoVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGravaArquivo: TfrmGravaArquivo;
  arquivo: TextFile;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure TfrmGravaArquivo.btnPedidoVendaClick(Sender: TObject);
const
  sql = ' select                                                ' +
        '     pv.nr_pedido,                                     ' +
        '     c.nome,                                           ' +
        '     pv.vl_total,                                      ' +
        '     pv.vl_acrescimo,                                  ' +
        '     pv.vl_desconto_pedido,                            ' +
        '     pv.dt_emissao,                                    ' +
        '     pvi.cd_produto,                                   ' +
        '     pvi.qtd_venda,                                    ' +
        '     pvi.un_medida,                                    ' +
        '     pvi.vl_unitario,                                  ' +
        '     pvi.vl_desconto,                                  ' +
        '     pvi.vl_total_item,                                ' +
        '     pvi.icms_vl_base,                                 ' +
        '     pvi.icms_pc_aliq,                                 ' +
        '     pvi.icms_valor,                                   ' +
        '     pvi.ipi_vl_base,                                  ' +
        '     pvi.ipi_pc_aliq,                                  ' +
        '     pvi.ipi_valor,                                    ' +
        '     pvi.pis_cofins_vl_base,                           ' +
        '     pvi.pis_cofins_pc_aliq,                           ' +
        '     pvi.pis_cofins_valor                              ' +
        ' from                                                  ' +
        '     pedido_venda pv                                   ' +
        ' join pedido_venda_item pvi on                         ' +
        '     pv.id_geral = pvi.id_pedido_venda                 ' +
        '     join cliente c on                                 ' +
        '     pv.cd_cliente = c.cd_cliente                      ' +
        ' where pv.dt_emissao between :dt_inicial and :dt_final ' +
        '     order by pv.dt_emissao asc                        ' ;
var
  caminho: string;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;
  qry.SQL.Add(sql);
  qry.ParamByName('dt_inicial').AsDate := edtDataIni.Date;
  qry.ParamByName('dt_final').AsDate := edtDataFim.Date;
  qry.Open(sql);

  caminho := edtArquivo.Text;

  if caminho <> '' then
  begin
    AssignFile(arquivo, caminho);

    {$I-}
    Reset(arquivo);
    {$I+}

    if (IOResult <> 0) then
      Rewrite(arquivo) {arquivo não existe e será criado }
    else
    begin
      Append(arquivo); {o arquivo existe e será aberto para saídas adicionais }
    end;

    Writeln(arquivo, 'Pedido','|','Cliente','|','Valor Total','|','Acrescimo','|','Desconto Pedido','|','Data Emissão',
                              '|','Cód. Produto','|','Qtdade Venda','|','Un. Medida','|','Valor Unitário','|','Desconto',
                              '|','Valor Total Item','|','ICMS Base','|','ICMS Aliq','|','ICMS Valor','|','IPI Base',
                              '|','IPI Aliq','|','IPI Valor','|','PIS/Cofins Base','|','PIS/Cofins Aliq','|','PIS/Cofins Valor');
    qry.First;

    if not qry.IsEmpty then
    begin
      while not qry.Eof do
      begin
        Writeln(arquivo,'|', qry.FieldByName('nr_pedido').AsInteger,
                        '|', qry.FieldByName('nome').AsString,
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_total').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_acrescimo').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_desconto_pedido').AsCurrency),
                        '|', FormatDateTime('dd/MM/yyyy', qry.FieldByName('dt_emissao').AsDateTime),
                        '|', qry.FieldByName('cd_produto').AsInteger,
                        '|', FormatFloat('#,##0.00', qry.FieldByName('qtd_venda').AsFloat),
                        '|', qry.FieldByName('un_medida').AsString,
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_unitario').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_desconto').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('vl_total_item').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('icms_vl_base').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('icms_pc_aliq').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('icms_valor').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('ipi_vl_base').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('ipi_pc_aliq').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('ipi_valor').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('pis_cofins_vl_base').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('pis_cofins_pc_aliq').AsCurrency),
                        '|', FormatCurr('#,##0.00', qry.FieldByName('pis_cofins_valor').AsCurrency));
        qry.Next;
      end;
    end;

    CloseFile(arquivo);
  end
  else
    ShowMessage('Selecione um arquivo!');

end;

procedure TfrmGravaArquivo.FormCreate(Sender: TObject);
begin
  edtDataIni.Date := Now;
  edtDataFim.Date := Now;
end;

procedure TfrmGravaArquivo.SpeedButton1Click(Sender: TObject);
begin
  if opArquivo.Execute then
    edtArquivo.Text := opArquivo.FileName;
end;

end.
