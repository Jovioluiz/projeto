unit cCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uValidaDcto,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.DBCtrls, Vcl.Buttons, StrUtils, System.Generics.Collections;

type
  TfrmCadCliente = class(TForm)
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
    procedure pFormarCamposPessoa;
    procedure edtCLIENTETP_PESSOAClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCepExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCLIENTEcd_clienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private

  public
    { Public declarations }
    procedure Salvar;
    procedure Excluir;
    procedure DesabilitaCampos;
    procedure LimpaCampos;
  end;

var
  frmCadCliente: TfrmCadCliente;
  temCep, camposDesabilitados: Boolean;
  cep, chamada: String;
  lista: TList<string>;
  CodCliente: Integer;

implementation

{$R *.dfm}

uses uDataModule, uUtil, uLogin, uConsulta, uclCliente;

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

procedure TfrmCadCliente.Salvar;
var
  cliente : TValidaDados;
  persistencia: TCliente;
  endereco: TClienteEndereco;
begin
  persistencia := TCliente.Create;
  endereco := TClienteEndereco.Create;
  try
    cliente := TValidaDados.Create;
    cliente.validaNomeCpf(edtCLIENTENM_CLIENTE.Text, edtCLIENTECPF_CNPJ.Text);
    cliente.validaCodigo(StrToInt(edtCLIENTEcd_cliente.Text));

    persistencia.cd_cliente := StrToInt(edtCLIENTEcd_cliente.Text);
    persistencia.nome := edtCLIENTENM_CLIENTE.Text;
    persistencia.fl_ativo := edtCLIENTEFL_ATIVO.Checked;
    persistencia.tp_pessoa := ifThen(edtCLIENTETP_PESSOA.ItemIndex = 0, 'F', 'J');
    persistencia.fl_fornecedor := edtCLIENTEFL_FORNECEDOR.Checked;
    persistencia.telefone := edtCLIENTEFONE.Text;
    persistencia.celular := edtCLIENTECELULAR.Text;
    persistencia.email := edtCLIENTEEMAIL.Text;
    persistencia.cpf_cnpj := edtCLIENTECPF_CNPJ.Text;
    persistencia.rg_ie := edtCLIENTERG.Text;
    persistencia.dt_nasc_fundacao := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

    endereco.cd_cliente := StrToInt(edtCLIENTEcd_cliente.Text);
    endereco.logradouro := edtCLIENTEENDERECO_LOGRADOURO.Text;
    endereco.numero := edtCLIENTEENDERECO_NUMERO.Text;
    endereco.bairro := edtCLIENTEENDERECO_BAIRRO.Text;
    endereco.cidade := edtCLIENTEENDERECO_CIDADE.Text;
    endereco.uf := edtEstado.Text;
    endereco.cep := edtCep.Text;

    if not persistencia.Pesquisar(StrToInt(edtCLIENTEcd_cliente.Text)) then
    begin
      persistencia.Inserir;
      endereco.Inserir;
      LimpaCampos;
    end
    else
    begin
      persistencia.Atualizar;
      endereco.Atualizar;
      LimpaCampos;
    end;
  finally
    persistencia.Free;
    endereco.Free;
  end;
end;

procedure TfrmCadCliente.DesabilitaCampos;
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
  qry.Connection := dm.conexaoBanco;

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
      qry.Open()
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
var
  temPermissaEdicao: Boolean;
  cliente: TValidaDados;
  persistencia: TCliente;
  enderecoPersistencia: TClienteEndereco;
begin
  temCep := False;
  cliente := TValidaDados.Create;
  temPermissaEdicao := cliente.validaEdicaoAcao(IdUsuario, 1);
  persistencia := TCliente.Create;
  enderecoPersistencia := TClienteEndereco.Create;

  try
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
      edtCLIENTEcd_cliente.Text := persistencia.GeraCodigoCliente.ToString;
    end
    else
    begin
      temCep := True;
      persistencia.Buscar(StrToInt(edtCLIENTEcd_cliente.Text));
      enderecoPersistencia.Buscar(StrToInt(edtCLIENTEcd_cliente.Text));

      edtCLIENTEFL_ATIVO.SetFocus;
      edtCLIENTENM_CLIENTE.Text := persistencia.nome;
      edtCLIENTEFL_ATIVO.Checked := persistencia.fl_ativo;
      edtCLIENTEFL_FORNECEDOR.Checked := persistencia.fl_fornecedor;

      if persistencia.tp_pessoa = 'F' then
      begin
        edtCLIENTETP_PESSOA.ItemIndex := 0;
        pFormarCamposPessoa;
      end
      else
      begin
        edtCLIENTETP_PESSOA.ItemIndex := 1;
        pFormarCamposPessoa;
      end;

      edtCLIENTEFONE.Text := persistencia.telefone;
      edtCLIENTECELULAR.Text := persistencia.celular;
      edtCLIENTEEMAIL.Text := persistencia.email;
      edtCLIENTECPF_CNPJ.Text := persistencia.cpf_cnpj;
      edtCLIENTERG.Text := persistencia.rg_ie;
      edtCLIENTEDATANASCIMENTO.Text := DateToStr(persistencia.dt_nasc_fundacao);
      edtCLIENTEENDERECO_LOGRADOURO.Text := enderecoPersistencia.logradouro;
      edtCLIENTEENDERECO_NUMERO.Text := enderecoPersistencia.numero;
      edtCLIENTEENDERECO_BAIRRO.Text := enderecoPersistencia.bairro;
      edtCLIENTEENDERECO_CIDADE.Text := enderecoPersistencia.cidade;
      edtEstado.Text := enderecoPersistencia.uf;
      edtCep.Text := enderecoPersistencia.cep;
      cep := edtCep.Text;

    end;

    if temPermissaEdicao then
      Exit
    else
      DesabilitaCampos;

  finally
    persistencia.Free;
    enderecoPersistencia.Free;
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
    consulta.MontaDataset(sql);
    consulta.Show;
  end;
end;

procedure TfrmCadCliente.edtCLIENTETP_PESSOAClick(Sender: TObject);
begin
  pFormarCamposPessoa;
end;


procedure TfrmCadCliente.Excluir;
var
  persistencia: TCliente;
begin
  persistencia := TCliente.Create;

  try
    if edtCLIENTEcd_cliente.Text <> '' then
    begin
      if (Application.MessageBox('Deseja Excluir o Cliente?','Atenção', MB_YESNO) = IDYES) then
      begin
        persistencia.cd_cliente := StrToInt(edtCLIENTEcd_cliente.Text);
        persistencia.Excluir;
        LimpaCampos;
      end;
    end;
  finally
    persistencia.Free;
  end;
end;

procedure TfrmCadCliente.FormActivate(Sender: TObject);
begin
  if chamada = 'cntCliente' then
    edtCLIENTEcd_cliente.Text := CodCliente.ToString;
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
    LimpaCampos
  else if key = VK_F2 then  //F2
    Salvar
  else if key = VK_F4 then    //F4
    Excluir
  else if key = VK_ESCAPE then //ESC
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
      Close;
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

procedure TfrmCadCliente.LimpaCampos;
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

end.
