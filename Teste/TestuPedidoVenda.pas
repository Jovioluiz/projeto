unit TestuPedidoVenda;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, FireDAC.Stan.Option, uConexao, FireDAC.DApt.Intf, FireDAC.DatS,
  uPedidoVenda, System.UITypes, FireDAC.Stan.Param, System.Classes, Vcl.ExtCtrls,
  Vcl.StdCtrls, FireDAC.Stan.Intf, System.Generics.Collections, Vcl.Grids,
  Vcl.ComCtrls, FireDAC.Stan.Error, Vcl.Graphics, FireDAC.Phys.Intf,
  FireDAC.Comp.Client, Winapi.Windows, System.Variants, Xml.XMLIntf,
  Datasnap.DBClient, Winapi.Messages, Vcl.Dialogs, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.Forms, System.SysUtils, Xml.xmldom, Data.DB, Vcl.Controls, JvBehaviorLabel,
  Xml.XMLDoc, Vcl.Mask, FireDAC.Comp.DataSet, Vcl.DBGrids, JvExStdCtrls;

type
  // Test methods for class TfrmPedidoVenda

  TestTfrmPedidoVenda = class(TTestCase)
  strict private
    FfrmPedidoVenda: TfrmPedidoVenda;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFormKeyPress;
    procedure TestedtCdClienteChange;
    procedure TestedtCdClienteExit;
    procedure TestedtCdFormaPgtoChange;
    procedure TestedtCdFormaPgtoExit;
    procedure TestedtCdCondPgtoChange;
    procedure TestedtCdCondPgtoExit;
    procedure TestedtCdProdutoChange;
    procedure TestedtCdtabelaPrecoChange;
    procedure TestedtCdtabelaPrecoExit;
    procedure TestedtQtdadeChange;
    procedure TestedtVlDescontoItemExit;
    procedure TestbtnAdicionarClick;
    procedure TestdbGridProdutosDrawColumnCell;
    procedure TestedtCdProdutoExit;
    procedure TestedtVlDescTotalPedidoExit;
    procedure TestbtnCancelarClick;
    procedure TestbtnConfirmarPedidoClick;
    procedure TestedtVlAcrescimoTotalPedidoExit;
    procedure TestdbGridProdutosKeyDown;
    procedure TestedtQtdadeExit;
    procedure TestFormCreate;
    procedure TestFormClose;
    procedure TestdbGridProdutosDblClick;
    procedure TestFormKeyDown;
    procedure TestedtCdProdutoEnter;
    procedure TestFormCloseQuery;
    procedure TestlimpaCampos;
    procedure TestlimpaDados;
    procedure TestatualizaEstoqueProduto;
    procedure TestGeraNumeroPedido;
    procedure TestProdutoJaLancado;
    procedure TestRetornaSequencia;
    procedure TestAlteraSequenciaItem;
    procedure TestSalvaCabecalho;
    procedure TestSalvaItens;
    procedure TestsetDadosNota;
    procedure TestcancelaPedidoVenda;
    procedure TestInsereWmsMvto;
  end;

implementation

procedure TestTfrmPedidoVenda.SetUp;
begin
  FfrmPedidoVenda := TfrmPedidoVenda.Create(nil);
end;

procedure TestTfrmPedidoVenda.TearDown;
begin
  FfrmPedidoVenda.Free;
  FfrmPedidoVenda := nil;
end;

procedure TestTfrmPedidoVenda.TestFormKeyPress;
var
  Key: Char;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.FormKeyPress(Sender, Key);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdClienteChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdClienteChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdClienteExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdClienteExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdFormaPgtoChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdFormaPgtoChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdFormaPgtoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdFormaPgtoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdCondPgtoChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdCondPgtoChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdCondPgtoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdCondPgtoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdProdutoChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdProdutoChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdtabelaPrecoChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdtabelaPrecoChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdtabelaPrecoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdtabelaPrecoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtQtdadeChange;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtQtdadeChange(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtVlDescontoItemExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtVlDescontoItemExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestbtnAdicionarClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.btnAdicionarClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestdbGridProdutosDrawColumnCell;
var
  State: TGridDrawState;
  Column: TColumn;
  DataCol: Integer;
  Rect: TRect;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.dbGridProdutosDrawColumnCell(Sender, Rect, DataCol, Column,
      State);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdProdutoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdProdutoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtVlDescTotalPedidoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtVlDescTotalPedidoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestbtnCancelarClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.btnCancelarClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestbtnConfirmarPedidoClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.btnConfirmarPedidoClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtVlAcrescimoTotalPedidoExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtVlAcrescimoTotalPedidoExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestdbGridProdutosKeyDown;
var
  Shift: TShiftState;
  Key: Word;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.dbGridProdutosKeyDown(Sender, Key, Shift);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtQtdadeExit;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtQtdadeExit(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestFormCreate;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.FormCreate(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestFormClose;
var
  Action: TCloseAction;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.FormClose(Sender, Action);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestdbGridProdutosDblClick;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.dbGridProdutosDblClick(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestFormKeyDown;
var
  Shift: TShiftState;
  Key: Word;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.FormKeyDown(Sender, Key, Shift);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestedtCdProdutoEnter;
var
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.edtCdProdutoEnter(Sender);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestFormCloseQuery;
var
  CanClose: Boolean;
  Sender: TObject;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.FormCloseQuery(Sender, CanClose);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestlimpaCampos;
begin
  FfrmPedidoVenda.limpaCampos;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestlimpaDados;
begin
  FfrmPedidoVenda.limpaDados;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestatualizaEstoqueProduto;
begin
  FfrmPedidoVenda.atualizaEstoqueProduto;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestGeraNumeroPedido;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmPedidoVenda.GeraNumeroPedido;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestProdutoJaLancado;
var
  ReturnValue: Boolean;
  CodProduto: Integer;
begin
  // TODO: Setup method call parameters
  ReturnValue := FfrmPedidoVenda.ProdutoJaLancado(CodProduto);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestRetornaSequencia;
var
  ReturnValue: Integer;
begin
  ReturnValue := FfrmPedidoVenda.RetornaSequencia;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestAlteraSequenciaItem;
begin
  FfrmPedidoVenda.AlteraSequenciaItem;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestSalvaCabecalho;
begin
  FfrmPedidoVenda.SalvaCabecalho;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestSalvaItens;
var
  EhEdicao: Boolean;
begin
  // TODO: Setup method call parameters
  FfrmPedidoVenda.SalvaItens(EhEdicao);
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestsetDadosNota;
begin
  FfrmPedidoVenda.setDadosNota;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestcancelaPedidoVenda;
begin
  FfrmPedidoVenda.cancelaPedidoVenda;
  // TODO: Validate method results
end;

procedure TestTfrmPedidoVenda.TestInsereWmsMvto;
begin
  FfrmPedidoVenda.InsereWmsMvto;
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTfrmPedidoVenda.Suite);
end.

