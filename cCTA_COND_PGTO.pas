unit cCTA_COND_PGTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConexao;

type
  TcadCondPgto = class(TfConexao)
    tpCondPgto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCTACONDPGTOCD_COND: TEdit;
    Label3: TLabel;
    edtCTACONDPGTODESCRICAO: TEdit;
    edtCTACONDPGTOCD_CTA_FORMA_PGTO: TEdit;
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtCTACONDPGTONR_PARCELAS: TEdit;
    edtCTACONDPGTOVL_MINIMO: TEdit;
    btnSalvar: TButton;
    btnFechar: TButton;
    sqlInsertCondPgto: TFDQuery;
    edtCTACONDPGTOFL_ATIVO: TCheckBox;
    selectCDPGTO: TFDQuery;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadCondPgto: TcadCondPgto;

implementation

{$R *.dfm}

procedure TcadCondPgto.btnFecharClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

procedure TcadCondPgto.btnSalvarClick(Sender: TObject);
begin
   //verifica se o código da condição e forma de pagamento estão vazias ao salvar
  if (edtCTACONDPGTOCD_COND.Text = EmptyStr) or (edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = EmptyStr) or (edtCTACONDPGTODESCRICAO.Text = EmptyStr) then
    raise Exception.Create('Código da Condição e Forma não podem ser vazios');

   //insert cta_cond_pagamento
  Close;
  sqlInsertCondPgto.Connection := conexao;
  sqlInsertCondPgto.SQL.Text := 'insert into cta_cond_pagamento (cd_cond_pag, nm_cond_pag, cd_cta_forma_pagamento, '+
                              'nr_parcelas, vl_minimo_parcela, fl_ativo)'+
                              'values (:cd_cond_pag, :nm_cond_pag, :cd_cta_forma_pagamento, :nr_parcelas, '+
                              ':vl_minimo_parcela, :fl_ativo)';

  sqlInsertCondPgto.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);
  sqlInsertCondPgto.ParamByName('nm_cond_pag').AsString := edtCTACONDPGTODESCRICAO.Text;
  sqlInsertCondPgto.ParamByName('cd_cta_forma_pagamento').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
  sqlInsertCondPgto.ParamByName('nr_parcelas').AsInteger := StrToInt(edtCTACONDPGTONR_PARCELAS.Text);
  sqlInsertCondPgto.ParamByName('vl_minimo_parcela').AsCurrency := StrToCurr(edtCTACONDPGTOVL_MINIMO.Text);
  sqlInsertCondPgto.ParamByName('fl_ativo').AsBoolean := edtCTACONDPGTOFL_ATIVO.Checked;

  try
    sqlInsertCondPgto.ExecSQL;
    sqlInsertCondPgto.Close;
    FreeAndNil(sqlInsertCondPgto);
    ShowMessage('Condição de Pagamento cadastrada com Sucesso!');

    edtCTACONDPGTOCD_COND.Text := '';
    edtCTACONDPGTODESCRICAO.Text := '';
    edtCTACONDPGTOFL_ATIVO.Checked := false;
    edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text := '';
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := '';
    edtCTACONDPGTOVL_MINIMO.Text := '';
    edtCTACONDPGTOVL_MINIMO.Text := '';

  except
    on E : exception do
      begin
        ShowMessage('Erro ao gravar os dados '+ E.Message);
        exit;
      end;
  end;

end;

//busca o nome da foma de pagamento
procedure TcadCondPgto.edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
begin
  inherited;
  begin
    if edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = '' then
      begin
        edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := '';
        exit;
      end;

  end;

    selectCDPGTO.Close;
    selectCDPGTO.SQL.Text := 'select nm_forma_pag from cta_forma_pagamento where cd_forma_pag = :cd_forma_pag ';
    selectCDPGTO.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
    selectCDPGTO.Open();
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := selectCDPGTO.FieldByName('nm_forma_pag').AsString;
    selectCDPGTO.Next;
end;


//passa pelos campos pressionando enter
procedure TcadCondPgto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
       Perform(WM_NEXTDLGCTL,1,0)
end;

end.
