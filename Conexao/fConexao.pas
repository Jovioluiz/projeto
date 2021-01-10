unit fConexao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles, Vcl.Mask;

type
  TfrmConexao = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtServidor: TEdit;
    edtBanco: TEdit;
    edtPorta: TEdit;
    edtUsuario: TEdit;
    btnTestar: TButton;
    btnSalvar: TButton;
    edtSenha: TMaskEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnTestarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    arquivoIni: TIniFile;
    procedure Salvar;
  public
    { Public declarations }
  end;

var
  frmConexao: TfrmConexao;

implementation

uses
  uDataModule;

{$R *.dfm}

procedure TfrmConexao.btnSalvarClick(Sender: TObject);
begin
  Salvar;
end;

procedure TfrmConexao.btnTestarClick(Sender: TObject);
var
  msg: string;
begin
  try
    dm.conexaoBanco.Params.Values['Server'] := edtServidor.Text;
    dm.conexaoBanco.Params.Database := edtBanco.Text;
    dm.conexaoBanco.Params.UserName := edtUsuario.Text;
    dm.conexaoBanco.Params.Password := EdtSenha.Text;
    dm.conexaoBanco.Params.Values['Port'] := edtPorta.Text;

    dm.conexaoBanco.Connected := true;
    ShowMessage('Conexão OK');
  except
    on e:Exception do
    begin
      msg := 'Erro ao conectar no banco de dados ' + edtBanco.Text;
      raise Exception.Create(msg + e.Message);
    end;
  end;
end;

procedure TfrmConexao.FormCreate(Sender: TObject);
begin
  arquivoIni := TIniFile.Create(GetCurrentDir + '\conexao\conexao.ini');

  edtServidor.Text := arquivoIni.ReadString('configuracoes', 'servidor', '');
  edtBanco.Text := arquivoIni.ReadString('configuracoes', 'banco', '');
  edtPorta.Text := arquivoIni.ReadString('configuracoes', 'porta', '');
  edtUsuario.Text := arquivoIni.ReadString('configuracoes', 'usuario', '');
  EdtSenha.Text := arquivoIni.ReadString('configuracoes', 'senha', '');
end;

procedure TfrmConexao.FormDestroy(Sender: TObject);
begin
  arquivoIni.Free;
end;

procedure TfrmConexao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0)
  end;
end;

procedure TfrmConexao.Salvar;
begin
  arquivoIni.WriteString('configuracoes', 'servidor', edtServidor.Text);
  arquivoIni.WriteString('configuracoes', 'banco', edtBanco.Text);
  arquivoIni.WriteString('configuracoes', 'porta', edtPorta.Text);
  arquivoIni.WriteString('configuracoes', 'usuario', edtUsuario.Text);
  arquivoIni.WriteString('configuracoes', 'senha', edtSenha.Text);

  ShowMessage('Salvo!');
end;

end.
