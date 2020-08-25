unit uVersao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.UITypes, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type TVersao = class

private
public

function GetBuildInfo(Prog: string): string;
end;

implementation

{ TVersao }


//exibe a versão do aplicativo
function TVersao.GetBuildInfo(Prog: string): string;
var
 VerInfoSize: DWORD;
 VerInfo: Pointer;
 VerValueSize: DWORD;
 VerValue: PVSFixedFileInfo;
 Dummy: DWORD;
 V1, V2, V3, V4: Word;
begin
   try
     VerInfoSize := GetFileVersionInfoSize(PChar(Prog), Dummy);
     GetMem(VerInfo, VerInfoSize);
     GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
     VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);

     with (VerValue^) do
     begin
       V1 := dwFileVersionMS shr 16;
       V2 := dwFileVersionMS and $FFFF;
       V3 := dwFileVersionLS shr 16;
       V4 := dwFileVersionLS and $FFFF;
     end;
     FreeMem(VerInfo, VerInfoSize);
     Result := Format('%d.%d.%d.%d', [v1, v2, v3, v4]);
   except
     Result := '1.0.0';
   end;
end;

end.
