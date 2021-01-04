unit uSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Gauges;

type
  TfrmSplash = class(TForm)
    Gauge1: TGauge;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //FreeAndNil(frmSplash);
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  Gauge1.Progress := Gauge1.Progress + 1;
  if Gauge1.Progress = 1 then
  begin
    Label1.Font.Size := 12;
    Label1.Caption := 'Inicializando...';
    Label1.Repaint;
  end;
  if Gauge1.Progress = 50 then
  begin
    Label1.Font.Size := 12;
    Label1.Caption := 'Carregando Formulários...';
    Label1.Repaint;
  end;
  if Gauge1.Progress = 100 then
  begin
    frmSplash.Close;
  end;
end;

end.
