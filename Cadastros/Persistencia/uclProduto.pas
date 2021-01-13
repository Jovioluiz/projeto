unit uclProduto;

interface

uses
  uclPadrao, FireDAC.Comp.Client, FireDAC.Stan.Param;

type TProduto = class(TPadrao)
  private
    Fobservacao: string;
    Fpeso_liquido: Double;
    Fcd_produto: Integer;
    Ffl_ativo: Boolean;
    Fun_medida: string;
    Fdesc_produto: string;
    Fimagem: Byte;
    Fpeso_bruto: Double;
    Ffator_conversao: Integer;
    procedure Setcd_produto(const Value: Integer);
    procedure Setdesc_produto(const Value: string);
    procedure Setfator_conversao(const Value: Integer);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setimagem(const Value: Byte);
    procedure Setobservacao(const Value: string);
    procedure Setpeso_bruto(const Value: Double);
    procedure Setpeso_liquido(const Value: Double);
    procedure Setun_medida(const Value: string);

  public
    procedure Atualizar; override;
    procedure Inserir; override;
    procedure Excluir; override;

    property cd_produto: Integer read Fcd_produto write Setcd_produto;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;
    property desc_produto: string read Fdesc_produto write Setdesc_produto;
    property un_medida: string read Fun_medida write Setun_medida;
    property fator_conversao: Integer read Ffator_conversao write Setfator_conversao;
    property peso_liquido: Double read Fpeso_liquido write Setpeso_liquido;
    property peso_bruto: Double read Fpeso_bruto write Setpeso_bruto;
    property observacao: string read Fobservacao write Setobservacao;
    property imagem: Byte read Fimagem write Setimagem;
end;

implementation

uses
  uDataModule, System.SysUtils;

{ TProduto }

procedure TProduto.Atualizar;
begin
  inherited;

end;


procedure TProduto.Excluir;
const
  sql = 'delete                    '+
        '  from                    '+
        'produto                   '+
        '  where                   '+
        'cd_produto = :cd_produto';
var
  qry: TFDQuery;
begin
  inherited;
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_produto').AsInteger := Fcd_produto;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao excluir os dados do produto ' + Fcd_produto.ToString + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TProduto.Inserir;
begin
  inherited;

end;

procedure TProduto.Setcd_produto(const Value: Integer);
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

end.
