unit cCTA_COND_PGTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Buttons, StrUtils;

type
  TfrmCadCondPgto = class(TForm)
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
const
  SQL = 'select '+
            'c.fl_ativo, '+
            'c.cd_cond_pag, '+
            'c.nm_cond_pag, '+
            'c.cd_cta_forma_pagamento, '+
            'f.nm_forma_pag, '+
            'c.vl_minimo_parcela, '+
            'c.nr_parcelas '+
          'from '+
            'cta_cond_pagamento c '+
          'join cta_forma_pagamento f on '+
            'c.cd_cta_forma_pagamento = f.cd_forma_pag '+
        'where cd_cond_pag = :cd_cond_pag';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try

    if edtCTACONDPGTOCD_COND.Text = EmptyStr then
    begin
      raise Exception.Create('C�digo n�o pode ser vazio');
      edtCTACONDPGTOCD_COND.SetFocus;
      Abort;
    end;

    qry.SQL.Add(SQL);
    qry.ParamByName('cd_cond_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_COND.Text);
    qry.Open();

    if not qry.IsEmpty then
    begin
      edtCTACONDPGTOFL_ATIVO.Checked := qry.FieldByName('fl_ativo').AsBoolean;
      edtCTACONDPGTODESCRICAO.Text := qry.FieldByName('nm_cond_pag').AsString;
      edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text := IntToStr(qry.FieldByName('cd_cta_forma_pagamento').AsInteger);
      edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := qry.FieldByName('nm_forma_pag').AsString;

      if qry.FieldByName('vl_minimo_parcela').AsCurrency = 0 then
        edtCTACONDPGTOVL_MINIMO.Text := ''
      else
        edtCTACONDPGTOVL_MINIMO.Text := FormatCurr('#,##0.00', qry.FieldByName('vl_minimo_parcela').AsCurrency);

      if qry.FieldByName('nr_parcelas').AsInteger = 0 then
        edtCTACONDPGTONR_PARCELAS.Text := ''
      else
        edtCTACONDPGTONR_PARCELAS.Text := IntToStr(qry.FieldByName('nr_parcelas').AsInteger);
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadCondPgto.edtCTACONDPGTOCD_CTA_FORMA_PGTOChange(Sender: TObject);
//busca o nome da foma de pagamento
const
  SQL = 'select '+
            'nm_forma_pag '+
       'from '+
            'cta_forma_pagamento '+
       'where '+
            'cd_forma_pag = :cd_forma_pag ';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  begin
    if edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = '' then
    begin
      edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := '';
      exit;
    end;
  end;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text);
    qry.Open();
    edtCTACONDPGTO_DESC_CTA_FORMA_PGTO.Text := qry.FieldByName('nm_forma_pag').AsString;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadCondPgto.excluir;
begin
  if (Application.MessageBox('Deseja Excluir a Condi��o de Pagamento?', 'Aviso', MB_YESNO) = IDYES) then
  begin
    try
      dm.conexaoBanco.ExecSQL('delete '+
                      ' from '+
                      'cta_cond_pagamento '+
                      ' where '+
                      'cd_cond_pag = :cd_cond_pag',
                      [StrToInt(edtCTACONDPGTOCD_COND.Text)]);
      ShowMessage('Condi��o de Pagamento exclu�da com sucesso!');
      limpaCampos;
    except
      on E:exception do
      begin
        ShowMessage('Erro ao excluir a condi��o de pagamento' + edtCTACONDPGTOCD_COND.Text + E.Message);
        dm.conexaoBanco.Rollback;
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
    limpaCampos
  else if key = VK_F2 then  //F2
    salvar
  else if key = VK_F4 then    //F4
    excluir
  else if key = VK_ESCAPE then //ESC
  if (Application.MessageBox('Deseja Fechar?','Aten��o', MB_YESNO) = IDYES) then
    Close;
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

  resultado := dm.conexaoBanco.ExecSQLScalar('select cd_cond_pag from cta_cond_pagamento where cd_cond_pag = :cd_cond_pag',
                            [StrToInt(edtCTACONDPGTOCD_COND.Text)]);

  if not resultado.IsEmpty then
    begin
      dm.conexaoBanco.StartTransaction;
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
      dm.conexaoBanco.Commit;
      ShowMessage('Condi��o de Pagamento cadastrada com Sucesso!');
      limpaCampos;
    end
  else
  begin
    dm.conexaoBanco.StartTransaction;
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
    dm.conexaoBanco.Commit;
    ShowMessage('Condi��o de Pagamento cadastrada com Sucesso!');
    limpaCampos;
  end;
except
  on E : exception do
  begin
    dm.conexaoBanco.Rollback;
    ShowMessage('Erro ao gravar os dados '+ E.Message);
    Exit;
  end;
end;
end;

procedure TfrmCadCondPgto.validaCampos;
begin
   //verifica se o c�digo da condi��o e forma de pagamento est�o vazias ao salvar
  if (edtCTACONDPGTOCD_COND.Text = EmptyStr) or (edtCTACONDPGTOCD_CTA_FORMA_PGTO.Text = EmptyStr)
  or (edtCTACONDPGTODESCRICAO.Text = EmptyStr) then
    raise Exception.Create('C�digo da Condi��o e Forma n�o podem ser vazios');
end;

end.
