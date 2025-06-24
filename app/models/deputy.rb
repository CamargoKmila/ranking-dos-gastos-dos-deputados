class Deputy < ApplicationRecord
  has_many :costs, dependent: :destroy
  
  validates :txNomeParlamentar, presence: true
  validates :sgPartido, presence: true
  validates :sgUF, presence: true

  def photo_url
    "https://www.camara.leg.br/internet/deputado/bandep/#{ideCadastro}.jpg"
  end
end
