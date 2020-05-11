unit cPRODUTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Data.FMTBcd, Data.DB, Data.SqlExpr, uConexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Buttons, Vcl.DBCtrls;

type
  TfrmCadProduto = class(TfrmConexao)
    comandoSelect: TFDQuery;
    comandosql: TFDQuery;
    PageControl1: TPageControl;
    TabSheetCadastroProduto: TTabSheet;
    Label1: TLabel;
    edtPRODUTOCD_PRODUTO: TEdit;
    Label2: TLabel;
    edtPRODUTODESCRICAO: TEdit;
    ckPRODUTOATIVO: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtPRODUTOUN_MEDIDA: TEdit;
    edtPRODUTOFATOR_CONVERSAO: TEdit;
    edtPRODUTOPESO_BRUTO: TEdit;
    edtPRODUTOPESO_LIQUIDO: TEdit;
    memoObservacao: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBGridCodigoBarras: TDBGrid;
    edtCodigoBarras: TEdit;
    btnAddCodBarras: TButton;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtProdutoGrupoTributacaoICMS: TEdit;
    edtProdutoGrupoTributacaoIPI: TEdit;
    edtProdutoGrupoTributacaoPISCOFINS: TEdit;
    edtProdutoNomeGrupoTributacaoICMS: TEdit;
    edtProdutoNomeGrupoTributacaoIPI: TEdit;
    edtProdutoNomeGrupoTributacaoPISCOFINS: TEdit;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    edtCodBarrasInterno: TRadioButton;
    edtCodBarrasGTIN: TRadioButton;
    edtCodBarrasOutro: TRadioButton;
    DataSource2: TDataSource;
    sqltributacao: TFDQuery;
    sqlVerificaTributacao: TFDQuery;
    btnPRODUTOCadastrar: TSpeedButton;
    btnPRODUTOCANCELAR: TSpeedButton;
    btnPRODUTOExcluir: TSpeedButton;
    btnPRODUTOLimpar: TSpeedButton;
    imagem: TImage;
    Label13: TLabel;
    Button1: TButton;
    btnCarregarImagem: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnPRODUTOCANCELARClick(Sender: TObject);
    procedure btnPRODUTOCADASTRARClick(Sender: TObject);
    procedure edtPRODUTOCD_PRODUTOExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddCodBarrasClick(Sender: TObject);
    procedure edtProdutoGrupoTributacaoICMSChange(Sender: TObject);
    procedure edtProdutoGrupoTributacaoIPIChange(Sender: TObject);
    procedure edtProdutoGrupoTributacaoPISCOFINSChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure btnPRODUTOSalvarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnPRODUTOLimparClick(Sender: TObject);
    procedure btnPRODUTOExcluirClick(Sender: TObject);
    procedure btnCarregarImagemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure limpaCampos;
    var NomeImg : string;
  end;

var
  frmCadProduto: TfrmCadProduto;
  //cd_produto : String;

implementation

{$R *.dfm}

uses uDataModule;

procedure TfrmCadProduto.btnAddCodBarrasClick(Sender: TObject);
begin
  if ClientDataSet1.FieldCount = 0 then
    begin
      ClientDataSet1.FieldDefs.Clear;
      ClientDataSet1.FieldDefs.Add('Tipo',ftString,10,false);
      ClientDataSet1.FieldDefs.Add('Codigo de Barras',ftString,40,false);
      ClientDataSet1.CreateDataSet;
    end;

    ClientDataSet1.Append;
  if edtCodBarrasInterno.Checked then
      begin
        ClientDataSet1.FieldByName('Tipo').AsString := 'I';
      end
    else if edtCodBarrasGTIN.Checked then
      begin
        ClientDataSet1.FieldByName('Tipo').AsString := 'G';
      end
    else if edtCodBarrasOutro.Checked then
      begin
       ClientDataSet1.FieldByName('Tipo').AsString := 'O';
      end
    else
      begin
        ClientDataSet1.FieldByName('Tipo').AsString := 'N';
      end;
  ClientDataSet1.FieldByName('Codigo de Barras').AsString := edtCodigoBarras.Text;

  ClientDataSet1.Post;
  edtCodigoBarras.Clear;

end;

procedure TfrmCadProduto.btnCarregarImagemClick(Sender: TObject);
var formato : string;
begin
  if OpenDialog1.Execute then
    begin
      imagem.Picture.LoadFromFile(OpenDialog1.FileName);
      formato := ExtractFileExt(OpenDialog1.FileName); //extraindo o formato da imagem
      NomeImg := VarToStr(edtPRODUTOCD_PRODUTO.Text) + '_' + 'imagem' + formato; //funcionou desse jeito. Se converter para floatToStr ou IntToStr da erro
      imagem.Picture.SaveToFile(GetCurrentDir + '\imagens_produto\' + NomeImg);
    end;
end;

procedure TfrmCadProduto.btnPRODUTOCADASTRARClick(Sender: TObject);
begin
//verifica se o código, descrição e UN estão vazios
if (edtPRODUTOCD_PRODUTO.Text = EmptyStr) or (edtPRODUTODESCRICAO.Text = EmptyStr) or (edtPRODUTOUN_MEDIDA.Text = EmptyStr) then
  begin
    raise Exception.Create('Código, Descrição e Unidade de Medida não podem ser vazios');
  end;
  //verifica se já esta cadastrado
  comandoSelect.Close;
  comandoSelect.SQL.Text := 'select         '+
                            '    *          '+
                            'from           '+
                            '    produto p  '+
                            'where          '+
                            '    p.cd_produto = :cd_produto';
  comandoSelect.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  comandoSelect.Open();

  if not comandoSelect.IsEmpty then
    begin
      comandosql.Close;
      conexao.StartTransaction;
      comandosql.SQL.Text := 'update                                  '+
                                'produto                              '+
                             'set                                     '+
                                  'fl_ativo = :fl_ativo,              '+
                                  'desc_produto = :desc_produto,      '+
                                  'un_medida = :un_medida,            '+
                                  'fator_conversao = :fator_conversao,'+
                                  'peso_liquido = :peso_liquido,      '+
                                  'peso_bruto = :peso_bruto,          '+
                                  'observacao = :observacao,           '+
                                  //'tipo_cod_barras = :tipo_cod_barras, '+
                                  //'codigo_barras = :codigo_barras,     '+
                                  'imagem = :imagem                    '+
                             'where                                    '+
                                  'cd_produto = :cd_produto';

      comandosql.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      comandosql.ParamByName('fl_ativo').AsBoolean := ckPRODUTOATIVO.Checked;
      comandosql.ParamByName('desc_produto').AsString := edtPRODUTODESCRICAO.Text;
      comandosql.ParamByName('un_medida').AsString := edtPRODUTOUN_MEDIDA.Text;
      comandosql.ParamByName('fator_conversao').AsCurrency := StrToCurr(edtPRODUTOFATOR_CONVERSAO.Text);
      comandosql.ParamByName('peso_liquido').AsCurrency := StrToCurr(edtPRODUTOPESO_LIQUIDO.Text);
      comandosql.ParamByName('peso_bruto').AsCurrency := StrToCurr(edtPRODUTOPESO_BRUTO.Text);
      comandosql.ParamByName('observacao').AsString := memoObservacao.Text;
      //comandosql.ParamByName('tipo_cod_barras').AsString := ClientDataSet1.FieldByName('Tipo').AsString;
      //comandosql.ParamByName('codigo_barras').AsString := ClientDataSet1.FieldByName('Codigo de Barras').AsString;
      //comandosql.ParamByName('codigo_barras').AsString := edtCodigoBarras.Text;
      comandosql.ParamByName('imagem').AsString := NomeImg;



      sqlVerificaTributacao.Close;
      sqlVerificaTributacao.SQL.Text := 'select * from produto_tributacao pt '+
                            'left join grupo_tributacao_icms gti on '+
                            '    pt.cd_tributacao_icms = gti.cd_tributacao '+
                            'left join grupo_tributacao_ipi gtipi on '+
                            '    pt.cd_tributacao_ipi = gtipi.cd_tributacao '+
                            'left join grupo_tributacao_pis_cofins gtpc on '+
                            '    pt.cd_tributacao_pis_cofins = gtpc.cd_tributacao '+
                            'where pt.cd_produto = :cd_produto';
      sqlVerificaTributacao.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      sqlVerificaTributacao.Open();

      if not sqlVerificaTributacao.IsEmpty then
        begin
          sqltributacao.Close;
          sqltributacao.SQL.Text := 'update                                                     '+
                                        'produto_tributacao                                     '+
                                     'set                                                       '+
                                          'cd_produto = :cd_produto,                            '+
                                          'cd_tributacao_icms = :cd_tributacao_icms,            '+
                                          'cd_tributacao_ipi = :cd_tributacao_ipi,              '+
                                          'cd_tributacao_pis_cofins = :cd_tributacao_pis_cofins '+
                                     'where                                   '+
                                          'cd_produto = :cd_produto';
          sqltributacao.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
          sqltributacao.ParamByName('cd_tributacao_icms').AsInteger := StrToInt(edtProdutoGrupoTributacaoICMS.Text);
          sqltributacao.ParamByName('cd_tributacao_ipi').AsInteger := StrToInt(edtProdutoGrupoTributacaoIPI.Text);
          sqltributacao.ParamByName('cd_tributacao_pis_cofins').AsInteger := StrToInt(edtProdutoGrupoTributacaoPISCOFINS.Text);
        end
      else
        begin
          sqltributacao.Close;
          sqltributacao.SQL.Text := 'insert into                      '+
                                      'produto_tributacao(cd_produto, '+
                                      'cd_tributacao_icms,            '+
                                      'cd_tributacao_ipi,             '+
                                      'cd_tributacao_pis_cofins)      '+
                              'values (:cd_produto,                   '+
                                      ':cd_tributacao_icms,           '+
                                      ':cd_tributacao_ipi,            '+
                                      ':cd_tributacao_pis_cofins)';
          sqltributacao.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
          sqltributacao.ParamByName('cd_tributacao_icms').AsInteger := StrToInt(edtProdutoGrupoTributacaoICMS.Text);
          sqltributacao.ParamByName('cd_tributacao_ipi').AsInteger := StrToInt(edtProdutoGrupoTributacaoIPI.Text);
          sqltributacao.ParamByName('cd_tributacao_pis_cofins').AsInteger := StrToInt(edtProdutoGrupoTributacaoPISCOFINS.Text);
        end;

      try
        comandosql.ExecSQL;
        sqltributacao.ExecSQL;
        conexao.Commit;
        ShowMessage('Produto Alterado com Sucesso');
        comandosql.Close;

        limpaCampos;

      except
        on E:exception do
          begin
            frmConexao.conexao.Rollback;
            ShowMessage('Erro ao gravar os dados'+ E.Message);
            Exit;
          end;
      end;
    end
  else
    begin
      comandosql.Close;
      conexao.StartTransaction;
      comandosql.SQL.Add('insert into                   '+
                                  'produto(cd_produto,  '+
                                  'fl_ativo,            '+
                                  'desc_produto,        '+
                                  'un_medida,           '+
                                  'fator_conversao,     '+
                                  'peso_liquido,        '+
                                  'peso_bruto,          '+
                                  'observacao,          '+
                                 // 'tipo_cod_barras,     '+
                                  //'codigo_barras,       '+
                                  'imagem)              '+
                          'values (:cd_produto,         '+
                                  ':fl_ativo,           '+
                                  ':desc_produto,       '+
                                  ':un_medida,          '+
                                  ':fator_conversao,    '+
                                  ':peso_liquido,       '+
                                  ':peso_bruto,         '+
                                  ':observacao,         '+
                                  //':tipo_cod_barras,    '+
                                  //':codigo_barras,      '+
                                  ':imagem)');

      comandosql.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      comandosql.ParamByName('fl_ativo').AsBoolean := ckPRODUTOATIVO.Checked;
      comandosql.ParamByName('desc_produto').AsString := edtPRODUTODESCRICAO.Text;
      comandosql.ParamByName('un_medida').AsString := edtPRODUTOUN_MEDIDA.Text;
      comandosql.ParamByName('fator_conversao').AsCurrency := StrToCurr(edtPRODUTOFATOR_CONVERSAO.Text);
      comandosql.ParamByName('peso_liquido').AsCurrency := StrToCurr(edtPRODUTOPESO_LIQUIDO.Text);
      comandosql.ParamByName('peso_bruto').AsCurrency := StrToCurr(edtPRODUTOPESO_BRUTO.Text);
      comandosql.ParamByName('observacao').AsString := memoObservacao.Text;
      //comandosql.ParamByName('tipo_cod_barras').AsString := ClientDataSet1.FieldByName('Tipo').AsString;
      //comandosql.ParamByName('codigo_barras').AsString := ClientDataSet1.FieldByName('Codigo de Barras').AsString;
      comandosql.ParamByName('imagem').AsString := NomeImg;

      try
        comandosql.ExecSQL;
        sqltributacao.ExecSQL;
        conexao.Commit;
        ShowMessage('Produto cadastrado com Sucesso!');
        comandosql.Close;
        sqltributacao.Close;

        limpaCampos;

      except
        on E:exception do
        begin
          conexao.Rollback;
          ShowMessage('Erro ao gravar os dados do produto '+ E.Message);
          Exit;
        end;

      end;
    end;
end;

procedure TfrmCadProduto.btnPRODUTOCANCELARClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
end;

procedure TfrmCadProduto.btnPRODUTOExcluirClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Excluir o Produto?','Atenção', MB_YESNO) = IDYES) then
    begin
      comandosql.Close;
      comandosql.SQL.Text := 'delete                    '+
                             '  from                    '+
                             'produto                   '+
                             '  where                   '+
                             'cd_produto = :cd_produto';
      comandosql.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);

      try
        comandosql.ExecSQL;
        comandosql.Close;
        ShowMessage('Produto Excluído com Sucesso!');
        limpaCampos;
      except
        on E:Exception do
          begin
            ShowMessage('Erro ao excluir o produto ' + edtPRODUTOCD_PRODUTO.Text + E.Message);
          end;
      end;
    end
  else
    begin
      Exit;
    end;

end;

procedure TfrmCadProduto.btnPRODUTOLimparClick(Sender: TObject);
begin
  limpaCampos;
end;

procedure TfrmCadProduto.edtPRODUTOCD_PRODUTOExit(Sender: TObject);
begin
  if edtPRODUTOCD_PRODUTO.Text = EmptyStr then
    begin
      raise Exception.Create('Código não pode ser vazio');
      edtPRODUTOCD_PRODUTO.SetFocus;
      Abort;
    end;

  comandoSelect.Close;
  comandoSelect.SQL.Text := 'select                                             '+
                            '    p.cd_produto,                                  '+
                            '    fl_ativo,                                      '+
                            '    desc_produto,                                  '+
                            '    un_medida,                                     '+
                            '    fator_conversao,                               '+
                            '    peso_liquido,                                  '+
                            '    peso_bruto,                                    '+
                            '    observacao,                                    '+
                            '    tipo_cod_barras,                               '+
                            '    codigo_barras,                                 '+
                            '    imagem,                                        '+
                            '    pt.cd_tributacao_icms,                         '+
                            '    gti.nm_tributacao_icms,                        '+
                            '    pt.cd_tributacao_ipi,                          '+
                            '    gtipi.nm_tributacao_ipi,                       '+
                            '    pt.cd_tributacao_pis_cofins,                   '+
                            '    gtpc.nm_tributacao_pis_cofins                  '+
                            'from                                               '+
                            '    produto p                                      '+
                            'left join produto_tributacao pt on                 '+
                            '    p.cd_produto = pt.cd_produto                   '+
                            'left join grupo_tributacao_icms gti on             '+
                            '    pt.cd_tributacao_icms = gti.cd_tributacao      '+
                            'left join grupo_tributacao_ipi gtipi on            '+
                            '    pt.cd_tributacao_ipi = gtipi.cd_tributacao     '+
                            'left join grupo_tributacao_pis_cofins gtpc on      '+
                            '    pt.cd_tributacao_pis_cofins = gtpc.cd_tributacao '+
                            'where                                              '+
                            '    p.cd_produto = :cd_produto';
  comandoSelect.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  comandoSelect.Open();

  ckPRODUTOATIVO.Checked := comandoSelect.FieldByName('fl_ativo').AsBoolean;
  edtPRODUTODESCRICAO.Text := comandoSelect.FieldByName('desc_produto').AsString;
  edtPRODUTOUN_MEDIDA.Text := comandoSelect.FieldByName('un_medida').AsString;
  edtPRODUTOFATOR_CONVERSAO.Text := CurrToStr(comandoSelect.FieldByName('fator_conversao').AsCurrency);
  edtPRODUTOPESO_LIQUIDO.Text := CurrToStr(comandoSelect.FieldByName('peso_liquido').AsCurrency);
  edtPRODUTOPESO_BRUTO.Text := CurrToStr(comandoSelect.FieldByName('peso_bruto').AsCurrency);
  memoObservacao.Text := comandoSelect.FieldByName('observacao').AsString;
  edtProdutoGrupoTributacaoICMS.Text := IntToStr(comandoSelect.FieldByName('cd_tributacao_icms').AsInteger);
  edtProdutoNomeGrupoTributacaoICMS.Text := comandoSelect.FieldByName('nm_tributacao_icms').AsString;
  edtProdutoGrupoTributacaoIPI.Text := IntToStr(comandoSelect.FieldByName('cd_tributacao_ipi').AsInteger);
  edtProdutoNomeGrupoTributacaoIPI.Text := comandoSelect.FieldByName('nm_tributacao_ipi').AsString;
  edtProdutoGrupoTributacaoPISCOFINS.Text := IntToStr(comandoSelect.FieldByName('cd_tributacao_pis_cofins').AsInteger);
  edtProdutoNomeGrupoTributacaoPISCOFINS.Text := comandoSelect.FieldByName('nm_tributacao_pis_cofins').AsString;
  if comandoSelect.FieldByName('imagem').AsString = '' then
    begin
      imagem.Picture := nil;
    end
  else
    begin
      imagem.Picture.LoadFromFile(GetCurrentDir + '\imagens_produto\' + comandoSelect.FieldByName('imagem').AsString);
    end;
  DBGridCodigoBarras.DataSource := DataSource2;
  DBGridCodigoBarras.Columns[0].Title.Caption := 'Tipo';
  DBGridCodigoBarras.Columns[0].FieldName := 'tipo_cod_barras';
  DBGridCodigoBarras.Columns[1].Title.Caption := 'Codigo de Barras';
  DBGridCodigoBarras.Columns[1].FieldName := 'codigo_barras';

end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoICMSChange(Sender: TObject);
begin
  inherited;
  if edtProdutoGrupoTributacaoICMS.Text = EmptyStr then
    begin
      edtProdutoGrupoTributacaoICMS.Text := '';
      edtProdutoNomeGrupoTributacaoICMS.Text := '';
      Exit;
    end;

  sqltributacao.Close;
  sqltributacao.SQL.Text := 'select '+
                                'cd_tributacao, '+
                                'nm_tributacao_icms '+
                            'from '+
                                'grupo_tributacao_icms '+
                            'where '+
                                'cd_tributacao = :cd_tributacao';
  sqltributacao.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoICMS.Text);
  sqltributacao.Open();
  edtProdutoNomeGrupoTributacaoICMS.Text := sqltributacao.FieldByName('nm_tributacao_icms').AsString;
end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoIPIChange(Sender: TObject);
begin
  inherited;
  if edtProdutoGrupoTributacaoIPI.Text = EmptyStr then
  begin
    edtProdutoGrupoTributacaoIPI.Text := '';
    edtProdutoNomeGrupoTributacaoIPI.Text := '';
    Exit;
  end;

  sqltributacao.Close;
  sqltributacao.SQL.Text := 'select '+
                                'cd_tributacao, '+
                                'nm_tributacao_ipi '+
                            'from '+
                                'grupo_tributacao_ipi '+
                            'where '+
                                'cd_tributacao = :cd_tributacao';
  sqltributacao.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoIPI.Text);
  sqltributacao.Open();
  edtProdutoNomeGrupoTributacaoIPI.Text := sqltributacao.FieldByName('nm_tributacao_ipi').AsString;
end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoPISCOFINSChange(
  Sender: TObject);
begin
  inherited;
  if edtProdutoGrupoTributacaoPISCOFINS.Text = EmptyStr then
    begin
      edtProdutoGrupoTributacaoPISCOFINS.Text := '';
      edtProdutoNomeGrupoTributacaoPISCOFINS.Text := '';
      Exit;
    end;

  sqltributacao.Close;
  sqltributacao.SQL.Text := 'select '+
                                'cd_tributacao, '+
                                'nm_tributacao_pis_cofins '+
                            'from '+
                                'grupo_tributacao_pis_cofins '+
                            'where '+
                                'cd_tributacao = :cd_tributacao';
  sqltributacao.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoPISCOFINS.Text);
  sqltributacao.Open();
  edtProdutoNomeGrupoTributacaoPISCOFINS.Text := sqltributacao.FieldByName('nm_tributacao_pis_cofins').AsString;
end;


procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProduto := nil;
end;

//passa pelos campos pressionando enter
procedure TfrmCadProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
       Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadProduto.limpaCampos;
begin
  edtPRODUTOCD_PRODUTO.Clear;
  edtPRODUTODESCRICAO.Clear;
  edtPRODUTOUN_MEDIDA.Clear;
  edtPRODUTOFATOR_CONVERSAO.Clear;
  edtPRODUTOPESO_BRUTO.Clear;
  edtPRODUTOPESO_LIQUIDO.Clear;
  edtCodigoBarras.Clear;
  edtProdutoGrupoTributacaoICMS.Clear;
  edtProdutoGrupoTributacaoIPI.Clear;
  edtProdutoGrupoTributacaoPISCOFINS.Clear;
  edtProdutoNomeGrupoTributacaoICMS.Clear;
  edtProdutoNomeGrupoTributacaoIPI.Clear;
  edtProdutoNomeGrupoTributacaoPISCOFINS.Clear;
  edtCodBarrasInterno.Checked := false;
  edtCodBarrasGTIN.Checked := false;
  edtCodBarrasOutro.Checked := false;
  memoObservacao.Clear;
  edtPRODUTOCD_PRODUTO.SetFocus;
  DBGridCodigoBarras.DataSource := nil;
  imagem.Picture := nil;
end;

procedure TfrmCadProduto.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  if (Application.MessageBox('Deseja realmente Fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
end;

end.
