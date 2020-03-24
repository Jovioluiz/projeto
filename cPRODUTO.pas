unit cPRODUTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Data.FMTBcd, Data.DB, Data.SqlExpr, uConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls;

type
  TfrmCadProduto = class(TfConexao)
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
    btnPRODUTOCADASTRAR: TButton;
    btnPRODUTOCANCELAR: TButton;
    sqlInsertProduto: TSQLQuery;
    comandoSelect: TFDQuery;
    comandosql: TFDQuery;
    procedure btnPRODUTOCANCELARClick(Sender: TObject);
    procedure btnPRODUTOCADASTRARClick(Sender: TObject);
    procedure edtPRODUTOCD_PRODUTOExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;
  cd_produto : String;

implementation

{$R *.dfm}

//ALTERAR ESTE CADASTRO PARA FICAR COMO O uCadastroTributacaoItem COM VÁRIAS PageControl

procedure TfrmCadProduto.btnPRODUTOCADASTRARClick(Sender: TObject);
begin
//realizar o update do produto neste form e excluir o form cConsultaPRODUTO (verCadTABELAPRECO como fazer)

//verifica se o código, descrção e UN estão vazios
if (edtPRODUTOCD_PRODUTO.Text = EmptyStr) or (edtPRODUTODESCRICAO.Text = EmptyStr) or (edtPRODUTOUN_MEDIDA.Text = EmptyStr) then
  begin
    raise Exception.Create('Código, Descrição e Unidade de Medida não podem ser vazios');
  end;

  comandosql.Close;
  comandosql.SQL.Add('insert into produto(cd_produto,fl_ativo,desc_produto,un_medida,fator_conversao,peso_liquido,peso_bruto,observacao)');
  comandosql.SQL.Add('values (:cd_produto,:fl_ativo,:desc_produto,:un_medida,:fator_conversao,:peso_liquido,:peso_bruto, :observacao)');


  comandosql.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  comandosql.ParamByName('fl_ativo').AsBoolean := ckPRODUTOATIVO.Checked;
  comandosql.ParamByName('desc_produto').AsString := edtPRODUTODESCRICAO.Text;
  comandosql.ParamByName('un_medida').AsString := edtPRODUTOUN_MEDIDA.Text;
  comandosql.ParamByName('fator_conversao').AsCurrency := StrToCurr(edtPRODUTOFATOR_CONVERSAO.Text);
  comandosql.ParamByName('peso_liquido').AsCurrency := StrToCurr(edtPRODUTOPESO_LIQUIDO.Text);
  comandosql.ParamByName('peso_bruto').AsCurrency := StrToCurr(edtPRODUTOPESO_BRUTO.Text);
  comandosql.ParamByName('observacao').AsString := memoObservacao.Text;

  try
    comandosql.Execute;
    comandosql.Close;
    ShowMessage('Produto cadastrado com Sucesso!');

    //limpa os campos após inserir
    edtPRODUTOCD_PRODUTO.Text := '';
    ckPRODUTOATIVO.Checked := false;
    edtPRODUTODESCRICAO.Text := '';
    edtPRODUTOUN_MEDIDA.Text := '';
    edtPRODUTOFATOR_CONVERSAO.Text := '';
    edtPRODUTOPESO_LIQUIDO.Text := '';
    edtPRODUTOPESO_BRUTO.Text := '';
    memoObservacao.Text := '';

  except
    on E:exception do
    begin
      ShowMessage('Erro ao gravar os dados do produto '+ E.Message);
      exit;
    end;

  end;
end;

procedure TfrmCadProduto.btnPRODUTOCANCELARClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;

procedure TfrmCadProduto.edtPRODUTOCD_PRODUTOExit(Sender: TObject);
begin
  inherited;
  //verifica se foi clicado no fechar, se clicou, não valida o cod. produto vazio
  if btnPRODUTOCANCELAR.MouseInClient then
    begin
      exit;
    end
  else if edtPRODUTOCD_PRODUTO.Text = EmptyStr then
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtPRODUTOCD_PRODUTO.SetFocus;
      Abort;
    end;

end;

//passa pelos campos pressionando enter
procedure TfrmCadProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;

end.
