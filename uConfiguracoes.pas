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
    FDQuery1: TFDQuery;
    Label1: TLabel;
    cbConfigAlteraCliPv: TComboBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    case cbConfigAlteraCliPv.ItemIndex of
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
    ShowMessage('Gravado com Sucesso');
  finally
    FDQuery1.Close;
  end;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
var f, config : Integer;
begin
   try
    FDQuery1.Close;
    FDQuery1.SQL.Text := 'select cd_configuracao, valor from configuracao order by cd_configuracao';
    FDQuery1.Open();

    FDQuery1.First;

    while not FDQuery1.Eof do
    begin
      config := FDQuery1.FieldByName('cd_configuracao').AsInteger;

      if FDQuery1.FieldByName('valor').AsString = 'S' then
        begin
          f := 0;
        end
      else if FDQuery1.FieldByName('valor').AsString = 'N' then
        begin
          f := 1;
        end;

      if config = 1 then
      begin
        case f of
        0:
          begin
            cbConfigAlteraCliPv.ItemIndex := 0;
          end;
        1:
          begin
            cbConfigAlteraCliPv.ItemIndex := 1;
          end;
        end;
      end;
      FDQuery1.Next;
    end;
  finally
    FDQuery1.Close;
  end;
end;

end.


