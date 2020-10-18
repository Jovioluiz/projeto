unit fCadastroEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvLabel,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmCadastroEnderecos = class(TForm)
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    edtCodDeposito: TEdit;
    JvLabel4: TJvLabel;
    edtAla: TEdit;
    edtRua: TEdit;
    edtComplemento: TEdit;
    JvLabel5: TJvLabel;
    edtCodBarrasProduto: TEdit;
    edtNomeProduto: TEdit;
    JvLabel6: TJvLabel;
    dbgrd1: TDBGrid;
    rgTipo: TRadioGroup;
    btnAdicionar: TButton;
    cdsEndereco: TClientDataSet;
    dsEndereco: TDataSource;
    intgrfldEnderecocd_produto: TIntegerField;
    cdsEndereconm_produto: TStringField;
    intgrfldEnderecocd_deposito: TIntegerField;
    cdsEnderecoala: TStringField;
    cdsEnderecorua: TStringField;
    cdsEnderecocomplemento: TStringField;
    btn1: TButton;
    btn2: TButton;
    cdsEndereconm_endereco: TStringField;
    edtOrdem: TEdit;
    JvLabel7: TJvLabel;
    intgrfldEnderecoordem: TIntegerField;
    procedure edtCodBarrasProdutoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SalvaEnderecoProduto;
    procedure SalvarEndereco;
    procedure LimpaCampos;
    procedure LimpaDados;
    function GetIdEndereco(NomeEndereco: String): Int64;
    function Pesquisar(IdEndereco: Int64; CdProduto: Integer): Boolean; overload;
    function Pesquisar(CdDeposito: Integer; Ala, Rua: string): Boolean; overload;
  public
    { Public declarations }
  end;

var
  frmCadastroEnderecos: TfrmCadastroEnderecos;

implementation

uses
  uDataModule, uGerador, uValidaDados;

{$R *.dfm}

procedure TfrmCadastroEnderecos.btn1Click(Sender: TObject);
begin
  SalvarEndereco;
  SalvaEnderecoProduto;
  LimpaDados;
end;

procedure TfrmCadastroEnderecos.btnAdicionarClick(Sender: TObject);
begin
  if not cdsEndereco.Locate('cd_deposito; ala; rua; ordem',
     VarArrayOf([StrToInt(edtCodDeposito.Text), edtAla.Text, edtRua.Text, StrToInt(edtOrdem.Text)]), []) then
  begin
    cdsEndereco.Append;
    cdsEndereco.FieldByName('cd_produto').AsInteger := StrToInt(edtCodBarrasProduto.Text);
    cdsEndereco.FieldByName('nm_produto').AsString := edtNomeProduto.Text;
    cdsEndereco.FieldByName('cd_deposito').AsInteger := StrToInt(edtCodDeposito.Text);
    cdsEndereco.FieldByName('ala').AsString := edtAla.Text;
    cdsEndereco.FieldByName('rua').AsString := edtRua.Text;
    cdsEndereco.FieldByName('complemento').AsString := edtComplemento.Text;
    cdsEndereco.FieldByName('nm_endereco').AsString := Concat(edtCodDeposito.Text,'-',edtAla.Text,'-',
                                                       edtRua.Text,'-', edtComplemento.Text);
    cdsEndereco.FieldByName('ordem').AsInteger := StrToInt(edtOrdem.Text);
    cdsEndereco.Post;
  end
  else
    raise Exception.Create('Endereço Já cadastrado para este Produto');

  LimpaCampos;
end;

procedure TfrmCadastroEnderecos.edtCodBarrasProdutoExit(Sender: TObject);
const
  SQL_PRODUTO = 'select desc_produto from produto where cd_produto = :cd_produto';
  SQL_PROD_BARRAS = 'select        ' +
                    'p.desc_produto  ' +
                    'from produto p  ' +
                    'join produto_cod_barras pcb on ' +
                    '    pcb.cd_produto = p.cd_produto  ' +
                    'where pcb.codigo_barras = :codigo_barras';
  SQL_ENDERECO = 'select ' +
                '    wep.cd_produto, ' +
                '    p.desc_produto, ' +
                '    we.cd_deposito, ' +
                '    we.ala, ' +
                '    we.rua, ' +
                '    we.complemento, ' +
                '    wep.nm_endereco  ' +
                '    from wms_endereco we ' +
                'join wms_endereco_produto wep on ' +
                '    wep.id_endereco = we.id_geral  ' +
                'join produto p on  ' +
                '    p.cd_produto = wep.cd_produto  ' +
                'where wep.cd_produto = :cd_produto  ';

var
  qryProduto, qryEnderecos: TFDQuery;
begin
  qryProduto := TFDQuery.Create(Self);
  qryProduto.Connection := dm.FDConnection1;
  qryEnderecos := TFDQuery.Create(Self);
  qryEnderecos.Connection := dm.FDConnection1;

  try
    cdsEndereco.EmptyDataSet;

    if not edtCodBarrasProduto.isEmpty then
    begin
      if rgTipo.ItemIndex = 0 then
      begin
        qryProduto.SQL.Clear;
        qryProduto.SQL.Add(SQL_PRODUTO);
        qryProduto.ParamByName('cd_produto').AsInteger := StrToInt(edtCodBarrasProduto.Text);
        qryProduto.Open(SQL_PRODUTO);

        if not qryProduto.IsEmpty then
          edtNomeProduto.Text := qryProduto.FieldByName('desc_produto').AsString
        else
        begin
          ShowMessage('Produto não encontrado');
          edtCodBarrasProduto.SetFocus;
        end;
      end
      else
      begin
        qryProduto.SQL.Clear;
        qryProduto.SQL.Add(SQL_PROD_BARRAS);
        qryProduto.ParamByName('codigo_barras').AsString := edtCodBarrasProduto.Text;
        qryProduto.Open(SQL_PROD_BARRAS);

        if not qryProduto.IsEmpty then
          edtNomeProduto.Text := qryProduto.FieldByName('desc_produto').AsString
        else
        begin
          ShowMessage('Produto não encontrado');
          edtCodBarrasProduto.SetFocus;
        end;
      end;

      if not qryProduto.IsEmpty then
      begin
        qryEnderecos.SQL.Add(SQL_ENDERECO);
        qryEnderecos.ParamByName('cd_produto').AsInteger := StrToInt(edtCodBarrasProduto.Text);
        qryEnderecos.Open(SQL_ENDERECO);

        qryEnderecos.First;
        if not qryEnderecos.IsEmpty then
        begin
          while not qryEnderecos.Eof do
          begin
            cdsEndereco.Append;
            cdsEndereco.FieldByName('cd_produto').AsInteger := qryEnderecos.FieldByName('cd_produto').AsInteger;
            cdsEndereco.FieldByName('nm_produto').AsString := qryEnderecos.FieldByName('desc_produto').AsString;
            cdsEndereco.FieldByName('cd_deposito').AsInteger := qryEnderecos.FieldByName('cd_deposito').AsInteger;
            cdsEndereco.FieldByName('ala').AsString := qryEnderecos.FieldByName('ala').AsString;
            cdsEndereco.FieldByName('rua').AsString := qryEnderecos.FieldByName('rua').AsString;
            cdsEndereco.FieldByName('complemento').AsString := qryEnderecos.FieldByName('complemento').AsString;
            cdsEndereco.FieldByName('nm_endereco').AsString := qryEnderecos.FieldByName('nm_endereco').AsString;
            cdsEndereco.Post;
            qryEnderecos.Next;
          end;
        end;
      end;
    end;
  finally
    qryProduto.Free;
    qryEnderecos.Free;
  end;

end;

procedure TfrmCadastroEnderecos.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

function TfrmCadastroEnderecos.GetIdEndereco(NomeEndereco: String): Int64;
const
  SQL = 'select ' +
        'id_geral    ' +
        'from            ' +
        'wms_endereco we ' +
        'where               ' +
        'concat(cd_deposito, ''-'', ala, ''-'', rua, ''-'', complemento) = :nm_endereco';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('nm_endereco').AsString := NomeEndereco;
    qry.Open(SQL);

    Result := qry.FieldByName('id_geral').AsInteger;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadastroEnderecos.LimpaCampos;
begin
  edtAla.Clear;
  edtRua.Clear;
  edtCodDeposito.Clear;
  edtComplemento.Clear;
end;

procedure TfrmCadastroEnderecos.LimpaDados;
begin
  edtCodBarrasProduto.Clear;
  edtNomeProduto.Clear;
  dbgrd1.DataSource := nil;
end;

function TfrmCadastroEnderecos.Pesquisar(CdDeposito: Integer; Ala, Rua: string): Boolean;
const
  SQL = 'select cd_deposito, ala, rua from wms_endereco ' +
        'where cd_deposito = :cd_deposito and ' +
        'ala = :ala and ' +
        'rua = :rua';
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('cd_deposito').AsInteger := CdDeposito;
    qry.ParamByName('ala').AsString := Ala;
    qry.ParamByName('rua').AsString := Rua;
    qry.Open(SQL);

    if not qry.IsEmpty then
      Result := True;

  finally
    qry.Free;
  end;
end;

function TfrmCadastroEnderecos.Pesquisar(IdEndereco: Int64; CdProduto: Integer): Boolean;
const
  SQL = 'select nm_endereco from wms_endereco_produto ' +
        'where id_endereco = :id_endereco and cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('id_endereco').AsInteger := IdEndereco;
    qry.ParamByName('cd_produto').AsInteger := CdProduto;
    qry.Open(SQL);

    if qry.FieldByName('nm_endereco').AsString = cdsEndereco.FieldByName('nm_endereco').AsString then
      Result := True;
  finally
    qry.Free;
  end;

end;

procedure TfrmCadastroEnderecos.SalvaEnderecoProduto;
const
  SQL_INSERT = 'insert into wms_endereco_produto (id_geral, id_endereco, nm_endereco, cd_produto) ' +
               'values(:id_geral, :id_endereco, :nm_endereco, :cd_produto)';
var
  qry: TFDQuery;
  idGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  idGeral := TGerador.Create;
  try
    qry.SQL.Add(SQL_INSERT);

    try
      cdsEndereco.First;
      while not cdsEndereco.Eof do
      begin //verifica se já possui um endereço cadastrado para o produto
        if not Pesquisar(GetIdEndereco(cdsEndereco.FieldByName('nm_endereco').AsString),
           cdsEndereco.FieldByName('cd_produto').AsInteger) then
        begin
          qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
          qry.ParamByName('id_endereco').AsInteger := GetIdEndereco(cdsEndereco.FieldByName('nm_endereco').AsString);
          qry.ParamByName('nm_endereco').AsString := cdsEndereco.FieldByName('nm_endereco').AsString;
          qry.ParamByName('cd_produto').AsInteger := cdsEndereco.FieldByName('cd_produto').AsInteger;
          qry.ExecSQL;
          qry.Connection.Commit;
        end;
        cdsEndereco.Next;
      end;
    except
      on E: Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar o endereço ' + cdsEndereco.FieldByName('nm_endereco').AsString + E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(idGeral);
    qry.Free;
  end;
end;

procedure TfrmCadastroEnderecos.SalvarEndereco;
const
  SQL_INSERT_ENDERECO = 'insert into wms_endereco(id_geral, cd_deposito, ala, rua, complemento) ' +
                        'values(:id_geral, :cd_deposito, :ala, :rua, :complemento)';
var
  qry: TFDQuery;
  idGeral: TGerador;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  qry.Connection.StartTransaction;
  idGeral := TGerador.Create;

  try
    try
      qry.SQL.Add(SQL_INSERT_ENDERECO);
      cdsEndereco.First;
      while not cdsEndereco.Eof do
      begin //verifica se já possui um endereço cadastrado
        if not Pesquisar(cdsEndereco.FieldByName('cd_deposito').AsInteger,
                 cdsEndereco.FieldByName('ala').AsString,
                 cdsEndereco.FieldByName('rua').AsString) then
        begin
          qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
          qry.ParamByName('cd_deposito').AsInteger := cdsEndereco.FieldByName('cd_deposito').AsInteger;
          qry.ParamByName('ala').AsString := cdsEndereco.FieldByName('ala').AsString;
          qry.ParamByName('rua').AsString := cdsEndereco.FieldByName('rua').AsString;
          qry.ParamByName('complemento').AsString := cdsEndereco.FieldByName('complemento').AsString;
          qry.ExecSQL;
          qry.Connection.Commit;
        end;
        cdsEndereco.Next;
      end;

    except
      on E: Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar o endereço ' + E.Message);
        Exit;
      end;
    end;
  finally
    FreeAndNil(idGeral);
    LimpaCampos;
    qry.Free;
  end;
end;

end.
