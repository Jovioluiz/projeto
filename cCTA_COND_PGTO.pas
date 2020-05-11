unit cCTA_COND_PGTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uConexao, Vcl.Buttons;

type
  TfrmCadCondPgto = class(TfrmConexao)
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
    sqlInsertCondPgto: TFDQuery;
    edtCTACONDPGTOFL_ATIVO: TCheckBox;
    selectCDPGTO: TFDQuery;
    btnFechar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnLimpar: TSpeedButton;
    btnSalvar: TSpeedButton;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCTACONDPGTOCD_CONDExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LimpaCampos;
  end;

var
  frmCadCondPgto: TfrmCadCondPgto;

implementation

{$R *.dfm}

uses uDataModule;

procedure TfrmCadCondPgto.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Deseja Excluir a Condição de Pagamento?', 'Aviso', MB_YESNO) = IDYES) then
    begin
      try
        conexao.ExecSQL('delete '+
                        ' from '+
                        'cta_cond_pagamento '+
                        ' where '+
                        'cd_cond_pag = :cd_cond_pag',
                        [StrToInt(edtCTACONDPGTOCD_COND.Text)]);
        ShowMessage('Condição de Pagamento excluída com sucesso!');
        LimpaCampos;
      except
        on E:exception do
          begin
            ShowMessage('Erro ao excluir a condição de pagamento' + edtCTACONDPGTOCD_COND.Text + E.Message);
            conexao.Rollback;
            Exit;
          end;
      end;
    end;

end;

procedure TfrmCadCondPgto.btnFecharClick(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Deseja realmente fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
end;

procedure TfrmCadCondPgto.btnLimparClick(Sender: TObject);
begin
  inherited;
  LimpaCampos;
end;

procedure TfrmCadCondPgto.btnSalvarClick(Sender: TObject);
var resultado : String;
begin
   //verifica se o código da condição e forma de pagamento estão vazias ao salvar
  if (edtCTACONDPGTOCD_COND.Text = EmptyStr) or (edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = EmptyStr) or (edtCTACONDPGTODESCRICAO.Text = EmptyStr) then
    raise Exception.Create('Código da Condição e Forma não podem ser vazios');

  try
   resultado := conexao.ExecSQLScalar('select cd_cond_pag from cta_cond_pagamento where cd_cond_pag = :cd_cond_pag',
                            [StrToInt(edtCTACONDPGTOCD_COND.Text)]);

    if not resultado.IsEmpty then
      begin
        conexao.ExecSQL('update                                                 '+
                            'cta_cond_pagamento                                 '+
                        'set                                                    '+
                        '    cd_cond_pag = :cd_cond_pag,                        '+
                         '   nm_cond_pag = :nm_cond_pag,                        '+
                          '  cd_cta_forma_pagamento = :cd_cta_forma_pagamento,  '+
                          '  nr_parcelas = :nr_parcelas,                        '+
                          '  vl_minimo_parcela = :vl_minimo_parcela,            '+
                          '  fl_ativo = :fl_ativo                               '+
                        'where                                                  '+
                          '  cd_cond_pag = :cd_cond_pag',
                          [StrToInt(edtCTACONDPGTOCD_COND.Text),
                          edtCTACONDPGTODESCRICAO.Text,
                          StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text),
                          StrToInt(edtCTACONDPGTONR_PARCELAS.Text),
                          StrToCurr(edtCTACONDPGTOVL_MINIMO.Text),
                          edtCTACONDPGTOFL_ATIVO.Checked]);

        ShowMessage('Condição de Pagamento cadastrada com Sucesso!');
        LimpaCampos;
      end
    else
      begin
        conexao.ExecSQL('insert                               '+
                            'into                             '+
                            'cta_cond_pagamento (cd_cond_pag, '+
                            'nm_cond_pag,                     '+
                            'cd_cta_forma_pagamento,          '+
                            'nr_parcelas,                     '+
                            'vl_minimo_parcela,               '+
                            'fl_ativo)                        '+
                        'values (:cd_cond_pag,                '+
                            ':nm_cond_pag,                    '+
                            ':cd_cta_forma_pagamento,         '+
                            ':nr_parcelas,                    '+
                            ':vl_minimo_parcela,              '+
                            ':fl_ativo)',
                    [StrToInt(edtCTACONDPGTOCD_COND.Text),
                    edtCTACONDPGTODESCRICAO.Text,
                    StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text),
                    StrToInt(edtCTACONDPGTONR_PARCELAS.Text),
                    StrToCurr(edtCTACONDPGTOVL_MINIMO.Text),
                    edtCTACONDPGTOFL_ATIVO.Checked],
                    [ftInteger, ftString, ftInteger, ftInteger, ftCurrency, ftBoolean]);

        ShowMessage('Condição de Pagamento cadastrada com Sucesso!');
        LimpaCampos;
      end;
  except
    on E : exception do
      begin
        conexao.Rollback;
        ShowMessage('Erro ao gravar os dados '+ E.Message);
        Exit;
      end;
  end;

end;


procedure TfrmCadCondPgto.edtCTACONDPGTOCD_CONDExit(Sender: TObject);
begin
  if edtCTACONDPGTOCD_COND.Text = EmptyStr then
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtCTACONDPGTOCD_COND.SetFocus;
      Abort;
    end;

  selectCDPGTO.Close;
  selectCDPGTO.SQL.Text := 'select '+
                              'ccp.cd_cond_pag, '+
                              'ccp.nm_cond_pag, '+
                              'ccp.cd_cta_forma_pagamento, '+
                              'cfp.nm_forma_pag, '+
                              'ccp.nr_parcelas, '+
                              'ccp.vl_minimo_parcela, '+
                              'ccp.fl_ativo '+
                            'from '+
                              'cta_cond_pagamento ccp '+
                            'join cta_forma_pagamento cfp on '+
                              'ccp.cd_cta_forma_pagamento = cfp.cd_forma_pag '+
                          'where cd_cond_pag = :cd_cond_pag';

  selectCDPGTO.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);

  selectCDPGTO.Open();

  edtCTACONDPGTODESCRICAO.Text := selectCDPGTO.FieldByName('nm_cond_pag').AsString;
  edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text := IntToStr(selectCDPGTO.FieldByName('cd_cta_forma_pagamento').AsInteger);
  edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := selectCDPGTO.FieldByName('nm_forma_pag').Text;
  //está dando erro ao carregar o nr_parcelas e vl_minimo_parcela na primeira vez
  edtCTACONDPGTOVL_MINIMO.Text := CurrToStr(selectCDPGTO.FieldByName('vl_minimo_parcela').AsCurrency);
  edtCTACONDPGTONR_PARCELAS.Text := IntToStr(selectCDPGTO.FieldByName('nr_parcelas').AsInteger);
  edtCTACONDPGTOFL_ATIVO.Checked := selectCDPGTO.FieldByName('fl_ativo').AsBoolean;
end;

procedure TfrmCadCondPgto.edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
//busca o nome da foma de pagamento
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
    selectCDPGTO.SQL.Text := 'select '+
                                  'nm_forma_pag '+
                             'from '+
                                  'cta_forma_pagamento '+
                             'where '+
                                  'cd_forma_pag = :cd_forma_pag ';
    selectCDPGTO.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
    selectCDPGTO.Open();
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := selectCDPGTO.FieldByName('nm_forma_pag').AsString;
    selectCDPGTO.Next;
end;



procedure TfrmCadCondPgto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadCondPgto := nil;
end;

procedure TfrmCadCondPgto.FormKeyPress(Sender: TObject; var Key: Char);
//passa pelos campos pressionando enter
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadCondPgto.LimpaCampos;
begin
    edtCTACONDPGTOCD_COND.Clear;
    edtCTACONDPGTODESCRICAO.Clear;
    edtCTACONDPGTOFL_ATIVO.Checked := false;
    edtCTACONDPGTOCD_CTA_FORMA_PGTO.Clear;
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Clear;
    edtCTACONDPGTOVL_MINIMO.Clear;
    edtCTACONDPGTOVL_MINIMO.Clear;
    edtCTACONDPGTONR_PARCELAS.Clear;
end;

end.
