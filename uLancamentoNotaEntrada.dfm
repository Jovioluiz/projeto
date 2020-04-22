object frmLancamentoNotaEntrada: TfrmLancamentoNotaEntrada
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Lan'#231'amento Nota Entrada'
  ClientHeight = 720
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 720
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 216
      Top = 85
      Width = 38
      Height = 13
      Caption = 'N'#186' Nota'
    end
    object Label2: TLabel
      Left = 47
      Top = 90
      Width = 24
      Height = 13
      Caption = 'S'#233'rie'
    end
    object Label3: TLabel
      Left = 24
      Top = 16
      Width = 47
      Height = 13
      Caption = 'Opera'#231#227'o'
    end
    object Label4: TLabel
      Left = 456
      Top = 16
      Width = 34
      Height = 13
      Caption = 'Modelo'
    end
    object Label5: TLabel
      Left = 16
      Top = 53
      Width = 55
      Height = 13
      Caption = 'Fornecedor'
    end
    object Label6: TLabel
      Left = 426
      Top = 53
      Width = 64
      Height = 13
      Caption = 'Data Emiss'#227'o'
    end
    object Label7: TLabel
      Left = 402
      Top = 85
      Width = 88
      Height = 13
      Caption = 'Data Recebimento'
    end
    object Label8: TLabel
      Left = 24
      Top = 160
      Width = 40
      Height = 13
      Caption = 'Servi'#231'os'
    end
    object Label9: TLabel
      Left = 120
      Top = 160
      Width = 43
      Height = 13
      Caption = 'Produtos'
    end
    object Label10: TLabel
      Left = 216
      Top = 160
      Width = 51
      Height = 13
      Caption = 'Base ICMS'
    end
    object Label11: TLabel
      Left = 316
      Top = 160
      Width = 67
      Height = 13
      Caption = 'Aliquota ICMS'
    end
    object Label12: TLabel
      Left = 414
      Top = 160
      Width = 52
      Height = 13
      Caption = 'Valor ICMS'
    end
    object Label13: TLabel
      Left = 510
      Top = 160
      Width = 26
      Height = 13
      Caption = 'Frete'
    end
    object Label14: TLabel
      Left = 606
      Top = 160
      Width = 14
      Height = 13
      Caption = 'IPI'
    end
    object Label15: TLabel
      Left = 704
      Top = 160
      Width = 16
      Height = 13
      Caption = 'ISS'
    end
    object Label16: TLabel
      Left = 24
      Top = 232
      Width = 45
      Height = 13
      Caption = 'Desconto'
    end
    object Label17: TLabel
      Left = 120
      Top = 232
      Width = 48
      Height = 13
      Caption = 'Acr'#233'scimo'
    end
    object Label18: TLabel
      Left = 316
      Top = 232
      Width = 29
      Height = 13
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label19: TLabel
      Left = 619
      Top = 53
      Width = 84
      Height = 13
      Caption = 'Data Lan'#231'amento'
    end
    object Label20: TLabel
      Left = 24
      Top = 320
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label21: TLabel
      Left = 103
      Top = 320
      Width = 46
      Height = 13
      Caption = 'Descri'#231#227'o'
    end
    object Label22: TLabel
      Left = 392
      Top = 312
      Width = 54
      Height = 13
      Caption = 'Un. Medida'
    end
    object Label23: TLabel
      Left = 456
      Top = 312
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label24: TLabel
      Left = 532
      Top = 312
      Width = 26
      Height = 13
      Caption = 'Fator'
    end
    object Label25: TLabel
      Left = 656
      Top = 312
      Width = 64
      Height = 13
      Caption = 'Valor Unit'#225'rio'
    end
    object Label26: TLabel
      Left = 726
      Top = 312
      Width = 51
      Height = 13
      Caption = 'Valor Total'
    end
    object Label27: TLabel
      Left = 520
      Top = 342
      Width = 6
      Height = 13
      Caption = 'X'
    end
    object Label28: TLabel
      Left = 596
      Top = 312
      Width = 49
      Height = 13
      Caption = 'Qtd. Total'
    end
    object Label29: TLabel
      Left = 208
      Top = 232
      Width = 82
      Height = 13
      Caption = 'Outras Despesas'
    end
    object edtNroNota: TEdit
      Left = 260
      Top = 82
      Width = 129
      Height = 21
      TabOrder = 4
      OnExit = edtNroNotaExit
    end
    object edtSerie: TEdit
      Left = 77
      Top = 82
      Width = 52
      Height = 21
      TabOrder = 3
      OnExit = edtSerieExit
    end
    object edtCdFornecedor: TEdit
      Left = 77
      Top = 50
      Width = 52
      Height = 21
      TabOrder = 2
      OnChange = edtCdFornecedorChange
      OnExit = edtCdFornecedorExit
    end
    object edtOperacao: TEdit
      Left = 77
      Top = 13
      Width = 52
      Height = 21
      TabOrder = 0
      OnChange = edtOperacaoChange
      OnExit = edtOperacaoExit
    end
    object edtModelo: TEdit
      Left = 510
      Top = 13
      Width = 44
      Height = 21
      TabOrder = 1
      OnChange = edtModeloChange
      OnExit = edtModeloExit
    end
    object edtNomeOperacao: TEdit
      Left = 144
      Top = 13
      Width = 245
      Height = 21
      Enabled = False
      TabOrder = 8
    end
    object edtNomeFornecedor: TEdit
      Left = 144
      Top = 50
      Width = 245
      Height = 21
      Enabled = False
      TabOrder = 9
    end
    object edtNomeModelo: TEdit
      Left = 560
      Top = 13
      Width = 249
      Height = 21
      Enabled = False
      TabOrder = 10
    end
    object edtDataEmissao: TDateTimePicker
      Left = 510
      Top = 50
      Width = 100
      Height = 21
      Date = 43905.000000000000000000
      Time = 0.811114513890061100
      TabOrder = 5
    end
    object edtDataRecebimento: TDateTimePicker
      Left = 510
      Top = 77
      Width = 100
      Height = 21
      Date = 43905.000000000000000000
      Time = 0.811114641204767400
      TabOrder = 6
    end
    object edtVlServico: TEdit
      Left = 24
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 11
      Text = '0,00'
      OnExit = edtVlServicoExit
    end
    object edtVlProduto: TEdit
      Left = 120
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 12
      Text = '0,00'
      OnExit = edtVlProdutoExit
    end
    object edtBaseIcms: TEdit
      Left = 216
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 13
      Text = '0,00'
    end
    object edtAliqIcms: TEdit
      Left = 316
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 14
      Text = '0,00'
      OnExit = edtAliqIcmsExit
    end
    object edtValorIcms: TEdit
      Left = 414
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 15
      Text = '0,00'
    end
    object edtValorFrete: TEdit
      Left = 510
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 16
      Text = '0,00'
      OnExit = edtValorFreteExit
    end
    object edtValorIPI: TEdit
      Left = 606
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 17
      Text = '0,00'
      OnExit = edtValorIPIExit
    end
    object edtValorISS: TEdit
      Left = 704
      Top = 179
      Width = 73
      Height = 21
      TabOrder = 18
      Text = '0,00'
    end
    object edtValorDesconto: TEdit
      Left = 24
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 19
      Text = '0,00'
      OnExit = edtValorDescontoExit
    end
    object edtValorAcrescimo: TEdit
      Left = 120
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 20
      Text = '0,00'
      OnExit = edtValorAcrescimoExit
    end
    object edtValorTotalNota: TEdit
      Left = 316
      Top = 251
      Width = 73
      Height = 21
      Enabled = False
      TabOrder = 22
      Text = '0,00'
    end
    object edtCodProduto: TEdit
      Left = 24
      Top = 339
      Width = 73
      Height = 21
      TabOrder = 23
      OnChange = edtCodProdutoChange
      OnEnter = edtCodProdutoEnter
      OnExit = edtCodProdutoExit
    end
    object edtDescricaoProduto: TEdit
      Left = 103
      Top = 339
      Width = 269
      Height = 21
      Enabled = False
      TabOrder = 24
    end
    object edtUnMedida: TEdit
      Left = 395
      Top = 339
      Width = 51
      Height = 21
      TabOrder = 25
    end
    object edtQuantidade: TEdit
      Left = 456
      Top = 339
      Width = 56
      Height = 21
      TabOrder = 26
      OnChange = edtQuantidadeChange
      OnExit = edtQuantidadeExit
    end
    object edtFatorConversao: TEdit
      Left = 532
      Top = 339
      Width = 51
      Height = 21
      Enabled = False
      TabOrder = 27
    end
    object edtValorUnitario: TEdit
      Left = 656
      Top = 339
      Width = 64
      Height = 21
      TabOrder = 29
      OnChange = edtValorUnitarioChange
    end
    object edtValorTotalProduto: TEdit
      Left = 726
      Top = 339
      Width = 67
      Height = 21
      TabOrder = 30
    end
    object edtQuantidadeTotalProduto: TEdit
      Left = 596
      Top = 339
      Width = 51
      Height = 21
      Enabled = False
      TabOrder = 28
    end
    object edtDataLancamento: TDateTimePicker
      Left = 709
      Top = 53
      Width = 100
      Height = 21
      Date = 43907.000000000000000000
      Time = 0.811114780095522300
      TabOrder = 7
    end
    object edtValorOutrasDespesas: TEdit
      Left = 208
      Top = 251
      Width = 73
      Height = 21
      TabOrder = 21
      Text = '0,00'
      OnExit = edtValorOutrasDespesasExit
    end
    object btnAddItens: TButton
      Left = 799
      Top = 337
      Width = 42
      Height = 26
      Caption = '+'
      TabOrder = 31
      OnClick = btnAddItensClick
    end
    object DBGridProdutos: TDBGrid
      Left = 24
      Top = 409
      Width = 817
      Height = 265
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 32
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Sequencia'
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'C'#243'd. Produto'
          ReadOnly = True
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Descri'#231#227'o'
          ReadOnly = True
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Un. Medida'
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          ReadOnly = True
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Fator Convers'#227'o'
          ReadOnly = True
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade Total'
          ReadOnly = True
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Unit'#225'rio'
          ReadOnly = True
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Valor Total'
          ReadOnly = True
          Width = 80
          Visible = True
        end>
    end
    object btnConfirmar: TButton
      Left = 632
      Top = 680
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 33
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 726
      Top = 680
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 34
      OnClick = btnCancelarClick
    end
  end
  object sqlCabecalho: TFDQuery
    Connection = frmConexao.conexao
    Left = 112
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 184
    Top = 472
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 472
  end
  object sqlIdGeral: TFDQuery
    Connection = frmConexao.conexao
    Left = 352
    Top = 472
  end
  object sqlInsert: TFDQuery
    Connection = frmConexao.conexao
    Left = 424
    Top = 472
  end
  object sqlUpdate: TFDQuery
    Connection = frmConexao.conexao
    Left = 496
    Top = 472
  end
end
