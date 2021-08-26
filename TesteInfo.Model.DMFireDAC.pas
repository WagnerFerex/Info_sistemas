unit TesteInfo.Model.DMFireDAC;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Web.HTTPApp, Web.DBWeb;

type
  TDMFireDAC = class(TDataModule)
    mtbCLIENTE: TFDMemTable;
    mtbCLIENTENome: TStringField;
    mtbCLIENTEIdentidade: TStringField;
    mtbCLIENTECPF: TStringField;
    mtbCLIENTETelefone: TStringField;
    mtbCLIENTEEmail: TStringField;
    mtbCLIENTECEP: TStringField;
    mtbCLIENTELogradouro: TStringField;
    mtbCLIENTENumero: TIntegerField;
    mtbCLIENTEComplemento: TStringField;
    mtbCLIENTEBairro: TStringField;
    mtbCLIENTECidade: TStringField;
    mtbCLIENTEEstado: TStringField;
    mtbCLIENTEPais: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
  DMFireDAC: TDMFireDAC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
