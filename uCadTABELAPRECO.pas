unit uCadTABELAPRECO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCadTabelaPrecoProduto, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient;

type
  TfrmcadTabelaPreco = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtFl_ativo: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    edtCodTabela: TEdit;
    edtNomeTabela: TEdit;
    edtDtInicial: TMaskEdit;
    edtDtFinal: TMaskEdit;
    DBGridProduto: TDBGrid;
    btnAdicionarProduto: TButton;
    btnSalvar: TButton;
    btnFechar: TButton;
    sqlTabelaPreco: TFDQuery;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btnLimpar: TButton;
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edtCodTabelaExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcadTabelaPreco: TfrmcadTabelaPreco;

implementation

{$R *.dfm}



procedure TfrmcadTabelaPreco.btnAdicionarProdutoClick(Sender: TObject);
begin
  frmCadTabelaPrecoProduto :=  TfrmCadTabelaPrecoProduto.Create(Self);
  frmCadTabelaPrecoProduto.ShowModal;
end;

procedure TfrmcadTabelaPreco.btnFecharClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente fechar?', mtConfirmation,[mbYes, mbNo],0) = 6 then
    begin
      Close;
    end;
end;


procedure TfrmcadTabelaPreco.btnSalvarClick(Sender: TObject);
begin
  sqlTabelaPreco.Close;
  //sqlTabelaPreco.SQL.Clear;
  //verifica se possui tabela com o mesmo código
  sqlTabelaPreco.SQL.Text := 'select cd_tabela from tabela_preco where cd_tabela = :cd_tabela';
  sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPreco.Open();
  
  if not sqlTabelaPreco.IsEmpty then
    //update
     begin
        sqlTabelaPreco.Close;
        sqlTabelaPreco.SQL.Text := 'update tabela_preco set nm_tabela = :nm_tabela, fl_ativo = :fl_ativo, '+
                                    'dt_inicio = :dt_inicio, dt_fim = :dt_fim where cd_tabela = :cd_tabela';

        sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
        sqlTabelaPreco.ParamByName('nm_tabela').AsString := edtNomeTabela.Text;
        sqlTabelaPreco.ParamByName('fl_ativo').AsBoolean := edtFl_ativo.Checked;
        sqlTabelaPreco.ParamByName('dt_inicio').AsDate := StrToDate(edtDtInicial.Text);
        sqlTabelaPreco.ParamByName('dt_fim').AsDate := StrToDate(edtDtFinal.Text);

        try
          sqlTabelaPreco.ExecSQL;
          sqlTabelaPreco.Close;
          //FreeAndNil(sqlTabelaPreco);
          ShowMessage('Dados Alterados com Sucesso');

          edtCodTabela.Text := '';
          edtNomeTabela.Text := '';
          edtFl_ativo.Checked := false;
          edtDtInicial.Text := '';
          edtDtFinal.Text := '';
              
        except
          on E:exception do
            begin
               ShowMessage('Erro ao gravar os dados'+ E.Message);
                exit;
            end;
        end;
     end
    else
      begin
        sqlTabelaPreco.Close;
        sqlTabelaPreco.SQL.Text := 'insert into tabela_preco (cd_tabela, nm_tabela,fl_ativo,dt_inicio,dt_fim) '+
                                'values (:cd_tabela,:nm_tabela,:fl_ativo,:dt_inicio,:dt_fim)';

        sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
        sqlTabelaPreco.ParamByName('nm_tabela').AsString := edtNomeTabela.Text;
        sqlTabelaPreco.ParamByName('fl_ativo').AsBoolean := edtFl_ativo.Checked;
        sqlTabelaPreco.ParamByName('dt_inicio').AsDate := StrToDate(edtDtInicial.Text);
        sqlTabelaPreco.ParamByName('dt_fim').AsDate := StrToDate(edtDtFinal.Text);

        try
          sqlTabelaPreco.ExecSQL;
          sqlTabelaPreco.Close;
          //FreeAndNil(sqlTabelaPreco);
          ShowMessage('Tabela de Preço cadastrada com Sucesso!');
          btnAdicionarProduto.Enabled := false;

          edtFl_ativo.Checked := false;
          edtCodTabela.Text := '';
          edtNomeTabela.Text := '';
          edtDtInicial.Text := '';
          edtDtFinal.Text := '';

        except
          on E : exception do
            begin
              ShowMessage('Erro ao gravar os dados '+ E.Message);
              exit;
            end;

        end;
      end;

  DBGridProduto.DataSource.Destroy;
end;

procedure TfrmcadTabelaPreco.btnLimparClick(Sender: TObject);
begin
  edtFl_ativo.Checked := false;
  edtCodTabela.Text := '';
  edtNomeTabela.Text := '';
  edtDtInicial.Text := '';
  edtDtFinal.Text := '';
  DBGridProduto.DataSource.Destroy;

end;

procedure TfrmcadTabelaPreco.edtCodTabelaExit(Sender: TObject);

begin
  if edtCodTabela.Text = EmptyStr then
    begin
     btnAdicionarProduto.Enabled := false;
     exit;
    end;


  sqlTabelaPreco.Close;
  sqlTabelaPreco.SQL.Text := 'select cd_tabela, nm_tabela, fl_ativo, dt_inicio, dt_fim '+
                              'from '+
                              'tabela_preco '+
                              'where cd_tabela = :cd_tabela';

  sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPreco.Open();

  edtFl_ativo.Checked := sqlTabelaPreco.FieldByName('fl_ativo').AsBoolean;
  edtNomeTabela.Text := sqlTabelaPreco.FieldByName('nm_tabela').AsString;
  edtDtInicial.Text := DateToStr(sqlTabelaPreco.FieldByName('dt_inicio').AsDateTime);
  edtDtFinal.Text := DateToStr(sqlTabelaPreco.FieldByName('dt_fim').AsDateTime);
  btnAdicionarProduto.Enabled := true;

FDQuery1.Close;
FDQuery1.SQL.Text := 'select p.cd_produto,p.desc_produto,valor,p.un_medida '+
                        'from produto p '+
                        'join tabela_preco_produto tpp on '+
                        'p.cd_produto = tpp.cd_produto '+
                        'where tpp.cd_tabela = :cd_tabela';
FDQuery1.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
FDQuery1.Open();


{
  ClientDataSet1.CommandText := 'select p.cd_produto,p.desc_produto,valor,p.un_medida '+
                        'from produto p '+
                        'join tabela_preco_produto tpp on '+
                        'p.cd_produto = tpp.cd_produto '+
                        'where tpp.cd_tabela = :cd_tabela';  }

  //FDQuery1.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  //FDQuery1.Open();

  DBGridProduto.DataSource := DataSource1;
  DBGridProduto.Columns[0].Title.Caption := 'Cod. Produto';
  DBGridProduto.Columns[0].FieldName := 'cd_produto';
  DBGridProduto.Columns[1].Title.Caption := 'Nome Produto';
  DBGridProduto.Columns[1].FieldName := 'desc_produto';
  DBGridProduto.Columns[2].Title.Caption := 'Valor';
  DBGridProduto.Columns[2].FieldName := 'valor';
  DBGridProduto.Columns[3].Title.Caption := 'UN Medida';
  DBGridProduto.Columns[3].FieldName := 'un_medida';
  //ClientDataSet1.Open;


end;

procedure TfrmcadTabelaPreco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;

end.
