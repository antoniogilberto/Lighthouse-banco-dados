---CRIANDO A TABELA PRODUTO---

CREATE TABLE produto (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    marca VARCHAR(50),
    preco DECIMAL(10,2)
);


--- BUSCANDO A TABELA CRIADA---

SELECT * FROM Produto



---- INSERINDO VALORES DENTRO DA TABELA

INSERT INTO produto (nome, marca, preco) VALUES
('Camiseta', 'Adidas', 59.90),
('Calça Jeans', 'Levis', 149.90),
('Tênis', 'Nike', 299.90),
('Bermuda', 'Polo Ralph Lauren', 129.90),
('Vestido', 'Zara', 89.90),
('Sapato Social', 'Calvin Klein', 199.90),
('Blusa de Frio', 'The North Face', 349.90),
('Jaqueta Jeans', 'Tommy Hilfiger', 279.90),
('Saia', 'H&M', 69.90),
('Chinelo', 'Havaianas', 29.90);



--- CRIANDO UMA NOVA TABELA PEDIDOS---

CREATE TABLE Pedidos (
ID_pedido PRIMARY KEY,
Pedido_qtd INT,
Data_pedido DATE NOT NULL,
Endereço_cliente VARCHAR(50)
);



