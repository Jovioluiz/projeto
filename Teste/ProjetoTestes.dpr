program ProjetoTestes;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestuUsuario in 'TestuUsuario.pas',
  uUsuario in '..\Usuario\uUsuario.pas' {$R *.RES},
  uDataModule in '..\Conexao\uDataModule.pas' {dm: TDataModule},
  uValidaDados in '..\Validacao\uValidaDados.pas',
  uGerador in 'uGerador.pas',
  TestfCadastroEnderecos in 'TestfCadastroEnderecos.pas',
  fCadastroEnderecos in '..\WMS\fCadastroEnderecos.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

