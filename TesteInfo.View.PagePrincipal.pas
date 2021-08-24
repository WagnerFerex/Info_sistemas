unit TesteInfo.View.PagePrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmPagePrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Sobre1: TMenuItem;
    Sair1: TMenuItem;
    mmCadCliente: TMenuItem;
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
  frmPageCliente := TfrmPageCliente.Create(nil);
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
  Application.MessageBox('', 'TesteInfo - Informação!', MB_ICONINFORMATION);
end;

end.
