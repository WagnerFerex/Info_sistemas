unit TesteInfo.Model.Utils;

interface

uses
  Data.DB;

  function iif(Condicao: Boolean; Valor1, Valor2: Variant): Variant;
  function EnviarEmail(ADataSet: TDataSet): Boolean;
  function GerarXML(DataSet: TDataSet): Boolean;
  function NotNULL(Value: Variant; Mensagem: string): Variant;
  function eEMail(aStr: string): Boolean;

implementation

uses
  System.Variants,
  System.SysUtils,
  Winapi.Windows,
  Vcl.Forms,
  Datasnap.DBClient,
  System.MaskUtils,
  TesteInfo.Model.eMail;


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
    raise Exception.Create(Mensagem);
    Abort;
  end;

  Result := Value;
end;

function GerarXML(DataSet: TDataSet): Boolean;
var
  aDataSet: TClientDataSet;
  I: Integer;

begin
  aDataSet := TClientDataSet.Create(nil);
  try
    aDataSet.FieldDefs.Assign(DataSet.FieldDefs);
    aDataSet.CreateDataSet;
    aDataSet.Append;

    for i :=0 to DataSet.FieldCount - 1 do
      aDataSet.Fields[i].Value := DataSet.Fields[i].Value;

    aDataSet.Post;
    aDataSet.SaveToFile(ExtractFileDir(ParamStr(0))+'\cliente.xml', dfXMLUTF8);
//    (DataSet as TFDMemTable).SaveToFile(ExtractFileDir(ParamStr(0))+'\cliente.xml', sfXML);
    Result := True;
  except
    Result := False;
  end;
  aDataSet.DisposeOf;
end;

function EnviarEmail(ADataSet: TDataSet): Boolean;
begin
  TModelEmail
    .New(465, 'smtp.gmail.com', 'sistemadelphi16122020@gmail.com', 'teste16122020*')
    .FromAddress('sistemadelphi16122020@gmail.com')         // remetente
    .FromName('TESTE INFOSISTEMAS')
//    .ReplyToAddress(ADataSet.FieldByName('Email').AsString)    // destinatário
    .RecipientsAddress(ADataSet.FieldByName('Email').AsString)               // copia
    .Subject('Cadastro de Cliente InfoSistemas')            // assunto
    .Attachment(ExtractFileDir(ParamStr(0))+'\cliente.xml') // Anexo
        .AddBody('<html><head><meta content=''text/html; charset=iso-8859-1'' http-equiv=''Content-Type'' />')
        .AddBody('<title>EMAIL AUTOMATICO - Cliente '+ ADataSet.FieldByName('Nome').AsString +'</title> </head>')
        .AddBody('<body bgcolor=''#FFFFFF''>')
        .AddBody('<p><b> Nome : </b>' +        ADataSet.FieldByName('Nome').AsString)
        .AddBody('<p><b> CPF : </b>' +         FormatMaskText('999.999.999-99;0;_', ADataSet.FieldByName('CPF').AsString))
        .AddBody('<p><b> Identidade : </b>' +  ADataSet.FieldByName('Identidade').AsString)
        .AddBody('<p><b> Telefone : </b>' +    FormatMaskText('!\(##\)####\-####;0;_', ADataSet.FieldByName('Telefone').AsString))
        .AddBody('<p><b> E-mail : </b>' +      ADataSet.FieldByName('Email').AsString)
        .AddBody('<p><b> CEP : </b>' +         FormatMaskText('#####\-###;0;_', ADataSet.FieldByName('CEP').AsString))
        .AddBody('<p><b> Logradouro : </b>' +  ADataSet.FieldByName('Logradouro').AsString)
        .AddBody('<p><b> Número : </b>' +      ADataSet.FieldByName('Numero').AsString)
        .AddBody('<p><b> Complemento : </b>' + ADataSet.FieldByName('Complemento').AsString)
        .AddBody('<p><b> Bairro : </b>' +      ADataSet.FieldByName('Bairro').AsString)
        .AddBody('<p><b> Cidade : </b>' +      ADataSet.FieldByName('Cidade').AsString)
        .AddBody('<p><b> Estado : </b>' +      ADataSet.FieldByName('Estado').AsString)
        .AddBody('<p><b> País : </b>' +        ADataSet.FieldByName('Pais').AsString)
        .AddBody('</body></html>')
    .Send;
  Result := True;
end;

function eEMail(aStr: string): Boolean;
begin
 aStr := Trim(UpperCase(aStr));
 if Pos('@', aStr) > 1 then
 begin
   Delete(aStr, 1, pos('@', aStr));
   Result := (Length(aStr) > 0) and (Pos('.', aStr) > 2);
 end
 else
   Result := False;
end;

end.
