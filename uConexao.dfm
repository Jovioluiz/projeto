object frmConexao: TfrmConexao
  Left = 0
  Top = 0
  Caption = 'Conexao'
  ClientHeight = 368
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object conexao: TFDConnection
    Params.Strings = (
      'Database=trabalho_engenharia'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'Port=5433'
      'DriverID=PG')
    TxOptions.AutoStop = False
    Left = 64
    Top = 104
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\jovio\Desktop\codigos_fontes\Delphi\AProjeto\trunk\lib\' +
      'libpq.dll'
    Left = 168
    Top = 104
  end
end
