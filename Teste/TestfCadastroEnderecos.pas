unit TestfCadastroEnderecos;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, {JvLabel, JvExControls} FireDAC.DApt.Intf, FireDAC.DatS,
  FireDAC.Stan.Param, Winapi.Messages, System.Classes, Vcl.ExtCtrls, Vcl.StdCtrls,
  FireDAC.Stan.Intf, Vcl.Grids, FireDAC.Stan.Error, Vcl.Graphics, FireDAC.Phys.Intf,
  FireDAC.Comp.Client, fCadastroEnderecos, Winapi.Windows, System.Variants,
  Datasnap.DBClient, Vcl.Dialogs, FireDAC.Stan.Async, FireDAC.DApt, Vcl.Forms,
  System.SysUtils, Data.DB, Vcl.Controls, FireDAC.Stan.Option, FireDAC.Comp.DataSet,
  Vcl.DBGrids;

type
  // Test methods for class TfrmCadastroEnderecos

  TestTfrmCadastroEnderecos = class(TTestCase)
  strict private
    FfrmCadastroEnderecos: TfrmCadastroEnderecos;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestedtCodBarrasProdutoExit;
    procedure TestFormKeyPress;
    procedure TestbtnAdicionarClick;
    procedure Testbtn1Click;
    procedure TestSalvaEnderecoProduto;
    procedure TestSalvarEndereco;
    procedure TestLimpaCampos;
    procedure TestLimpaDados;
    procedure TestGetIdEndereco;
    procedure TestPesquisar;
    procedure TestPesquisar1;
  end;

implementation

procedure TestTfrmCadastroEnderecos.SetUp;
begin
  FfrmCadastroEnderecos := TfrmCadastroEnderecos.Create(nil);
end;

procedure TestTfrmCadastroEnderecos.TearDown;
begin
  FfrmCadastroEnderecos.Free;
  FfrmCadastroEnderecos := nil;
end;

procedure TestTfrmCadastroEnderecos.TestedtCodBarrasProdutoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmCadastroEnderecos.edtCodBarrasProdutoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestFormKeyPress;
var
  Key: Char;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmCadastroEnderecos.FormKeyPress(Sender, Key);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestbtnAdicionarClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmCadastroEnderecos.btnAdicionarClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.Testbtn1Click;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmCadastroEnderecos.btnAdicionarClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestSalvaEnderecoProduto;
begin
  FfrmCadastroEnderecos.SalvaEnderecoProduto;
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestSalvarEndereco;
begin
  FfrmCadastroEnderecos.SalvarEndereco;
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestLimpaCampos;
begin
  FfrmCadastroEnderecos.LimpaCampos;
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestLimpaDados;
begin
  FfrmCadastroEnderecos.LimpaDados;
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestGetIdEndereco;
var
  ReturnValue: Int64;
  NomeEndereco: string;
begin
  // TODO: Setup method call parameters
//  ReturnValue := FfrmCadastroEnderecos.GetIdEndereco(NomeEndereco);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestPesquisar;
var
  ReturnValue: Boolean;
  CdProduto: Integer;
  IdEndereco: Int64;
begin
  // TODO: Setup method call parameters
  //ReturnValue := FfrmCadastroEnderecos.Pesquisar(IdEndereco, CdProduto);
  // TODO: Validate method results
end;

procedure TestTfrmCadastroEnderecos.TestPesquisar1;
var
  ReturnValue: Boolean;
  Rua: string;
  Ala: string;
  CdDeposito: Integer;
begin
  // TODO: Setup method call parameters
  ReturnValue := FfrmCadastroEnderecos.Pesquisar(CdDeposito, Ala, Rua);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmCadastroEnderecos.Suite);
end.

