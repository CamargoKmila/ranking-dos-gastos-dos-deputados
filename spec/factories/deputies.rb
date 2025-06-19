FactoryBot.define do
  factory :deputy do
    txNomeParlamentar { "Deputado Exemplo" }
    ideCadastro { 1234 }
    nuCarteiraParlamentar { "123" }
    cpf { "12345678900" }
    sgUF { "SP" }
    sgPartido { "ABC" }
  end
end
