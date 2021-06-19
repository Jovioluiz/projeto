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
    btnGerar: TButton;
    edtDataIni: TDateTimePicker;
    edtDataFim: TDateTimePicker;
    odArquivo: TOpenTextFileDialog;
    Label1: TLabel;
    edtArquivo: TEdit;
    btnCaminho: TSpeedButton;
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCaminhoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGravaArquivo: TfrmGravaArquivo;
  arquivo: TStringList;

implementation

uses
  uDataModule, uThread, FileCtrl;

{$R *.dfm}

procedure TfrmGravaArquivo.btnCaminhoClick(Sender: TObject);
var
  dir: string;
begin
  if SelectDirectory(ExtractFilePath(odArquivo.FileName), 'C:\', dir) then
    edtArquivo.Text := dir + '\' + 'relatorio.txt';
end;

procedure TfrmGravaArquivo.btnGerarClick(Sender: TObject);
const
  sql = 'select                                                 ' +
'             pv.nr_pedido,                                      ' +
'             c.nome,                                            ' +
'             pv.vl_total,                                       ' +
'             pv.vl_acrescimo,                                   ' +
'             pv.vl_desconto_pedido,                             ' +
'             pv.dt_emissao,                                     ' +
'             p.cd_produto,                                      ' +
'             p.desc_produto,                                    ' +
'             pvi.qtd_venda,                                     ' +
'             pvi.un_medida,                                     ' +
'             pvi.vl_unitario,                                   ' +
'             pvi.vl_desconto,                                   ' +
'             pvi.vl_total_item,                                 ' +
'             pvi.icms_vl_base,                                  ' +
'             pvi.icms_pc_aliq,                                  ' +
'             pvi.icms_valor,                                    ' +
'             pvi.ipi_vl_base,                                   ' +
'             pvi.ipi_pc_aliq,                                   ' +
'             pvi.ipi_valor,                                     ' +
'             pvi.pis_cofins_vl_base,                            ' +
'             pvi.pis_cofins_pc_aliq,                            ' +
'             pvi.pis_cofins_valor                               ' +
'         from                                                   ' +
'             pedido_venda pv                                    ' +
'         join pedido_venda_item pvi on                          ' +
'             pv.id_geral = pvi.id_pedido_venda                  ' +
'        join produto p on p.id_item = pvi.id_item               ' +
'         join cliente c on                                      ' +
'             pv.cd_cliente = c.cd_cliente                       ' +
'         where pv.dt_emissao between :dt_inicial and :dt_final  ' +
'             order by pv.nr_pedido, pv.dt_emissao asc  ';
var
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

  TThreadTeste.Create(qry, edtArquivo.Text);

  ShowMessage('Gravação Concluída');
end;

procedure TfrmGravaArquivo.FormCreate(Sender: TObject);
begin
  edtDataIni.Date := Now;
  edtDataFim.Date := Now;
end;

end.
