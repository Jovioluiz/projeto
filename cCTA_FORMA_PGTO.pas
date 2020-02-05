unit cCTA_FORMA_PAGAMENTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.FMTBcd, Data.SqlExpr, uConexao,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls;

type
  TcadFormaPagamento = class(TfConexao)
    tpCadFormaPgto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCTA_FORMA_PGTOCODIGO: TEdit;
    edtCTA_FORMA_PGTODESCRICAO: TEdit;
    edtCTA_FORMA_PGTOFL_ATIVO: TCheckBox;
    edtCTA_FORMA_PGTOCLASSIFICACAO: TRadioGroup;
    sqlInsertFormaPgto: TFDQuery;
    btnSalvar: TButton;
    btnFechar: TButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCTA_FORMA_PGTOCODIGOExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadFormaPagamento: TcadFormaPagamento;

implementation

{$R *.dfm}



procedure TcadFormaPagamento.btnCancelarClick(Sender: TObject);
begin
   if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

procedure TcadFormaPagamento.btnFecharClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

procedure TcadFormaPagamento.btnSalvarClick(Sender: TObject);
begin
//verifica se o código está vazio
  if (edtCTA_FORMA_PGTOCODIGO.Text = EmptyStr) or (edtCTA_FORMA_PGTODESCRICAO.Text = EmptyStr) or (edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex = -1) then
    begin
      raise Exception.Create('Código, Descição e Classificação não podem ser vazios');
    end;

  Close;
  sqlInsertFormaPgto.Connection := conexao;
  sqlInsertFormaPgto.SQL.Clear;
  sqlInsertFormaPgto.SQL.Add('insert into cta_forma_pagamento (cd_forma_pag, nm_forma_pag, fl_ativo, tp_classificacao)');
  sqlInsertFormaPgto.SQL.Add('values (:cd_forma_pag, :nm_forma_pag, :fl_ativo, :tp_classificacao)');

  sqlInsertFormaPgto.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTA_FORMA_PGTOCODIGO.Text);
  sqlInsertFormaPgto.ParamByName('nm_forma_pag').AsString := edtCTA_FORMA_PGTODESCRICAO.Text;
  sqlInsertFormaPgto.ParamByName('fl_ativo').AsBoolean := edtCTA_FORMA_PGTOFL_ATIVO.Checked;
  sqlInsertFormaPgto.ParamByName('tp_classificacao').AsString := edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex.ToString;


  try
    sqlInsertFormaPgto.Execute();
    sqlInsertFormaPgto.Close;
    FreeAndNil(sqlInsertFormaPgto);
    ShowMessage('Forma de Pagamento cadastrada com Sucesso!');

    edtCTA_FORMA_PGTOCODIGO.Text := '';
    edtCTA_FORMA_PGTODESCRICAO.Text := '';
    edtCTA_FORMA_PGTOFL_ATIVO.Checked := false;

  except
    on E : exception do
      begin
        ShowMessage('Erro ao gravar os dados '+ E.Message);
        exit;
      end;
  end;
end;

procedure TcadFormaPagamento.edtCTA_FORMA_PGTOCODIGOExit(Sender: TObject);
begin
//verifica se foi clicado no fechar, se clicou, não valida o cod. da forma vazio
  if btnFechar.MouseInClient then
    begin
      exit
    end
  else if edtCTA_FORMA_PGTOCODIGO.Text = EmptyStr then
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtCTA_FORMA_PGTOCODIGO.SetFocus;
      Abort;
    end;

end;

end.
