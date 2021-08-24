object frmPageCliente: TfrmPageCliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sistema Generico - Teste Info Sistemas'
  ClientHeight = 619
  ClientWidth = 920
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 548
    Width = 920
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object btnSalvar: TSpeedButton
      Left = 701
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = '&Salvar'
      OnClick = btnSalvarClick
      ExplicitLeft = 293
      ExplicitTop = 6
      ExplicitHeight = 69
    end
    object btnEditar: TSpeedButton
      Left = 555
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = '&Editar'
      OnClick = btnEditarClick
      ExplicitLeft = 104
      ExplicitHeight = 68
    end
    object btnSair: TSpeedButton
      Left = 847
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = 'Sair'
      OnClick = btnSairClick
      ExplicitLeft = 298
      ExplicitTop = 6
      ExplicitHeight = 69
    end
    object btnExcluir: TSpeedButton
      Left = 628
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = 'E&xcluir'
      OnClick = btnExcluirClick
      ExplicitLeft = 169
      ExplicitHeight = 69
    end
    object btnNovo: TSpeedButton
      Left = 482
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = '&Novo'
      OnClick = btnNovoClick
      ExplicitLeft = 501
      ExplicitTop = -6
    end
    object btnCancelar: TSpeedButton
      Left = 774
      Top = 0
      Width = 73
      Height = 52
      Align = alRight
      Caption = '&Cancelar'
      OnClick = btnCancelarClick
      ExplicitLeft = 298
      ExplicitTop = 6
      ExplicitHeight = 69
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 600
    Width = 920
    Height = 19
    Panels = <>
  end
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 920
    Height = 548
    ActivePage = tsPageCadastro
    Align = alClient
    TabOrder = 2
    ExplicitTop = 6
    ExplicitHeight = 542
    object tsPageListagem: TTabSheet
      Caption = 'tsPageListagem'
      TabVisible = False
      ExplicitHeight = 532
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 912
        Height = 49
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ButtonedEdit1: TButtonedEdit
          Left = 7
          Top = 19
          Width = 778
          Height = 24
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TextHint = ' Informe o valor a ser pesquisado...'
        end
        object BitBtn1: TBitBtn
          Left = 793
          Top = 17
          Width = 98
          Height = 28
          Caption = 'Filtrar'
          TabOrder = 1
        end
      end
      object dbgListagem: TDBGrid
        Left = 0
        Top = 49
        Width = 912
        Height = 489
        Align = alClient
        DataSource = dsrCLIENTE
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'CPF'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 320
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Identidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Telefone'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Email'
            Width = 254
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Endereco'
            Visible = True
          end>
      end
    end
    object tsPageCadastro: TTabSheet
      Caption = 'tsPageCadastro'
      ImageIndex = 1
      TabVisible = False
      ExplicitHeight = 532
      object Label8: TLabel
        Left = 8
        Top = 17
        Width = 27
        Height = 13
        Caption = 'Nome'
        FocusControl = edtNome
      end
      object Label9: TLabel
        Left = 8
        Top = 57
        Width = 52
        Height = 13
        Caption = 'Identidade'
        FocusControl = edtIdentidade
      end
      object Label10: TLabel
        Left = 8
        Top = 98
        Width = 19
        Height = 13
        Caption = 'CPF'
        FocusControl = edtCPF
      end
      object Label11: TLabel
        Left = 8
        Top = 137
        Width = 42
        Height = 13
        Caption = 'Telefone'
        FocusControl = edtTelefone
      end
      object Label12: TLabel
        Left = 8
        Top = 178
        Width = 24
        Height = 13
        Caption = 'Email'
        FocusControl = edtEmail
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 238
        Width = 912
        Height = 300
        Align = alBottom
        Caption = 'Endere'#231'o'
        TabOrder = 0
        ExplicitTop = 232
        object Label1: TLabel
          Left = 16
          Top = 34
          Width = 19
          Height = 13
          Caption = 'CEP'
        end
        object SpeedButton7: TSpeedButton
          Left = 185
          Top = 48
          Width = 23
          Height = 22
        end
        object Label2: TLabel
          Left = 16
          Top = 76
          Width = 55
          Height = 13
          Caption = 'Logradouro'
        end
        object Label3: TLabel
          Left = 143
          Top = 159
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object Label4: TLabel
          Left = 249
          Top = 118
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object Label5: TLabel
          Left = 482
          Top = 118
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object Label6: TLabel
          Left = 16
          Top = 118
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object Label7: TLabel
          Left = 16
          Top = 159
          Width = 37
          Height = 13
          Caption = 'Numero'
        end
        object Label13: TLabel
          Left = 484
          Top = 159
          Width = 19
          Height = 13
          Caption = 'Pa'#237's'
        end
        object edtCEP: TEdit
          Left = 16
          Top = 48
          Width = 166
          Height = 21
          TabOrder = 0
        end
        object edtLogradouro: TEdit
          Left = 16
          Top = 90
          Width = 545
          Height = 21
          TabOrder = 1
        end
        object edtComplemento: TEdit
          Left = 143
          Top = 173
          Width = 337
          Height = 21
          TabOrder = 7
        end
        object edtCidade: TEdit
          Left = 249
          Top = 132
          Width = 230
          Height = 21
          TabOrder = 4
        end
        object edtUF: TEdit
          Left = 482
          Top = 132
          Width = 79
          Height = 21
          TabOrder = 5
        end
        object edtBairro: TEdit
          Left = 16
          Top = 132
          Width = 230
          Height = 21
          TabOrder = 3
        end
        object edtNumero: TEdit
          Left = 16
          Top = 173
          Width = 121
          Height = 21
          NumbersOnly = True
          TabOrder = 2
        end
        object edtPais: TEdit
          Left = 484
          Top = 173
          Width = 77
          Height = 21
          TabOrder = 6
        end
      end
      object edtNome: TDBEdit
        Left = 8
        Top = 32
        Width = 300
        Height = 21
        DataField = 'Nome'
        DataSource = dsrCLIENTE
        TabOrder = 1
      end
      object edtIdentidade: TDBEdit
        Left = 8
        Top = 73
        Width = 264
        Height = 21
        DataField = 'Identidade'
        DataSource = dsrCLIENTE
        TabOrder = 2
      end
      object edtCPF: TDBEdit
        Left = 8
        Top = 113
        Width = 147
        Height = 21
        DataField = 'CPF'
        DataSource = dsrCLIENTE
        TabOrder = 3
      end
      object edtTelefone: TDBEdit
        Left = 8
        Top = 153
        Width = 134
        Height = 21
        DataField = 'Telefone'
        DataSource = dsrCLIENTE
        TabOrder = 4
      end
      object edtEmail: TDBEdit
        Left = 8
        Top = 193
        Width = 400
        Height = 21
        DataField = 'Email'
        DataSource = dsrCLIENTE
        TabOrder = 5
      end
    end
  end
  object dsrCLIENTE: TDataSource
    OnStateChange = dsrCLIENTEStateChange
    Left = 820
    Top = 24
  end
end
