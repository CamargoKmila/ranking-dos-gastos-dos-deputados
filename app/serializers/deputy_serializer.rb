class DeputySerializer
  include JSONAPI::Serializer

  attributes :id, :txNomeParlamentar, :ideCadastro, :nuCarteiraParlamentar, :cpf, :sgUF, :sgPartido
end
