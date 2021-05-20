unit transferenciaTabelas;

interface

uses
  Data.DB;

  function CloneDatasets(Origem, Destino: TDataSet; CriaCampos: Boolean = True; Zeratabela: Boolean = True; DisableControls: Boolean = True): Boolean;
  function CopiaEstruturaDataSet(Origem, Destino: TDataSet): Boolean;
  procedure CreateDataset(Dataset: TDataSet);
  procedure EmptyDataset(Dataset: TDataSet);
  function TransferirTabela(Origem, Destino: TDataSet; VerificarNome: Boolean = True): Boolean;
implementation

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Dialogs, Datasnap.DBClient;

function CloneDatasets(Origem, Destino: TDataSet; CriaCampos: Boolean = True; Zeratabela: Boolean = True; DisableControls: Boolean = True): Boolean;
begin
  if DisableControls then
  begin
    Origem.DisableControls;
    Destino.DisableControls;
  end;

  try
    if (Zeratabela) and (not Destino.IsEmpty) then
    begin
      EmptyDataset(Destino);
      Destino.Close;
    end;

    if CriaCampos then
      Result := CopiaEstruturaDataSet(Origem, Destino) and TransferirTabela(Origem, Destino, False)
    else
    begin
      if not Destino.Active then
        CreateDataset(Destino);
      Result := TransferirTabela(Origem, Destino)
    end;

  finally
    if DisableControls then
    begin
      Origem.EnableControls;
      Destino.EnableControls;
    end;
  end;
end;

function CopiaEstruturaDataSet(Origem, Destino: TDataSet): Boolean;
var
  field: TField;
begin
  try
    if Destino.Active then
      Destino.Close;
    Destino.FieldDefs.Clear;
    for field in Origem.Fields do
      Destino.FieldDefs.Add(field.FieldName, field.DataType, field.Size);
    CreateDataSet(Destino);
    Result := True;
  except
    on e: Exception do
    begin
      showmessage(e.message);
      Result := False;
    end;
  end;
end;

procedure CreateDataset(Dataset: TDataSet);
begin
  if Dataset is TClientDataset then
    TClientDataSet(Dataset).CreateDataset
  else if Dataset is TFDMemTable then
    TFDMemTable(Dataset).CreateDataset;
end;

procedure EmptyDataset(Dataset: TDataSet);
begin
  if Dataset is TClientDataset then
    TClientDataSet(Dataset).EmptyDataset
  else if Dataset is TFDMemTable then
    TFDMemTable(Dataset).EmptyDataset;
end;

function TransferirTabela(Origem, Destino: TDataSet; VerificarNome: Boolean = True): Boolean;
var
  i: Integer;
  fieldOrigem, fieldDestino: TField;
begin
  Origem.DisableControls;
  Origem.DisableControls;

  try
    try
      Origem.First;
      while not Origem.Eof do
      begin
        Destino.Append;
        try
          if VerificarNome then
            for fieldOrigem in Origem.Fields do
            begin
              fieldDestino := Destino.FindField(fieldOrigem.FieldName);
              if (fieldDestino <> nil ) then
              begin
                if fieldOrigem.DataType = ftBlob then
                  fieldDestino.AsBytes := fieldOrigem.AsBytes
                else
                  fieldDestino.Value := fieldOrigem.Value;
              end;
            end
          else
            for i := 0 to Origem.Fields.Count - 1 do
            begin
              if i < Destino.Fields.Count then
                Destino.Fields[i].Value := Origem.Fields[i].Value;
            end;
        except end;
        Destino.Post;
        Origem.Next;
      end;
      Result := True;

    except
      on e: Exception do
      begin
        showmessage(e.message);
        Result := False;
      end;
    end;

  finally
    Origem.First;
    Destino.First;
    Origem.EnableControls;
    Destino.EnableControls;
  end;
end;

end.
