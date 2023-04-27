-- Criação do Database
CREATE DATABASE my_company;




-- Criação da tabela Produto
CREATE TABLE Produto(
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(60),
    Marca VARCHAR(60),
    Preco Float(10)
);


-- Adição de 10 produtos na tabela Produto
INSERT INTO Produto (Nome, Marca, Preco) VALUES
    ('Chai', 'Shein', 100),
    ('Chang', 'Marisa', 17),
    ('Aniseed Syrup', 'Shein', 20.5),
    ('Chef Anton''s Cajun Seasoning', 'Riachuelo', 2.35006),
    ('Chef Anton''s Gumbo Mix', 'Riachuelo', 150.75),
    ('Grandma''s Boysenberry Spread', 'C&A', 26.7),
    ('Uncle Bob''s Organic Dried Pears', 'C&A', 70),
    ('Northwoods Cranberry Sauce', 'Renner', 2),
    ('Mishi Kobe Niku', 'Renner', 60.50001),
    ('Ikura', 'Marisa', 8);



--

CREATE TABLE pedidos (
    ID SERIAL PRIMARY KEY, 
    DataPedido DATE, 
    NomeDestinatario VARCHAR(60), 
    EnderecoDestinatario VARCHAR(60),
);


CREATE TABLE PedidoItem (
    ID SERIAL PRIMARY KEY,
    id_pedido INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES Pedidos (ID),
  FOREIGN KEY (id_produto) REFERENCES Produto (ID)
);

 



INSERT INTO Pedidos (DataPedido, NomeDestinatario, EnderecoDestinatario) VALUES
  ('2023-04-25', 'João', 'Rua A'),
  ('2023-04-24', 'Maria', 'Rua B'),
  ('2023-04-23', 'José', 'Rua C'),
  ('2023-04-22', 'Antônio', 'Rua D'),
  ('2023-04-21', 'Sandra', 'Rua E');

 


INSERT INTO PedidoItem (id_pedido, id_produto) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);



CREATE INDEX idx_pedidos_id ON Pedidos (id);