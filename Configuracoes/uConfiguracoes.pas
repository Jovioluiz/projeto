unit uConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uConexao, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, System.UITypes;

type
  TfrmConfiguracoes = class(TfrmConexao)
    btnSalvar: TButton;
    Button2: TButton;
    FDQuery1: TFDQuery;
    Label1: TLabel;
    cbConfigAlteraCliPv: TComboBox;
    lbl1: TLabel;
    cbbLancaItemPedido: TComboBox;
    status: TStatusBar;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  uDataModule;

{$R *.dfm}

//testar isso para ver se funciona

//fazer um select para carregar as informações ao abrir
procedure TfrmConfiguracoes.btnSalvarClick(Sender: TObject);
const
  sql_update = 'update configuracao set valor = :valor where cd_configuracao = :cd_configuracao';
var
  qryUpdate: TFDQuery;
begin
  qryUpdate := TFDQuery.Create(Self);
  qryUpdate.Connection := dm.FDConnection1;


  qryUpdate.SQL.Add(sql_update);

  try
    if cbConfigAlteraCliPv.ItemIndex = 0 then
      qryUpdate.ParamByName('valor').AsString := 'S'
    else
      qryUpdate.ParamByName('valor').AsString := 'N';

    qryUpdate.ParamByName('cd_configuracao').AsInteger := 1;
    qryUpdate.ExecSQL;

    if cbbLancaItemPedido.ItemIndex = 0 then
      qryUpdate.ParamByName('valor').AsString := 'S'
    else
      qryUpdate.ParamByName('valor').AsString := 'N';

    qryUpdate.ParamByName('cd_configuracao').AsInteger := 3;
    qryUpdate.ExecSQL;

    ShowMessage('Gravado com Sucesso');
  finally
    qryUpdate.Free;
  end;
end;

procedure TfrmConfiguracoes.Button2Click(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
  begin
    Close;
  end;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
var
  config : Integer;
begin
   try
    FDQuery1.Close;
    FDQuery1.SQL.Text := 'select cd_configuracao, valor from configuracao order by cd_configuracao';
    FDQuery1.Open();

    FDQuery1.First;

    while not FDQuery1.Eof do
    begin
      config := FDQuery1.FieldByName('cd_configuracao').AsInteger;

      if (FDQuery1.FieldByName('valor').AsString <> 'S')
      and (FDQuery1.FieldByName('valor').AsString <> 'N') then
        raise Exception.Create('Valor da configuração incorreto');

      case config of
      1:
      begin
        if FDQuery1.FieldByName('valor').AsString = 'S' then
          cbConfigAlteraCliPv.ItemIndex := 0
        else
          cbConfigAlteraCliPv.ItemIndex := 1;
      end;
      3:
        begin
          if FDQuery1.FieldByName('valor').AsString = 'S' then
            cbbLancaItemPedido.ItemIndex := 0
          else
            cbbLancaItemPedido.ItemIndex := 1;
        end;
      end;
      FDQuery1.Next;
    end;
  finally
    FDQuery1.Close;
  end;
end;

end.


