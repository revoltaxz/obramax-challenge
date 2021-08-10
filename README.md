![Logo Obramax](https://d27vawk0lzy7cb.cloudfront.net/logo/stores/3/logo-obramax.png) 

# FreteValidate

Como executar o projeto (localmente):

  Caso utilize asdf (package manager), para instalar a versão correta execute:
  `asdf install`
  
  - Instale as dependências utilizando `mix deps.get`
  - Execute o projeto com `mix phx.server ou iex -S mix phx.server (debug mode)`
  - Estará disponível na porta 4000  

Como executar o projeto via Docker:

  Basta executar o seguinte comando:

  `docker run -p 4000:4000 revoltaxz/fretevalidate:1.0.0`

  - Estará disponivel na porta 4000
# Decisões tomadas no projeto

  Optei por utilizar o framework Phoenix com o intuito de prover uma API simples, 
para realizar a transformação do dado de acordo com as validações, com a idéia de que poderia ser utilizado 
para um painel simples para consulta (frontend) e também como um microserviço podendo ser escalado caso seja necessário.
  Em um nível arquitetural, não foi realizado a utilização do Ecto por não haver necessidade de persistir algum dado,
com isso não foi criado estruturas utilizando migrations, schemas e changeset. Todas as validações foram feitas de forma manual
inseridas em um arquivo comum (`validates.ex`), com isso ficou de forma enxuta, sendo possível visualizar as funções mais facilmente, além de ser possível adicionar novas funções de validações.
  Utilizei o formato de arquivo citado no README do teste (Exemplo de arquivo de entrada) para facilitar a visualização,
e realizando também uma validação nas chaves de cada Map para respeitar a estrutura base.
# Como funciona

  Foi realizado um endpoint apenas (POST) e nele é realizado as etapas de:

    - Validação do arquivo de entrada (Com base no inserido do teste)
    - Transformação e validação do CEP (Caso não seja enviado o CEP do tamanho correto, ocorre um erro).
    - Inicialização de um output com base no arquivo de entrada.
    - Função que possui validações dos requisitos abordados no teste:
      - price (number / integer)
      - cep (string)
      - active (boolean)
# Bibliotecas utilizadas

  Utilizei as bibliotecas:

    - {:cors_plug, "~> 2.0"} / Para comunicação externa
    - {:phoenix, "~> 1.5.10"} / Para prover todo ambiente favorável para desenvolvimento da API.

# Endpoint criado

  ## Para realizar o request basta utilizar o endpoint:

   `/validate - POST`

  ## Com o content-body:

 -  `cep: String `
 -  `price: Integer / Number`


  ## Exemplo de request
    ```
      curl --request POST \
        --url http://localhost:4000/validate \
        --header 'Content-Type: application/json' \
        --data '{
        "cep": "14783-231",
        "price": 1000
      }
    ```

## Executar frontend (Opcional)

  Foi desenvolvido um frontend para facilitar a visualização do retorno do request,
  como o teste é fullstack optei por desenvolver também este client.

  Para executar é bem simples, basta acessar a pasta client e executar:

  - `yarn install`
  - `yarn dev`
  - Pronto o projeto estará rodando na porta 3000
