
-- Criação da tabela Produto
CREATE TABLE Produto(
    ID INT PRIMARY KEY,
    Nome VARCHAR(60),
    Marca VARCHAR(60),
    Preco Float(10)
);




-- Adição de 10 produtos na tabela Produto
INSERT INTO Produto (ID, Nome, Marca, Preco) VALUES
(1,'Camiseta masculina', 'Nike', 59.90),
(2,'Camiseta feminina', 'Adidas', 49.99),
(3,'Camiseta polo masculina', 'Lacoste', 129.90),
(4,'Camiseta polo feminina', 'Tommy Hilfiger', 169.99),
(5,'Calça jeans masculina', 'Levi''s', 189.90),
(6,'Calça jeans feminina', 'Calvin Klein', 219.99),
(7,'Blazer masculino', 'Armani', 899.90),
(8,'Blazer feminino', 'Chanel', 1499.99),
(9,'Vestido de festa', 'Dolce & Gabbana', 2999.99),
(10,'Sapato social masculino', 'Gucci', 999.90);


--- VERIFICANDO A TABELA E OS PRODUTOS ADICIONADOS

  select * from produto;
 
 
 
   
---  CRIANDO A TABELA PEDIDOS

CREATE TABLE pedidos (
    ID SERIAL PRIMARY KEY, 
    Data_Pedido DATE, 
    Nome VARCHAR(60), 
    Endereco VARCHAR(60)
);


---  CRIANDO A TABELA PEDIDOSITEM

CREATE TABLE PedidoItem (
    ID SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES Pedidos (ID),
  FOREIGN KEY (id_produto) REFERENCES Produto (ID)
);

 

--- INSERINDO VALORES

INSERT INTO Pedidos (Data_Pedido, Nome, Endereco) VALUES
  ('2023-04-25', 'Jessica', 'Rua Francisco Vasconcelos'),
  ('2023-04-24', 'Gil', 'Rua Beija Flor'),
  ('2023-04-23', 'Neide', 'Rua Girassol'),
  ('2023-04-22', 'Antônio', 'Rua Jardim'),
  ('2023-04-21', 'Bea', 'Rua Flor');

 


INSERT INTO PedidoItem (id_pedido, id_produto) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);



CREATE INDEX idx_pedidos_id ON Pedidos (id);