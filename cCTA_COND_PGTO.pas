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
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCTACONDPGTOCD_CONDExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure salvar;
    procedure excluir;
    procedure validaCampos;
    procedure limpaCampos;
  public
    { Public declarations }

  end;

var
  frmCadCondPgto: TfrmCadCondPgto;

implementation

{$R *.dfm}

uses uDataModule;

procedure TfrmCadCondPgto.edtCTACONDPGTOCD_CONDExit(Sender: TObject);
begin
  if edtCTACONDPGTOCD_COND.Text = EmptyStr then
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtCTACONDPGTOCD_COND.SetFocus;
      Abort;
    end;

  selectCDPGTO.Close;
  selectCDPGTO.SQL.Clear;
  selectCDPGTO.SQL.Text := 'select '+
                              'c.fl_ativo, '+
                              'cd_cond_pag, '+
                              'nm_cond_pag, '+
                              'c.cd_cta_forma_pagamento, '+
                              'f.nm_forma_pag, '+
                              'vl_minimo_parcela, '+
                              'nr_parcelas '+
                            'from '+
                              'cta_cond_pagamento c '+
                            'join cta_forma_pagamento f on '+
                              'c.cd_cta_forma_pagamento = f.cd_forma_pag '+
                          'where cd_cond_pag = :cd_cond_pag';

  selectCDPGTO.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);

  selectCDPGTO.Open();

  if not selectCDPGTO.IsEmpty then
  begin
    edtCTACONDPGTOFL_ATIVO.Checked := selectCDPGTO.FieldByName('fl_ativo').AsBoolean;
    edtCTACONDPGTODESCRICAO.Text := selectCDPGTO.FieldByName('nm_cond_pag').AsString;
    edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text := IntToStr(selectCDPGTO.FieldByName('cd_cta_forma_pagamento').AsInteger);
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := selectCDPGTO.FieldByName('nm_forma_pag').Text;
    //está dando erro ao carregar o nr_parcelas e vl_minimo_parcela na primeira vez
    if selectCDPGTO.FieldByName('vl_minimo_parcela').AsCurrency = 0 then
    begin
      edtCTACONDPGTOVL_MINIMO.Text := '';
    end
    else
    begin
      edtCTACONDPGTOVL_MINIMO.Text := CurrToStr(selectCDPGTO.FieldByName('vl_minimo_parcela').AsCurrency);
    end;
    edtCTACONDPGTONR_PARCELAS.Text := IntToStr(selectCDPGTO.FieldByName('nr_parcelas').AsInteger);
  end
  else
    Exit;
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

procedure TfrmCadCondPgto.excluir;
begin
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
        limpaCampos;
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

procedure TfrmCadCondPgto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadCondPgto := nil;
end;

procedure TfrmCadCondPgto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_F3 then //F3
  begin
    limpaCampos;
  end
  else if key = VK_F2 then  //F2
  begin
    salvar;
  end
  else if key = VK_F4 then    //F4
  begin
    excluir;
  end
  else if key = VK_ESCAPE then //ESC
  begin
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
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

procedure TfrmCadCondPgto.limpaCampos;
begin
    edtCTACONDPGTOCD_COND.Clear;
    edtCTACONDPGTODESCRICAO.Clear;
    edtCTACONDPGTOFL_ATIVO.Checked := false;
    edtCTACONDPGTOCD_CTA_FORMA_PGTO.Clear;
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Clear;
    edtCTACONDPGTOVL_MINIMO.Clear;
    edtCTACONDPGTOVL_MINIMO.Clear;
    edtCTACONDPGTONR_PARCELAS.Clear;
    edtCTACONDPGTOCD_COND.SetFocus;
end;

procedure TfrmCadCondPgto.salvar;
var resultado : String;
begin
try
  validaCampos;

   resultado := conexao.ExecSQLScalar('select cd_cond_pag from cta_cond_pagamento where cd_cond_pag = :cd_cond_pag',
                            [StrToInt(edtCTACONDPGTOCD_COND.Text)]);

  if not resultado.IsEmpty then
    begin
      conexao.StartTransaction;
      sqlInsertCondPgto.SQL.Text :='update                                                  '+
                                        'cta_cond_pagamento                                 '+
                                    'set                                                    '+
                                    '    cd_cond_pag = :cd_cond_pag,                        '+
                                     '   nm_cond_pag = :nm_cond_pag,                        '+
                                      '  cd_cta_forma_pagamento = :cd_cta_forma_pagamento,  '+
                                      '  nr_parcelas = :nr_parcelas,                        '+
                                      '  vl_minimo_parcela = :vl_minimo_parcela,            '+
                                      '  fl_ativo = :fl_ativo                               '+
                                    'where                                                  '+
                                      '  cd_cond_pag = :cd_cond_pag';

      sqlInsertCondPgto.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);
      sqlInsertCondPgto.ParamByName('nm_cond_pag').AsString := edtCTACONDPGTODESCRICAO.Text;
      sqlInsertCondPgto.ParamByName('cd_cta_forma_pagamento').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
            if edtCTACONDPGTONR_PARCELAS.Text = '' then
      begin
        sqlInsertCondPgto.ParamByName('nr_parcelas').AsInteger := 0;
      end
      else
      begin
        sqlInsertCondPgto.ParamByName('nr_parcelas').AsInteger := StrToInt(edtCTACONDPGTONR_PARCELAS.Text);
      end;
      if edtCTACONDPGTOVL_MINIMO.Text = '' then
      begin
        sqlInsertCondPgto.ParamByName('vl_minimo_parcela').AsCurrency := 0;
      end
      else
      begin
         sqlInsertCondPgto.ParamByName('vl_minimo_parcela').AsCurrency := StrToCurr(edtCTACONDPGTOVL_MINIMO.Text);
      end;
      sqlInsertCondPgto.ParamByName('fl_ativo').AsBoolean := edtCTACONDPGTOFL_ATIVO.Checked;

      sqlInsertCondPgto.ExecSQL;
      conexao.Commit;
      ShowMessage('Condição de Pagamento cadastrada com Sucesso!');
      limpaCampos;
    end
  else
    begin
      conexao.StartTransaction;
      sqlInsertCondPgto.SQL.Text := 'insert                           '+
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
                                    ':fl_ativo)';

      sqlInsertCondPgto.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);
      sqlInsertCondPgto.ParamByName('nm_cond_pag').AsString := edtCTACONDPGTODESCRICAO.Text;
      sqlInsertCondPgto.ParamByName('cd_cta_forma_pagamento').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
      if edtCTACONDPGTONR_PARCELAS.Text = '' then
      begin
        sqlInsertCondPgto.ParamByName('nr_parcelas').AsInteger := 0;
      end
      else
      begin
        sqlInsertCondPgto.ParamByName('nr_parcelas').AsInteger := StrToInt(edtCTACONDPGTONR_PARCELAS.Text);
      end;
      if edtCTACONDPGTOVL_MINIMO.Text = '' then
      begin
        sqlInsertCondPgto.ParamByName('vl_minimo_parcela').AsCurrency := 0;
      end
      else
      begin
         sqlInsertCondPgto.ParamByName('vl_minimo_parcela').AsCurrency := StrToCurr(edtCTACONDPGTOVL_MINIMO.Text);
      end;
      sqlInsertCondPgto.ParamByName('fl_ativo').AsBoolean := edtCTACONDPGTOFL_ATIVO.Checked;

      sqlInsertCondPgto.ExecSQL;
      conexao.Commit;
      ShowMessage('Condição de Pagamento cadastrada com Sucesso!');
      limpaCampos;
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

procedure TfrmCadCondPgto.validaCampos;
begin
   //verifica se o código da condição e forma de pagamento estão vazias ao salvar
  if (edtCTACONDPGTOCD_COND.Text = EmptyStr) or (edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = EmptyStr)
  or (edtCTACONDPGTODESCRICAO.Text = EmptyStr) then
    raise Exception.Create('Código da Condição e Forma não podem ser vazios');
end;

end.
