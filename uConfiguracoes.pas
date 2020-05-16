unit uConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uConexao, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmConfiguracoes = class(TfrmConexao)
    btnSalvar: TButton;
    Button2: TButton;
    rgEditaClientePV: TRadioGroup;
    FDQuery1: TFDQuery;
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.dfm}

//testar isso para ver se funciona

//fazer um select para carregar as informações ao abrir
procedure TfrmConfiguracoes.btnSalvarClick(Sender: TObject);
begin
  try
    FDQuery1.Close;
    FDQuery1.SQL.Text := 'update configuracao set valor = :valor where cd_configuracao = :cd_configuracao';
    case rgEditaClientePV.ItemIndex of
    0:
    begin
      FDQuery1.ParamByName('valor').AsString := 'S';
    end;
    1:
    begin
      FDQuery1.ParamByName('valor').AsString := 'N';
    end;
    end;

    FDQuery1.ParamByName('cd_configuracao').AsInteger := 1;

    FDQuery1.ExecSQL;
  finally
    FDQuery1.Close;
  end;
end;

end.
