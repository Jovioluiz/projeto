unit uCadastroTributacaoItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.UITypes;

type
  TfrmCadastraTributacaoItem = class(TForm)
    PageControl1: TPageControl;
    TabSheetICMS: TTabSheet;
    Label1: TLabel;
    edtCdGrupoTributacaoICMS: TEdit;
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
    edtCdGrupoTributacaoIPI: TEdit;
    Label8: TLabel;
    TabSheetISS: TTabSheet;
    Label9: TLabel;
    edtCdGrupoTributacaoISS: TEdit;
    edtNomeGrupoTributacaoISS: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtAliqISS: TEdit;
    TabSheetPISCOFINS: TTabSheet;
    Label4: TLabel;
    edtCdGrupoTributacaoPISCOFINS: TEdit;
    Label5: TLabel;
    edtNomeGrupoTributacaoPISCOFINS: TEdit;
    edtAliqPISCOFINS: TEdit;
    Label12: TLabel;
    comandoSQL: TFDQuery;
    comandoselect: TFDQuery;
    procedure edtCdGrupoTributacaoICMSExit(Sender: TObject);
    procedure edtCdGrupoTributacaoIPIExit(Sender: TObject);
    procedure edtCdGrupoTributacaoISSExit(Sender: TObject);
    procedure edtCdGrupoTributacaoPISCOFINSExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    procedure limpaCampos;
    procedure salvar;
    procedure desabilitaCampos;
  public
    { Public declarations }
  end;

var
  frmCadastraTributacaoItem: TfrmCadastraTributacaoItem;
  camposDesabilitados: Boolean;

implementation

uses
  uValidaDados, uDataModule, uLogin;

{$R *.dfm}

procedure TfrmCadastraTributacaoItem.desabilitaCampos;
begin
  edtCdGrupoTributacaoICMS.Enabled := False;
  edtNomeGrupoTributacaoICMS.Enabled := False;
  edtAliqICMS.Enabled := False;

  camposDesabilitados := True;
end;

procedure TfrmCadastraTributacaoItem.edtCdGrupoTributacaoICMSExit(Sender: TObject);
var
  temPermissaoEdicao : Boolean;
  icms : TValidaDados;
begin
  icms := TValidaDados.Create;
  temPermissaoEdicao := icms.validaEdicaoAcao(idUsuario, 13);

  if edtCdGrupoTributacaoICMS.Text = EmptyStr then
  begin
    raise Exception.Create('Campo não pode ser vazio');
    edtCdGrupoTributacaoICMS.SetFocus;
  end
  else
  begin
    comandoselect.Close;
    comandoselect.SQL.Text := 'select                             '+
                              '    cd_tributacao,                 '+
                              '    nm_tributacao_icms,            '+
                              '    aliquota_icms                  '+
                              'from                               '+
                              '    grupo_tributacao_icms          '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoselect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoICMS.Text);
    comandoselect.Open();
    if not comandoselect.IsEmpty then
    begin
      //edtCdGrupoTributacaoICMS.Text := IntToStr(comandoselect.FieldByName('cd_tributacao').AsInteger);
      edtNomeGrupoTributacaoICMS.Text := comandoselect.FieldByName('nm_tributacao_icms').AsString;
      edtAliqICMS.Text := CurrToStr(comandoselect.FieldByName('aliquota_icms').AsCurrency);
    end;

    if (not temPermissaoEdicao) and (comandoSQL.IsEmpty) then
    begin
      MessageDlg('Usuário não possui Permissão para realizar Cadastro/Edição', mtInformation, [mbOK], 0);
      //edtCdGrupoTributacaoICMS.SetFocus;
    end;
  end;

  if temPermissaoEdicao then
    Exit
  else
    desabilitaCampos;
end;


procedure TfrmCadastraTributacaoItem.edtCdGrupoTributacaoIPIExit(Sender: TObject);
begin
  if edtCdGrupoTributacaoIPI.Text = EmptyStr then
  begin
    raise Exception.Create('Campo não pode ser vazio');
    edtCdGrupoTributacaoIPI.SetFocus;
  end
  else
  begin
    comandoselect.Close;
    comandoselect.SQL.Text := 'select                             '+
                              '    cd_tributacao,                 '+
                              '    nm_tributacao_ipi,             '+
                              '    aliquota_ipi                   '+
                              'from                               '+
                              '    grupo_tributacao_ipi           '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoselect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoIPI.Text);
    comandoselect.Open();
    if not comandoselect.IsEmpty then
    begin
      //edtCdGrupoTributacaoIPI.Text := IntToStr(comandoselect.FieldByName('cd_tributacao').AsInteger);
      edtNomeGrupoTributacaoIPI.Text := comandoselect.FieldByName('nm_tributacao_ipi').AsString;
      edtAliqIPI.Text := CurrToStr(comandoselect.FieldByName('aliquota_ipi').AsCurrency);
    end;
  end;
end;

procedure TfrmCadastraTributacaoItem.edtCdGrupoTributacaoISSExit(Sender: TObject);
begin
  if edtCdGrupoTributacaoISS.Text = EmptyStr then
  begin
    raise Exception.Create('Campo não pode ser vazio');
    edtCdGrupoTributacaoISS.SetFocus;
  end
  else
  begin
    comandoselect.Close;
    comandoselect.SQL.Text := 'select                             '+
                              '    cd_tributacao,                 '+
                              '    nm_tributacao_iss,             '+
                              '    aliquota_iss                   '+
                              'from                               '+
                              '    grupo_tributacao_iss           '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoselect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoISS.Text);
    comandoselect.Open();

    if not comandoselect.IsEmpty then
    begin
      //edtCdGrupoTributacaoISS.Text := IntToStr(comandoselect.FieldByName('cd_tributacao').AsInteger);
      edtNomeGrupoTributacaoISS.Text := comandoselect.FieldByName('nm_tributacao_iss').AsString;
      edtAliqISS.Text := CurrToStr(comandoselect.FieldByName('aliquota_iss').AsCurrency);
    end;
  end;
end;

procedure TfrmCadastraTributacaoItem.edtCdGrupoTributacaoPISCOFINSExit(Sender: TObject);
begin
  if edtCdGrupoTributacaoPISCOFINS.Text = EmptyStr then
  begin
    raise Exception.Create('Campo não pode ser vazio');
    edtCdGrupoTributacaoPISCOFINS.SetFocus;
  end
  else
  begin
    comandoselect.Close;
    comandoselect.SQL.Text := 'select                             '+
                              '    cd_tributacao,                 '+
                              '    nm_tributacao_pis_cofins,                 '+
                              '    aliquota_pis_cofins            '+
                              'from                               '+
                              '    grupo_tributacao_pis_cofins    '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoselect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoPISCOFINS.Text);
    comandoselect.Open();

    if not comandoselect.IsEmpty then
    begin
      //edtCdGrupoTributacaoPISCOFINS.Text := IntToStr(comandoselect.FieldByName('cd_tributacao').AsInteger);
      edtNomeGrupoTributacaoPISCOFINS.Text := comandoselect.FieldByName('nm_tributacao_pis_cofins').AsString;
      edtAliqPISCOFINS.Text := CurrToStr(comandoselect.FieldByName('aliquota_pis_cofins').AsCurrency);
    end;
  end;
end;

procedure TfrmCadastraTributacaoItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmCadastraTributacaoItem := nil;
end;

procedure TfrmCadastraTributacaoItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F3 then //F3
  begin
    limpaCampos;
  end
  else if key = VK_F2 then  //F2
  begin
    salvar;
  end
  else if key = VK_ESCAPE then //ESC
  begin
    if (Application.MessageBox('Deseja Fechar?','Atenção', MB_YESNO) = IDYES) then
    begin
      Close;
    end;
  end;
end;

procedure TfrmCadastraTributacaoItem.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL,0,0)
  end;
end;

procedure TfrmCadastraTributacaoItem.limpaCampos;
begin
  if camposDesabilitados then
  begin
    edtCdGrupoTributacaoICMS.Enabled := True;
    edtNomeGrupoTributacaoICMS.Enabled := True;
    edtAliqICMS.Enabled := True;
    camposDesabilitados := False;
  end;

  edtCdGrupoTributacaoICMS.Clear;
  edtNomeGrupoTributacaoICMS.Clear;
  edtAliqICMS.Clear;
  edtCdGrupoTributacaoIPI.Clear;
  edtNomeGrupoTributacaoIPI.Clear;
  edtAliqIPI.Clear;
  edtCdGrupoTributacaoISS.Clear;
  edtNomeGrupoTributacaoISS.Clear;
  edtAliqISS.Clear;
  edtCdGrupoTributacaoPISCOFINS.Clear;
  edtNomeGrupoTributacaoPISCOFINS.Clear;
  edtAliqPISCOFINS.Clear;
end;

procedure TfrmCadastraTributacaoItem.salvar;
begin
  if TabSheetICMS.Showing = true then      //ICMS
  begin
    comandoSelect.Close;
    comandoSelect.SQL.Text := 'select                             '+
                              '    cd_tributacao                  '+
                              'from                               '+
                              '    grupo_tributacao_icms          '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoSelect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoICMS.Text);
    comandoSelect.Open();

    if not comandoselect.IsEmpty then
    begin
      //update
      comandoSQL.Close;
      comandoSQL.SQL.Text :=  'update                              '+
                                  'grupo_tributacao_icms           '+
                              'set                                 '+
                                  'cd_tributacao = :cd_tributacao, '+
                                  'nm_tributacao_icms = :nm_tributacao_icms, '+
                                  'aliquota_icms = :aliquota_icms  '+
                              'where                               '+
                                  'cd_tributacao = :cd_tributacao';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoICMS.Text);
      comandoSQL.ParamByName('nm_tributacao_icms').AsString := edtNomeGrupoTributacaoICMS.Text;
      comandoSQL.ParamByName('aliquota_icms').AsCurrency := StrToCurr(edtAliqICMS.Text);

     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoICMS.Clear;
       edtNomeGrupoTributacaoICMS.Clear;
       edtAliqICMS.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end
    else
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text := 'insert                                      '+
                                  'into                                   '+
                                  'grupo_tributacao_icms (cd_tributacao,  '+
                                  'nm_tributacao_icms,                    '+
                                  'aliquota_icms)                         '+
                              'values (:cd_tributacao,                    '+
                                  ':nm_tributacao_icms,                   '+
                                  ':aliquota_icms)';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoICMS.Text);
      comandoSQL.ParamByName('nm_tributacao_icms').AsString := edtNomeGrupoTributacaoICMS.Text;
      comandoSQL.ParamByName('aliquota_icms').AsCurrency := StrToCurr(edtAliqICMS.Text);

     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoICMS.Clear;
       edtNomeGrupoTributacaoICMS.Clear;
       edtAliqICMS.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end;
  end
  else if TabSheetIPI.Showing then    //IPI
  begin
    comandoSelect.Close;
    comandoSelect.SQL.Text := 'select                             '+
                              '    cd_tributacao                  '+
                              'from                               '+
                              '    grupo_tributacao_ipi           '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoSelect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoIPI.Text);
    comandoSelect.Open();

    if not comandoselect.IsEmpty then
      //update
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text :=  'update                              '+
                                  'grupo_tributacao_ipi            '+
                              'set                                 '+
                                  'cd_tributacao = :cd_tributacao, '+
                                  'nm_tributacao_ipi = :nm_tributacao_ipi, '+
                                  'aliquota_ipi = :aliquota_ipi    '+
                              'where                               '+
                                  'cd_tributacao = :cd_tributacao';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoIPI.Text);
      comandoSQL.ParamByName('nm_tributacao_ipi').AsString := edtNomeGrupoTributacaoIPI.Text;
      comandoSQL.ParamByName('aliquota_ipi').AsCurrency := StrToCurr(edtAliqIPI.Text);
     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoIPI.Clear;
       edtNomeGrupoTributacaoIPI.Clear;
       edtAliqIPI.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end
    else
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text := 'insert                                    '+
                                  'into                                 '+
                                  'grupo_tributacao_ipi (cd_tributacao, '+
                                  'nm_tributacao_ipi,                   '+
                                  'aliquota_ipi)                        '+
                              'values (:cd_tributacao,                  '+
                                  ':nm_tributacao_ipi,                  '+
                                  ':aliquota_ipi)';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoIPI.Text);
      comandoSQL.ParamByName('nm_tributacao_ipi').AsString := edtNomeGrupoTributacaoIPI.Text;
      comandoSQL.ParamByName('aliquota_ipi').AsCurrency := StrToCurr(edtAliqIPI.Text);

     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoIPI.Clear;
       edtNomeGrupoTributacaoIPI.Clear;
       edtAliqIPI.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end;
  end
  else if TabSheetISS.Showing then      //ISS
   begin
    comandoSelect.Close;
    comandoSelect.SQL.Text := 'select                             '+
                              '    cd_tributacao                  '+
                              'from                               '+
                              '    grupo_tributacao_iss           '+
                              'where                              '+
                                  'cd_tributacao = :cd_tributacao';
    comandoSelect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoISS.Text);
    comandoSelect.Open();

    if not comandoselect.IsEmpty then
      //update
      begin
        comandoSQL.Close;
        comandoSQL.SQL.Text :=  'update                              '+
                                    'grupo_tributacao_iss            '+
                                'set                                 '+
                                    'cd_tributacao = :cd_tributacao, '+
                                    'nm_tributacao_iss = :nm_tributacao_iss, '+
                                    'aliquota_iss = :aliquota_iss    '+
                                'where                               '+
                                    'cd_tributacao = :cd_tributacao';
        comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoISS.Text);
        comandoSQL.ParamByName('nm_tributacao_iss').AsString := edtNomeGrupoTributacaoISS.Text;
        comandoSQL.ParamByName('aliquota_iss').AsCurrency := StrToCurr(edtAliqISS.Text);
       try
         comandoSQL.ExecSQL;
         comandoSQL.Close;
         ShowMessage('Salvo');
         edtCdGrupoTributacaoISS.Clear;
         edtNomeGrupoTributacaoISS.Clear;
         edtAliqISS.Clear;
       except
        on E:Exception do
          begin
            ShowMessage('Erro ao gravar os dados'+ E.Message);
            Exit;
          end;
       end;
      end
    else
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text := 'insert                                    '+
                                  'into                                 '+
                                  'grupo_tributacao_iss (cd_tributacao, '+
                                  'nm_tributacao_iss,                       '+
                                  'aliquota_iss)                        '+
                              'values (:cd_tributacao,                  '+
                                  ':nm_tributacao_iss,                      '+
                                  ':aliquota_iss)';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoISS.Text);
      comandoSQL.ParamByName('nm_tributacao_iss').AsString := edtNomeGrupoTributacaoISS.Text;
      comandoSQL.ParamByName('aliquota_iss').AsCurrency := StrToCurr(edtAliqISS.Text);

     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoISS.Clear;
       edtNomeGrupoTributacaoISS.Clear;
       edtAliqISS.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end;
  end
  else if TabSheetPISCOFINS.Showing then //PIS/COFINS
  begin
    comandoSelect.Close;
    comandoSelect.SQL.Text := 'select         '+
                              '    cd_tributacao                        '+
                              'from                                     '+
                              '    grupo_tributacao_pis_cofins          '+
                              'where                                    '+
                                  'cd_tributacao = :cd_tributacao';
    comandoSelect.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoPISCOFINS.Text);
    comandoSelect.Open();

    if not comandoselect.IsEmpty then
      //update
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text :=  'update                                           '+
                                  'grupo_tributacao_pis_cofins                  '+
                              'set                                              '+
                                  'cd_tributacao = :cd_tributacao,              '+
                                  'nm_tributacao_pis_cofins = :nm_tributacao_pis_cofins,              '+
                                  'aliquota_pis_cofins = :aliquota_pis_cofins   '+
                              'where                                            '+
                                  'cd_tributacao = :cd_tributacao';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoPISCOFINS.Text);
      comandoSQL.ParamByName('nm_tributacao_pis_cofins').AsString := edtNomeGrupoTributacaoPISCOFINS.Text;
      comandoSQL.ParamByName('aliquota_pis_cofins').AsCurrency := StrToCurr(edtAliqPISCOFINS.Text);
     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoPISCOFINS.Clear;
       edtNomeGrupoTributacaoPISCOFINS.Clear;
       edtAliqPISCOFINS.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end
    else
    begin
      comandoSQL.Close;
      comandoSQL.SQL.Text := 'insert                                          '+
                                  'into                                       '+
                                  'grupo_tributacao_pis_cofins (cd_tributacao,'+
                                  'nm_tributacao_pis_cofins,                  '+
                                  'aliquota_pis_cofins)                       '+
                              'values (:cd_tributacao,                        '+
                                  ':nm_tributacao_pis_cofins,                 '+
                                  ':aliquota_pis_cofins)';
      comandoSQL.ParamByName('cd_tributacao').AsInteger := StrToInt(edtCdGrupoTributacaoPISCOFINS.Text);
      comandoSQL.ParamByName('nm_tributacao_pis_cofins').AsString := edtNomeGrupoTributacaoPISCOFINS.Text;
      comandoSQL.ParamByName('aliquota_pis_cofins').AsCurrency := StrToCurr(edtAliqPISCOFINS.Text);

     try
       comandoSQL.ExecSQL;
       comandoSQL.Close;
       ShowMessage('Salvo');
       edtCdGrupoTributacaoPISCOFINS.Clear;
       edtNomeGrupoTributacaoPISCOFINS.Clear;
       edtAliqPISCOFINS.Clear;
     except
      on E:Exception do
        begin
          ShowMessage('Erro ao gravar os dados'+ E.Message);
          Exit;
        end;
     end;
    end;
  end;
end;

end.
