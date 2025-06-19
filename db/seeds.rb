deputado1 = Deputy.find_or_create_by!(ideCadastro: 1) do |d|
  d.txNomeParlamentar = "Deputado Teste 1"
  d.nuCarteiraParlamentar = "123"
  d.cpf = "00000000000"
  d.sgUF = "SP"
  d.sgPartido = "ABC"
end

deputado2 = Deputy.find_or_create_by!(ideCadastro: 2) do |d|
  d.txNomeParlamentar = "Deputado Teste 2"
  d.nuCarteiraParlamentar = "456"
  d.cpf = "11111111111"
  d.sgUF = "RJ"
  d.sgPartido = "DEF"
end

Cost.create!(
  txtDescricao: "Material de Escritório",
  txtFornecedor: "Fornecedor Exemplo",
  txtCNPJCPF: "12345678000199",
  datEmissao: DateTime.now - 10.days,
  vlrLiquido: 150.75,
  urlDocumento: "http://example.com/doc1.pdf",
  deputy: deputado1
)

Cost.create!(
  txtDescricao: "Serviço de Limpeza",
  txtFornecedor: "Fornecedor Limpeza",
  txtCNPJCPF: "98765432000155",
  datEmissao: DateTime.now - 5.days,
  vlrLiquido: 300.00,
  urlDocumento: "http://example.com/doc2.pdf",
  deputy: deputado1
)

Cost.create!(
  txtDescricao: "Transporte",
  txtFornecedor: "Fornecedor Transporte",
  txtCNPJCPF: "19283746500011",
  datEmissao: DateTime.now - 3.days,
  vlrLiquido: 120.00,
  urlDocumento: "http://example.com/doc3.pdf",
  deputy: deputado2
)

puts "Deputies count: #{Deputy.count}"
puts "Costs count: #{Cost.count}"
