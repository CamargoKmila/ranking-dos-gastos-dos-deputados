# Ranking dos Gastos dos Deputados

Projeto desenvolvido em Ruby on Rails para importação, armazenamento e exibição dos gastos parlamentares de deputados federais, com foco inicial no estado de São Paulo (UF: SP).

---

## ✨ Funcionalidades principais

- Importação de dados via upload de arquivos CSV.
- Filtro automático para importar apenas deputados da UF **SP**.
- Prevenção de duplicidade de registros de deputados e gastos.
- Cadastro de gastos vinculados aos deputados.
- Exibição dos dados para acompanhamento e análise.

---

## 📂 Tecnologias utilizadas

- **Ruby** 3.0.4
- **Rails** 6.1.x
- **PostgreSQL**
- **RSpec** 
- **Webpacker**

---

## ✅ Setup do projeto (Local)

### Pré-requisitos:

- Ruby 3.0.4
- PostgreSQL
- Node.js e Yarn (para o Webpacker)

### Passos:

#### Clone o repositório
```bash
git clone git@github.com:CamargoKmila/ranking-dos-gastos-dos-deputados.git
```

#### Instale as dependências Ruby
```bash
bundle install
```

#### Instale as dependências JS
```bash
yarn install --check-files
```

#### Crie e configure o banco de dados
```bash
rails db:create
rails db:migrate
```
#### (Opcional) Popular com dados de exemplo
```bash
rails db:seed
```

### 🚀 Como rodar o servidor localmente:
```bash
rails s
```
#### Acesse no navegador:
```http://localhost:3000```

## 📝 Upload de CSV

### Acesso via navegador:
```http://localhost:3000/dashboard/upload```

#### Upload de arquivo:
Na tela de upload, selecione o arquivo CSV contendo os dados de deputados e seus respectivos gastos.

#### 💡 Importante:
O sistema atualmente só processa linhas com UF = SP.
Arquivos fora do formato CSV são rejeitados.

## ⚙️ Regras de validação na importação:
- **Deputados** são identificados de forma única pelos campos:
`txNomeParlamentar`, `ideCadastro`, `cpf`, `nuCarteiraParlamentar`, `sgUF`, `sgPartido`

- **Gastos (Costs)** são identificados de forma única por:
`txtDescricao`, `txtFornecedor`, `txtCNPJCPF`, `datEmissao`, `vlrLiquido`, `urlDocumento`, `deputy_id`

- **Erros de validação (como datas inválidas ou registros duplicados) são tratados individualmente por linha e registrados na execução.

## ✅ Como rodar os testes:
```bash
bundle exec rspec
```
