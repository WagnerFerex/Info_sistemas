object DMFireDAC: TDMFireDAC
  OldCreateOrder = False
  Height = 317
  Width = 404
  object mtbCLIENTE: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 63
    Top = 30
    object mtbCLIENTENome: TStringField
      FieldName = 'Nome'
      Size = 200
    end
    object mtbCLIENTEIdentidade: TStringField
      FieldName = 'Identidade'
    end
    object mtbCLIENTECPF: TStringField
      FieldName = 'CPF'
      Size = 11
    end
    object mtbCLIENTETelefone: TStringField
      FieldName = 'Telefone'
      Size = 10
    end
    object mtbCLIENTEEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object mtbCLIENTECEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object mtbCLIENTELogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 200
    end
    object mtbCLIENTENumero: TIntegerField
      FieldName = 'Numero'
    end
    object mtbCLIENTEComplemento: TStringField
      FieldName = 'Complemento'
      Size = 50
    end
    object mtbCLIENTEBairro: TStringField
      FieldName = 'Bairro'
    end
    object mtbCLIENTECidade: TStringField
      FieldName = 'Cidade'
      Size = 50
    end
    object mtbCLIENTEEstado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object mtbCLIENTEPais: TStringField
      FieldName = 'Pais'
      Size = 10
    end
  end
end
