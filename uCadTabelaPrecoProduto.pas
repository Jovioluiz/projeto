unit uCadTabelaPrecoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.UITypes,
  FireDAC.Comp.Client, uConexao, Vcl.Buttons;

type
  TfrmCadTabelaPrecoProduto = class(TfrmConexao)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodProduto: TEdit;
    edtValor: TEdit;
    edtUNMedida: TEdit;
    edtNomeProduto: TEdit;
    sqlTabelaPrecoProduto: TFDQuery;
    Label5: TLabel;
    edtCodTabela: TEdit;
    edtNomeTabela: TEdit;
    sql: TFDQuery;
    procedure edtCodProdutoChange(Sender: TObject);
    procedure edtCodTabelaChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodTabelaExit(Sender: TObject);
  private
    { Private declarations }
    procedure limpaCampos;
    procedure salvar;
    procedure excluir;
  public
    { Public declarations }
  end;

var
  frmCadTabelaPrecoProduto: TfrmCadTabelaPrecoProduto;
  implementation

{$R *.dfm}

procedure TfrmCadTabelaPrecoProduto.edtCodProdutoChange(Sender: TObject);
begin
  if edtCodProduto.Text = '' then
    begin
      edtNomeProduto.Text := '';
      Exit;
    end
  else
    begin
      sqlTabelaPrecoProduto.Close;
      sqlTabelaPrecoProduto.SQL.Text := 'select               '+
                                              'desc_produto,  '+
                                              'un_medida      '+
                                        'from                 '+
                                              'produto        '+
                                        'where                '+
                                              'cd_produto = :cd_produto';
      sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sqlTabelaPrecoProduto.Open();
      edtNomeProduto.Text := sqlTabelaPrecoProduto.FieldByName('desc_produto').AsString;
      edtUNMedida.Text := sqlTabelaPrecoProduto.FieldByName('un_medida').AsString;
    end;
end;

procedure TfrmCadTabelaPrecoProduto.edtCodTabelaChange(Sender: TObject);
begin
  //retorna a tabela de preço
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select '+
                                        'cd_tabela, '+
                                        'nm_tabela '+
                                    'from '+
                                        'tabela_preco '+
                                    'where '+
                                        'cd_tabela = :cd_tabela';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.Open();
  edtNomeTabela.Text := sqlTabelaPrecoProduto.FieldByName('nm_tabela').AsString;
end;

procedure TfrmCadTabelaPrecoProduto.edtCodTabelaExit(Sender: TObject);
begin
  //retorna a tabela de preço
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select '+
                                        'cd_tabela, '+
                                        'nm_tabela '+
                                    'from '+
                                        'tabela_preco '+
                                    'where '+
                                        'cd_tabela = :cd_tabela';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.Open();
  edtNomeTabela.Text := sqlTabelaPrecoProduto.FieldByName('nm_tabela').AsString;
end;

procedure TfrmCadTabelaPrecoProduto.excluir;
begin
if (Application.MessageBox('Deseja Excluir o produto da Tabela de Preço?', 'Atenção', MB_YESNO) = IDYES) then
  begin
    try
      sql.Close;
      sql.SQL.Text := 'delete                         '+
                      '   from                        '+
                      'tabela_preco_produto           '+
                      '   where                       '+
                      '(cd_produto = :cd_produto) and '+
                      '(cd_tabela = :cd_tabela)';
      sql.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
      sql.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sql.ExecSQL;
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

procedure TfrmCadTabelaPrecoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmCadTabelaPrecoProduto := nil;
end;

procedure TfrmCadTabelaPrecoProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
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

procedure TfrmCadTabelaPrecoProduto.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadTabelaPrecoProduto.limpaCampos;
begin
  edtCodProduto.Clear;
  edtValor.Clear;
  edtUNMedida.Clear;
  edtNomeProduto.Clear;
  edtNomeTabela.Clear;
  edtCodTabela.SetFocus;
end;

procedure TfrmCadTabelaPrecoProduto.salvar;
begin
  sqlTabelaPrecoProduto.Close;
  sqlTabelaPrecoProduto.SQL.Text := 'select                                     '+
                                    ' tpp.cd_produto                            '+
                                    'from tabela_preco tp                       '+
                                    ' join tabela_preco_produto tpp on          '+
                                    'tp.cd_tabela = tpp.cd_tabela               '+
                                    ' where (tp.cd_tabela = :cd_tabela) and     '+
                                    '(tpp.cd_produto = :cd_produto)';
  sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
  sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
  sqlTabelaPrecoProduto.Open();

  if not sqlTabelaPrecoProduto.IsEmpty then
  begin
    try
      sql.Close;
      sql.SQL.Text := 'update '+
                      '   tabela_preco_produto '+
                      'set '+
                      '   cd_tabela = :cd_tabela, '+
                      '   cd_produto = :cd_produto, '+
                      '   valor = :valor, '+
                      '   un_medida = :un_medida  '+
                      'where '+
                      '   (cd_tabela = :cd_tabela) and '+
                      '   (cd_produto = :cd_produto)';
      sql.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
      sql.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sql.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
      sql.ParamByName('un_medida').AsString := edtUNMedida.Text;

      sql.ExecSQL;
      limpaCampos;
    except
      on E:exception do
        begin
          ShowMessage('Erro ao gravar os dados '+ E.Message);
          Exit;
        end;
    end;
  end
  else
  begin
    try
      sqlTabelaPrecoProduto.Close;
      sqlTabelaPrecoProduto.SQL.Text := 'insert '+
                                            'into '+
                                            'tabela_preco_produto(cd_tabela, '+
                                            'cd_produto, '+
                                            'valor, '+
                                            'un_medida)'+
                                        'values (:cd_tabela, '+
                                            ':cd_produto, '+
                                            ':valor, '+
                                            ':un_medida)';
      sqlTabelaPrecoProduto.ParamByName('cd_tabela').AsInteger := StrToInt(edtCodTabela.Text);
      sqlTabelaPrecoProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodProduto.Text);
      sqlTabelaPrecoProduto.ParamByName('valor').AsCurrency := StrToCurr(edtValor.Text);
      sqlTabelaPrecoProduto.ParamByName('un_medida').AsString := edtUNMedida.Text;

      sqlTabelaPrecoProduto.ExecSQL;
      ShowMessage('Dados Gravados com Sucesso');
      limpaCampos;

    except
      on E:exception do
        begin
          frmConexao.conexao.Rollback;
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
    end;
  end;

end;

end.
