unit cCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uValidaDcto, uConexao,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.DBCtrls, Vcl.Buttons, StrUtils, System.Generics.Collections;

type
  TfrmCadCliente = class(TfrmConexao)
    tpCadCliente: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCLIENTECPF_CNPJ: TLabel;
    Label11: TLabel;
    lblCLIENTEIE_RG: TLabel;
    lblCLIENTEDTNASCIMENTO: TLabel;
    edtCLIENTENM_CLIENTE: TEdit;
    gbENDERECO: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtCLIENTEENDERECO_BAIRRO: TEdit;
    edtCLIENTEENDERECO_CIDADE: TEdit;
    edtCLIENTEENDERECO_NUMERO: TEdit;
    edtCLIENTETP_PESSOA: TRadioGroup;
    edtCLIENTECELULAR: TMaskEdit;
    edtCLIENTEEMAIL: TEdit;
    edtCLIENTEENDERECO_LOGRADOURO: TEdit;
    edtCLIENTECPF_CNPJ: TMaskEdit;
    edtCLIENTERG: TEdit;
    edtCLIENTEDATANASCIMENTO: TMaskEdit;
    edtCLIENTEFL_FORNECEDOR: TCheckBox;
    edtCLIENTEFL_ATIVO: TCheckBox;
    edtCLIENTEcd_cliente: TEdit;
    edtEstado: TEdit;
    Label5: TLabel;
    edtCep: TEdit;
    edtCLIENTEFONE: TMaskEdit;
    cbbEstado: TComboBox;
    procedure pFormarCamposPessoa;
    procedure edtCLIENTETP_PESSOAClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCepExit(Sender: TObject);
    procedure edtCLIENTECELULARExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCLIENTEcd_clienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FcdCliente: Integer;
    { Private declarations }
    procedure limpaCampos;
    //procedure validaCampos;
    procedure salvar;
    procedure excluir;
    procedure desabilitaCampos;
    procedure SetcdCliente(const Value: Integer);
    procedure listaEstados;
  public
    { Public declarations }
    property cdCliente: Integer read FcdCliente write SetcdCliente;
  end;

var
  frmCadCliente: TfrmCadCliente;
  temCep, camposDesabilitados: Boolean;
  cep, chamada: String;
  lista: TList<string>;

implementation

{$R *.dfm}

uses uDataModule, uValidaDados, uLogin, uConsulta;

procedure TfrmCadCliente.pFormarCamposPessoa;
begin
  //Muda o caption do label CPF/CNPJ e RG/IE
  if edtCLIENTETP_PESSOA.ItemIndex = 0 then
  begin
    lblCLIENTECPF_CNPJ.Caption := 'CPF';
    edtCLIENTECPF_CNPJ.Width    := 90;
    edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CPF;
    lblCLIENTEIE_RG.Caption    := 'RG';
    lblCLIENTEDTNASCIMENTO.Caption := 'Data Nascimento';
    edtCLIENTEDATANASCIMENTO.EditMask := uValidaDcto.MASCARA_DATA;
    edtCLIENTEFONE.EditMask := uValidaDcto.MASCARA_TELEFONE;
    edtCLIENTECELULAR.EditMask := uValidaDcto.MASCARA_CELULAR;
    edtCLIENTEDATANASCIMENTO.Visible := true;
  end
  else
  begin
    lblCLIENTECPF_CNPJ.Caption  := 'CNPJ';
    edtCLIENTECPF_CNPJ.Width    := 110;
    edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CNPJ;
    lblCLIENTEIE_RG.Caption    := 'IE';
    lblCLIENTEDTNASCIMENTO.Caption := 'Data Fundação';
    edtCLIENTEDATANASCIMENTO.EditMask := uValidaDcto.MASCARA_DATA;
    edtCLIENTEFONE.EditMask := uValidaDcto.MASCARA_TELEFONE;
    edtCLIENTECELULAR.EditMask := uValidaDcto.MASCARA_CELULAR;
  end;
end;

procedure TfrmCadCliente.salvar;
const
  SQL_CLIENTE = 'select       '+
                    '*        '+
                'from         '+
                    'cliente  '+
                'where        '+
                    'cd_cliente = :cd_cliente';

var cliente : TValidaDados;
qry, qryCliente, qryEnd: TFDQuery;
begin
  dm.transacao.StartTransaction;
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;
  qryCliente := TFDQuery.Create(Self);
  qryCliente.Connection := dm.FDConnection1;
  qryEnd := TFDQuery.Create(Self);
  qryEnd.Connection := dm.FDConnection1;

   try
    cliente := TValidaDados.Create;
    cliente.nomeCliente := edtCLIENTENM_CLIENTE.Text;
    cliente.cpf := edtCLIENTECPF_CNPJ.Text;
    cliente.cdCliente := StrToInt(edtCLIENTEcd_cliente.Text);
    cliente.validaNomeCpf(edtCLIENTENM_CLIENTE.Text, edtCLIENTECPF_CNPJ.Text);
    cliente.validaCodigo(StrToInt(edtCLIENTEcd_cliente.Text));

    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add(SQL_CLIENTE);
    qry.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
    qry.Open();

    if not qry.IsEmpty then
    begin
      qryCliente.SQL.Clear;
      qryCliente.SQL.Text := 'update                                  '+
                                      'cliente                              '+
                                  'set                                      '+
                                  '    nome = :nome,                        '+
                                   '   fl_ativo = :fl_ativo,                '+
                                    '  tp_pessoa = :tp_pessoa,              '+
                                    '  telefone = :telefone,                '+
                                    '  celular = :celular,                  '+
                                    '  email = :email,                      '+
                                    '  cpf_cnpj = :cpf_cnpj,                '+
                                    '  rg_ie = :rg_ie,                      '+
                                    '  dt_nasc_fundacao = :dt_nasc_fundacao '+
                                  'where                                    '+
                                    '  cd_cliente = :cd_cliente';

      qryCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
      qryCliente.ParamByName('nome').AsString := edtCLIENTENM_CLIENTE.Text;
      qryCliente.ParamByName('fl_ativo').AsBoolean := edtCLIENTEFL_ATIVO.Checked;
      case edtCLIENTETP_PESSOA.ItemIndex of
      0:
        begin
          qryCliente.ParamByName('tp_pessoa').AsString := 'F';
        end;
      1:
        begin
          qryCliente.ParamByName('tp_pessoa').AsString := 'J';
        end;
      end;

      qryCliente.ParamByName('telefone').AsString := edtCLIENTEFONE.Text;
      qryCliente.ParamByName('celular').AsString := edtCLIENTECELULAR.Text;
      qryCliente.ParamByName('email').AsString := edtCLIENTEEMAIL.Text;
      qryCliente.ParamByName('cpf_cnpj').AsString := edtCLIENTECPF_CNPJ.Text;
      qryCliente.ParamByName('rg_ie').AsString := edtCLIENTERG.Text;
      qryCliente.ParamByName('dt_nasc_fundacao').AsDate := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

      qryEnd.SQL.Text := 'update                           '+
                                          'endereco_cliente           '+
                                    'set                              '+
                                     '   cd_cliente = :cd_cliente,    '+
                                      '  logradouro = :logradouro,    '+
                                      '  num = :num,                  '+
                                      '  bairro = :bairro,            '+
                                      '  cidade = :cidade,            '+
                                      '  uf = :uf,                    '+
                                      '  cep = :cep                   '+
                                    'where                            '+
                                      '  cd_cliente = :cd_cliente';

      qryEnd.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
      qryEnd.ParamByName('logradouro').AsString := edtCLIENTEENDERECO_LOGRADOURO.Text;
      qryEnd.ParamByName('num').AsInteger := StrToInt(edtCLIENTEENDERECO_NUMERO.Text);
      qryEnd.ParamByName('bairro').AsString := edtCLIENTEENDERECO_BAIRRO.Text;
      qryEnd.ParamByName('cidade').AsString := edtCLIENTEENDERECO_CIDADE.Text;
      qryEnd.ParamByName('uf').AsString := edtEstado.Text;
      qryEnd.ParamByName('cep').AsString := edtCep.Text;

      try
        qryCliente.ExecSQL;
        qryEnd.ExecSQL;
        dm.transacao.Commit;
        ShowMessage('Cliente alterado com sucesso');
        limpaCampos;
      except
        on E:exception do
          begin
            dm.transacao.Rollback;
            ShowMessage('Erro ao gravar os dados do cliente '+ E.Message);
            Exit;
          end;
      end;
    end
    else
    begin
      qryCliente.Close;
      qryCliente.SQL.Text :=  'insert                     '+
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

      qryCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
      qryCliente.ParamByName('fl_ativo').AsBoolean := edtCLIENTEFL_ATIVO.Checked;
      qryCliente.ParamByName('fl_fornecedor').AsBoolean := edtCLIENTEFL_FORNECEDOR.Checked;
      qryCliente.ParamByName('nome').AsString := edtCLIENTENM_CLIENTE.Text;
      //tipo da pessoa tá gravando F - Fisica, J - Juridica
      case edtCLIENTETP_PESSOA.ItemIndex of
      0:
        begin
          qryCliente.ParamByName('tp_pessoa').AsString := 'F';
        end;
      1:
        begin
          qryCliente.ParamByName('tp_pessoa').AsString := 'J';
        end;
      end;

      qryCliente.ParamByName('telefone').AsString := edtCLIENTEFONE.Text;
      qryCliente.ParamByName('celular').AsString := edtCLIENTECELULAR.Text;
      qryCliente.ParamByName('email').AsString := edtCLIENTEEMAIL.Text;
      qryCliente.ParamByName('cpf_cnpj').AsString := edtCLIENTECPF_CNPJ.Text;
      qryCliente.ParamByName('rg_ie').AsString := edtCLIENTERG.Text;
      qryCliente.ParamByName('dt_nasc_fundacao').AsDate := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

      qryEnd.SQL.Text := 'insert                     '+
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

      qryEnd.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
      qryEnd.ParamByName('logradouro').AsString := edtCLIENTEENDERECO_LOGRADOURO.Text;
      qryEnd.ParamByName('num').AsInteger := StrToInt(edtCLIENTEENDERECO_NUMERO.Text);
      qryEnd.ParamByName('bairro').AsString := edtCLIENTEENDERECO_BAIRRO.Text;
      qryEnd.ParamByName('cidade').AsString := edtCLIENTEENDERECO_CIDADE.Text;
      qryEnd.ParamByName('uf').AsString := edtEstado.Text;
      qryEnd.ParamByName('cep').AsString := edtCep.Text;

      try
        qryCliente.ExecSQL;
        qryEnd.ExecSQL;
        dm.transacao.Commit;
        ShowMessage('Cliente inserido com sucesso');
        limpaCampos;
      except
      on E:exception do
          begin
            dm.transacao.Rollback;
            ShowMessage('Erro ao gravar os dados do cliente '+ E.Message);
            Exit;
          end;
      end;
    end;
    finally
    qry.Free;
    qryCliente.Free;
    qryEnd.Free;
  end;
end;

procedure TfrmCadCliente.SetcdCliente(const Value: Integer);
begin
  FcdCliente := Value;
end;

procedure TfrmCadCliente.desabilitaCampos;
begin
  edtCLIENTENM_CLIENTE.Enabled := False;
  edtCLIENTEENDERECO_BAIRRO.Enabled := False;
  edtCLIENTEENDERECO_CIDADE.Enabled := False;
  edtCLIENTEENDERECO_NUMERO.Enabled := False;
  edtCLIENTETP_PESSOA.Enabled := False;
  edtCLIENTECELULAR.Enabled := False;
  edtCLIENTEEMAIL.Enabled := False;
  edtCLIENTEENDERECO_LOGRADOURO.Enabled := False;
  edtCLIENTECPF_CNPJ.Enabled := False;
  edtCLIENTERG.Enabled := False;
  edtCLIENTEDATANASCIMENTO.Enabled := False;
  edtCLIENTEFL_FORNECEDOR.Enabled := False;
  edtCLIENTEFL_ATIVO.Enabled := False;
  edtCLIENTEcd_cliente.Enabled := False;
  edtEstado.Enabled := False;
  edtCep.Enabled := False;
  edtCLIENTEFONE.Enabled := False;
  camposDesabilitados := True;
end;

procedure TfrmCadCliente.edtCepExit(Sender: TObject);
const
  SQL_ENDERECO_CLIENTE = 'select                                '+
                        '    e.endereco_logradouro,             '+
                        '    b.bairro_descricao,                '+
                        '    c.nm_cidade,                       '+
                        '    es.uf                              '+
                        '    from endereco e                    '+
                        'join bairro b on                       '+
                        '    e.bairro_codigo = b.bairro_codigo  '+
                        'join cidade c on                       '+
                        '    b.cidade_codigo = c.cd_cidade      '+
                        'join estado es on                      '+
                        '    c.uf = es.uf                       '+
                        'where e.endereco_cep = :endereco_cep		';

var
  sql : String;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    qry.SQL.Add(SQL_ENDERECO_CLIENTE);
    qry.ParamByName('endereco_cep').AsString := edtCep.Text;

    //se o cep do cadastro for diferente do que foi digitado
    //executa o sql acima
    if cep <> edtCep.Text then
      temCep := False;
    if temCep = True then
      Exit;

    if not qry.IsEmpty then
    begin
      qry.Open();
    end
    else
    begin
      qry.SQL.Add('or c.cep = :cep limit 1');
      qry.ParamByName('cep').AsString := edtCep.Text;
      qry.SQL.Add(sql);
      qry.Open();
    end;

    edtCLIENTEENDERECO_LOGRADOURO.Text := qry.FieldByName('endereco_logradouro').AsString;
    edtCLIENTEENDERECO_BAIRRO.Text := qry.FieldByName('bairro_descricao').AsString;
    edtCLIENTEENDERECO_CIDADE.Text := qry.FieldByName('nm_cidade').AsString;
    edtEstado.Text := qry.FieldByName('uf').AsString;
    edtCLIENTEENDERECO_LOGRADOURO.SetFocus;
  finally
    qry.Free;
  end;
end;

procedure TfrmCadCliente.edtCLIENTEcd_clienteExit(Sender: TObject);
const
  sql_seq = 'select last_value + 1 as last_value from cliente_seq';

  sql_temp = 'select nextval(''cliente_seq'')';

  sql_cliente = 'select '+
                    'c.cd_cliente, '+
                    'nome, '+
                    'fl_ativo, '+
                    'fl_fornecedor, '+
                    'tp_pessoa,'+
                    'telefone, '+
                    'celular, '+
                    'email, '+
                    'cpf_cnpj, '+
                    'rg_ie, '+
                    'dt_nasc_fundacao,'+
                    'logradouro, '+
                    'num, '+
                    'bairro, '+
                    'cidade, '+
                    'uf, '+
                    'cep '+
              'from '+
                    'cliente c '+
              'join endereco_cliente e on '+
                    'c.cd_cliente = e.cd_cliente '+
              'where c.cd_cliente = :cd_cliente';

var
 f : Integer;
 temPermissaEdicao: Boolean;
 cliente : TValidaDados;
 qry: TFDQuery;
begin
  temCep := False;
  cliente := TValidaDados.Create;
  temPermissaEdicao := cliente.validaEdicaoAcao(idUsuario, 1);
  qry := TFDQuery.Create(Self);
  qry.Connection := dm.FDConnection1;

  try
    f := 0;
    if edtCLIENTEcd_cliente.Text = '' then
      begin
        if not temPermissaEdicao then
        begin
          MessageDlg('Usuário não possui Permissão para realizar Cadastro', mtInformation, [mbOK], 0);
          edtCLIENTEcd_cliente.SetFocus;
          Exit;
        end;

        edtCLIENTEFL_ATIVO.SetFocus;

        //incrementa o código do cliente
        qry.Close;
        qry.Open(sql_seq);
        qry.First;
        edtCLIENTEcd_cliente.Text := qry.FieldByName('last_value').AsString;
        qry.Close;

        //incrementa o sequence
        qry.Open(sql_temp);
        qry.Close;
      end
    else
    begin
      with dm.sqlCliente do
      begin
        temCep := True;
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add(sql_cliente);
        qry.ParamByName('cd_cliente').Value := StrToInt(edtCLIENTEcd_cliente.Text);
        qry.Open();

        if not qry.IsEmpty then
        begin
          edtCLIENTEFL_ATIVO.SetFocus;
          edtCLIENTEcd_cliente.Text := IntToStr(qry.FieldByName('cd_cliente').AsInteger);
          edtCLIENTENM_CLIENTE.Text := qry.FieldByName('nome').AsString;
          edtCLIENTEFL_ATIVO.Checked := qry.FieldByName('fl_ativo').AsBoolean;
          edtCLIENTEFL_FORNECEDOR.Checked := qry.FieldByName('fl_fornecedor').AsBoolean;

          if qry.FieldByName('tp_pessoa').AsString = 'F' then
          begin
            f := 0;
          end
          else if qry.FieldByName('tp_pessoa').AsString = 'J' then
          begin
            f := 1;
          end;

          case f of
          0:
            begin
              edtCLIENTETP_PESSOA.ItemIndex := 0;
              pFormarCamposPessoa;
            end;
          1:
            begin
              edtCLIENTETP_PESSOA.ItemIndex := 1;
              pFormarCamposPessoa;
            end;
          end;

          edtCLIENTEFONE.Text := qry.FieldByName('telefone').AsString;
          edtCLIENTECELULAR.Text := qry.FieldByName('celular').AsString;
          edtCLIENTEEMAIL.Text := qry.FieldByName('email').AsString;
          edtCLIENTECPF_CNPJ.Text := qry.FieldByName('cpf_cnpj').AsString;
          edtCLIENTERG.Text := qry.FieldByName('rg_ie').AsString;
          edtCLIENTEDATANASCIMENTO.Text := DateToStr(qry.FieldByName('dt_nasc_fundacao').AsDateTime);
          edtCLIENTEENDERECO_LOGRADOURO.Text := qry.FieldByName('logradouro').AsString;
          edtCLIENTEENDERECO_NUMERO.Text := IntToStr(qry.FieldByName('num').AsInteger);
          edtCLIENTEENDERECO_BAIRRO.Text := qry.FieldByName('bairro').AsString;
          edtCLIENTEENDERECO_CIDADE.Text := qry.FieldByName('cidade').AsString;
          edtEstado.Text := qry.FieldByName('uf').AsString;
          edtCep.Text := qry.FieldByName('cep').AsString;
          cep := edtCep.Text;
        end;
      end;
    end;

    if temPermissaEdicao then
      Exit
    else
      desabilitaCampos;

  finally
    qry.Free;
  end;
end;


procedure TfrmCadCliente.edtCLIENTEcd_clienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
const
  sql = 'select cd_cliente, nome, cpf_cnpj from cliente';
var
  consulta: TfrmConsulta;
begin
  consulta := TfrmConsulta.Create(Self);
  if key = VK_F9 then
  begin
    chamada := 'cntCliente';
    consulta.abreConsultaCliente(sql);
    consulta.ShowModal;
  end;
end;

procedure TfrmCadCliente.edtCLIENTECELULARExit(Sender: TObject);
begin
  inherited;
  edtCep.SetFocus;
end;

procedure TfrmCadCliente.edtCLIENTETP_PESSOAClick(Sender: TObject);
begin
  pFormarCamposPessoa;
end;


procedure TfrmCadCliente.excluir;
begin
  if (Application.MessageBox('Deseja Excluir o Cliente?','Atenção', MB_YESNO) = IDYES) then
  begin
    try
      conexao.ExecSQL('delete                   '+
                      ' from                    '+
                      'cliente                  '+
                      ' where                   '+
                      'cd_cliente = :cd_cliente',
                      [StrToInt(edtCLIENTEcd_cliente.Text)]);//parametros
      ShowMessage('Cliente excluído com sucesso!');
      limpaCampos;
    except
      on E:exception do
      begin
        ShowMessage('Erro ao excluir os dados do cliente ' +edtCLIENTEcd_cliente.Text + E.Message);
      end;
    end;
  end
  else
  begin
    Exit;
  end;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmCadCliente := nil;
end;

procedure TfrmCadCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
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

procedure TfrmCadCliente.FormKeyPress(Sender: TObject; var Key: Char);
//passa pelos campos pressionando enter
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmCadCliente.limpaCampos;
begin
  if camposDesabilitados then
  begin
    edtCLIENTENM_CLIENTE.Enabled := True;
    edtCLIENTEENDERECO_BAIRRO.Enabled := True;
    edtCLIENTEENDERECO_CIDADE.Enabled := True;
    edtCLIENTEENDERECO_NUMERO.Enabled := True;
    edtCLIENTETP_PESSOA.Enabled := True;
    edtCLIENTECELULAR.Enabled := True;
    edtCLIENTEEMAIL.Enabled := True;
    edtCLIENTEENDERECO_LOGRADOURO.Enabled := True;
    edtCLIENTECPF_CNPJ.Enabled := True;
    edtCLIENTERG.Enabled := True;
    edtCLIENTEDATANASCIMENTO.Enabled := True;
    edtCLIENTEFL_FORNECEDOR.Enabled := True;
    edtCLIENTEFL_ATIVO.Enabled := True;
    edtCLIENTEcd_cliente.Enabled := True;
    edtEstado.Enabled := True;
    edtCep.Enabled := True;
    edtCLIENTEFONE.Enabled := True;
    camposDesabilitados := False;
  end;

  //limpa os campos
  edtCLIENTEcd_cliente.Clear;
  edtCLIENTENM_CLIENTE.Clear;
  edtCLIENTEFONE.Clear;
  edtCLIENTECELULAR.Clear;
  edtCLIENTEEMAIL.Clear;
  edtCLIENTEENDERECO_LOGRADOURO.Clear;
  edtCLIENTECPF_CNPJ.Clear;
  edtCLIENTEENDERECO_BAIRRO.Clear;
  edtCLIENTEENDERECO_CIDADE.Clear;
  edtCLIENTEENDERECO_NUMERO.Clear;
  edtCLIENTEFL_ATIVO.Checked := false;
  edtCLIENTEFL_FORNECEDOR.Checked := false;
  edtCLIENTERG.Clear;
  edtCLIENTEDATANASCIMENTO.Clear;
  edtCLIENTEcd_cliente.SetFocus;
  edtCLIENTETP_PESSOA.ItemIndex := -1;
  edtCep.Clear;
  edtEstado.Clear;
end;

procedure TfrmCadCliente.listaEstados;
var
  lista: TList<string>;
  i: Integer;
begin
  lista := TList<string>.Create;

  try
    lista.Add('AC');
    lista.Add('AL');
    lista.Add('AM');
    lista.Add('AP');
    lista.Add('BA');
    lista.Add('CE');
    lista.Add('DF');
    lista.Add('ES');
    lista.Add('GO');
    lista.Add('MA');
    lista.Add('MG');
    lista.Add('MS');
    lista.Add('MT');
    lista.Add('PA');
    lista.Add('PB');
    lista.Add('PE');
    lista.Add('PI');
    lista.Add('PR');
    lista.Add('RJ');
    lista.Add('RN');
    lista.Add('RO');
    lista.Add('RR');
    lista.Add('RS');
    lista.Add('SC');
    lista.Add('SE');
    lista.Add('SP');
    lista.Add('TO');

    for i := 0 to lista.Count - 1 do
    begin
      cbbEstado.Items.Add(lista[i]);
    end;

  finally
    lista.Free;
  end;
end;

end.
