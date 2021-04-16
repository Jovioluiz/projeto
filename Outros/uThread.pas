unit uThread;

interface

uses
  System.Classes;

type ThreadTeste = class(TThread)

  private
    FArquivo: string;

  public
    constructor Create(arq: string);
    procedure Execute; override;


end;


implementation

uses
  uImportacaoDados;

{ ThreadTeste }

constructor ThreadTeste.Create(arq: string);
begin
  inherited Create(False);
  Self.FArquivo := arq;
end;

procedure ThreadTeste.Execute;
var
  importa: TImportacaoDados;
  linhas: TStringList;
begin
  inherited;
  importa := TImportacaoDados.Create;
  linhas := TStringList.Create;

  linhas.LoadFromFile(Self.FArquivo);

  try
    for var i := 0 to Pred(linhas.Count) do
    begin
      if Self.Terminated then
        Break;

      importa.ListaProdutos(Self.FArquivo);

    end;

  finally
    importa.Free;
  end;
end;

end.
