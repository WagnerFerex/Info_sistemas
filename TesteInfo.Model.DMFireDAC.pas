unit TesteInfo.Model.DMFireDAC;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Web.HTTPApp, Web.DBWeb, FireDAC.Stan.StorageXML;

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
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GerarXML(DataSet: TDataSet): Boolean;


var
  DMFireDAC: TDMFireDAC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function GerarXML(DataSet: TDataSet): Boolean;
var
  aDataSet: TFDMemTable;

begin
  aDataSet := TFDMemTable.Create(nil);
  try
    aDataSet.CopyFields(DataSet);
    aDataSet.CopyRecord(DataSet);
    aDataSet.SaveToFile(ExtractFileDir(ParamStr(0))+'\cliente.xml', sfXML);

//    (DataSet as TFDMemTable).SaveToFile(FileName, sfXML);
    Result := True;
  except
    Result := False;
  end;
  aDataSet.DisposeOf;
end;

end.
