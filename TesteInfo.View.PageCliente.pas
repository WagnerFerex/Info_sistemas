unit TesteInfo.View.PageCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  eSituacao = (stList, stCrud, stDel);
  TfrmPageCliente = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    pcPrincipal: TPageControl;
    tsPageListagem: TTabSheet;
    tsPageCadastro: TTabSheet;
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnSair: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnNovo: TSpeedButton;
    Panel3: TPanel;
    dbgListagem: TDBGrid;
    ButtonedEdit1: TButtonedEdit;
    BitBtn1: TBitBtn;
    btnCancelar: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtCEP: TEdit;
    SpeedButton7: TSpeedButton;
    Label2: TLabel;
    edtLogradouro: TEdit;
    Label3: TLabel;
    edtComplemento: TEdit;
    Label4: TLabel;
    edtCidade: TEdit;
    edtUF: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtBairro: TEdit;
    edtNumero: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtNome: TDBEdit;
    Label9: TLabel;
    edtIdentidade: TDBEdit;
    Label10: TLabel;
    edtCPF: TDBEdit;
    Label11: TLabel;
    edtTelefone: TDBEdit;
    Label12: TLabel;
    edtEmail: TDBEdit;
    edtPais: TEdit;
    Label13: TLabel;
    dsrCLIENTE: TDataSource;
    procedure dsrCLIENTEStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    FSituacao: eSituacao;
    FDataSet: TDataSet;
    procedure EnviarEmail();
    procedure HabDesEndereco(Logradouro, Complemento, Localidade, UF, Bairro: string);
    procedure SetSituacao(const Value: eSituacao);
    property Situacao: eSituacao read FSituacao write SetSituacao;
  public
    { Public declarations }
  end;

var
  frmPageCliente: TfrmPageCliente;

implementation

{$R *.dfm}

uses
  System.MaskUtils,
  System.StrUtils,
  TesteInfo.Model.ViaCEP,
  TesteInfo.Model.eMail,
  TesteInfo.Model.Utils, TesteInfo.Model.DMFireDAC;


procedure TfrmPageCliente.btnCancelarClick(Sender: TObject);
begin
  FDataSet.Cancel;
  Situacao := stList;
end;

procedure TfrmPageCliente.btnEditarClick(Sender: TObject);
begin
  FDataSet.Edit;
  Situacao := stCrud;
end;

procedure TfrmPageCliente.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Deseja excluir o registro?'),
    'Confirmação - InfoSistemas', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) <> idYes
  then
    Exit;

  if not FDataSet.IsEmpty then
    FDataSet.Delete;
end;

procedure TfrmPageCliente.btnNovoClick(Sender: TObject);
begin
  FDataSet.Append;
  Situacao := stCrud;
end;

procedure TfrmPageCliente.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmPageCliente.btnSalvarClick(Sender: TObject);
begin
  try
    FDataSet.FieldByName('CEP').Value         := NotNULL(edtCEP.Text, 'Informe o CEP');
    FDataSet.FieldByName('Logradouro').Value  := NotNULL(edtLogradouro.Text, 'Informe o Logradouro');
    FDataSet.FieldByName('Numero').Value      := NotNULL(edtNumero.Text, 'Informe o Número');
    FDataSet.FieldByName('Complemento').Value := Trim(edtComplemento.Text);
    FDataSet.FieldByName('Bairro').Value      := NotNULL(edtBairro.Text, );
    FDataSet.FieldByName('Cidade').Value      := NotNULL(edtCidade.Text);
    FDataSet.FieldByName('Estado').Value      := NotNULL(edtUF.Text);
    FDataSet.FieldByName('Pais').Value        := NotNULL(edtPais.Text);
    FDataSet.Post;
    Situacao := stList;
    HabDesEndereco('', '', '', '', '');

    GerarXML(FDataSet);
    EnviarEmail();

  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'TesteInfo - Informação!', MB_ICONINFORMATION);
  end;
end;

procedure TfrmPageCliente.dsrCLIENTEStateChange(Sender: TObject);
begin
  case FDataSet.State of
    dsInactive: ;
    dsBrowse: ;
    dsEdit: ;
    dsInsert: ;
    dsSetKey: ;
    dsCalcFields: ;
    dsFilter: ;
    dsNewValue: ;
    dsOldValue: ;
    dsCurValue: ;
    dsBlockRead: ;
    dsInternalCalc: ;
    dsOpening: ;
  end;

  btnNovo.Enabled     := (FDataSet.State in [dsBrowse]);
  btnEditar.Enabled   := (FDataSet.State in [dsBrowse]) and (not dsrCLIENTE.DataSet.IsEmpty);
  btnExcluir.Enabled  := (FDataSet.State in [dsBrowse]) and (not dsrCLIENTE.DataSet.IsEmpty);
  btnSalvar.Enabled   := (FDataSet.State in [dsInsert, dsEdit]) and (not dsrCLIENTE.DataSet.IsEmpty);
  btnCancelar.Enabled := (FDataSet.State in [dsInsert, dsEdit]) and (not dsrCLIENTE.DataSet.IsEmpty);
end;

procedure TfrmPageCliente.EnviarEmail;
begin
  TModelEmail
    .New(465, 'smtp.gmail.com', 'exampleemail@empresa.com', 'password')
    .Subject('Cadastro de Cliente InfoSistemas')
    .FromName('TESTE INFOSISTEMAS')
    .FromAddress('sistemadelphi16122020@gmail.com')         // remetente
    .ReplyToAddress('sistemadelphi16122020@gmail.com')      // destinatário
    .Attachment(ExtractFileDir(ParamStr(0))+'\cliente.xml') // Anexo

    .AddBody('<html><head><meta content=''text/html; charset=iso-8859-1'' http-equiv=''Content-Type'' />')
    .AddBody('<title>EMAIL AUTOMATICO - Cliente '+ '<NOMECLIENTE>' +'</title> </head>')
    .AddBody('<body bgcolor=''#FFFFFF''>')
    .AddBody('<p><b> Nome : </b>' + '<NOME_CLIENTE>')
    .AddBody('<p><b> CPF : </b>' + FormatMaskText('999.999.999-99;0;_', '<CPF_CLIENTE>'))
    .AddBody('<p><b> Identidade : </b>' + '<RG_CLIENTE>')
    .AddBody('<p><b> DDD : </b>' + '<DDD>')
    .AddBody('<p><b> Telefone : </b>' + FormatMaskText('99999-9999;0;_', '<TELEFONE>'))
    .AddBody('<p><b> E-mail : </b>' + '<EMAIL>')
    .AddBody('<p><b> CEP : </b>' + FormatMaskText('99.999-999;0;_', '<CEP>'))
    .AddBody('<p><b> Logradouro : </b>' + '<LOGRADOURO>')
    .AddBody('<p><b> Número : </b>' + 'NUMERO')
    .AddBody('<p><b> Complemento : </b>' + 'COMPLEMENTO')
    .AddBody('<p><b> Bairro : </b>' + '<BAIRRO>')
    .AddBody('<p><b> Cidade : </b>' + 'CIDADE')
    .AddBody('<p><b> Estado : </b>' + 'ESTADO')
    .AddBody('<p><b> País : </b>' + 'PAIS')
    .AddBody('</body></html>').Send;
end;

procedure TfrmPageCliente.FormShow(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsPageListagem;
  FDataSet := dsrCLIENTE.DataSet;
  FDataSet.Open;
end;

procedure TfrmPageCliente.HabDesEndereco(Logradouro, Complemento, Localidade, UF, Bairro: string);
begin
  edtLogradouro.Enabled := Trim(Logradouro).IsEmpty;
  edtLogradouro.Text    := IfThen(Logradouro <> '', Trim(Logradouro));
  edtLogradouro.Color   := iif(Logradouro <> '', clBtnFace, clWhite);

  edtComplemento.Enabled := Trim(Complemento).IsEmpty;
  edtComplemento.Text    := IfThen(Complemento <> '', Trim(Complemento));
  edtComplemento.Color   := iif(Complemento <> '', clBtnFace, clWhite);

  edtCidade.Enabled := Trim(Localidade).IsEmpty;
  edtCidade.Text    := IfThen(Localidade <> '', Trim(Localidade));
  edtCidade.Color   := iif(Localidade <> '', clBtnFace, clWhite);

  edtUF.Enabled := Trim(UF).IsEmpty;
  edtUF.Text    := IfThen(UF <> '', Trim(UF));
  edtUF.Color   := iif(UF <> '', clBtnFace, clWhite);

  edtBairro.Enabled := Trim(Bairro).IsEmpty;
  edtBairro.Text    := IfThen(Bairro <> '', Trim(Bairro));
  edtBairro.Color   := iif(Bairro <> '', clBtnFace, clWhite);
end;

procedure TfrmPageCliente.SetSituacao(const Value: eSituacao);
begin
  FSituacao := Value;
  case FSituacao of
    stList: pcPrincipal.ActivePage := tsPageListagem;
    stCrud: pcPrincipal.ActivePage := tsPageCadastro;
    stDel: ;
  end;
end;

procedure TfrmPageCliente.SpeedButton7Click(Sender: TObject);
var
  Result: IBuscaCEP;

begin
  try
    Result := TModelViaCEP.New.Buscar(edtCEP.Text);
    HabDesEndereco(
      Result.Logradouro,
      Result.Complemento,
      Result.Localidade,
      Result.UF,
      Result.Bairro);
  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'TesteInfo - Informação!', MB_ICONINFORMATION);
  end;
end;

end.
