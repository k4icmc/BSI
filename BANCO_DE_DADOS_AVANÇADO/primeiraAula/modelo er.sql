create database modelo_er;
use modelo_er;


-- CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

-- VENDEDOR
CREATE TABLE vendedor (
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100)
);

-- PRODUTO
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

-- PEDIDO
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATE,
    id_cliente INT,
    id_vendedor INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

-- ITEM_PEDIDO
CREATE TABLE item_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

-- DADOS (20+)

INSERT INTO cliente (nome,email,telefone) VALUES
('Ana','ana@email.com','1111'),
('Bruno','bruno@email.com','2222'),
('Carlos','carlos@email.com','3333'),
('Diana','diana@email.com','4444'),
('Edu','edu@email.com','5555');

INSERT INTO vendedor (nome,email) VALUES
('Vendedor 1','v1@email.com'),
('Vendedor 2','v2@email.com'),
('Vendedor 3','v3@email.com');

INSERT INTO produto (nome,preco,estoque) VALUES
('Mouse',50.00,100),
('Teclado',120.00,80),
('Monitor',900.00,30),
('Notebook',3500.00,20),
('Headset',200.00,60);

INSERT INTO pedido (data_pedido,id_cliente,id_vendedor) VALUES
('2024-10-01',1,1),
('2024-10-02',2,2),
('2024-10-03',3,1),
('2024-10-04',4,3),
('2024-10-05',5,2);

INSERT INTO item_pedido (id_pedido,id_produto,quantidade,preco_unitario) VALUES
(1,1,2,50.00),
(1,2,1,120.00),
(2,3,1,900.00),
(2,5,2,200.00),
(3,4,1,3500.00),
(3,1,1,50.00),
(4,2,2,120.00),
(4,5,1,200.00),
(5,3,1,900.00),
(5,2,1,120.00),
(1,5,1,200.00),
(2,1,3,50.00),
(3,2,1,120.00),
(4,3,1,900.00),
(5,4,1,3500.00),
(1,3,1,900.00),
(2,2,1,120.00),
(3,5,2,200.00),
(4,1,1,50.00),
(5,5,1,200.00);
