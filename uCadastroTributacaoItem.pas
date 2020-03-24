unit uCadastroTributacaoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TfrmCadastraTributacaoItem = class(TForm)
    PageControl1: TPageControl;
    TabSheetICMS: TTabSheet;
    Label1: TLabel;
    edtGrupoTributacaoICMS: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtNomeGrupoTributacaoICMS: TEdit;
    edtAliqICMS: TEdit;
    StatusBar1: TStatusBar;
    TabSheetIPI: TTabSheet;
    edtAliqIPI: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edtNomeGrupoTributacaoIPI: TEdit;
    edtGrupoTributacaoIPI: TEdit;
    Label8: TLabel;
    TabSheetISS: TTabSheet;
    Label9: TLabel;
    edtGrupoTributacaoISS: TEdit;
    edtNomeGrupoTributacaoISS: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtAliqISS: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    edtGrupoTributacaoPISCOFINS: TEdit;
    Label5: TLabel;
    edtNomeGrupoTributacaoPISCOFINS: TEdit;
    edtAliqPISCOFINS: TEdit;
    Label12: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastraTributacaoItem: TfrmCadastraTributacaoItem;

implementation

{$R *.dfm}

end.
