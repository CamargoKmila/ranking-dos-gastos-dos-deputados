class Deputy < ApplicationRecord
  has_many :costs, dependent: :destroy
  
  validates :txNomeParlamentar, presence: true
  validates :sgPartido, presence: true
  validates :sgUF, presence: true
end
