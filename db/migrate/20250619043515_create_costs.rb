class CreateCosts < ActiveRecord::Migration[6.1]
  def change
    create_table :costs do |t|
      t.string :txtDescricao
      t.string :txtFornecedor
      t.string :txtCNPJCPF
      t.datetime :datEmissao
      t.decimal :vlrLiquido
      t.string :urlDocumento
      t.belongs_to :deputy, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
