FactoryBot.define do
  factory :cost do
    txtDescricao { "Material de Escritório" }
    txtFornecedor { "Fornecedor Exemplo" }
    txtCNPJCPF { "12345678000199" }
    datEmissao { DateTime.now }
    vlrLiquido { 100.50 }
    urlDocumento { "http://example.com/doc.pdf" }
    deputy
  end
end
