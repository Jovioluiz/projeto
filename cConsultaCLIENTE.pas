unit cConsultaCLIENTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, uValidaDcto, uConexao,
  Data.FMTBcd, Data.DB, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.Comp.Client, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TconsultaCliente = class(TfConexao)
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
    btnCancelarCadCliente: TButton;
    edtCLIENTEDATANASCIMENTO: TMaskEdit;
    comandoSql: TFDQuery;
    btnEditar: TButton;
    btnGravar: TButton;
    procedure pFormarCamposPessoa;
    //procedure edtCLIENTETP_PESSOAClick(Sender: TObject);
    procedure btnCancelarCadClienteClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteExit(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure edtCLIENTEcd_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    //sql_seq : String;
  public
    { Public declarations }
  end;

var
  consultaCliente: TconsultaCliente;

implementation

{$R *.dfm}

procedure TconsultaCliente.pFormarCamposPessoa;
begin
  //Muda o caption do label CPF/CNPJ e RG/IE
  if edtCLIENTETP_PESSOA.ItemIndex = 0 then
    begin
      lblCLIENTECPF_CNPJ.Caption := 'CPF';
      edtCLIENTECPF_CNPJ.Width    := 90;
      edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CPF;
      lblCLIENTEIE_RG.Caption    := 'RG';
      lblCLIENTEDTNASCIMENTO.Caption := 'Data Nascimento';
  //edtCLIENTEDATANASCIMENTO.Visible := true;
    end
  else
    begin
      lblCLIENTECPF_CNPJ.Caption  := 'CNPJ';
      edtCLIENTECPF_CNPJ.Width    := 110;
      edtCLIENTECPF_CNPJ.EditMask := uValidaDcto.MASCARA_CNPJ;
      lblCLIENTEIE_RG.Caption    := 'IE';
      lblCLIENTEDTNASCIMENTO.Caption := 'Data Fundação';
    end;
end;

procedure TconsultaCliente.btnCancelarCadClienteClick(Sender: TObject);
begin
  if MessageDlg('Deseja realmente sair?', mtConfirmation, [mbyes, mbno], 0) = 6 then
    begin
      Close();
    end;
end;

procedure TconsultaCliente.btnEditarClick(Sender: TObject);
begin
  inherited;
  //habilita os campos
    edtCLIENTEcd_cliente.Enabled := false;
    edtCLIENTENM_CLIENTE.Enabled := true;
    edtCLIENTETP_PESSOA.Enabled := true;
    edtCLIENTEFL_ATIVO.Enabled := true;
    edtCLIENTETP_PESSOA.Enabled := true;
    edtCLIENTEFONE.Enabled := true;
    edtCLIENTECELULAR.Enabled := true;
    edtCLIENTEEMAIL.Enabled := true;
    edtCLIENTECPF_CNPJ.Enabled := true;
    edtCLIENTERG.Enabled := true;
    edtCLIENTEDATANASCIMENTO.Enabled := true;
    edtCLIENTEENDERECO_LOGRADOURO.Enabled := true;
    edtCLIENTEENDERECO_NUMERO.Enabled := true;
    edtCLIENTEENDERECO_BAIRRO.Enabled := true;
    edtCLIENTEENDERECO_CIDADE.Enabled := true;
    cbESTADO.Enabled := true;
end;

procedure TconsultaCliente.btnGravarClick(Sender: TObject);
begin
  inherited;
  comandoSql.Close;
  comandoSql.SQL.Text;
end;

procedure TconsultaCliente.edtCLIENTEcd_clienteExit(Sender: TObject);
 //sql para visualizar o cadastro do cliente
begin
  comandoSql.Close;
  comandoSql.SQL.Text := 'select c.cd_cliente, nome,fl_ativo,tp_pessoa,'+
                      'telefone,celular,email,cpf_cnpj,rg_ie,dtnascimento,'+
                      'logradouro,num,bairro,cidade,uf '+
                      'from cliente c '+
                      'join endereco e on '+
                      'c.cd_cliente = e.cd_cliente '+
                      'where c.cd_cliente = :c.cd_cliente';

  comandoSql.ParamByName('c.cd_cliente').AsInteger := StrToInt(edtCLIENTEcd_cliente.Text);
  comandoSql.Open();
  comandoSql.First;
     //não está mudando corretamente o label do cpf_cnpj, rg_ie e data fundação quando pessoa juridica
     //ajustar para quando não encontrar nenhum registro

  if comandoSql <> nil then
    begin
      edtCLIENTEcd_cliente.Text := IntToStr(comandoSql.FieldByName('cd_cliente').AsInteger);
      edtCLIENTENM_CLIENTE.Text := comandoSql.FieldByName('nome').AsString;
      edtCLIENTEFL_ATIVO.Checked := comandoSql.FieldByName('fl_ativo').AsBoolean;
        if (comandoSql.FieldByName('tp_pessoa').AsInteger = 0) then
          begin
            edtCLIENTETP_PESSOA.ItemIndex := 0;
            pFormarCamposPessoa;
          end;
        if (comandoSql.FieldByName('tp_pessoa').AsInteger = 1) then
          begin
           edtCLIENTETP_PESSOA.ItemIndex := 1;
           pFormarCamposPessoa;
          end;
      edtCLIENTETP_PESSOA.Items.Text := IntToStr(comandoSql.FieldByName('tp_pessoa').AsInteger);
      edtCLIENTEFONE.Text := comandoSql.FieldByName('telefone').AsString;
      edtCLIENTECELULAR.Text := comandoSql.FieldByName('celular').AsString;
      edtCLIENTEEMAIL.Text := comandoSql.FieldByName('email').AsString;
      edtCLIENTECPF_CNPJ.Text := comandoSql.FieldByName('cpf_cnpj').AsString;
      edtCLIENTERG.Text := comandoSql.FieldByName('rg_ie').AsString;
      edtCLIENTEDATANASCIMENTO.Text := DateToStr(comandoSql.FieldByName('dtnascimento').AsDateTime);
      edtCLIENTEENDERECO_LOGRADOURO.Text := comandoSql.FieldByName('logradouro').AsString;
      edtCLIENTEENDERECO_NUMERO.Text := IntToStr(comandoSql.FieldByName('num').AsInteger);
      edtCLIENTEENDERECO_BAIRRO.Text := comandoSql.FieldByName('bairro').AsString;
      edtCLIENTEENDERECO_CIDADE.Text := comandoSql.FieldByName('cidade').AsString;
      cbESTADO.Text := comandoSql.FieldByName('uf').AsString;
    end;

    edtCLIENTEcd_cliente.Enabled := false;
    edtCLIENTENM_CLIENTE.Enabled := false;
    edtCLIENTETP_PESSOA.Enabled := false;
    edtCLIENTEFL_ATIVO.Enabled := false;
    edtCLIENTETP_PESSOA.Enabled := false;
    edtCLIENTEFONE.Enabled := false;
    edtCLIENTECELULAR.Enabled := false;
    edtCLIENTEEMAIL.Enabled := false;
    edtCLIENTECPF_CNPJ.Enabled := false;
    edtCLIENTERG.Enabled := false;
    edtCLIENTEDATANASCIMENTO.Enabled := false;
    edtCLIENTEENDERECO_LOGRADOURO.Enabled := false;
    edtCLIENTEENDERECO_NUMERO.Enabled := false;
    edtCLIENTEENDERECO_BAIRRO.Enabled := false;
    edtCLIENTEENDERECO_CIDADE.Enabled := false;
    cbESTADO.Enabled := false;

end;

//passa pelos campos pressionando enter
procedure TconsultaCliente.edtCLIENTEcd_clienteKeyPress(Sender: TObject;
 var Key: Char);

begin
  inherited;
  if Key=#13 then
    Perform(WM_NEXTDLGCTL,0,0)
  else if Key = #27 then
    Perform(WM_NEXTDLGCTL,1,0)
end;

end.
