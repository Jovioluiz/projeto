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

uses
  uclCtaFormaPagamento;

{$R *.dfm}

procedure TfrmCadFormaPagamento.edtCTA_FORMA_PGTOCODIGOExit(Sender: TObject);
const
  SQL = 'select                          '+
         '  cd_forma_pag,                 '+
         '  nm_forma_pag,                 '+
         '  fl_ativo,                     '+
         '  tp_classificacao              '+
         'from                            '+
         '  cta_forma_pagamento           '+
         'where                           '+
         '  cd_forma_pag = :cd_forma_pag';
var
  qry: TFDQuery;
begin
  if edtCTA_FORMA_PGTOCODIGO.Text = EmptyStr then
  begin
    raise Exception.Create('Código não pode ser vazio');
    edtCTA_FORMA_PGTOCODIGO.SetFocus;
  end;

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_forma_pag').AsInteger := StrToInt(edtCTA_FORMA_PGTOCODIGO.Text);
    qry.Open();

    if not qry.IsEmpty then
      begin
        edtCTA_FORMA_PGTODESCRICAO.Text := qry.FieldByName('nm_forma_pag').AsString;
        edtCTA_FORMA_PGTOFL_ATIVO.Checked := qry.FieldByName('fl_ativo').AsBoolean;

        case qry.FieldByName('tp_classificacao').AsInteger of
          0: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 0;
          1: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 1;
          2: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 2;
          3: edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex := 3;
        end;
      end
    else
      Exit;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadFormaPagamento.excluir;
var
  persistencia: TCtaFormaPagamento;
begin
  persistencia := TCtaFormaPagamento.Create;

  try
    if edtCTA_FORMA_PGTOCODIGO.Text <> '' then
    begin
      if (Application.MessageBox('Deseja Excluir a Forma de Pagamento?', 'Aviso', MB_YESNO) = IDYES) then
      begin
        persistencia.cd_forma_pgto := StrToInt(edtCTA_FORMA_PGTOCODIGO.Text);
        persistencia.Excluir;
        limpaCampos;
      end;
    end;
  finally
    persistencia.Free;
  end;
end;

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

//passa pelos campos pressionando enter
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
var
  persistencia: TCtaFormaPagamento;
begin
  validaCampos;

  persistencia := TCtaFormaPagamento.Create;

  try
    persistencia.cd_forma_pgto := StrToInt(edtCTA_FORMA_PGTOCODIGO.Text);
    persistencia.nm_forma_pgto := edtCTA_FORMA_PGTODESCRICAO.Text;
    persistencia.fl_ativo := edtCTA_FORMA_PGTOFL_ATIVO.Checked;
    persistencia.tp_classificacao := edtCTA_FORMA_PGTOCLASSIFICACAO.ItemIndex;

    if not persistencia.Pesquisar(StrToInt(edtCTA_FORMA_PGTOCODIGO.Text)) then
    begin
      persistencia.Inserir;
      limpaCampos;
    end
    else
    begin
      persistencia.Atualizar;
      limpaCampos;
    end;
  finally
    persistencia.Free;
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
