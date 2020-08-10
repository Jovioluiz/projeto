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
    sqltributacao: TFDQuery;
    sqlVerificaTributacao: TFDQuery;
    imagem: TImage;
    Label13: TLabel;
    Button1: TButton;
    btnCarregarImagem: TButton;
    OpenDialog1: TOpenDialog;
    cbTipoCodBarras: TComboBox;
    edtUnCodBarras: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    procedure btnPRODUTOCANCELARClick(Sender: TObject);
    procedure edtPRODUTOCD_PRODUTOExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutoGrupoTributacaoICMSChange(Sender: TObject);
    procedure edtProdutoGrupoTributacaoIPIChange(Sender: TObject);
    procedure edtProdutoGrupoTributacaoPISCOFINSChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarregarImagemClick(Sender: TObject);
    procedure imagemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAddCodBarrasClick(Sender: TObject);
    procedure DBGridCodigoBarrasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure limpaCampos;
    procedure salvar;
    procedure excluir;
    procedure validaCampos;
    procedure listarCodBarras;
    procedure desabilitaCampos;
    procedure validaCamposCodBarra;
  public
    { Public declarations }


    var NomeImg : string;
  end;

var
  frmCadProduto: TfrmCadProduto;
  camposDesabilitados : Boolean;

implementation

{$R *.dfm}

uses uDataModule, uValidaDados, uLogin;

procedure TfrmCadProduto.btnAddCodBarrasClick(Sender: TObject);
begin
  validaCamposCodBarra;
  dm.dsCodBarraProduto.DataSet.Active := True;
  dm.dsCodBarraProduto.DataSet.Append;
  dm.dsCodBarraProduto.DataSet.FieldByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  dm.dsCodBarraProduto.DataSet.FieldByName('un_medida').AsString := edtUnCodBarras.Text;
  dm.dsCodBarraProduto.DataSet.FieldByName('tipo_cod_barras').AsInteger := cbTipoCodBarras.ItemIndex;
  dm.dsCodBarraProduto.DataSet.FieldByName('codigo_barras').AsString := edtCodigoBarras.Text;
  dm.dsCodBarraProduto.DataSet.Post;

  listarCodBarras;

  cbTipoCodBarras.ItemIndex := -1;
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

procedure TfrmCadProduto.btnPRODUTOCANCELARClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
end;

procedure TfrmCadProduto.DBGridCodigoBarrasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DELETE then
    begin
      if MessageDlg('Deseja excluir o código de barras?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
         begin
            try
              dm.query.Close;
              dm.query.SQL.Clear;
              dm.query.SQL.Text := 'delete '+
                                   '  from '+
                                   'produto_cod_barras '+
                                   '  where '+
                                   'cd_produto = :cd_produto and '+
                                   'codigo_barras = :codigo_barras';
              dm.query.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
              dm.query.ParamByName('codigo_barras').AsString := IntToStr(DBGridCodigoBarras.Fields[2].Value);
              dm.query.ExecSQL;
              edtPRODUTOCD_PRODUTO.SetFocus;
            except
                on E : exception do
              begin
                ShowMessage('Erro ' + E.Message);
                Exit;
              end;
            end;
         end;
    end;
    listarCodBarras;
end;

procedure TfrmCadProduto.desabilitaCampos;
//desabilita os campos quando o usuário não possui permissão de edição
begin
  edtPRODUTOCD_PRODUTO.Enabled := false;
  edtPRODUTODESCRICAO.Enabled := false;
  edtPRODUTOUN_MEDIDA.Enabled := false;
  edtPRODUTOFATOR_CONVERSAO.Enabled := false;
  edtPRODUTOPESO_BRUTO.Enabled := false;
  edtPRODUTOPESO_LIQUIDO.Enabled := false;
  edtCodigoBarras.Enabled := false;
  edtProdutoGrupoTributacaoICMS.Enabled := false;
  edtProdutoGrupoTributacaoIPI.Enabled := false;
  edtProdutoGrupoTributacaoPISCOFINS.Enabled := false;
  edtProdutoNomeGrupoTributacaoICMS.Enabled := false;
  edtProdutoNomeGrupoTributacaoIPI.Enabled := false;
  edtProdutoNomeGrupoTributacaoPISCOFINS.Enabled := false;
  cbTipoCodBarras.Enabled := false;
  ckPRODUTOATIVO.Enabled := false;
  btnAddCodBarras.Enabled := false;
  btnCarregarImagem.Enabled := false;
  memoObservacao.Enabled := false;
  edtUnCodBarras.Enabled := false;
  DBGridCodigoBarras.Enabled := False;
  camposDesabilitados := True;
end;

procedure TfrmCadProduto.edtPRODUTOCD_PRODUTOExit(Sender: TObject);
var
  temPermissaoEdicao : Boolean;
  cliente : TValidaDados;
begin
  cliente := TValidaDados.Create;
  temPermissaoEdicao := cliente.validaEdicaoAcao(idUsuario, 2);

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

  if (not temPermissaoEdicao) and (comandosql.IsEmpty) then
  begin
    MessageDlg('Usuário não possui Permissão para realizar Cadastro', mtInformation, [mbOK], 0);
    edtPRODUTOCD_PRODUTO.SetFocus;
    Exit;
  end;

  ckPRODUTOATIVO.Checked := comandoSelect.FieldByName('fl_ativo').AsBoolean;
  edtPRODUTODESCRICAO.Text := comandoSelect.FieldByName('desc_produto').AsString;
  edtPRODUTOUN_MEDIDA.Text := comandoSelect.FieldByName('un_medida').AsString;
  edtPRODUTOFATOR_CONVERSAO.Text := CurrToStr(comandoSelect.FieldByName('fator_conversao').AsCurrency);
  edtPRODUTOPESO_LIQUIDO.Text := CurrToStr(comandoSelect.FieldByName('peso_liquido').AsCurrency);
  edtPRODUTOPESO_BRUTO.Text := CurrToStr(comandoSelect.FieldByName('peso_bruto').AsCurrency);
  memoObservacao.Text := comandoSelect.FieldByName('observacao').AsString;
  if comandoSelect.FieldByName('cd_tributacao_icms').Value = null then
  begin
    edtProdutoGrupoTributacaoICMS.Text := '';
  end
  else
  begin
    edtProdutoGrupoTributacaoICMS.Text := comandoSelect.FieldByName('cd_tributacao_icms').Value;
  end;
  edtProdutoNomeGrupoTributacaoICMS.Text := comandoSelect.FieldByName('nm_tributacao_icms').AsString;
  if comandoSelect.FieldByName('cd_tributacao_ipi').Value = null then
  begin
    edtProdutoGrupoTributacaoIPI.Text := '';
  end
  else
  begin
    edtProdutoGrupoTributacaoIPI.Text := comandoSelect.FieldByName('cd_tributacao_ipi').Value;
  end;
  edtProdutoNomeGrupoTributacaoIPI.Text := comandoSelect.FieldByName('nm_tributacao_ipi').AsString;
  if comandoSelect.FieldByName('cd_tributacao_pis_cofins').Value = null then
  begin
    edtProdutoGrupoTributacaoPISCOFINS.Text := '';
  end
  else
  begin
    edtProdutoGrupoTributacaoPISCOFINS.Text := comandoSelect.FieldByName('cd_tributacao_pis_cofins').Value;
  end;
  edtProdutoNomeGrupoTributacaoPISCOFINS.Text := comandoSelect.FieldByName('nm_tributacao_pis_cofins').AsString;
  if comandoSelect.FieldByName('imagem').AsString = '' then
  begin
    imagem.Picture := nil;
  end
else
  begin
    imagem.Picture.LoadFromFile(GetCurrentDir + '\imagens_produto\' + comandoSelect.FieldByName('imagem').AsString);
  end;

  listarCodBarras;

  if temPermissaoEdicao = True then
    Exit
  else
    desabilitaCampos;


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


procedure TfrmCadProduto.excluir;
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

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProduto := nil;
end;

procedure TfrmCadProduto.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmCadProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
//passa pelos campos pressionando enter
  if Key = #13 then
    begin
      Key := #0;
       Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadProduto.imagemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbRight then
    if (Application.MessageBox('Deseja Excluir a Imagem do Produto?', 'Aviso', MB_YESNO) = IDYES) then
      begin
        imagem.Picture := nil;
        conexao.ExecSQL('update produto set imagem = NULL where cd_produto = :cd_produto',
                                                        [StrToInt(edtPRODUTOCD_PRODUTO.Text)]);
      end
    else
      begin
        exit;
      end;
end;

procedure TfrmCadProduto.limpaCampos;
begin
  if camposDesabilitados then
  begin
    edtPRODUTOCD_PRODUTO.Enabled := true;
    edtPRODUTODESCRICAO.Enabled := true;
    edtPRODUTOUN_MEDIDA.Enabled := true;
    edtPRODUTOFATOR_CONVERSAO.Enabled := true;
    edtPRODUTOPESO_BRUTO.Enabled := true;
    edtPRODUTOPESO_LIQUIDO.Enabled := true;
    edtCodigoBarras.Enabled := true;
    edtProdutoGrupoTributacaoICMS.Enabled := true;
    edtProdutoGrupoTributacaoIPI.Enabled := true;
    edtProdutoGrupoTributacaoPISCOFINS.Enabled := true;
    edtProdutoNomeGrupoTributacaoICMS.Enabled := true;
    edtProdutoNomeGrupoTributacaoIPI.Enabled := true;
    edtProdutoNomeGrupoTributacaoPISCOFINS.Enabled := true;
    cbTipoCodBarras.Enabled := true;
    ckPRODUTOATIVO.Enabled := true;
    btnAddCodBarras.Enabled := true;
    btnCarregarImagem.Enabled := true;
    memoObservacao.Enabled := true;
    edtUnCodBarras.Enabled := true;

    camposDesabilitados := false;
  end;

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
  memoObservacao.Clear;
  edtUnCodBarras.Clear;
  edtPRODUTOCD_PRODUTO.SetFocus;
  dm.queryCodBarraProduto.Close;
  imagem.Picture := nil;
end;

procedure TfrmCadProduto.listarCodBarras;
const
    sql =  'select  '+
           '    * '+
           'from '+
           '    produto_cod_barras '+
           'where '+
           '    cd_produto = :cd_produto';

  {sql = 'select '+
        '	cd_produto, '+
        '	un_medida, '+
        '	case '+
        '		when tipo_cod_barras = 0 then ''Interno'' 	'+
        '		when tipo_cod_barras = 1 then ''GTIN'' 		'+
        '		when tipo_cod_barras = 2 then ''Outro'' 	'+
        '	end tipo_cod_barras, '+
        '	codigo_barras '+
        'from '+
        '	produto_cod_barras '+
        'where '+
        '	cd_produto = :cd_produto ';}
begin
  dm.queryCodBarraProduto.Close;
  dm.queryCodBarraProduto.SQL.Clear;
  dm.queryCodBarraProduto.SQL.Add(sql);
  dm.queryCodBarraProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  dm.queryCodBarraProduto.Open(sql);
end;

procedure TfrmCadProduto.salvar;
begin
  validaCampos;
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
      comandosql.ParamByName('imagem').AsString := NomeImg;

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


      try
        comandosql.ExecSQL;
        sqltributacao.ExecSQL;
        conexao.Commit;
        ShowMessage('Produto Alterado com Sucesso');
        comandosql.Close;
        sqltributacao.Close;
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
      comandosql.SQL.Text := 'insert into               '+
                                  'produto (cd_produto, '+
                                  'fl_ativo,            '+
                                  'desc_produto,        '+
                                  'un_medida,           '+
                                  'fator_conversao,     '+
                                  'peso_liquido,        '+
                                  'peso_bruto,          '+
                                  'observacao,          '+
                                  'imagem)              '+
                          ' values (:cd_produto,         '+
                                  ':fl_ativo,           '+
                                  ':desc_produto,       '+
                                  ':un_medida,          '+
                                  ':fator_conversao,    '+
                                  ':peso_liquido,       '+
                                  ':peso_bruto,         '+
                                  ':observacao,         '+
                                  ':imagem)';

      comandosql.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      comandosql.ParamByName('fl_ativo').AsBoolean := ckPRODUTOATIVO.Checked;
      comandosql.ParamByName('desc_produto').AsString := edtPRODUTODESCRICAO.Text;
      comandosql.ParamByName('un_medida').AsString := edtPRODUTOUN_MEDIDA.Text;
      comandosql.ParamByName('fator_conversao').AsCurrency := StrToCurr(edtPRODUTOFATOR_CONVERSAO.Text);
      comandosql.ParamByName('peso_liquido').AsCurrency := StrToCurr(edtPRODUTOPESO_LIQUIDO.Text);
      comandosql.ParamByName('peso_bruto').AsCurrency := StrToCurr(edtPRODUTOPESO_BRUTO.Text);
      comandosql.ParamByName('observacao').AsString := memoObservacao.Text;
      comandosql.ParamByName('imagem').AsString := NomeImg;

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

procedure TfrmCadProduto.validaCampos;
begin
  if (edtPRODUTOCD_PRODUTO.Text = EmptyStr) or (edtPRODUTODESCRICAO.Text = EmptyStr)
    or (edtPRODUTOUN_MEDIDA.Text = EmptyStr) then
  begin
    raise Exception.Create('Código, Descrição e Unidade de Medida não podem ser vazios');
  end
  else if (edtProdutoGrupoTributacaoICMS.Text = EmptyStr) or (edtProdutoGrupoTributacaoIPI.Text = EmptyStr) 
        or (edtProdutoGrupoTributacaoPISCOFINS.Text = EmptyStr) then
  begin
    raise Exception.Create('Preencha os tipos de Tributação do produto!');
  end;
       
end;

procedure TfrmCadProduto.validaCamposCodBarra;
const
  sql = 'select '+
        '   un_medida '+
        'from '+
        '   produto_cod_barras '+
        'where '+
        '   cd_produto = :cd_produto';
begin
  if (Trim(edtCodigoBarras.Text) = EmptyStr) or (Trim(edtUnCodBarras.Text) = EmptyStr) or
  (cbTipoCodBarras.ItemIndex = -1) then
    raise Exception.Create('Campos não podem ser vazios');


  dm.query.Close;
  dm.query.SQL.Clear;
  dm.query.SQL.Add(sql);
  dm.query.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  dm.query.Open(sql);

  if dm.query.FieldByName('un_medida').AsString = edtUnCodBarras.Text then
    raise Exception.Create('O produto já possui código de barras cadastrado para a unidade de medida informada');
  
end;

end.
