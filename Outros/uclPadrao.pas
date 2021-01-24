unit uclPadrao;

interface

uses
  uDataModule;

type TPadrao = class abstract
  private

  public
  procedure Atualizar; virtual; abstract;
  procedure Inserir; virtual; abstract;
  procedure Excluir; virtual; abstract;

end;

implementation

{ TPadrao }


end.
