# Aula Lighthouse Banco de Dados

# Configurando o ambiente

Como pré-requisitos para realizar esse exemplo você precisa de um ambiente virtual Python instalado. Depois rode:

```
pip install -r requirements.txt
```

# Instruções

## Criando uma instância de PostgreSQL

Para podermos realizar os exemplos dessa aula precisamos ter uma instância do PostgreSQL online, nosso servidor de banco de dados. Você pode levantar uma instância localmente utilizando o docker:

```
docker run --name aula-postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -d postgres
```

Ou subir uma instância na nuvem, por exemplo através do [Google Cloud Platform](https://console.cloud.google.com/sql/instances/create;engine=PostgreSQL?).

Para poder acessar à instância do Google SQL você precisará configurar uma Rede para seu IP (201.xx.xxx.xxx) ou pública (0.0.0.0/0).


## Conectando ao Banco de Dados

Há inúmeras formas de se conectar a um banco de dados. As mais comuns são utilizando a linha de comando ou um cliente SQL. Cada linguagem de programação também tem suas próprias bibliotecas para interface com os bancos de dados em geral.

### Usando o psql

Para conectar-se a sua instância use:

```
psql -U postgres -h localhost -p 5432
psql (13.5 (Ubuntu 13.5-0ubuntu0.21.04.1), server 14.5 (Debian 14.5-1.pgdg110+1))
WARNING: psql major version 13, server major version 14.
         Some psql features might not work.
Type "help" for help.

postgres=# 
```

### Usando dbeaver

O dbeaver é um cliente SQL gratuito e de código aberto muito utilizado. Siga  as instruções de instalação para seu sistema operacional neste [link](https://dbeaver.io/download/).

Para se conectar ao banco de dados, clique em Nova Conexão/Postgres e adicione as credenciais.

## Criando um database

Após conectar ao servidor de banco de dados, precisamos criar nosso primeiro banco de dados em si: 

```
create database my_company;
CREATE DATABASE
```

Para se conectar a esse banco de dados, usamos o seguinte comando:

```
\c my_company
You are now connected to database "my_company" as user "postgres".
```

## Criando nossa primeira tabela

Por enquanto nosso banco de dados está vazio. Vamos criar nossa primeira tabela, que vai armazenar nossos dados de clientes:

```
CREATE TABLE clientes
 (id INTEGER PRIMARY KEY
 , nome_cliente VARCHAR(10)
 , cidade VARCHAR(10)
 , uf VARCHAR(2)
 );
```

Podemos verificar que nossa tabela foi criada através da seguinte operação do psql:

```
my_company=# \d
          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | clientes | table | postgres
(1 row)
```

## Adicionando dados à tabela

Para adicionar dados a uma tabela, usamos o comando INSERT. Por exemplo, o código abaixo cria 2 novos clientes no banco de dados:

```
INSERT INTO clientes (id, nome_cliente, cidade)
VALUES 
  (1, 'joão', 'SC'),
  (2, 'maria', 'SP');
```

Mas o que aconteceria se tentássemos adicionar um novo cliente com o ID 1, que já existe no banco de dados?

```
INSERT INTO clientes (id, nome_cliente, cidade)
VALUES 
  (1, 'daniel', 'RJ');
ERROR:  duplicate key value violates unique constraint "clientes_pkey"
DETAIL:  Key (id)=(1) already exists.
```

Como ID é uma chave primária da tabela clientes, o banco de dados não permite adicionar um dado duplicado. É a chamada propriedade de Consistência do modelo ACID.

## Criando uma tabela com chave estrangeira

Agora vamos criar uma nova tabela para armazenar os pedidos para nossa loja. Sabemos que não podemos ter um pedido sem um cliente, então dizemos ao banco de dados que a coluna id_cliente precisa existir na tabela clientes:

```
create table pedidos (
id int primary key generated always as identity, 
codigo_pedido int,
id_cliente int,
constraint fk_customer
  foreign key(id_cliente) 
  references clientes(id)
)
```

Antes de adicionar alguns pedidos, notamos que esquecemos da coluna de Valor do Pedido. Mas como fazemos para adicioná-la? Para isso usaremos o comando `ALTER TABLE` do SQL:

```
alter table pedidos 
add column valor_pedido numeric;
```

Findalmente podemos registrar alguns pedidos:

```
INSERT INTO pedidos (codigo_pedido, id_cliente, valor_pedido)
VALUES 
  (1001, 1, 10.20),
  (1002, 1, 35.43);
```

Imagine agora que nosso sistema registra um novo pedido para o cliente de código 5. O que aconteceria?

```
INSERT INTO pedidos (codigo_pedido, id_cliente, valor_pedido)
VALUES 
  (1003, 5, 10.20)
db error: ERROR: insert or update on table "pedidos" violates foreign key constraint "fk_customer" DETAIL: Key (id_cliente)=(5) is not present in table "clientes
```

Como o cliente 5 não existe na tabela `clientes` nossa restrição de chave estrangeira não permite inserir esse novo pedido e retorna um erro!

## Subindo um database inteiro ao banco

Agora que entendemos o básico de DDL em SQL, vamos subir um banco de dados completo em nosso banco. Para isso vamos criar um novo `database` chamado *northwind* para armazenar nossos dados:

```
postgres# create database northwind;
```

E subir o banco de dados através do terminal:

```
cat northwind.sql | psql -U postgres -h localhost -p 5432 -d northwind
```

# TO DO

- [] Criar uma tabela Produto com as colunas (ID, Nome, Marca, Preço)
- [] Adicionar 10 produtos na tabela Produto
- [] Adicionar uma tabela Pedido Item que relacione Pedidos e Produtos através de chaves estrangeiras
- [] Adicionar 5 pedidos com pelo menos 1 item em cada pedido.
- [] Criar um índice na tabela pedidos para a coluna ID


