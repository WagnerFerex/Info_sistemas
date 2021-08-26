unit TesteInfo.Model.Utils;

interface

  function iif(Condicao: Boolean; Valor1, Valor2: Variant): Variant;
  function NotNULL(Value: Variant; Mensagem: string): Variant;

implementation

uses
  System.Variants,
  System.SysUtils,
  Winapi.Windows,
  Vcl.Forms;


function iif(Condicao: Boolean; Valor1, Valor2: Variant): Variant;
begin
  if Condicao then
    Result := Valor1
  else
    Result := Valor2;
end;

function NotNULL(Value: Variant; Mensagem: string): Variant;
begin
  if Trim(VarToStr(Value)) = '' then
  begin
    Application.MessageBox(PChar(Mensagem), 'TesteInfo - Informação!', MB_ICONINFORMATION);
    Abort;
  end;

  Result := Value;
//    raise Exception.Create(Mensagem);
end;

end.
