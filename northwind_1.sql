--- CRIANDO O BANCO DE DADOS
CREATE DATABASE meu_projeto_lighthouse

---CRIANDO A TABELA PRODUTO---

CREATE TABLE produto (
    id INT SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    marca VARCHAR(50),
    preco DECIMAL(10,2) 
);


--- BUSCANDO A TABELA CRIADA---

SELECT * FROM Produto



---- INSERINDO VALORES DENTRO DA TABELA

INSERT INTO produto (id, nome, marca, preco) VALUES
(1,'Camiseta', 'Adidas', 59.90),
(2,'Calça Jeans', 'Levis', 149.90),
(3,'Tênis', 'Nike', 299.90),
(4,'Bermuda', 'Polo Ralph Lauren', 129.90),
(5,'Vestido', 'Zara', 89.90),
(6,'Sapato Social', 'Calvin Klein', 199.90),
(7,'Blusa de Frio', 'The North Face', 349.90),
(8,'Jaqueta Jeans', 'Tommy Hilfiger', 279.90),
(9,'Saia', 'H&M', 69.90),
(10,'Chinelo', 'Havaianas', 29.90);



--- CRIANDO UMA NOVA TABELA PEDIDOS---

CREATE TABLE Pedidos (
ID INT SERIAL PRIMARY KEY,
Pedido_qtd INT,
Data_pedido DATE NOT NULL,
Endereço_cliente VARCHAR(50)
);


CREATE TABLE Pedidos_item (
ID INT SERIAL PRIMARY KEY,
Id_pedido INT NOT NULL,
Id_produto INT NOT NULL
FOREIGN KEY (Id_pedido) REFERENCES Pedidos (ID),
FOREIGN KEY (Id_produto) REFERENCES Produto (ID)

)
