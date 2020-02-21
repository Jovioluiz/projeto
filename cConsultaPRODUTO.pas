unit cConsultaPRODUTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Data.FMTBcd, Data.DB, Data.SqlExpr, uConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls;

type
  TfConsultaProduto = class(TfConexao)
    tpCadProduto: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtPRODUTOCD_PRODUTO: TEdit;
    edtPRODUTODESCRICAO: TEdit;
    ckPRODUTOATIVO: TCheckBox;
    edtPRODUTOUN_MEDIDA: TEdit;
    edtPRODUTOFATOR_CONVERSAO: TEdit;
    edtPRODUTOPESO_LIQUIDO: TEdit;
    edtPRODUTOPESO_BRUTO: TEdit;
    memoObservacao: TMemo;
    btnPRODUTOCANCELAR: TButton;
    comandoSelect: TFDQuery;
    btnEditar: TButton;
    btnGravar: TButton;
    sqlUpdate: TFDQuery;
    Label8: TLabel;
    edtQtdEstoque: TEdit;
    procedure btnPRODUTOCANCELARClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtPRODUTOCD_PRODUTOExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure verificaClicouFechar();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConsultaProduto: TfConsultaProduto;
  cd_produto : String;

implementation

{$R *.dfm}



procedure TfConsultaProduto.btnEditarClick(Sender: TObject);
begin
  inherited;
    edtPRODUTOCD_PRODUTO.Enabled := false;
    ckPRODUTOATIVO.Enabled := true;
    edtPRODUTODESCRICAO.Enabled := true;
    edtPRODUTOUN_MEDIDA.Enabled := true;
    edtPRODUTOFATOR_CONVERSAO.Enabled := true;
    edtPRODUTOPESO_LIQUIDO.Enabled := true;
    edtPRODUTOPESO_BRUTO.Enabled := true;
    memoObservacao.Enabled := true;
    btnGravar.Enabled := true;
end;

procedure TfConsultaProduto.btnGravarClick(Sender: TObject);
begin
  inherited;
  sqlUpdate.Close;
  sqlUpdate.SQL.Text := 'update produto set fl_ativo = :fl_ativo, desc_produto = :desc_produto, '+
                        'un_medida = :un_medida, fator_conversao = :fator_conversao, peso_liquido = :peso_liquido, '+
                        'peso_bruto = :peso_bruto, observacao = :observacao where cd_produto = :cd_produto';

  sqlUpdate.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  sqlUpdate.ParamByName('fl_ativo').AsBoolean := ckPRODUTOATIVO.Checked;
  sqlUpdate.ParamByName('desc_produto').AsString := edtPRODUTODESCRICAO.Text;
  sqlUpdate.ParamByName('un_medida').AsString := edtPRODUTOUN_MEDIDA.Text;
  sqlUpdate.ParamByName('fator_conversao').AsCurrency := StrToCurr(edtPRODUTOFATOR_CONVERSAO.Text);
  sqlUpdate.ParamByName('peso_liquido').AsCurrency := StrToCurr(edtPRODUTOPESO_LIQUIDO.Text);
  sqlUpdate.ParamByName('peso_bruto').AsCurrency := StrToCurr(edtPRODUTOPESO_BRUTO.Text);
  sqlUpdate.ParamByName('observacao').AsString := memoObservacao.Text;


  try
    sqlUpdate.ExecSQL;
    sqlUpdate.Close;
    //FreeAndNil(sqlUpdate);
    ShowMessage('Produto Alterado com Sucesso');

    //limpa os campos após alterar
    edtPRODUTOCD_PRODUTO.Text := '';
    ckPRODUTOATIVO.Checked := false;
    edtPRODUTODESCRICAO.Text := '';
    edtPRODUTOUN_MEDIDA.Text := '';
    edtPRODUTOFATOR_CONVERSAO.Text := '';
    edtPRODUTOPESO_LIQUIDO.Text := '';
    edtPRODUTOPESO_BRUTO.Text := '';
    memoObservacao.Text := '';
    edtQtdEstoque.Text := '';

    edtPRODUTOCD_PRODUTO.Enabled := true;

  except
    on E:exception do
      begin
        ShowMessage('Erro ao gravar os dados do produto '+ E.Message);
        exit;
      end;
  end;
end;

procedure TfConsultaProduto.btnPRODUTOCANCELARClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;


procedure TfConsultaProduto.edtPRODUTOCD_PRODUTOExit(Sender: TObject);
begin
  comandoSelect.Close;
  comandoSelect.SQL.Text := 'select cd_produto, '+
                                'fl_ativo, '+
                                'desc_produto, '+
                                'un_medida, '+
                                'fator_conversao, '+
                                'peso_liquido, '+
                                'peso_bruto, '+
                                'observacao, '+
                                'qtd_estoque '+
                            'from produto '+
                                'where cd_produto = :cd_produto';
  comandoSelect.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  comandoSelect.Open();
  comandoSelect.First();

  {verifica se encontrou algum registro, se encontrou mostra o produto,
    se não encontrou pode ser cadastrado outro produto }
  if comandoSelect <> nil then
      edtPRODUTOCD_PRODUTO.Text := IntToStr(comandoSelect.FieldByName('cd_produto').AsInteger);
      ckPRODUTOATIVO.Checked := comandoSelect.FieldByName('fl_ativo').AsBoolean;
      edtPRODUTODESCRICAO.Text := comandoSelect.FieldByName('desc_produto').AsString;
      edtPRODUTOUN_MEDIDA.Text := comandoSelect.FieldByName('un_medida').AsString;
      edtPRODUTOFATOR_CONVERSAO.Text := CurrToStr(comandoSelect.FieldByName('fator_conversao').AsCurrency);
      edtPRODUTOPESO_LIQUIDO.Text := CurrToStr(comandoSelect.FieldByName('peso_liquido').AsCurrency);
      edtPRODUTOPESO_BRUTO.Text := CurrToStr(comandoSelect.FieldByName('peso_bruto').AsCurrency);
      memoObservacao.Text := comandoSelect.FieldByName('observacao').AsString;
      edtQtdEstoque.Text := CurrToStr(comandoSelect.FieldByName('qtd_estoque').AsCurrency);

      //desabilita os campos para edição
      edtPRODUTOCD_PRODUTO.Enabled := false;
      ckPRODUTOATIVO.Enabled := false;
      edtPRODUTODESCRICAO.Enabled := false;
      edtPRODUTOUN_MEDIDA.Enabled := false;
      edtPRODUTOFATOR_CONVERSAO.Enabled := false;
      edtPRODUTOPESO_LIQUIDO.Enabled := false;
      edtPRODUTOPESO_BRUTO.Enabled := false;
      memoObservacao.Enabled := false;
      edtQtdEstoque.Enabled := false;
      btnGravar.Enabled := false;
end;

//passa pelos campos pressionando enter
procedure TfConsultaProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;


procedure TfConsultaProduto.verificaClicouFechar();
begin
  //verifica se foi clicado no fechar, se clicou, não valida o cod. produto vazio
  if btnPRODUTOCANCELAR.MouseInClient then
    begin
      exit;
    end
  else
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtPRODUTOCD_PRODUTO.SetFocus;
      Abort;
    end;
end;

end.
