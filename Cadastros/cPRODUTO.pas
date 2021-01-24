unit cPRODUTO;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Buttons, Vcl.DBCtrls, Jpeg, dProdutoCodBarras,
  uclProduto;

type
  TfrmCadProduto = class(TForm)
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
    imagem: TImage;
    Label13: TLabel;
    Button1: TButton;
    btnCarregarImagem: TButton;
    dlgImagem: TOpenDialog;
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
    procedure FormCreate(Sender: TObject);
    procedure edtPRODUTOCD_PRODUTOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FRegra: TProdutoCodigoBarras;
    { Private declarations }
    procedure limpaCampos;
    procedure Salvar;
    procedure excluir;
    procedure validaCampos;
    procedure listarCodBarras;
    procedure desabilitaCampos;
    procedure validaCamposCodBarra;
    procedure SalvarCodBarras;
    procedure SalvarFoto;
    procedure SalvarTributacao;
    function carregaImagem(Aimagem: TImage; ABlobField: TBlobField): Boolean;
  public
    { Public declarations }

    var NomeImg : string;

    property Regra: TProdutoCodigoBarras read FRegra;
  end;

var
  frmCadProduto: TfrmCadProduto;
  camposDesabilitados : Boolean;
  img: TPicture;

implementation

{$R *.dfm}

uses uDataModule, uUtil, uLogin, uConsulta, uclProdutoTributacao;

procedure TfrmCadProduto.btnAddCodBarrasClick(Sender: TObject);
begin
  validaCamposCodBarra;

  Regra.Dados.dsBarras.DataSet.Active := True;

  Regra.Dados.cdsBarras.AppendRecord([edtUnCodBarras.Text, cbTipoCodBarras.ItemIndex, edtCodigoBarras.Text]);

  cbTipoCodBarras.ItemIndex := -1;
  edtUnCodBarras.Clear;
  edtCodigoBarras.Clear;
end;

procedure TfrmCadProduto.btnCarregarImagemClick(Sender: TObject);
begin
  if dlgImagem.Execute then
  begin
    imagem.Picture.LoadFromFile(dlgImagem.FileName);
  end;
end;

procedure TfrmCadProduto.btnPRODUTOCANCELARClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja realmente fechar?','Atenção', MB_YESNO) = IDYES) then
    Close;
end;

function TfrmCadProduto.carregaImagem(Aimagem: TImage;
  ABlobField: TBlobField): Boolean;
var
  JpgImg: TJPEGImage;
  StMem: TMemoryStream;
begin
  if ABlobField.DataSet.IsEmpty then
  begin
    Result := False;
    Exit;
  end;

  Aimagem.Picture.Assign(nil);

  if not (ABlobField.IsNull) and not (ABlobField.AsString = '') then
  begin
    jpgImg := TJPEGImage.Create;
    stMem := TMemoryStream.Create;
    try
      ABlobField.SaveToStream(StMem);
      StMem.Position := 0;
      JpgImg.LoadFromStream(StMem);
      Aimagem.Picture.Assign(JpgImg);
    finally
      StMem.Free;
      JpgImg.Free;
    end;
  end;

  Result := True;
end;

procedure TfrmCadProduto.DBGridCodigoBarrasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_DELETE then
   begin
     if MessageDlg('Deseja excluir o código de barras?', mtConfirmation,[mbYes,mbNo], 0) = mrYes then
     begin
      FRegra.cd_produto := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      FRegra.codigo_barras := FRegra.Dados.cdsBarras.FieldByName('codigo_barras').AsString;
      FRegra.un_medida := FRegra.Dados.cdsBarras.FieldByName('un_medida').AsString;
      FRegra.Excluir;
      FRegra.Dados.cdsBarras.Delete;

      edtPRODUTOCD_PRODUTO.SetFocus;
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
const
  sql = 'select                                             '+
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
var
  temPermissaoEdicao : Boolean;
  produto : TValidaDados;
  qry: TFDQuery;
begin
  produto := TValidaDados.Create;
  temPermissaoEdicao := produto.validaEdicaoAcao(idUsuario, 2);

  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;

  if edtPRODUTOCD_PRODUTO.isEmpty then
  begin
    raise Exception.Create('Código não pode ser vazio');
    edtPRODUTOCD_PRODUTO.SetFocus;
    Abort;
  end;

  qry.SQL.Add(sql);
  qry.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
  qry.Open(sql);

  if (not temPermissaoEdicao) and (qry.IsEmpty) then
  begin
    MessageDlg('Usuário não possui Permissão para realizar Cadastro', mtInformation, [mbOK], 0);
    edtPRODUTOCD_PRODUTO.SetFocus;
    Exit;
  end;

  ckPRODUTOATIVO.Checked := qry.FieldByName('fl_ativo').AsBoolean;
  edtPRODUTODESCRICAO.Text := qry.FieldByName('desc_produto').AsString;
  edtPRODUTOUN_MEDIDA.Text := qry.FieldByName('un_medida').AsString;
  edtPRODUTOFATOR_CONVERSAO.Text := CurrToStr(qry.FieldByName('fator_conversao').AsCurrency);
  edtPRODUTOPESO_LIQUIDO.Text := CurrToStr(qry.FieldByName('peso_liquido').AsCurrency);
  edtPRODUTOPESO_BRUTO.Text := CurrToStr(qry.FieldByName('peso_bruto').AsCurrency);
  memoObservacao.Text := qry.FieldByName('observacao').AsString;

  if qry.FieldByName('cd_tributacao_icms').Value = null then
    edtProdutoGrupoTributacaoICMS.Text := ''
  else
    edtProdutoGrupoTributacaoICMS.Text := qry.FieldByName('cd_tributacao_icms').Value;
  edtProdutoNomeGrupoTributacaoICMS.Text := qry.FieldByName('nm_tributacao_icms').AsString;

  if qry.FieldByName('cd_tributacao_ipi').Value = null then
    edtProdutoGrupoTributacaoIPI.Text := ''
  else
    edtProdutoGrupoTributacaoIPI.Text := qry.FieldByName('cd_tributacao_ipi').Value;
  edtProdutoNomeGrupoTributacaoIPI.Text := qry.FieldByName('nm_tributacao_ipi').AsString;

  if qry.FieldByName('cd_tributacao_pis_cofins').Value = null then
    edtProdutoGrupoTributacaoPISCOFINS.Text := ''
  else
    edtProdutoGrupoTributacaoPISCOFINS.Text := qry.FieldByName('cd_tributacao_pis_cofins').Value;
  edtProdutoNomeGrupoTributacaoPISCOFINS.Text := qry.FieldByName('nm_tributacao_pis_cofins').AsString;

  if qry.FieldByName('imagem').AsBytes = null then
    imagem.Picture := nil
  else
    carregaImagem(imagem, TBlobField(qry.FieldByName('imagem')));

  listarCodBarras;

  if temPermissaoEdicao then
    Exit
  else
    desabilitaCampos;
end;

procedure TfrmCadProduto.edtPRODUTOCD_PRODUTOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
const
  sql = 'select cd_produto, desc_produto, un_medida, fator_conversao, peso_bruto, peso_liquido, observacao from produto';
var
  consulta: TfrmConsulta;
begin
  consulta := TfrmConsulta.Create(Self);
  if key = VK_F9 then
  begin
    //chamada := 'cntProduto';
    consulta.MontaDataset(sql);
    consulta.Show;
  end;
end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoICMSChange(Sender: TObject);
const
  sql = 'select '+
        ' cd_tributacao, '+
        ' nm_tributacao_icms '+
        'from '+
        ' grupo_tributacao_icms '+
        'where '+
        ' cd_tributacao = :cd_tributacao';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;

  if edtProdutoGrupoTributacaoICMS.isEmpty then
  begin
    edtProdutoGrupoTributacaoICMS.Text := '';
    edtProdutoNomeGrupoTributacaoICMS.Text := '';
    Exit;
  end;

  qry.SQL.Add(sql);
  qry.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoICMS.Text);
  qry.Open(sql);
  edtProdutoNomeGrupoTributacaoICMS.Text := qry.FieldByName('nm_tributacao_icms').AsString;
end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoIPIChange(Sender: TObject);
const
  sql = 'select '+
        ' cd_tributacao, '+
        ' nm_tributacao_ipi '+
        'from '+
        ' grupo_tributacao_ipi '+
        'where '+
        ' cd_tributacao = :cd_tributacao';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;

  if edtProdutoGrupoTributacaoIPI.isEmpty then
  begin
    edtProdutoGrupoTributacaoIPI.Text := '';
    edtProdutoNomeGrupoTributacaoIPI.Text := '';
    Exit;
  end;

  qry.SQL.Add(sql);
  qry.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoIPI.Text);
  qry.Open(sql);
  edtProdutoNomeGrupoTributacaoIPI.Text := qry.FieldByName('nm_tributacao_ipi').AsString;
end;

procedure TfrmCadProduto.edtProdutoGrupoTributacaoPISCOFINSChange(Sender: TObject);
const
  sql = 'select '+
        ' cd_tributacao, '+
        ' nm_tributacao_pis_cofins '+
        'from '+
        ' grupo_tributacao_pis_cofins '+
        'where '+
        ' cd_tributacao = :cd_tributacao';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Close;
  qry.SQL.Clear;

  if edtProdutoGrupoTributacaoPISCOFINS.isEmpty then
  begin
    edtProdutoGrupoTributacaoPISCOFINS.Text := '';
    edtProdutoNomeGrupoTributacaoPISCOFINS.Text := '';
    Exit;
  end;

  qry.SQL.Add(sql);
  qry.ParamByName('cd_tributacao').AsInteger := StrToInt(edtProdutoGrupoTributacaoPISCOFINS.Text);
  qry.Open(sql);
  edtProdutoNomeGrupoTributacaoPISCOFINS.Text := qry.FieldByName('nm_tributacao_pis_cofins').AsString;
end;


procedure TfrmCadProduto.excluir;
var
  persistencia: TProduto;
begin
  persistencia := TProduto.Create;

  try
    if edtPRODUTOCD_PRODUTO.Text <> '' then
    begin
      if (Application.MessageBox('Deseja Excluir o Produto?','Atenção', MB_YESNO) = IDYES) then
      begin
        persistencia.cd_produto := StrToInt(edtPRODUTOCD_PRODUTO.Text);
        persistencia.Excluir;
        limpaCampos;
      end;
    end;
  finally
    persistencia.Free;
  end;
end;


procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frmCadProduto := nil;
  FRegra.Free;
end;

procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  TabSheetCadastroProduto.Show;
  FRegra := TProdutoCodigoBarras.Create;
end;

procedure TfrmCadProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F3 then //F3
    limpaCampos
  else if key = VK_F2 then  //F2
    Salvar
  else if key = VK_F4 then    //F4
    excluir
  else if key = VK_ESCAPE then //ESC
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
      Close;
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
  begin
    if (Application.MessageBox('Deseja Excluir a Imagem do Produto?', 'Aviso', MB_YESNO) = IDYES) then
    begin
      imagem.Picture := nil;
      dm.conexaoBanco.ExecSQL('update produto set imagem = NULL where cd_produto = :cd_produto',
                                                      [StrToInt(edtPRODUTOCD_PRODUTO.Text)]);
    end
    else
        Exit;
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
  TabSheetCadastroProduto.Show;//se estiver em outra aba, sempre volta para a primeira aba

  FRegra.Dados.cdsBarras.EmptyDataSet;
end;

procedure TfrmCadProduto.listarCodBarras;
const
  sql = 'select ' +
        '   un_medida, ' +
        'case          ' +
        '   when tipo_cod_barras = 0 then ''Interno'' ' +
        '   when tipo_cod_barras = 1 then ''GTIN''    ' +
        '   else ''Outro''       ' +
        'end tipo_cod_barras, ' +
        '   codigo_barras '+
        'from '+
        '	  produto_cod_barras '+
        'where '+
        '	  cd_produto = :cd_produto ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;

  try
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(sql);
    qry.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
    qry.Open(sql);

    qry.First;
    while not qry.Eof do
    begin
      FRegra.Dados.cdsBarras.AppendRecord([qry.FieldByName('un_medida').AsString,
                              qry.FieldByName('tipo_cod_barras').AsString,
                              qry.FieldByName('codigo_barras').AsString]);
      qry.Next;
    end;

  finally
    qry.Free;
  end;
end;

procedure TfrmCadProduto.SalvarFoto;
const
  sql = 'update produto set imagem = :imagem where cd_produto = :cd_produto';
var
  qry: TFDQuery;
  Imagem: TFileStream;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      if dlgImagem.FileName <> '' then
      begin
        Imagem := TFileStream.Create(dlgImagem.FileName, fmOpenRead or fmShareDenyWrite);
        qry.SQL.Add(sql);
        qry.ParamByName('imagem').LoadFromStream(Imagem, ftBlob);
        qry.ParamByName('cd_produto').AsInteger := StrToInt(edtPRODUTOCD_PRODUTO.Text);
        qry.ExecSQL;

        qry.Connection.Commit;
      end;
    except
    on E:Exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar a foto do produto ' + E.Message);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadProduto.SalvarTributacao;
var
  persistencia: TProdutoTributacao;
begin
  persistencia := TProdutoTributacao.Create;

  try
    persistencia.cd_produto := StrToInt(edtPRODUTOCD_PRODUTO.Text);
    persistencia.cd_tributacao_icms := StrToInt(edtProdutoGrupoTributacaoICMS.Text);
    persistencia.cd_tributacao_ipi := StrToInt(edtProdutoGrupoTributacaoIPI.Text);
    persistencia.cd_tributacao_pis_cofins := StrToInt(edtProdutoGrupoTributacaoPISCOFINS.Text);

    if not persistencia.Pesquisar(StrToInt(edtPRODUTOCD_PRODUTO.Text)) then
      persistencia.Inserir
    else
      persistencia.Atualizar;

  finally
    persistencia.Free;
  end;
end;

procedure TfrmCadProduto.Salvar;
var
  persistencia: TProduto;
begin
  validaCampos;

  persistencia := TProduto.Create;

  try
    persistencia.cd_produto := StrToInt(edtPRODUTOCD_PRODUTO.Text);
    persistencia.fl_ativo := ckPRODUTOATIVO.Checked;
    persistencia.desc_produto := edtPRODUTODESCRICAO.Text;
    persistencia.un_medida := edtPRODUTOUN_MEDIDA.Text;
    persistencia.fator_conversao := StrToInt(edtPRODUTOFATOR_CONVERSAO.Text);
    persistencia.peso_liquido := StrToFloat(edtPRODUTOPESO_LIQUIDO.Text);
    persistencia.peso_bruto := StrToFloat(edtPRODUTOPESO_BRUTO.Text);
    persistencia.observacao := memoObservacao.Text;

    if not persistencia.Pesquisar(StrToInt(edtPRODUTOCD_PRODUTO.Text)) then
      persistencia.Inserir
    else
      persistencia.Atualizar;

    SalvarTributacao;
    SalvarCodBarras;
    SalvarFoto;
    limpaCampos;

  finally
    persistencia.Free;
  end;
end;

procedure TfrmCadProduto.SalvarCodBarras;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;

  try
    try
      FRegra.cd_produto := StrToInt(edtPRODUTOCD_PRODUTO.Text);
      FRegra.tipo_cod_barras := FRegra.Dados.cdsBarras.FieldByName('tipo_cod_barras').AsString;
      FRegra.codigo_barras := FRegra.Dados.cdsBarras.FieldByName('codigo_barras').AsString;
      FRegra.un_medida := FRegra.Dados.cdsBarras.FieldByName('un_medida').AsString;

      FRegra.Dados.cdsBarras.First;

      FRegra.Dados.cdsBarras.Loop(
      procedure
      begin
        if not FRegra.Pesquisar(StrToInt(edtPRODUTOCD_PRODUTO.Text),
                                FRegra.Dados.cdsBarras.FieldByName('codigo_barras').AsString) then
          FRegra.Inserir
        else
          FRegra.Atualizar;
      end);
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do código de barras do produto ' + E.Message);
      end;
    end;
  finally
    qry.Free;
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
begin
  if (Trim(edtCodigoBarras.Text) = EmptyStr)
      or (Trim(edtUnCodBarras.Text) = EmptyStr)
      or (cbTipoCodBarras.ItemIndex = -1) then
    raise Exception.Create('Campos não podem ser vazios');

  if FRegra.Dados.cdsBarras.Locate('un_medida', VarArrayOf([edtUnCodBarras.Text]), []) then
    raise Exception.Create('O produto já possui código de barras cadastrado para a unidade de medida informada');

end;

end.
