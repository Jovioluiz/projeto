unit fCadastroEnderecos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvLabel,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCadastroEnderecos = class(TForm)
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    edtCodDeposito: TEdit;
    JvLabel4: TJvLabel;
    edtAla: TEdit;
    edtRua: TEdit;
    edtEdtComplemento: TEdit;
    JvLabel5: TJvLabel;
    edtCodProduto: TEdit;
    edtNomeProduto: TEdit;
    JvLabel6: TJvLabel;
    dbgrd1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroEnderecos: TfrmCadastroEnderecos;

implementation

{$R *.dfm}

end.
