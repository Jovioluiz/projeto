unit cCTA_FORMA_PAGAMENTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.FMTBcd, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, Vcl.Buttons, uDataModule;

type
  TfrmCadFormaPagamento = class(TForm)
    tpCadFormaPgto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCTA_FORMA_PGTOCODIGO: TEdit;
    edtCTA_FORMA_PGTODESCRICAO: TEdit;
    edtCTA_FORMA_PGTOFL_ATIVO: TCheckBox;
    edtCTA_FORMA_PGTOCLASSIFICACAO: TRadioGroup;
    sqlFormaPgto: TFDQuery;
    procedure edtCTA_FORMA_PGTOCODIGOExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure limpaCampos;
    procedure salvar;
    procedure excluir;
    procedure validaCampos;
  public
    { Public declarations }

  end;

var
  frmCadFormaPagamento: TfrmCadFormaPagamento;

implementation

{$R *.dfm}

procedure TfrmCadFormaPagamento.edtCTA_FORMA_PGTOCODIGOExit(Sender: TObject);
begin
  if edtCTA_FORMA_PGTOCODIGO.Text = EmptyStr then
  begin
    raise Exception.Create('Código não pode ser vazio');
    edtCTA_FORMA_PGTOCODIGO.SetFocus;
    Abort;
  end;

  sqlFormaPgto.Close;
  sqlFormaPgto.SQL.Text := 'select                          '+
                           '  cd_forma_pag,                 '+
                           '  nm_forma_pag,                 '+
                           '  fl_ativo,                     '+
                           '  tp_classificacao              '+
                           'from                            '+
                           '  cta_forma_pagamento           '+
                           'where                           '+
                           '  cd_forma_pag = :cd_forma_pag';
  sqlFormaPgto.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTA_FORMA_PGTOCODIGO.Text);
  sqlFormaPgto.Open();

  if not sqlFormaPgto.IsEmpty then
    begin
      edtCTA_FORMA_PGTODESCRICAO.Text := sqlFormaPgto.FieldByName('nm_forma_pag').AsString;
      edtCTA_FORMA_PGTOFL_ATIVO.Checked := sqlFormaPgto.FieldByName('fl_ativo').AsBoolean;

      case sqlFormaPgto.FieldByName('tp_classificacao').AsInteger of
        0: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 0;
        1: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 1;
        2: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 2;
        3: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 3;
      end;
    end
  else
    Exit;
end;

procedure TfrmCadFormaPagamento.excluir;
begin
  if (Application.MessageBox('Deseja Excluir a Forma de Pagamento?', 'Atenção', MB_YESNO) = IDYES) then
  begin
    try
      dm.conexaoBanco.ExecSQL('delete '+
                      ' from '+
                      'cta_forma_pagamento '+
                      ' where '+
                      'cd_forma_pag = :cd_forma_pag',
                          [StrToInt(edtCTA_FORMA_PGTOCODIGO.Text)]);
      ShowMessage('Forma de Pagamento excluída com sucesso!');
      LimpaCampos;
    except
      on E:exception do
      begin
        ShowMessage('Erro ao excluir a Forma de Pagamento ' + edtCTA_FORMA_PGTOCODIGO.Text + E.Message);
        dm.conexaoBanco.Rollback;
        Exit;
      end;
    end;
  end;
end;

//passa pelos campos pressionando enter
procedure TfrmCadFormaPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadFormaPagamento := nil;
end;

procedure TfrmCadFormaPagamento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_F3 then //F3
    limpaCampos
  else if key = VK_F2 then //F2
    salvar
  else if key = VK_F4 then //F4
    excluir
  else if key = VK_ESCAPE then //ESC
  if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

procedure TfrmCadFormaPagamento.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmCadFormaPagamento.limpaCampos;
begin
  edtCTA_FORMA_PGTOCODIGO.Clear;
  edtCTA_FORMA_PGTODESCRICAO.Clear;
  edtCTA_FORMA_PGTOFL_ATIVO.Checked := false;
  edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := -1;
  edtCTA_FORMA_PGTOCODIGO.SetFocus;
end;

procedure TfrmCadFormaPagamento.salvar;
var resultado : String;
begin
  try
    validaCampos;

    resultado := dm.conexaoBanco.ExecSQLScalar('select cd_forma_pag from cta_forma_pagamento where cd_forma_pag = :cd_forma_pag',
                                        [StrToInt(edtCTA_FORMA_PGTOCODIGO.Text)]);
    if not resultado.IsEmpty then
    begin
      dm.conexaoBanco.ExecSQL('update                             '+
                          'cta_forma_pagamento                    '+
                      'set                                        '+
                      '    cd_forma_pag = :cd_forma_pag,          '+
                       '   nm_forma_pag = :nm_forma_pag,          '+
                        '  fl_ativo = :fl_ativo,                  '+
                        '  tp_classificacao = :tp_classificacao   '+
                      'where                                      '+
                        'cd_forma_pag = :cd_forma_pag',
                        [StrToInt(edtCTA_FORMA_PGTOCODIGO.Text),
                        edtCTA_FORMA_PGTODESCRICAO.Text,
                        edtCTA_FORMA_PGTOFL_ATIVO.Checked,
                        edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex.ToString]);
      ShowMessage('Forma de Pagamento cadastrada com Sucesso!');
      LimpaCampos;
    end
    else
    begin
      dm.conexaoBanco.ExecSQL('insert                                '+
                          'into                              '+
                          'cta_forma_pagamento(cd_forma_pag, '+
                          'nm_forma_pag,                     '+
                          'fl_ativo,                         '+
                          'tp_classificacao)                 '+
                      'values (:cd_forma_pag,                '+
                          ':nm_forma_pag,                    '+
                          ':fl_ativo,                        '+
                          ':tp_classificacao)',
                  [StrToInt(edtCTA_FORMA_PGTOCODIGO.Text),
                  edtCTA_FORMA_PGTODESCRICAO.Text,
                  edtCTA_FORMA_PGTOFL_ATIVO.Checked,
                  edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex.ToString],
                  [ftInteger, ftString, ftBoolean, ftInteger]);
      ShowMessage('Forma de Pagamento cadastrada com Sucesso!');
      LimpaCampos;
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

procedure TfrmCadFormaPagamento.validaCampos;
begin
  //verifica se o código está vazio
  if (edtCTA_FORMA_PGTOCODIGO.Text = EmptyStr) or (edtCTA_FORMA_PGTODESCRICAO.Text = EmptyStr)
    or (edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex = -1) then
    raise Exception.Create('Código, Descrição e Classificação não podem ser vazios');
end;

end.
