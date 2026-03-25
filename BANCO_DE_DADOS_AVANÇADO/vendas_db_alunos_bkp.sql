-- ============================================================================
-- SCRIPT DE CRIAÇÃO: LABORATÓRIO DE SQL AVANÇADO
-- Banco de Dados: lab_ecommerce
-- Tema: Subconsultas, Views e Índices
-- ============================================================================

-- corrigido: evitar erro se o banco não existir
DROP DATABASE IF EXISTS lab_ecommerce;

-- Criar o banco de dados
CREATE DATABASE IF NOT EXISTS lab_ecommerce;
USE lab_ecommerce;

-- ============================================================================
-- TABELA: clientes
-- ============================================================================
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50),
    estado VARCHAR(2),
    gasto_total DECIMAL(10, 2) DEFAULT 0.00
);

-- ============================================================================
-- TABELA: fornecedores
-- ============================================================================
CREATE TABLE fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_fornecedor VARCHAR(100) NOT NULL,
    pais VARCHAR(50),
    telefone VARCHAR(20)
);

-- ============================================================================
-- TABELA: produtos
-- ============================================================================
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

-- ============================================================================
-- TABELA: pedidos
-- ============================================================================
CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    valor_total DECIMAL(10, 2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ============================================================================
-- TABELA: itens_pedido
-- ============================================================================
CREATE TABLE itens_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- ============================================================================
-- INSERÇÃO DE DADOS: FORNECEDORES
-- ============================================================================
INSERT INTO fornecedores (nome_fornecedor, pais, telefone) VALUES
('Eletrônicos Brasil', 'Brasil', '11-3000-0001'),
('TechGlobal', 'China', '+86-10-5555-0001'),
('Importados Premium', 'Japão', '+81-3-1234-5678'),
('Componentes Ltda', 'Brasil', '21-2500-0001');

-- ============================================================================
-- INSERÇÃO DE DADOS: PRODUTOS
-- ============================================================================
INSERT INTO produtos (nome_produto, descricao, preco, estoque, id_fornecedor) VALUES
('Notebook Dell', 'Notebook 15 polegadas, Intel i7, 16GB RAM', 3500.00, 5, 1),
('Mouse Logitech', 'Mouse sem fio, 2.4GHz', 150.00, 50, 2),
('Teclado Mecânico', 'Teclado RGB, switches Cherry MX', 450.00, 20, 2),
('Monitor LG 27"', 'Monitor Full HD, 144Hz', 1200.00, 8, 3),
('Webcam HD', 'Webcam 1080p com microfone', 300.00, 30, 1),
('Headset Gamer', 'Headset com som surround 7.1', 350.00, 15, 2),
('SSD 1TB', 'Unidade SSD NVMe 1TB', 600.00, 25, 3),
('Memória RAM 16GB', 'RAM DDR4 3200MHz', 400.00, 40, 4),
('Processador Ryzen 5', 'Processador AMD Ryzen 5 5600X', 1800.00, 10, 4),
('Placa Mãe B550', 'Placa mãe ASUS B550', 800.00, 12, 3);

-- ============================================================================
-- INSERÇÃO DE DADOS: CLIENTES
-- ============================================================================
INSERT INTO clientes (nome, email, cidade, estado, gasto_total) VALUES
('Ana Silva', 'ana.silva@email.com', 'São Paulo', 'SP', 5500.00),
('Bruno Santos', 'bruno.santos@email.com', 'Rio de Janeiro', 'RJ', 2300.00),
('Carlos Oliveira', 'carlos.oliveira@email.com', 'Belo Horizonte', 'MG', 1200.00),
('Diana Costa', 'diana.costa@email.com', 'São Paulo', 'SP', 8900.00),
('Eduardo Lima', 'eduardo.lima@email.com', 'Curitiba', 'PR', 3400.00),
('Fernanda Pereira', 'fernanda.pereira@email.com', 'Salvador', 'BA', 1500.00),
('Gabriel Martins', 'gabriel.martins@email.com', 'São Paulo', 'SP', 4200.00),
('Helena Rocha', 'helena.rocha@email.com', 'Recife', 'PE', 2800.00);

-- ============================================================================
-- INSERÇÃO DE DADOS: PEDIDOS
-- ============================================================================
INSERT INTO pedidos (id_cliente, data_pedido, valor_total, status) VALUES
(1, '2024-01-15', 3650.00, 'entregue'),
(1, '2024-02-20', 1850.00, 'entregue'),
(2, '2024-01-10', 2300.00, 'entregue'),
(3, '2024-02-05', 1200.00, 'pendente'),
(4, '2024-01-25', 5100.00, 'entregue'),
(4, '2024-02-15', 3800.00, 'processando'),
(5, '2024-02-10', 3400.00, 'entregue'),
(6, '2024-01-30', 1500.00, 'entregue'),
(7, '2024-02-01', 4200.00, 'entregue'),
(8, '2024-02-08', 2800.00, 'processando');

-- ============================================================================
-- INSERÇÃO DE DADOS: ITENS_PEDIDO
-- ============================================================================
INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
-- Pedido 1 (Ana Silva)
(1, 1, 1, 3500.00),
(1, 2, 1, 150.00),

-- Pedido 2 (Ana Silva)
(2, 3, 1, 450.00),
(2, 5, 3, 300.00),

-- Pedido 3 (Bruno Santos)
(3, 4, 1, 1200.00),
(3, 6, 1, 1100.00),

-- Pedido 4 (Carlos Oliveira)
(4, 2, 2, 150.00),
(4, 7, 1, 600.00),
(4, 8, 1, 300.00),

-- Pedido 5 (Diana Costa)
(5, 1, 1, 3500.00),
(5, 4, 1, 1200.00),
(5, 6, 1, 400.00),

-- Pedido 6 (Diana Costa)
(6, 9, 1, 1800.00),
(6, 10, 1, 1200.00),
(6, 7, 1, 800.00),

-- Pedido 7 (Eduardo Lima)
(7, 3, 2, 450.00),
(7, 5, 2, 300.00),
(7, 8, 2, 400.00),
(7, 2, 1, 150.00),

-- Pedido 8 (Fernanda Pereira)
(8, 6, 1, 350.00),
(8, 2, 1, 150.00),
(8, 3, 1, 450.00),
(8, 5, 1, 300.00),

-- Pedido 9 (Gabriel Martins)
(9, 1, 1, 3500.00),
(9, 3, 1, 450.00),
(9, 2, 1, 150.00),
(9, 5, 1, 100.00),

-- Pedido 10 (Helena Rocha)
(10, 4, 1, 1200.00),
(10, 6, 1, 350.00),
(10, 2, 1, 150.00),
(10, 7, 1, 100.00);

-- ============================================================================
-- VERIFICAÇÃO FINAL
-- ============================================================================
-- Verificar se as tabelas foram criadas corretamente
SELECT 'Clientes' AS Tabela, COUNT(*) AS Total FROM clientes
UNION ALL
SELECT 'Fornecedores', COUNT(*) FROM fornecedores
UNION ALL
SELECT 'Produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'Pedidos', COUNT(*) FROM pedidos
UNION ALL
SELECT 'Itens Pedido', COUNT(*) FROM itens_pedido;

-- ============================================================================
-- FIM DO SCRIPT
-- ============================================================================

SELECT nome_produto, preco 
FROM produtos 
WHERE preco > (SELECT AVG(preco) FROM produtos);

SELECT AVG(preco) FROM produtos;

-- =============================================================
-- **Exemplo 2: Comparação IN vs EXISTS**
-- *Objetivo: Listar clientes que já fizeram algum pedido.*
-- =============================================================
SELECT nome FROM clientes
WHERE id_cliente NOT IN (SELECT id_cliente FROM pedidos);

SELECT id_cliente FROM pedidos;

INSERT INTO clientes (nome, email, cidade, estado, gasto_total) VALUES
('Ane', 'ane.silva@email.com', 'Formosa', 'GO', 15500.00);

-- Usando EXISTS (Geralmente mais rápido em grandes volumes)

SELECT nome FROM clientes c
WHERE NOT EXISTS (SELECT 1 FROM pedidos p WHERE p.id_cliente=c.id_cliente);

-- =============================================================================

-- *Exercício 1:* Liste os nomes dos clientes cujo valor total de pedidos é superior ao valor total de pedidos dos clientes da cidade 'São Paulo'. **

-- =========================
SELECT nome -- seleciona o nome do cliente
FROM clientes -- da tabela de clientes
WHERE gasto_total > ( -- filtra quem gastou mais que...
    SELECT AVG(gasto_total) -- a média de gasto
    FROM clientes -- da tabela clientes
    WHERE cidade = 'São Paulo' -- considerando só quem é de SP
); -- fecha a subconsulta

-- *Exercício 2:* Crie uma subconsulta que calcula o total de vendas por mês. A consulta principal deve retornar somente os meses onde o total de vendas foi superior a R$ 3.000. **

SELECT mes, total_vendas -- seleciona o mês e o total vendido
FROM ( -- começa uma subconsulta (tipo uma tabela temporária)
    SELECT 
        MONTH(data_pedido) AS mes, -- pega o mês da data do pedido
        SUM(valor_total) AS total_vendas -- soma os valores dos pedidos do mês
    FROM pedidos -- da tabela pedidos
    GROUP BY MONTH(data_pedido) -- agrupa tudo por mês
) AS vendas_mes -- dá um nome pra subconsulta
WHERE total_vendas > 3000; -- filtra só meses com mais de 3k de vendas

-- *Exercício 3:* Liste os nomes dos produtos que nunca foram vendidos em nenhum pedido. **

SELECT nome_produto -- seleciona o nome do produto
FROM produtos -- da tabela produtos
WHERE id_produto NOT IN ( -- pega produtos que NÃO estão...
    SELECT id_produto -- na lista de produtos
    FROM itens_pedido -- que já apareceram nos pedidos
); -- fecha a subconsulta

-- *Exercício 4:* Liste os pedidos (ID e valor) junto com a média de valor dos pedidos feitos pelo mesmo cliente. **

SELECT 
    p.id_pedido, -- pega o id do pedido
    p.valor_total, -- pega o valor do pedido
    ( -- começa a subconsulta
        SELECT AVG(p2.valor_total) -- calcula a média dos pedidos
        FROM pedidos p2 -- da tabela pedidos (com outro apelido)
        WHERE p2.id_cliente = p.id_cliente -- só do mesmo cliente
    ) AS media_cliente -- nome da coluna da média
FROM pedidos p; -- tabela principal com apelido p
