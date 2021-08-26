unit TesteInfo.View.PagePrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmPagePrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    mmCadCliente: TMenuItem;
    Image1: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure mmCadClienteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagePrincipal: TfrmPagePrincipal;

implementation

{$R *.dfm}

uses TesteInfo.View.PageCliente;

procedure TfrmPagePrincipal.mmCadClienteClick(Sender: TObject);
begin
  Application.CreateForm(TfrmPageCliente, frmPageCliente);
  try
    frmPageCliente.ShowModal;
  finally
    FreeAndNil(frmPageCliente);
  end;
end;

procedure TfrmPagePrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPagePrincipal.Sobre1Click(Sender: TObject);
begin
  Application.MessageBox(
    'Sistema de Teste - InfoSistemas'+ #13 +
    'Versão: 1.0'+ #13 +
    'Desenvolvido por: Wagner Vasconcelos',
    'TesteInfo - Informação!', MB_ICONINFORMATION);
end;

end.
