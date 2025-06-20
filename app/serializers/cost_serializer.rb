class CostSerializer
  include JSONAPI::Serializer

  attributes :id, :txtDescricao, :txtFornecedor, :txtCNPJCPF, :datEmissao, :vlrLiquido, :urlDocumento
end
