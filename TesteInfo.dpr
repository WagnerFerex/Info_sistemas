program TesteInfo;

uses
  Vcl.Forms,
  TesteInfo.View.PagePrincipal in 'TesteInfo.View.PagePrincipal.pas' {frmPagePrincipal},
  TesteInfo.View.PageCliente in 'TesteInfo.View.PageCliente.pas' {frmPageCliente},
  TesteInfo.Model.DMFireDAC in 'TesteInfo.Model.DMFireDAC.pas' {DMFireDAC: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPagePrincipal, frmPagePrincipal);
  Application.CreateForm(TfrmPageCliente, frmPageCliente);
  Application.CreateForm(TDMFireDAC, DMFireDAC);
  Application.Run;
end.
