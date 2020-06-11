unit cCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uValidaDcto, uConexao,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.DBCtrls, Vcl.Buttons;

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
    edtCLIENTEFONE: TMaskEdit;
    edtCLIENTECELULAR: TMaskEdit;
    edtCLIENTEEMAIL: TEdit;
    edtCLIENTEENDERECO_LOGRADOURO: TEdit;
    edtCLIENTECPF_CNPJ: TMaskEdit;
    edtCLIENTERG: TEdit;
    edtCLIENTEDATANASCIMENTO: TMaskEdit;
    FDQuery1: TFDQuery;
    sqlInsertCliente: TFDQuery;
    sqlInsertEndereco: TFDQuery;
    edtCLIENTEFL_FORNECEDOR: TCheckBox;
    edtCLIENTEFL_ATIVO: TCheckBox;
    btnSalvar: TSpeedButton;
    edtCLIENTEcd_cliente: TEdit;
    btnCancelarCadCliente: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnCLIENTELimpar: TSpeedButton;
    edtEstado: TEdit;
    Label5: TLabel;
    edtCep: TEdit;
    procedure pFormarCamposPessoa;
    procedure edtCLIENTETP_PESSOAClick(Sender: TObject);
    procedure btnCancelarCadClienteClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCLIENTELimparClick(Sender: TObject);
    procedure edtCepExit(Sender: TObject);
    procedure edtCLIENTECELULARExit(Sender: TObject);
  private
    { Private declarations }
    sql_seq : String;
    procedure limpaCampos;
    procedure validaCampos;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDataModule;

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

procedure TfrmCadCliente.validaCampos;
begin
 if (Trim(edtCLIENTEcd_cliente.Text) = '') and (Trim(edtCLIENTENM_CLIENTE.Text) = '') and
    (Trim(edtCLIENTECPF_CNPJ.Text) = '') then
    raise Exception.Create('Código, nome e CPF/CNPJ não podem ser vazios');
end;

procedure TfrmCadCliente.btnExcluirClick(Sender: TObject);
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

procedure TfrmCadCliente.btnCLIENTELimparClick(Sender: TObject);
begin
  inherited;
  limpaCampos;
end;

procedure TfrmCadCliente.btnSalvarClick(Sender: TObject);
begin
  try
    validaCampos;

    FDQuery1.Close;
    FDQuery1.SQL.Text := 'select        '+
                              '*        '+
                          'from         '+
                              'cliente  '+
                          'where        '+
                              'cd_cliente = :cd_cliente';
    FDQuery1.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
    FDQuery1.Open();

    if not FDQuery1.IsEmpty then
      begin
        sqlInsertCliente.Close;
        sqlInsertCliente.SQL.Text := 'update                                  '+
                                        'cliente                              '+
                                    'set                                      '+
                                    '    cd_cliente = :cd_cliente,            '+
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

        sqlInsertCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
        sqlInsertCliente.ParamByName('fl_ativo').AsBoolean := edtCLIENTEFL_ATIVO.Checked;
        case edtCLIENTETP_PESSOA.ItemIndex of
        0:
          begin
            sqlInsertCliente.ParamByName('tp_pessoa').AsString := 'F';
          end;
        1:
          begin
            sqlInsertCliente.ParamByName('tp_pessoa').AsString := 'J';
          end;
        end;

        sqlInsertCliente.ParamByName('telefone').AsString := edtCLIENTEFONE.Text;
        sqlInsertCliente.ParamByName('celular').AsString := edtCLIENTECELULAR.Text;
        sqlInsertCliente.ParamByName('email').AsString := edtCLIENTEEMAIL.Text;
        sqlInsertCliente.ParamByName('cpf_cnpj').AsString := edtCLIENTECPF_CNPJ.Text;
        sqlInsertCliente.ParamByName('rg_ie').AsString := edtCLIENTERG.Text;
        sqlInsertCliente.ParamByName('dt_nasc_fundacao').AsDate := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

        sqlInsertEndereco.SQL.Text := 'update                           '+
                                            'endereco_cliente           '+
                                      'set                              '+
                                       '   cd_cliente = :cd_cliente,    '+
                                        '  logradouro = :logradouro,    '+
                                        '  num = :num,                  '+
                                        '  bairro = :bairro,            '+
                                        '  cidade = :cidade,            '+
                                        '  uf = :uf,                    '+
                                        'cep = :cep                     '+
                                      'where                            '+
                                        '  cd_cliente = :cd_cliente';

        sqlInsertEndereco.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
        sqlInsertEndereco.ParamByName('logradouro').AsString := edtCLIENTEENDERECO_LOGRADOURO.Text;
        sqlInsertEndereco.ParamByName('num').AsInteger := StrToInt(edtCLIENTEENDERECO_NUMERO.Text);
        sqlInsertEndereco.ParamByName('bairro').AsString := edtCLIENTEENDERECO_BAIRRO.Text;
        sqlInsertEndereco.ParamByName('cidade').AsString := edtCLIENTEENDERECO_CIDADE.Text;
        sqlInsertEndereco.ParamByName('uf').AsString := edtEstado.Text;
        sqlInsertEndereco.ParamByName('cep').AsString := edtCep.Text;

        try
          sqlInsertCliente.ExecSQL;
          sqlInsertEndereco.ExecSQL;
          sqlInsertCliente.Close;
          sqlInsertEndereco.Close;
          ShowMessage('Cliente alterado com sucesso');
        except
          on E:exception do
            begin
              ShowMessage('Erro ao gravar os dados do cliente '+ E.Message);
              Exit;
            end;
        end;
      end
    else
      begin
        sqlInsertCliente.Close;
        sqlInsertCliente.SQL.Text :=  'insert                     '+
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

        sqlInsertCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
        sqlInsertCliente.ParamByName('fl_ativo').AsBoolean := edtCLIENTEFL_ATIVO.Checked;
        sqlInsertCliente.ParamByName('fl_fornecedor').AsBoolean := edtCLIENTEFL_FORNECEDOR.Checked;
        sqlInsertCliente.ParamByName('nome').AsString := edtCLIENTENM_CLIENTE.Text;
        //tipo da pessoa tá gravando F - Fisica, J - Juridica
        case edtCLIENTETP_PESSOA.ItemIndex of
        0:
          begin
            sqlInsertCliente.ParamByName('tp_pessoa').AsString := 'F';
          end;
        1:
          begin
            sqlInsertCliente.ParamByName('tp_pessoa').AsString := 'J';
          end;
        end;

        sqlInsertCliente.ParamByName('telefone').AsString := edtCLIENTEFONE.Text;
        sqlInsertCliente.ParamByName('celular').AsString := edtCLIENTECELULAR.Text;
        sqlInsertCliente.ParamByName('email').AsString := edtCLIENTEEMAIL.Text;
        sqlInsertCliente.ParamByName('cpf_cnpj').AsString := edtCLIENTECPF_CNPJ.Text;
        sqlInsertCliente.ParamByName('rg_ie').AsString := edtCLIENTERG.Text;
        sqlInsertCliente.ParamByName('dt_nasc_fundacao').AsDate := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

        sqlInsertEndereco.Close;
        sqlInsertEndereco.SQL.Text := 'insert                     '+
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

        sqlInsertEndereco.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
        sqlInsertEndereco.ParamByName('logradouro').AsString := edtCLIENTEENDERECO_LOGRADOURO.Text;
        sqlInsertEndereco.ParamByName('num').AsInteger := StrToInt(edtCLIENTEENDERECO_NUMERO.Text);
        sqlInsertEndereco.ParamByName('bairro').AsString := edtCLIENTEENDERECO_BAIRRO.Text;
        sqlInsertEndereco.ParamByName('cidade').AsString := edtCLIENTEENDERECO_CIDADE.Text;
        sqlInsertEndereco.ParamByName('uf').AsString := edtEstado.Text;
        sqlInsertEndereco.ParamByName('cep').AsString := edtCep.Text;

        try
          sqlInsertCliente.ExecSQL;
          sqlInsertEndereco.ExecSQL;
          sqlInsertCliente.Close;
          sqlInsertEndereco.Close;
          ShowMessage('Cliente inserido com sucesso');
        except
        on E:exception do
            begin
              ShowMessage('Erro ao gravar os dados do cliente '+ E.Message);
              Exit;
            end;
        end;
      end;

  finally
    FreeAndNil(sqlInsertCliente);
    FreeAndNil(sqlInsertEndereco);
    limpaCampos;
  end;

end;

procedure TfrmCadCliente.btnCancelarCadClienteClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Cancelar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
end;

procedure TfrmCadCliente.edtCepExit(Sender: TObject);
var sql : String;
begin
  inherited;
  FDQuery1.Close;
  FDQuery1.SQL.Text := 'select                                  '+
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

  FDQuery1.ParamByName('endereco_cep').AsString := edtCep.Text;

  if not FDQuery1.IsEmpty then
  begin
    FDQuery1.Open();
  end
  else
  begin
    FDQuery1.SQL.Add('or c.cep = :cep limit 1');
    FDQuery1.ParamByName('cep').AsString := edtCep.Text;
    FDQuery1.SQL.Add(sql);
    FDQuery1.Open();
  end;

  edtCLIENTEENDERECO_LOGRADOURO.Text := FDQuery1.FieldByName('endereco_logradouro').AsString;
  edtCLIENTEENDERECO_BAIRRO.Text := FDQuery1.FieldByName('bairro_descricao').AsString;
  edtCLIENTEENDERECO_CIDADE.Text := FDQuery1.FieldByName('nm_cidade').AsString;
  edtEstado.Text := FDQuery1.FieldByName('uf').AsString;

end;

procedure TfrmCadCliente.edtCLIENTEcd_clienteExit(Sender: TObject);
var
 sql_temp : String;
 f : Integer;
begin
//verifica se foi clicado no fechar, se clicou, não valida o cod. cliente vazio

  if edtCLIENTEcd_cliente.Text = '' then
    begin
      //incrementa o código do cliente
      sql_seq := 'select last_value + 1 as last_value from cliente_seq';
      FDQuery1.Close;
      FDQuery1.Open(sql_seq);
      FDQuery1.First;
      edtCLIENTEcd_cliente.Text := FDQuery1.FieldByName('last_value').AsString;
      FDQuery1.Close;

      //incrementa o sequence
      sql_temp := 'select nextval(''cliente_seq'');';
      FDQuery1.Open(sql_temp);
      FDQuery1.Close;
    end
  else
    begin
      with dm.sqlCliente do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select '+
                    'c.cd_cliente, '+
                    'nome, '+
                    'fl_ativo, '+
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
              'where c.cd_cliente = :cd_cliente');
        ParamByName('cd_cliente').Value := StrToInt(edtCLIENTEcd_cliente.Text);

        Open();

        if RecordCount > 0 then
          begin
            edtCLIENTEcd_cliente.Text := IntToStr(FieldByName('cd_cliente').AsInteger);
            edtCLIENTENM_CLIENTE.Text := FieldByName('nome').AsString;
            edtCLIENTEFL_ATIVO.Checked := FieldByName('fl_ativo').AsBoolean;
            if FieldByName('tp_pessoa').AsString = 'F' then
              begin
                f := 0;
              end
            else if FieldByName('tp_pessoa').AsString = 'J' then
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
            edtCLIENTEFONE.Text := FieldByName('telefone').AsString;
            edtCLIENTECELULAR.Text := FieldByName('celular').AsString;
            edtCLIENTEEMAIL.Text := FieldByName('email').AsString;
            edtCLIENTECPF_CNPJ.Text := FieldByName('cpf_cnpj').AsString;
            edtCLIENTERG.Text := FieldByName('rg_ie').AsString;
            edtCLIENTEDATANASCIMENTO.Text := DateToStr(FieldByName('dt_nasc_fundacao').AsDateTime);
            edtCLIENTEENDERECO_LOGRADOURO.Text := FieldByName('logradouro').AsString;
            edtCLIENTEENDERECO_NUMERO.Text := IntToStr(FieldByName('num').AsInteger);
            edtCLIENTEENDERECO_BAIRRO.Text := FieldByName('bairro').AsString;
            edtCLIENTEENDERECO_CIDADE.Text := FieldByName('cidade').AsString;
            edtEstado.Text := FieldByName('uf').AsString;
            edtCep.Text := FieldByName('cep').AsString;
          end;

      end;

      //ShowMessage('Código do Cliente não pode ser vazio');
      //edtCLIENTEcd_cliente.SetFocus;
      //exit;
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


procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmCadCliente := nil;
end;

//passa pelos campos pressionando enter
procedure TfrmCadCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      Key := #0;
      Perform(WM_NEXTDLGCTL,0,0)
    end;
end;

procedure TfrmCadCliente.limpaCampos;
begin
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
end;

end.
