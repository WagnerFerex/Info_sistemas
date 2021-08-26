program TesteInfo;

uses
  Vcl.Forms,
  TesteInfo.View.PagePrincipal in 'TesteInfo.View.PagePrincipal.pas' {frmPagePrincipal},
  TesteInfo.View.PageCliente in 'TesteInfo.View.PageCliente.pas' {frmPageCliente},
  TesteInfo.Model.DMFireDAC in 'TesteInfo.Model.DMFireDAC.pas' {DMFireDAC: TDataModule},
  TesteInfo.Model.eMail in 'TesteInfo.Model.eMail.pas',
  TesteInfo.Model.ViaCEP in 'TesteInfo.Model.ViaCEP.pas',
  TesteInfo.Model.Utils in 'TesteInfo.Model.Utils.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Cyan Dusk');
  Application.CreateForm(TDMFireDAC, DMFireDAC);
  Application.CreateForm(TfrmPagePrincipal, frmPagePrincipal);
  Application.Run;
end.
