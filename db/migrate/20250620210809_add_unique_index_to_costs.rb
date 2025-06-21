class AddUniqueIndexToCosts < ActiveRecord::Migration[6.1]
  def change
    add_index :costs, [:txtDescricao, :txtFornecedor, :txtCNPJCPF, :datEmissao, :vlrLiquido, :urlDocumento, :deputy_id],
              unique: true,
              name: 'index_unique_costs_per_fields'
  end
end
