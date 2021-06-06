unit dWMS;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TdmWMS = class(TDataModule)
    dsEndereco: TDataSource;
    dsEnderecoProduto: TDataSource;
    cdsEndereco: TClientDataSet;
    cdsEnderecocd_deposito: TIntegerField;
    cdsEnderecoala: TStringField;
    cdsEnderecorua: TStringField;
    cdsEnderecocomplemento: TStringField;
    cdsEndereconm_endereco: TStringField;
    cdsEnderecoordem: TIntegerField;
    cdsEnderecoProduto: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmWMS: TdmWMS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
