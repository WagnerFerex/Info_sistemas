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
    dsrCLIENTE: TDataSource;
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
    procedure dsrCLIENTEStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSituacao: eSituacao;
    FDataSet: TDataSet;
    procedure SetSituacao(const Value: eSituacao);
    property Situacao: eSituacao read FSituacao write SetSituacao;
  public
    { Public declarations }
  end;

var
  frmPageCliente: TfrmPageCliente;

implementation

{$R *.dfm}

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
  FDataSet.FieldByName('CEP').Value := ;
  FDataSet.FieldByName('').Value := ;
  FDataSet.FieldByName('').Value := ;
  FDataSet.FieldByName('').Value := ;
  FDataSet.FieldByName('').Value := ;
  FDataSet.FieldByName('').Value := ;
  FDataSet.Post;
  Situacao := stList;
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

procedure TfrmPageCliente.FormShow(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsPageListagem;
  FDataSet := dsrCLIENTE.DataSet;
  FDataSet.Open;
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

end.
