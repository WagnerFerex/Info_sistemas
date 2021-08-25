unit TesteInfo.Model.Utils;

interface

  function iif(Condicao: Boolean; Valor1, Valor2: Variant): Variant;

implementation

function iif(Condicao: Boolean; Valor1, Valor2: Variant): Variant;
begin
  if Condicao then
    Result := Valor1
  else
    Result := Valor2;
end;

end.
