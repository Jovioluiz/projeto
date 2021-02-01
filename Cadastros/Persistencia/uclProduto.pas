unit uclProduto;

interface

uses
  uclPadrao, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  dProdutoCodBarras;

type TProduto = class(TPadrao)
  private
    Fobservacao: string;
    Fpeso_liquido: Double;
    Fcd_produto: String;
    Ffl_ativo: Boolean;
    Fun_medida: string;
    Fdesc_produto: string;
    Fimagem: Byte;
    Fpeso_bruto: Double;
    Ffator_conversao: Integer;
    Fid_item: Int64;
    procedure Setcd_produto(const Value: String);
    procedure Setdesc_produto(const Value: string);
    procedure Setfator_conversao(const Value: Integer);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setimagem(const Value: Byte);
    procedure Setobservacao(const Value: string);
    procedure Setpeso_bruto(const Value: Double);
    procedure Setpeso_liquido(const Value: Double);
    procedure Setun_medida(const Value: string);
    procedure Setid_item(const Value: Int64);


  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(IdItem: Int64): Boolean;
    function GeraIdItem: Int64;

    property cd_produto: String read Fcd_produto write Setcd_produto;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;
    property desc_produto: string read Fdesc_produto write Setdesc_produto;
    property un_medida: string read Fun_medida write Setun_medida;
    property fator_conversao: Integer read Ffator_conversao write Setfator_conversao;
    property peso_liquido: Double read Fpeso_liquido write Setpeso_liquido;
    property peso_bruto: Double read Fpeso_bruto write Setpeso_bruto;
    property observacao: string read Fobservacao write Setobservacao;
    property imagem: Byte read Fimagem write Setimagem;
    property id_item: Int64 read Fid_item write Setid_item;
end;

type TProdutoCodigoBarras = class(TProduto)
  private
    Fcodigo_barras: String;
    Ftipo_cod_barras: String;
    FDados: TdmProdutoCodBarras;
    procedure Setcodigo_barras(const Value: String);
    procedure Settipo_cod_barras(const Value: String);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;
    function Pesquisar(CdProduto: Integer): Boolean; overload;
    function Pesquisar(IdItem: Int64; CodBarras: String): Boolean;overload;
    constructor Create;
    destructor Destroy; override;

    property tipo_cod_barras: String read Ftipo_cod_barras write Settipo_cod_barras;
    property codigo_barras: String read Fcodigo_barras write Setcodigo_barras;
    property Dados: TdmProdutoCodBarras read FDados;
end;

implementation

uses
  uDataModule, System.SysUtils;

{ TProduto }

procedure TProduto.Atualizar;
const
  SQL = 'update                               '+
         '  produto                            '+
         'set                                  '+
         '  fl_ativo = :fl_ativo,              '+
         '  desc_produto = :desc_produto,      '+
         '  un_medida = :un_medida,            '+
         '  fator_conversao = :fator_conversao,'+
         '  peso_liquido = :peso_liquido,      '+
         '  peso_bruto = :peso_bruto,          '+
         '  observacao = :observacao           '+
         'where                                '+
         '  id_item = :id_item';
var
  qry: TFDQuery;
begin
  //inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('desc_produto').AsString := Fdesc_produto;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ParamByName('fator_conversao').AsCurrency := Ffator_conversao;
      qry.ParamByName('peso_liquido').AsCurrency := Fpeso_liquido;
      qry.ParamByName('peso_bruto').AsCurrency := Fpeso_bruto;
      qry.ParamByName('observacao').AsString := Fobservacao;
      qry.ParamByName('id_item').AsLargeInt := Fid_item;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados do produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TProduto.Excluir;
const
  sql = 'delete                    '+
        '  from                    '+
        'produto                   '+
        '  where                   '+
        'id_item = :id_item';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao excluir os dados do produto ' + Fcd_produto + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TProduto.GeraIdItem: Int64;
const
  SQL = 'select *from func_id_item()';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.Open(SQL);

    Result := qry.FieldByName('func_id_item').AsLargeInt;
  finally
    qry.Free;
  end;
end;

procedure TProduto.Inserir;
const
  SQL = 'insert into               '+
                'produto (cd_produto, '+
                'fl_ativo,            '+
                'desc_produto,        '+
                'un_medida,           '+
                'fator_conversao,     '+
                'peso_liquido,        '+
                'peso_bruto,          '+
                'observacao,          '+
                'id_item)          '+
        ' values (:cd_produto,         '+
                ':fl_ativo,           '+
                ':desc_produto,       '+
                ':un_medida,          '+
                ':fator_conversao,    '+
                ':peso_liquido,       '+
                ':peso_bruto,         '+
                ':observacao,         '+
                ':id_item)';
var
  qry: TFDQuery;
begin
  //inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_produto').AsString := Fcd_produto;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      qry.ParamByName('desc_produto').AsString := Fdesc_produto;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ParamByName('fator_conversao').AsCurrency := Ffator_conversao;
      qry.ParamByName('peso_liquido').AsCurrency := Fpeso_liquido;
      qry.ParamByName('peso_bruto').AsCurrency := Fpeso_bruto;
      qry.ParamByName('observacao').AsString := Fobservacao;
      qry.ParamByName('id_item').AsLargeInt := Fid_item;

      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os dados do produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TProduto.Pesquisar(IdItem: Int64): Boolean;
const
  SQL = 'select         '+
        '   id_item     '+
        'from           '+
        '   produto     '+
        'where          '+
        '   id_item = :id_item';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL);
    qry.ParamByName('id_item').AsLargeInt := IdItem;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TProduto.Setcd_produto(const Value: String);
begin
  Fcd_produto := Value;
end;

procedure TProduto.Setdesc_produto(const Value: string);
begin
  Fdesc_produto := Value;
end;

procedure TProduto.Setfator_conversao(const Value: Integer);
begin
  Ffator_conversao := Value;
end;

procedure TProduto.Setfl_ativo(const Value: Boolean);
begin
  Ffl_ativo := Value;
end;

procedure TProduto.Setid_item(const Value: Int64);
begin
  Fid_item := Value;
end;

procedure TProduto.Setimagem(const Value: Byte);
begin
  Fimagem := Value;
end;

procedure TProduto.Setobservacao(const Value: string);
begin
  Fobservacao := Value;
end;

procedure TProduto.Setpeso_bruto(const Value: Double);
begin
  Fpeso_bruto := Value;
end;

procedure TProduto.Setpeso_liquido(const Value: Double);
begin
  Fpeso_liquido := Value;
end;

procedure TProduto.Setun_medida(const Value: string);
begin
  Fun_medida := Value;
end;

{ TProdutoCodigoBarras }

procedure TProdutoCodigoBarras.Atualizar;
const
  SQL_UPDATE = 'update produto_cod_barras set '+
               '  un_medida = :un_medida, '+
               '  tipo_cod_barras = :tipo_cod_barras, '+
               '  codigo_barras = :codigo_barras '+
               'where id_item = :id_item';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(sql_update);

      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('un_medida').AsString := Dados.cdsBarras.FieldByName('un_medida').AsString;
      if Dados.cdsBarras.FieldByName('tipo_cod_barras').AsString = 'Interno' then
        qry.ParamByName('tipo_cod_barras').AsInteger := 0
      else if Dados.cdsBarras.FieldByName('tipo_cod_barras').AsString = 'GTIN' then
        qry.ParamByName('tipo_cod_barras').AsInteger := 1
      else
        qry.ParamByName('tipo_cod_barras').AsInteger := 2;
      qry.ParamByName('codigo_barras').AsString := Dados.cdsBarras.FieldByName('codigo_barras').AsString;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os códigos de barras do produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

constructor TProdutoCodigoBarras.Create;
begin
  FDados := TdmProdutoCodBarras.Create(nil);
end;

destructor TProdutoCodigoBarras.Destroy;
begin
  FDados.Free;
end;

procedure TProdutoCodigoBarras.Excluir;
const SQL =
        'delete '+
         '  from '+
         'produto_cod_barras '+
         '  where '+
         'cd_produto = :cd_produto and '+
         'codigo_barras = :codigo_barras and ' +
         'un_medida = :un_medida';

var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL);
      qry.ParamByName('cd_produto').AsString := Fcd_produto;
      qry.ParamByName('codigo_barras').AsString := Fcodigo_barras;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ExecSQL;
      dm.conexaoBanco.Commit;
    except
      on E : exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os códigos de barras do produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

procedure TProdutoCodigoBarras.Inserir;
const
  SQL_INSERT = 'insert into produto_cod_barras(id_item, un_medida, tipo_cod_barras, codigo_barras) ' +
               ' values '+
               '(:id_item, :un_medida, :tipo_cod_barras, :codigo_barras)';
var
  qry: TFDQuery;
begin
  //inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  dm.conexaoBanco.StartTransaction;

  try
    try
      qry.SQL.Add(SQL_INSERT);
      qry.ParamByName('id_item').AsLargeInt := Fid_item;
      qry.ParamByName('un_medida').AsString := Fun_medida;
      qry.ParamByName('tipo_cod_barras').AsInteger := Ftipo_cod_barras.ToInteger;
      qry.ParamByName('codigo_barras').AsString := Fcodigo_barras;
      qry.ExecSQL;

      dm.conexaoBanco.Commit;

    except
    on E:exception do
      begin
        dm.conexaoBanco.Rollback;
        raise Exception.Create('Erro ao gravar os códigos de barras do produto ' + E.Message);
      end;
    end;
  finally
    dm.conexaoBanco.Rollback;
    qry.Free;
  end;
end;

function TProdutoCodigoBarras.Pesquisar(CdProduto: Integer): Boolean;
begin
 Result := False;
end;

function TProdutoCodigoBarras.Pesquisar(IdItem: Int64; CodBarras: String): Boolean;
const
  sql = 'select '+
        '   id_item '+
        'from '+
        '   produto_cod_barras '+
        'where '+
        '   id_item = :id_item and '+
        '   codigo_barras = :codigo_barras';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(sql);

    qry.ParamByName('id_item').AsInteger := IdItem;
    qry.ParamByName('codigo_barras').AsString := CodBarras;
    qry.Open(sql);

    Result := not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

procedure TProdutoCodigoBarras.Setcodigo_barras(const Value: String);
begin
  Fcodigo_barras := Value;
end;

procedure TProdutoCodigoBarras.Settipo_cod_barras(const Value: String);
begin
  Ftipo_cod_barras := Value;
end;

end.
