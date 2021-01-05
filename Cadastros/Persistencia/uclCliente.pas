unit uclCliente;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Comp.DataSet, Data.DB;

type TCliente = class
  private
    Fcpf_cnpj: string;
    Femail: string;
    Frg_ie: string;
    Ffl_ativo: Boolean;
    Ftp_pessoa: string;
    Fdt_nasc_fundacao: TDateTime;
    Fnome: string;
    Ftelefone: string;
    Fcelular: string;
    Fcd_cliente: Integer;
    Ffl_fornecedor: Boolean;
    procedure Setcelular(const Value: string);
    procedure Setcpf_cnpj(const Value: string);
    procedure Setdt_nasc_fundacao(const Value: TDateTime);
    procedure Setemail(const Value: string);
    procedure Setfl_ativo(const Value: Boolean);
    procedure Setnome(const Value: string);
    procedure Setrg_ie(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Settp_pessoa(const Value: string);
    procedure Setcd_cliente(const Value: Integer);
    procedure Setfl_fornecedor(const Value: Boolean);
  public
    function Pesquisar(CdCliente: Integer): Boolean;
    function GeraCodigoCliente: Integer;
    procedure Atualizar;
    procedure Inserir;
    procedure Excluir;
    procedure Buscar(CdCliente: Integer);

    property cd_cliente: Integer read Fcd_cliente write Setcd_cliente;
    property nome: string read Fnome write Setnome;
    property fl_ativo: Boolean read Ffl_ativo write Setfl_ativo;
    property tp_pessoa: string read Ftp_pessoa write Settp_pessoa;
    property telefone: string read Ftelefone write Settelefone;
    property celular: string read Fcelular write Setcelular;
    property email: string read Femail write Setemail;
    property cpf_cnpj: string read Fcpf_cnpj write Setcpf_cnpj;
    property rg_ie: string read Frg_ie write Setrg_ie;
    property dt_nasc_fundacao: TDateTime read Fdt_nasc_fundacao write Setdt_nasc_fundacao;
    property fl_fornecedor: Boolean read Ffl_fornecedor write Setfl_fornecedor;
end;

type TClienteEndereco = class
  private
    Flogradouro: string;
    Fbairro: string;
    Fuf: string;
    Fcep: string;
    Fnumero: string;
    Fcd_cliente: Integer;
    Fcidade: string;
    procedure Setbairro(const Value: string);
    procedure Setcd_cliente(const Value: Integer);
    procedure Setcep(const Value: string);
    procedure Setcidade(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setnumero(const Value: string);
    procedure Setuf(const Value: string);

  public
    procedure Atualizar;
    procedure Inserir;
    procedure Buscar(CdCliente: Integer);
    property cd_cliente: Integer read Fcd_cliente write Setcd_cliente;
    property logradouro: string read Flogradouro write Setlogradouro;
    property numero: string read Fnumero write Setnumero;
    property bairro: string read Fbairro write Setbairro;
    property cidade: string read Fcidade write Setcidade;
    property uf: string read Fuf write Setuf;
    property cep: string read Fcep write Setcep;
end;

implementation

uses
  uDataModule, System.SysUtils, Vcl.Dialogs;

{ TCliente }

procedure TCliente.Atualizar;
const
  SQL =
    'update                                 '+
    '   cliente                             '+
    'set                                    '+
    '  nome = :nome,                        '+
    '  Fl_ativo = :fl_ativo,                '+
    '  tp_pessoa = :tp_pessoa,              '+
    '  telefone = :telefone,                '+
    '  celular = :celular,                  '+
    '  email = :email,                      '+
    '  cpf_cnpj = :cpf_cnpj,                '+
    '  rg_ie = :rg_ie,                      '+
    '  dt_nasc_fundacao = :dt_nasc_fundacao,'+
    '  fl_fornecedor = :fl_fornecedor       '+
    'where                                  '+
    '  cd_cliente = :cd_cliente';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cliente').AsInteger := Fcd_cliente;
      qry.ParamByName('nome').AsString := Fnome;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      if Ftp_pessoa = 'F' then
        qry.ParamByName('tp_pessoa').AsString := 'F'
      else
        qry.ParamByName('tp_pessoa').AsString := 'J';
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('celular').AsString := Fcelular;
      qry.ParamByName('email').AsString := Femail;
      qry.ParamByName('cpf_cnpj').AsString := Fcpf_cnpj;
      qry.ParamByName('rg_ie').AsString := Frg_ie;
      qry.ParamByName('dt_nasc_fundacao').AsDate := Fdt_nasc_fundacao;
      qry.ParamByName('fl_fornecedor').AsBoolean := Ffl_fornecedor;

      qry.ExecSQL;
      qry.Connection.Commit;
    except
      on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do cliente' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TCliente.Buscar(CdCliente: Integer);
const
  SQL =
    'select ' +
    '    c.cd_cliente, ' +
    '    c.nome, ' +
    '    c.tp_pessoa, ' +
    '    c.fl_ativo, ' +
    '    c.telefone, ' +
    '    c.celular, ' +
    '    c.email, ' +
    '    c.cpf_cnpj, ' +
    '    c.rg_ie, ' +
    '    c.dt_nasc_fundacao, ' +
    '    c.fl_fornecedor ' +
    'from ' +
    '    cliente c ' +
    'where ' +
    '    c.cd_cliente = :cd_cliente ';
var
  qry: TFDQuery;
  endereco: TClienteEndereco;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.SQL.Add(SQL);
  endereco := TClienteEndereco.Create;

  try
    qry.ParamByName('cd_cliente').AsInteger := CdCliente;
    qry.Open();

    if not qry.IsEmpty then
    begin
      cd_cliente := qry.FieldByName('cd_cliente').AsInteger;
      nome := qry.FieldByName('nome').AsString;
      fl_ativo := qry.FieldByName('fl_ativo').AsBoolean;
      tp_pessoa := qry.FieldByName('tp_pessoa').AsString;
      telefone := qry.FieldByName('telefone').AsString;
      celular := qry.FieldByName('celular').AsString;
      email := qry.FieldByName('email').AsString;
      cpf_cnpj := qry.FieldByName('cpf_cnpj').AsString;
      rg_ie := qry.FieldByName('rg_ie').AsString;
      dt_nasc_fundacao := qry.FieldByName('dt_nasc_fundacao').AsDateTime;
      fl_fornecedor := qry.FieldByName('fl_fornecedor').AsBoolean;
    end;

  finally
    endereco.Free;
    qry.Free;
  end;
end;

procedure TCliente.Excluir;
const
  SQL =
  'delete                   '+
  ' from                    '+
  'cliente                  '+
  ' where                   '+
  'cd_cliente = :cd_cliente';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cliente').AsInteger := Fcd_cliente;
      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao excluir os dados do cliente ' + Fcd_cliente.ToString + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

function TCliente.GeraCodigoCliente: Integer;
const
  SQL = 'select nextval(''cliente_seq'') as cod';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.SQL.Add(SQL);

  try
    qry.Open();

    Result := qry.FieldByName('cod').AsInteger;

  finally
    qry.Free;
  end;
end;

procedure TCliente.Inserir;
const
  SQL =
  'insert                     '+
  '    into                   '+
  '    cliente (cd_cliente,   '+
  '    fl_ativo,              '+
  '    fl_fornecedor,         '+
  '    nome,                  '+
  '    tp_pessoa,             '+
  '    telefone,              '+
  '    celular,               '+
  '    email,                 '+
  '    cpf_cnpj,              '+
  '    rg_ie,                 '+
  '    dt_nasc_fundacao)      '+
  'values (:cd_cliente,       '+
  ':fl_ativo,                 '+
  ':fl_fornecedor,            '+
  ':nome,                     '+
  ':tp_pessoa,                '+
  ':telefone,                 '+
  ':celular,                  '+
  ':email,                    '+
  ':cpf_cnpj,                 '+
  ':rg_ie,                    '+
  ':dt_nasc_fundacao)';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cliente').AsInteger := Fcd_cliente;
      qry.ParamByName('nome').AsString := Fnome;
      qry.ParamByName('fl_ativo').AsBoolean := Ffl_ativo;
      if Ftp_pessoa = 'F' then
        qry.ParamByName('tp_pessoa').AsString := 'F'
      else
        qry.ParamByName('tp_pessoa').AsString := 'J';
      qry.ParamByName('telefone').AsString := Ftelefone;
      qry.ParamByName('celular').AsString := Fcelular;
      qry.ParamByName('email').AsString := Femail;
      qry.ParamByName('cpf_cnpj').AsString := Fcpf_cnpj;
      qry.ParamByName('rg_ie').AsString := Frg_ie;
      qry.ParamByName('dt_nasc_fundacao').AsDate := Fdt_nasc_fundacao;
      qry.ParamByName('fl_fornecedor').AsBoolean := Ffl_fornecedor;

      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do cliente' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

function TCliente.Pesquisar(CdCliente: Integer): Boolean;
const
  SQL_CLIENTE = 'select       '+
                    '*        '+
                'from         '+
                    'cliente  '+
                'where        '+
                    'cd_cliente = :cd_cliente';
var
  qry: TFDquery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;

  try
    qry.SQL.Add(SQL_CLIENTE);
    qry.ParamByName('cd_cliente').AsInteger := CdCliente;
    qry.Open();

    Result := not qry.IsEmpty;

  finally
    qry.Free;
  end;
end;

procedure TCliente.Setcd_cliente(const Value: Integer);
begin
  Fcd_cliente := Value;
end;

procedure TCliente.Setcelular(const Value: string);
begin
  Fcelular := Value;
end;

procedure TCliente.Setcpf_cnpj(const Value: string);
begin
  Fcpf_cnpj := Value;
end;

procedure TCliente.Setdt_nasc_fundacao(const Value: TDateTime);
begin
  Fdt_nasc_fundacao := Value;
end;

procedure TCliente.Setemail(const Value: string);
begin
  Femail := Value;
end;

procedure TCliente.Setfl_ativo(const Value: Boolean);
begin
  Ffl_ativo := Value;
end;

procedure TCliente.Setfl_fornecedor(const Value: Boolean);
begin
  Ffl_fornecedor := Value;
end;

procedure TCliente.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure TCliente.Setrg_ie(const Value: string);
begin
  Frg_ie := Value;
end;

procedure TCliente.Settelefone(const Value: string);
begin
  Ftelefone := Value;
end;

procedure TCliente.Settp_pessoa(const Value: string);
begin
  Ftp_pessoa := Value;
end;

{ TClienteEndereco }

procedure TClienteEndereco.Atualizar;
const
  SQL =
      'update                          '+
      '   endereco_cliente             '+
      'set                             '+
      '   cd_cliente = :cd_cliente,    '+
      '   logradouro = :logradouro,    '+
      '   num = :num,                  '+
      '   bairro = :bairro,            '+
      '   cidade = :cidade,            '+
      '   uf = :uf,                    '+
      '   cep = :cep                   '+
      'where                           '+
      '   cd_cliente = :cd_cliente';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cliente').AsInteger := Fcd_cliente;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('num').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;

      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do cliente' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TClienteEndereco.Buscar(CdCliente: Integer);
const
  SQL =
    'select ' +
    '    c.cd_cliente, ' +
    '    c.logradouro, ' +
    '    c.num, ' +
    '    c.bairro, ' +
    '    c.cidade, ' +
    '    c.uf, ' +
    '    c.cep ' +
    'from ' +
    '    endereco_cliente c ' +
    'where ' +
    '    c.cd_cliente = :cd_cliente ';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.SQL.Add(SQL);

  try
    qry.ParamByName('cd_cliente').AsInteger := CdCliente;
    qry.Open();

    if not qry.IsEmpty then
    begin
      cd_cliente := qry.FieldByName('cd_cliente').AsInteger;
      logradouro := qry.FieldByName('logradouro').AsString;
      numero := qry.FieldByName('num').AsString;
      bairro := qry.FieldByName('bairro').AsString;
      cidade := qry.FieldByName('cidade').AsString;
      uf := qry.FieldByName('uf').AsString;
      cep := qry.FieldByName('cep').AsString;
    end;

  finally
    qry.Free;
  end;
end;

procedure TClienteEndereco.Inserir;
const
  SQL =
  'insert                     '+
  '    into                   '+
  '    endereco_cliente       '+
  '   (cd_cliente,            '+
  '    logradouro,            '+
  '    num,                   '+
  '    bairro,                '+
  '    cidade,                '+
  '    uf,                    '+
  '    cep)                   '+
  'values (:cd_cliente,       '+
  ':logradouro,               '+
  ':num,                      '+
  ':bairro,                   '+
  ':cidade,                   '+
  ':uf,                       '+
  ':cep)';
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.Connection := dm.conexaoBanco;
  qry.Connection.StartTransaction;
  qry.SQL.Add(SQL);

  try
    try
      qry.ParamByName('cd_cliente').AsInteger := Fcd_cliente;
      qry.ParamByName('logradouro').AsString := Flogradouro;
      qry.ParamByName('num').AsString := Fnumero;
      qry.ParamByName('bairro').AsString := Fbairro;
      qry.ParamByName('cidade').AsString := Fcidade;
      qry.ParamByName('uf').AsString := Fuf;
      qry.ParamByName('cep').AsString := Fcep;

      qry.ExecSQL;
      qry.Connection.Commit;
    except
    on E:exception do
      begin
        qry.Connection.Rollback;
        raise Exception.Create('Erro ao gravar os dados do cliente' + E.Message);
      end;
    end;
  finally
    qry.Connection.Rollback;
    qry.Free;
  end;
end;

procedure TClienteEndereco.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TClienteEndereco.Setcd_cliente(const Value: Integer);
begin
  Fcd_cliente := Value;
end;

procedure TClienteEndereco.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TClienteEndereco.Setcidade(const Value: string);
begin
  Fcidade := Value;
end;

procedure TClienteEndereco.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TClienteEndereco.Setnumero(const Value: string);
begin
  Fnumero := Value;
end;

procedure TClienteEndereco.Setuf(const Value: string);
begin
  Fuf := Value;
end;

end.
