unit uCadTABELAPRECO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCadTabelaPrecoProduto, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.UITypes, Datasnap.DBClient, uUtil,
  uDataModule;

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
    sqlTabelaPreco: TFDQuery;
    sqlTabelaPrecoProduto: TFDQuery;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure edtCodTabelaExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure limpaCampos;
    procedure salvar;
    procedure excluir;
  public
    { Public declarations }

  end;

var
  frmcadTabelaPreco: TfrmcadTabelaPreco;
  temPermissao : Boolean;
  cliente : TValidaDados;


implementation

{$R *.dfm}

uses uLogin;

procedure TfrmcadTabelaPreco.btnAdicionarProdutoClick(Sender: TObject);
begin
  //aberto := True;arrumar
  temPermissao := False;
  cliente := TValidaDados.Create;
  temPermissao := cliente.validaAcessoAcao(idUsuario, 6);

  if temPermissao = True then
  begin
    frmCadTabelaPrecoProduto := TfrmCadTabelaPrecoProduto.Create(Self);
    frmCadTabelaPrecoProduto.Show;
  end;
end;

procedure TfrmcadTabelaPreco.DBGridProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if KEY = VK_DELETE then
  begin
    if (Application.MessageBox('Deseja Excluir o produto da Tabela?', 'Aten��o', MB_YESNO) = IDYES) then
    begin
      try
        sqlTabelaPreco.Close;
        sqlTabelaPreco.SQL.Text := 'delete                '+
                                   '   from               '+
                                   'tabela_preco_produto  '+
                                   '   where              '+
                                   'cd_produto = :cd_produto';
        sqlTabelaPreco.ParamByName('cd_produto').AsInteger := StrToInt(DBGridProduto.Columns[0].Field.Text);
        sqlTabelaPreco.ExecSQL;

      except
        on E : exception do
          ShowMessage('Erro ao Excluir o produto ' + IntToStr(ClientDataSet1.FieldByName('Produto').AsInteger) +
                    ' da tabela de pre�o' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmcadTabelaPreco.edtCodTabelaExit(Sender: TObject);
begin
  if edtCodTabela.Text = EmptyStr then
  begin
   btnAdicionarProduto.Enabled := false;
   Exit;
  end;

  sqlTabelaPreco.Close;
  sqlTabelaPreco.SQL.Text := 'select                '+
                                  'cd_tabela,       '+
                                  'nm_tabela,       '+
                                  'fl_ativo,        '+
                                  'dt_inicio,       '+
                                  'dt_fim           '+
                              'from                 '+
                                  'tabela_preco     '+
                              'where                '+
                                  'cd_tabela = :cd_tabela';

  sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPreco.Open();

  edtFl_ativo.Checked := sqlTabelaPreco.FieldByName('fl_ativo').AsBoolean;
  edtNomeTabela.Text := sqlTabelaPreco.FieldByName('nm_tabela').AsString;
  edtDtInicial.Text := DateToStr(sqlTabelaPreco.FieldByName('dt_inicio').AsDateTime);
  edtDtFinal.Text := DateToStr(sqlTabelaPreco.FieldByName('dt_fim').AsDateTime);
  btnAdicionarProduto.Enabled := true;

  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select                         '+
                                      'p.cd_produto,                '+
                                      'p.desc_produto,              '+
                                      'valor,                       '+
                                      'p.un_medida                  '+
                                  'from                             '+
                                      'produto p                    '+
                                  'join tabela_preco_produto tpp on '+
                                      'p.cd_produto = tpp.cd_produto '+
                                  'where                            '+
                                      'tpp.cd_tabela = :cd_tabela';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.Open();

  DBGridProduto.DataSource := DataSource1;
  DBGridProduto.Columns[0].Title.Caption := 'Produto';
  DBGridProduto.Columns[0].FieldName := 'cd_produto';
  DBGridProduto.Columns[1].Title.Caption := 'Nome Produto';
  DBGridProduto.Columns[1].FieldName := 'desc_produto';
  DBGridProduto.Columns[2].Title.Caption := 'Valor';
  DBGridProduto.Columns[2].FieldName := 'valor';
  DBGridProduto.Columns[3].Title.Caption := 'UN Medida';
  DBGridProduto.Columns[3].FieldName := 'un_medida';


end;

procedure TfrmcadTabelaPreco.excluir;
begin
  if (Application.MessageBox('Deseja Excluir a Tabela de Pre�o?', 'Aten��o', MB_YESNO) = IDYES) then
  begin
    try
      sqlTabelaPreco.Close;
      sqlTabelaPreco.SQL.Text := 'delete                  '+
                                 '   from                 '+
                                 'tabela_preco            '+
                                 '   where                '+
                                 'cd_tabela = :cd_tabela';
      sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
      sqlTabelaPreco.ExecSQL;
      limpaCampos;

    except
      on E:exception do
      begin
        ShowMessage('Erro ao excluir a tabela '+ E.Message);
        Exit;
      end;
    end;
  end;
end;

procedure TfrmcadTabelaPreco.FormActivate(Sender: TObject);
{quando fechar o formulario (uCadTabelaPrecoProduto) de adicionar o produto na tabela de pre�o,
sempre vai executar o sql abaixo, para atualizar os valores dos produtos no grid}
begin
  inherited;
  //arrumar
//  if aberto = False then
//  begin
//    sqlTabelaPrecoProduto.Close;
//    sqlTabelaPrecoProduto.SQL.Text := 'select                         '+
//                                        'p.cd_produto,                '+
//                                        'p.desc_produto,              '+
//                                        'valor,                       '+
//                                        'p.un_medida                  '+
//                                    'from                             '+
//                                        'produto p                    '+
//                                    'join tabela_preco_produto tpp on '+
//                                        'p.cd_produto = tpp.cd_produto '+
//                                    'where                            '+
//                                        'tpp.cd_tabela = :cd_tabela';
//    sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
//    sqlTabelaPrecoProduto.Open();
//
//    DBGridProduto.DataSource := DataSource1;
//    DBGridProduto.Columns[0].Title.Caption := 'Produto';
//    DBGridProduto.Columns[0].FieldName := 'cd_produto';
//    DBGridProduto.Columns[1].Title.Caption := 'Nome Produto';
//    DBGridProduto.Columns[1].FieldName := 'desc_produto';
//    DBGridProduto.Columns[2].Title.Caption := 'Valor';
//    DBGridProduto.Columns[2].FieldName := 'valor';
//    DBGridProduto.Columns[3].Title.Caption := 'UN Medida';
//    DBGridProduto.Columns[3].FieldName := 'un_medida';
//  end;
end;

procedure TfrmcadTabelaPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmcadTabelaPreco := nil;
end;

procedure TfrmcadTabelaPreco.FormCreate(Sender: TObject);
begin
  inherited;
  //aberto := True;
end;

procedure TfrmcadTabelaPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TfrmcadTabelaPreco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmcadTabelaPreco.limpaCampos;
begin
  edtFl_ativo.Checked := false;
  edtCodTabela.Clear;
  edtNomeTabela.Clear;
  edtDtInicial.Clear;
  edtDtFinal.Clear;
  DBGridProduto.DataSource := nil;
  edtCodTabela.SetFocus;
end;

procedure TfrmcadTabelaPreco.salvar;
begin
  sqlTabelaPreco.Close;
  //verifica se possui tabela com o mesmo c�digo
  sqlTabelaPreco.SQL.Text := 'select '+
                                  'cd_tabela '+
                              'from '+
                                  'tabela_preco '+
                              'where '+
                                    'cd_tabela = :cd_tabela';
  sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPreco.Open();

  if not sqlTabelaPreco.IsEmpty then //update
  begin
    sqlTabelaPreco.Close;
    dm.conexaoBanco.StartTransaction;
    sqlTabelaPreco.SQL.Text := 'update                          '+
                                    'tabela_preco               '+
                              'set                              '+
                                    'nm_tabela = :nm_tabela,    '+
                                    'fl_ativo = :fl_ativo,      '+
                                    'dt_inicio = :dt_inicio,    '+
                                    'dt_fim = :dt_fim           '+
                              'where cd_tabela = :cd_tabela';

    sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
    sqlTabelaPreco.ParamByName('nm_tabela').AsString := edtNomeTabela.Text;
    sqlTabelaPreco.ParamByName('fl_ativo').AsBoolean := edtFl_ativo.Checked;
    sqlTabelaPreco.ParamByName('dt_inicio').AsDate := StrToDate(edtDtInicial.Text);
    sqlTabelaPreco.ParamByName('dt_fim').AsDate := StrToDate(edtDtFinal.Text);

    try
      sqlTabelaPreco.ExecSQL;
      dm.conexaoBanco.Commit;
      ShowMessage('Dados Alterados com Sucesso');
      sqlTabelaPreco.Close;
      edtCodTabela.SetFocus;
      edtCodTabela.Text := '';
      edtNomeTabela.Text := '';
      edtFl_ativo.Checked := false;
      edtDtInicial.Text := '';
      edtDtFinal.Text := '';

    except
      on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        ShowMessage('Erro ao gravar os dados'+ E.Message);
        Exit;
      end;
    end;
  end
  else
  begin
    sqlTabelaPreco.Close;
    dm.conexaoBanco.StartTransaction;
    sqlTabelaPreco.SQL.Text := 'insert                        '+
                                    'into                     '+
                                    'tabela_preco (cd_tabela, '+
                                    'nm_tabela,               '+
                                    'fl_ativo,                '+
                                    'dt_inicio,               '+
                                    'dt_fim)                  '+
                                'values (:cd_tabela,          '+
                                    ':nm_tabela,              '+
                                    ':fl_ativo,               '+
                                    ':dt_inicio,              '+
                                    ':dt_fim)';

    sqlTabelaPreco.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
    sqlTabelaPreco.ParamByName('nm_tabela').AsString := edtNomeTabela.Text;
    sqlTabelaPreco.ParamByName('fl_ativo').AsBoolean := edtFl_ativo.Checked;
    sqlTabelaPreco.ParamByName('dt_inicio').AsDate := StrToDate(edtDtInicial.Text);
    sqlTabelaPreco.ParamByName('dt_fim').AsDate := StrToDate(edtDtFinal.Text);

    try
      sqlTabelaPreco.ExecSQL;
      dm.conexaoBanco.Commit;
      ShowMessage('Tabela de Pre�o cadastrada com Sucesso!');
      sqlTabelaPreco.Close;
      edtCodTabela.SetFocus;
      btnAdicionarProduto.Enabled := false;
      edtFl_ativo.Checked := false;
      edtCodTabela.Text := '';
      edtNomeTabela.Text := '';
      edtDtInicial.Text := '';
      edtDtFinal.Text := '';

    except
      on E : exception do
        begin
          dm.conexaoBanco.Rollback;
          ShowMessage('Erro ao gravar os dados '+ E.Message);
          Exit;
        end;
    end;
  end;
  dm.conexaoBanco.Close;
  DBGridProduto.DataSource := nil;
end;

end.
