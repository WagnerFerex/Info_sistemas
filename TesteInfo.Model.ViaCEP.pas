unit TesteInfo.Model.ViaCEP;

interface

uses
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.StdCtrls, System.JSON;

type
  IBuscaCEP = interface
    ['{E8EB9439-0C3E-4795-9893-A092C4FA18D2}']
    function CEP: string;
    function Logradouro: string;
    function Complemento: string;
    function Bairro: string;
    function Localidade: string;
    function UF: string;
    function IBGE: string;
    function GIA: string;
    function DDD: string;
    function Siafi: string;
    function Buscar(CEP: string): IBuscaCEP;
  end;

  TModelViaCEP = class(TInterfacedObject, IBuscaCEP)
  private
    FIdHTTP: TIdHTTP;
    FIdSSL: TIdSSLIOHandlerSocketOpenSSL;
    FJson: TJSONObject;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IBuscaCEP;
    function CEP: string;
    function Logradouro: string;
    function Complemento: string;
    function Bairro: string;
    function Localidade: string;
    function UF: string;
    function IBGE: string;
    function GIA: string;
    function DDD: string;
    function Siafi: string;
    function Buscar(CEP: string): IBuscaCEP;
  end;


implementation

uses
  System.Classes, System.SysUtils;

{ TViaCEPService }

function TModelViaCEP.CEP: string;
begin
  Result := FJson.GetValue<string>('cep');
end;

function TModelViaCEP.Complemento: string;
begin
  Result := FJson.GetValue<string>('complemento');
end;

constructor TModelViaCEP.Create;
begin
  FIdSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP := TIdHTTP.Create;
  FIdHTTP.IOHandler := FIdSSL;
end;

function TModelViaCEP.DDD: string;
begin
  Result := FJson.GetValue<string>('ddd');
end;

destructor TModelViaCEP.Destroy;
begin
  FreeAndNil(FIdHTTP);
  FreeAndNil(FIdSSL);
  if Assigned(FJson) then
    FreeAndNil(FJson);
  inherited;
end;

function TModelViaCEP.Bairro: string;
begin
  Result := FJson.GetValue<string>('bairro');
end;

function TModelViaCEP.GIA: string;
begin
  Result := FJson.GetValue<string>('gia');
end;

function TModelViaCEP.IBGE: string;
begin
  Result := FJson.GetValue<string>('ibge');
end;

function TModelViaCEP.Localidade: string;
begin
  Result := FJson.GetValue<string>('localidade');
end;

function TModelViaCEP.Logradouro: string;
begin
  Result := FJson.GetValue<string>('logradouro');
end;

function TModelViaCEP.Buscar(CEP: string): IBuscaCEP;
var
  LResult: TStringStream;

begin
  Result := Self;
  LResult := TStringStream.Create;
  try
    try

      FIdHTTP.Get(Format('http://viacep.com.br/ws/%s/json/', [CEP]), LResult);
    except on E: Exception do
      raise Exception.Create('Não foi possível consultar o CEP, tente novamente.');
    end;

    if (FIdHTTP.ResponseCode <> 200) then
      raise Exception.Create(FIdHTTP.ResponseText);

    FJson := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(UTF8ToString(LResult.DataString)), 0) as TJSONObject;
  finally
    LResult.DisposeOf;
  end;
end;

class function TModelViaCEP.New: IBuscaCEP;
begin
  Result := Self.Create;
end;

function TModelViaCEP.Siafi: string;
begin
  Result := FJson.GetValue<string>('siafi');
end;

function TModelViaCEP.UF: string;
begin
  Result := FJson.GetValue<string>('uf');
end;

end.
