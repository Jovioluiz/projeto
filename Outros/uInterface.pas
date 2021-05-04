unit uInterface;

interface
  type IInterfaceModelo = interface

    procedure Atualizar;
    procedure Inserir;
    procedure Excluir;
    function Pesquisar(Codigo: Integer): Boolean;

end;

implementation

end.
