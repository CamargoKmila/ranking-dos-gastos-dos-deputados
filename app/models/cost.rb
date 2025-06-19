class Cost < ApplicationRecord
  belongs_to :deputy

  validates :vlrLiquido, numericality: true, allow_nil: true
  validates :datEmissao, presence: true

  def self.total_cost
    sum(:vlrLiquido)
  end

  def self.max_cost
    order(vlrLiquido: :desc).first
  end
end
