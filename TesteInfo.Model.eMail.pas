unit TesteInfo.Model.eMail;

interface


uses
  IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase,Vcl.StdCtrls, System.SysUtils, Vcl.Dialogs,
  System.UITypes, System.Classes;

type
  ISendMail = interface
    ['{212C9172-D02B-4471-B259-5E0AAF386DE8}']
    function FromAddress(AValue: string): ISendMail;
    function FromName(AValue: string): ISendMail;
    function ReplyToAddress(AValue: string): ISendMail;
    function RecipientsAddress(AValue: string): ISendMail;
    function Subject(AValue: string): ISendMail;
    function AddBody(AValue: string): ISendMail;
    function Attachment(AValue: string): ISendMail;
    function Send: ISendMail;
  end;

  TModelEmail = class(TInterfacedObject, ISendMail)
  private
    FFromAddress: string;
    FFromName: string;
    FReplyToAddress: string;
    FRecipientsAddress: string;
    FBody: TStringList;
    FSubject: string;
    FAttachment: string;
    FIdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    FIdSMTP: TIdSMTP;
    FIdMessage: TIdMessage;
    FIdText: TIdText;
    procedure SetMailParams;
    procedure SetMailBody;
    procedure SetMailAttachment;
  public
    constructor Create(Port: Integer; Host, UserName, Password: string);
    destructor Destroy(); override;
    class function New(Port: Integer; Host, UserName, Password: string): ISendMail;
    function FromAddress(AValue: string): ISendMail;
    function FromName(AValue: string): ISendMail;
    function ReplyToAddress(AValue: string): ISendMail;
    function RecipientsAddress(AValue: string): ISendMail;
    function Subject(AValue: string): ISendMail;
    function AddBody(AValue: string): ISendMail;
    function Attachment(AValue: string): ISendMail;
    function Send: ISendMail;
  end;

implementation

{ TUtils4DeMail }

function TModelEmail.Attachment(AValue: string): ISendMail;
begin
  Result := Self;
  FAttachment := AValue;
end;

function TModelEmail.AddBody(AValue: string): ISendMail;
begin
  Result := Self;
  FBody.Append(AValue);
end;

constructor TModelEmail.Create(Port: Integer; Host, UserName,
  Password: string);
begin
  FIdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FIdSMTP := TIdSMTP.Create(nil);
  FIdMessage := TIdMessage.Create(nil);
  FBody := TStringLIst.Create;

  FIdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
  FIdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

  FIdSMTP.IOHandler := FIdSSLIOHandlerSocket;
  FIdSMTP.UseTLS := utUseImplicitTLS;
  FIdSMTP.AuthType := satDefault;
  FIdSMTP.Port := Port;
  FIdSMTP.Host := Host;
  FIdSMTP.UserName := UserName;
  FIdSMTP.Password := Password;
end;

destructor TModelEmail.Destroy;
begin
  FreeAndNil(FIdSSLIOHandlerSocket);
  FreeAndNil(FIdSMTP);
  FreeAndNil(FIdMessage);

  inherited;
end;

function TModelEmail.FromAddress(AValue: string): ISendMail;
begin
  Result := Self;
  FFromAddress := AValue;
end;

function TModelEmail.FromName(AValue: string): ISendMail;
begin
  Result := Self;
  FFromName := AValue;
end;

class function TModelEmail.New(Port: Integer; Host, UserName,
  Password: string): ISendMail;
begin
  Result := Self.Create(Port, Host, UserName, Password);
end;

function TModelEmail.RecipientsAddress(AValue: string): ISendMail;
begin
  Result := Self;
  FRecipientsAddress := AValue;
end;

function TModelEmail.ReplyToAddress(AValue: string): ISendMail;
begin
  Result := Self;
  FReplyToAddress := AValue;
end;

function TModelEmail.Send: ISendMail;
begin
  Result := Self;
  SetMailParams;
  SetMailBody;
  SetMailAttachment;

  FIdSMTP.Connect;
  try
    FIdSMTP.Authenticate;
    FIdSMTP.Send(FIdMessage);
  finally
    FIdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
  end;
end;

procedure TModelEmail.SetMailAttachment;
begin
  if FileExists(FAttachment) then
    TIdAttachmentFile.Create(FIdMessage.MessageParts, FAttachment);
end;

procedure TModelEmail.SetMailBody;
begin
  if Trim(FBody.Text) = '' then
    raise Exception.Create('Corpo da Mensagem Vazio');

  FIdText := TIdText.Create(FIdMessage.MessageParts);
  FIdText.Body.Assign(FBody);
  FIdText.ContentType := 'text/html; charset=utf-8';
end;

procedure TModelEmail.SetMailParams;
begin
  if Trim(FReplyToAddress) = '' then
    raise Exception.Create('Sem destinatario.');

  if Trim(FSubject) = '' then
    raise Exception.Create('Sem assunto.');

  FIdMessage.From.Address := FFromAddress;
  FIdMessage.From.Name := FFromName;
  FIdMessage.ReplyTo.EMailAddresses := FReplyToAddress;
  FIdMessage.Recipients.Add.Text := FRecipientsAddress;
  FIdMessage.Subject := FSubject;
  FIdMessage.Encoding := meMIME;
end;

function TModelEmail.Subject(AValue: string): ISendMail;
begin
  Result := Self;
  FSubject := AValue;
end;

end.
