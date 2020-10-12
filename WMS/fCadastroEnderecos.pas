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
    edtEdtComplemento: TEdit;
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
    procedure edtCodBarrasProdutoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
  private
    { Private declarations }
    procedure SalvaEnderecoProduto;
    procedure LimpaCampos;
    function GetIdPedido(NomeEndereco: String): Int64;
  public
    { Public declarations }
  end;

var
  frmCadastroEnderecos: TfrmCadastroEnderecos;

implementation

uses
  uDataModule, uGerador;

{$R *.dfm}

procedure TfrmCadastroEnderecos.btnAdicionarClick(Sender: TObject);
const
  SQL_INSERT_ENDERECO = 'insert into wms_endereco (id_geral, cd_deposito, ala, rua, complemento) ' +
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
    cdsEndereco.Append;
    cdsEndereco.FieldByName('cd_produto').AsInteger := StrToInt(edtCodBarrasProduto.Text);
    cdsEndereco.FieldByName('nm_produto').AsString := edtNomeProduto.Text;
    cdsEndereco.FieldByName('cd_deposito').AsInteger := StrToInt(edtCodDeposito.Text);
    cdsEndereco.FieldByName('ala').AsString := edtAla.Text;
    cdsEndereco.FieldByName('rua').AsString := edtRua.Text;
    cdsEndereco.FieldByName('complemento').AsString := edtEdtComplemento.Text;
    cdsEndereco.Post;

    try
      qry.SQL.Add(SQL_INSERT_ENDERECO);
      qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
      qry.ParamByName('cd_deposito').AsInteger := cdsEndereco.FieldByName('cd_deposito').AsInteger;
      qry.ParamByName('ala').AsString := cdsEndereco.FieldByName('ala').AsString;
      qry.ParamByName('rua').AsString := cdsEndereco.FieldByName('rua').AsString;
      qry.ParamByName('complemento').AsString := cdsEndereco.FieldByName('complemento').AsString;
      qry.ExecSQL;
      qry.Connection.Commit;

    except
      on E: Exception do
      begin
        qry.Connection.Rollback;
        ShowMessage('Erro ao gravar o endereço ' + E.Message);
        Exit;
      end;
    end;
  finally
    LimpaCampos;
    qry.Free;
  end;
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

function TfrmCadastroEnderecos.GetIdPedido(NomeEndereco: String): Int64;
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
  edtEdtComplemento.Clear;
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
  //TERMINAR
  try
    qry.SQL.Add(SQL_INSERT);

    try
      cdsEndereco.First;
      while not cdsEndereco.Eof do
      begin
        qry.SQL.Clear;
        qry.ParamByName('id_geral').AsInteger := idGeral.GeraIdGeral;
        qry.ParamByName('id_endereco').AsInteger := GetIdPedido(cdsEndereco.FieldByName('nm_endereco').AsString);
        qry.ParamByName('nm_endereco').AsString := cdsEndereco.FieldByName('nm_endereco').AsString;
        qry.ParamByName('cd_produto').AsInteger := cdsEndereco.FieldByName('cd_produto').AsInteger;
        qry.ExecSQL;
        qry.Connection.Commit;
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
    qry.Free;
  end;
end;

end.
