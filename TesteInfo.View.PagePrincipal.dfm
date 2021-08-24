object frmPagePrincipal: TfrmPagePrincipal
  Left = 0
  Top = 0
  Caption = 'frmPagePrincipal'
  ClientHeight = 429
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object mmCadCliente: TMenuItem
        Caption = 'Cliente'
        OnClick = mmCadClienteClick
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
      OnClick = Sobre1Click
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
