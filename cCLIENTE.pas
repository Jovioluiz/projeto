unit cCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uValidaDcto, uConexao,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client;

type
  TcadCliente = class(TfConexao)
    tpCadCliente: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCLIENTECPF_CNPJ: TLabel;
    Label11: TLabel;
    lblCLIENTEIE_RG: TLabel;
    lblCLIENTEDTNASCIMENTO: TLabel;
    edtCLIENTEcd_cliente: TEdit;
    edtCLIENTENM_CLIENTE: TEdit;
    gbENDERECO: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbESTADO: TComboBox;
    edtCLIENTEENDERECO_BAIRRO: TEdit;
    edtCLIENTEENDERECO_CIDADE: TEdit;
    edtCLIENTEENDERECO_NUMERO: TEdit;
    edtCLIENTETP_PESSOA: TRadioGroup;
    edtCLIENTEFONE: TMaskEdit;
    edtCLIENTECELULAR: TMaskEdit;
    edtCLIENTEEMAIL: TEdit;
    edtCLIENTEENDERECO_LOGRADOURO: TEdit;
    edtCLIENTECPF_CNPJ: TMaskEdit;
    edtCLIENTEFL_ATIVO: TCheckBox;
    edtCLIENTERG: TEdit;
    btnSalvarCliente: TButton;
    btnCancelarCadCliente: TButton;
    edtCLIENTEDATANASCIMENTO: TMaskEdit;
    sqlinsert: TSQLQuery;
    sqlInsertCliente: TFDCommand;
    sqlInsertEndereco: TFDCommand;
    procedure pFormarCamposPessoa;
    procedure edtCLIENTETP_PESSOAClick(Sender: TObject);
    procedure btnCancelarCadClienteClick(Sender: TObject);
    procedure edtCLIENTECPF_CNPJExit(Sender: TObject);
    procedure edtCLIENTERGExit(Sender: TObject);
    procedure btnSalvarClienteClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cadCliente: TcadCliente;

implementation

{$R *.dfm}

procedure TcadCliente.pFormarCamposPessoa;
begin
  //Muda o caption do label CPF/CNPJ e RG/IE
  if edtCLIENTETP_PESSOA.ItemIndex = 0 then
    begin
      lblCLIENTECPF_CNPJ.Caption := 'CPF';
      edtCLIENTECPF_CNPJ.Width    := 90;
      edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CPF;
      lblCLIENTEIE_RG.Caption    := 'RG';
      lblCLIENTEDTNASCIMENTO.Caption := 'Data Nascimento';
      edtCLIENTEDATANASCIMENTO.Visible := true;
      //edtCLIENTETP_PESSOA := 'Fisica';

    end
  else
    begin
      lblCLIENTECPF_CNPJ.Caption  := 'CNPJ';
      edtCLIENTECPF_CNPJ.Width    := 110;
      edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CNPJ;
      lblCLIENTEIE_RG.Caption    := 'IE';
      lblCLIENTEDTNASCIMENTO.Caption := 'Data Fundação';
       //edtCLIENTETP_PESSOA.Items := 'Juridica';
    end;
end;

procedure TcadCliente.btnCancelarCadClienteClick(Sender: TObject);

begin
  if MessageDlg('Deseja realmente sair?', mtConfirmation, [mbyes, mbno], 0) = 6 then
    begin
      Close();
    end;

end;

procedure TcadCliente.btnSalvarClienteClick(Sender: TObject);
var tipo_pessoaF , tipo_pessoaJ : String;

begin


  //insert na tabela cliente
  sqlInsertCliente.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
  sqlInsertCliente.ParamByName('fl_ativo').AsBoolean := edtCLIENTEFL_ATIVO.Checked;
  sqlInsertCliente.ParamByName('nome').AsString := edtCLIENTENM_CLIENTE.Text;
  //tipo da pessoa tá gravando 0 - Fisica, 1 - Juridica
  sqlInsertCliente.ParamByName('tp_pessoa').AsString := edtCLIENTETP_PESSOA.ItemIndex.ToString;
  sqlInsertCliente.ParamByName('telefone').AsString := edtCLIENTEFONE.Text;
  sqlInsertCliente.ParamByName('celular').AsString := edtCLIENTECELULAR.Text;
  sqlInsertCliente.ParamByName('email').AsString := edtCLIENTEEMAIL.Text;
  sqlInsertCliente.ParamByName('cpf_cnpj').AsString := edtCLIENTECPF_CNPJ.Text;
  sqlInsertCliente.ParamByName('rg_ie').AsString := edtCLIENTERG.Text;
  sqlInsertCliente.ParamByName('dtnascimento').AsDate := StrToDate(edtCLIENTEDATANASCIMENTO.Text);

  //insert na tabela endereço
  sqlInsertEndereco.ParamByName('cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
  sqlInsertEndereco.ParamByName('logradouro').AsString := edtCLIENTEENDERECO_LOGRADOURO.Text;
  sqlInsertEndereco.ParamByName('num').AsInteger := StrToInt(edtCLIENTEENDERECO_NUMERO.Text);
  sqlInsertEndereco.ParamByName('bairro').AsString := edtCLIENTEENDERECO_BAIRRO.Text;
  sqlInsertEndereco.ParamByName('cidade').AsString := edtCLIENTEENDERECO_CIDADE.Text;
  //não está gravando no banco de dados
  sqlInsertEndereco.ParamByName('uf').AsString := cbESTADO.Text;

  try
    sqlInsertCliente.Execute();
    sqlInsertEndereco.Execute();
    sqlInsertCliente.Close;
    sqlInsertEndereco.Close;
    FreeAndNil(sqlInsertCliente);
    FreeAndNil(sqlInsertEndereco);
    ShowMessage('Cliente cadastrado com sucesso!');

    //limpa os campos após inserir
    edtCLIENTEcd_cliente.Text := '';
    edtCLIENTENM_CLIENTE.Text := '';
    edtCLIENTEFONE.Text := '';
    edtCLIENTECELULAR.Text := '';
    edtCLIENTEEMAIL.Text := '';
    edtCLIENTEENDERECO_LOGRADOURO.Text := '';
    edtCLIENTECPF_CNPJ.Text := '';
    edtCLIENTEENDERECO_BAIRRO.Text := '';
    edtCLIENTEENDERECO_CIDADE.Text := '';
    edtCLIENTEENDERECO_NUMERO.Text := '';
    edtCLIENTEFL_ATIVO.Checked := false;
    edtCLIENTERG.Text := '';
    edtCLIENTEDATANASCIMENTO.Text := '';

  except
  on E:exception do
    begin
      ShowMessage('Erro ao gravar os dados do cliente '+ E.Message);
      exit;
    end;

  end;
end;

procedure TcadCliente.edtCLIENTEcd_clienteExit(Sender: TObject);
begin
//verifica se foi clicado no fechar, se clicou, não valida o cod. cliente vazio
  if btnCancelarCadCliente.MouseInClient then
    begin
      exit
    end
  else if edtCLIENTEcd_cliente.Text = '' then
    begin
      raise Exception.Create('Código do Cliente não pode ser vazio');
      edtCLIENTEcd_cliente.SetFocus;
      exit;
    end;

end;

procedure TcadCliente.edtCLIENTECPF_CNPJExit(Sender: TObject);
begin
  if edtCLIENTECPF_CNPJ.Text = '' then
    raise Exception.Create('Campo não pode ser vazio');
end;

procedure TcadCliente.edtCLIENTERGExit(Sender: TObject);
begin
  if edtCLIENTERG.Text = '' then
    raise Exception.Create('Campo não pode ser Vazio');
end;

procedure TcadCliente.edtCLIENTETP_PESSOAClick(Sender: TObject);
begin
  pFormarCamposPessoa;
end;

end.
