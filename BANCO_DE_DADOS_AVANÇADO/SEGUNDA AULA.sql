-- ============================================================================
-- SCRIPT DE CRIAÇÃO E POPULAÇÃO DO BANCO DE DADOS DE VENDAS
-- Para Aula Prática de JOINs em MySQL
-- Instrutor: MSc Sandir Rodrigues Campos
-- Instituição: IESGO
-- ============================================================================

-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS vendas_iesgo;
USE vendas_iesgo;

-- ============================================================================
-- TABELA: CLIENTE
-- ============================================================================
CREATE TABLE CLIENTE (
    ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    CIDADE VARCHAR(50) NOT NULL,
    UF CHAR(2) NOT NULL,
    EMAIL VARCHAR(100),
    TELEFONE VARCHAR(20)
);

-- Inserir dados de clientes
INSERT INTO CLIENTE (NOME, CIDADE, UF, EMAIL, TELEFONE) VALUES
('João Silva', 'São Paulo', 'SP', 'joao.silva@email.com', '11-98765-4321'),
('Maria Santos', 'Rio de Janeiro', 'RJ', 'maria.santos@email.com', '21-99876-5432'),
('Pedro Oliveira', 'Belo Horizonte', 'MG', 'pedro.oliveira@email.com', '31-97654-3210'),
('Ana Costa', 'Salvador', 'BA', 'ana.costa@email.com', '71-98765-4321'),
('Carlos Ferreira', 'Brasília', 'DF', 'carlos.ferreira@email.com', '61-99876-5432'),
('Juliana Mendes', 'Recife', 'PE', 'juliana.mendes@email.com', '81-97654-3210'),
('Roberto Alves', 'Manaus', 'AM', 'roberto.alves@email.com', '92-98765-4321'),
('Fernanda Lima', 'Curitiba', 'PR', 'fernanda.lima@email.com', '41-99876-5432'),
('Lucas Gomes', 'Porto Alegre', 'RS', 'lucas.gomes@email.com', '51-97654-3210'),
('Patricia Rocha', 'Fortaleza', 'CE', 'patricia.rocha@email.com', '85-98765-4321'),
('Bruno Martins', 'São Paulo', 'SP', 'bruno.martins@email.com', '11-99876-5432'),
('Camila Souza', 'Rio de Janeiro', 'RJ', 'camila.souza@email.com', '21-97654-3210'),
('Diego Ribeiro', 'Belo Horizonte', 'MG', 'diego.ribeiro@email.com', '31-98765-4321'),
('Gabriela Teixeira', 'Salvador', 'BA', 'gabriela.teixeira@email.com', '71-99876-5432'),
('Rafael Pereira', 'Brasília', 'DF', 'rafael.pereira@email.com', '61-97654-3210');

-- ============================================================================
-- TABELA: VENDEDOR
-- ============================================================================
CREATE TABLE VENDEDOR (
    ID_VENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    SALARIO DECIMAL(10, 2) NOT NULL,
    COMISSAO DECIMAL(5, 2) NOT NULL,
    DATA_ADMISSAO DATE
);

-- Inserir dados de vendedores
INSERT INTO VENDEDOR (NOME, SALARIO, COMISSAO, DATA_ADMISSAO) VALUES
('Marcos Silva', 3000.00, 5.0, '2020-01-15'),
('Beatriz Costa', 3500.00, 6.0, '2019-03-20'),
('Thiago Oliveira', 3200.00, 5.5, '2021-06-10'),
('Isabela Mendes', 3800.00, 7.0, '2018-09-05'),
('Gustavo Ferreira', 2800.00, 4.5, '2022-02-28'),
('Natalia Rocha', 3600.00, 6.5, '2020-11-12');

-- ============================================================================
-- TABELA: PRODUTO
-- ============================================================================
CREATE TABLE PRODUTO (
    ID_PRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    DESCRICAO VARCHAR(150) NOT NULL,
    VAL_UNIT DECIMAL(10, 2) NOT NULL,
    ESTOQUE INT NOT NULL
);

-- Inserir dados de produtos
INSERT INTO PRODUTO (DESCRICAO, VAL_UNIT, ESTOQUE) VALUES
('Notebook Dell Inspiron 15', 3500.00, 25),
('Mouse Logitech MX Master 3', 350.00, 150),
('Teclado Mecânico RGB', 450.00, 80),
('Monitor LG 27 polegadas 4K', 1200.00, 40),
('Webcam Logitech HD 1080p', 280.00, 120),
('Headset Gamer HyperX Cloud', 550.00, 60),
('Mousepad XL Premium', 120.00, 200),
('Hub USB 3.0 com 7 portas', 180.00, 100),
('Cabo HDMI 2.1', 85.00, 300),
('Suporte para Monitor Ajustável', 250.00, 90),
('SSD Samsung 1TB', 600.00, 50),
('Memória RAM DDR4 16GB', 400.00, 75),
('Processador Intel i7', 2000.00, 15),
('Placa Mãe ASUS ROG', 1500.00, 20),
('Fonte 850W 80 Plus Gold', 700.00, 35);

-- ============================================================================
-- TABELA: PEDIDO
-- ============================================================================
CREATE TABLE PEDIDO (
    NUM_PEDIDO INT PRIMARY KEY AUTO_INCREMENT,
    ID_CLIENTE INT NOT NULL,
    ID_VENDEDOR INT,
    DATA_PEDIDO DATE NOT NULL,
    PRAZO_ENTREGA INT,
    STATUS VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE),
    FOREIGN KEY (ID_VENDEDOR) REFERENCES VENDEDOR(ID_VENDEDOR)
);

-- Inserir dados de pedidos
INSERT INTO PEDIDO (ID_CLIENTE, ID_VENDEDOR, DATA_PEDIDO, PRAZO_ENTREGA, STATUS) VALUES
(1, 1, '2025-01-05', 5, 'Entregue'),
(1, 1, '2025-02-10', 7, 'Entregue'),
(2, 2, '2025-01-15', 5, 'Entregue'),
(3, 3, '2025-01-20', 10, 'Entregue'),
(4, 4, '2025-02-01', 7, 'Entregue'),
(5, 1, '2025-02-05', 5, 'Entregue'),
(6, 2, '2025-02-08', 7, 'Processando'),
(7, 5, '2025-02-12', 10, 'Processando'),
(8, 3, '2025-02-15', 5, 'Entregue'),
(9, 4, '2025-02-18', 7, 'Entregue'),
(10, 6, '2025-02-20', 5, 'Processando'),
(11, 1, '2025-02-22', 7, 'Entregue'),
(2, 3, '2025-02-25', 10, 'Pendente'),
(3, 2, '2025-03-01', 5, 'Pendente'),
(12, 4, '2025-03-02', 7, 'Pendente'),
(13, 5, '2025-03-05', 5, 'Pendente'),
(14, 6, '2025-03-08', 7, 'Pendente'),
(15, 1, '2025-03-10', 10, 'Pendente'),
(4, 2, '2025-03-12', 5, 'Pendente'),
(5, 3, '2025-03-15', 7, 'Pendente');

-- ============================================================================
-- TABELA: ITEM_PEDIDO
-- ============================================================================
CREATE TABLE ITEM_PEDIDO (
    ID_ITEM_PEDIDO INT PRIMARY KEY AUTO_INCREMENT,
    NUM_PEDIDO INT NOT NULL,
    ID_PRODUTO INT NOT NULL,
    QUANTIDADE INT NOT NULL,
    FOREIGN KEY (NUM_PEDIDO) REFERENCES PEDIDO(NUM_PEDIDO),
    FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO)
);

-- Inserir dados de itens de pedidos
INSERT INTO ITEM_PEDIDO (NUM_PEDIDO, ID_PRODUTO, QUANTIDADE) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1),
(3, 5, 3),
(3, 6, 1),
(4, 7, 5),
(4, 8, 2),
(5, 9, 10),
(5, 10, 1),
(6, 11, 1),
(6, 12, 2),
(7, 13, 1),
(8, 14, 1),
(8, 15, 1),
(9, 1, 1),
(9, 2, 1),
(10, 3, 2),
(11, 4, 1),
(11, 5, 2),
(12, 6, 1),
(12, 7, 3),
(13, 8, 2),
(14, 9, 5),
(15, 10, 1),
(16, 11, 1),
(17, 12, 1),
(18, 13, 1),
(19, 14, 1),
(20, 15, 2);

-- ============================================================================
-- CRIAR ÍNDICES PARA MELHOR DESEMPENHO
-- ============================================================================
CREATE INDEX idx_pedido_cliente ON PEDIDO(ID_CLIENTE);
CREATE INDEX idx_pedido_vendedor ON PEDIDO(ID_VENDEDOR);
CREATE INDEX idx_item_pedido_pedido ON ITEM_PEDIDO(NUM_PEDIDO);
CREATE INDEX idx_item_pedido_produto ON ITEM_PEDIDO(ID_PRODUTO);

-- ============================================================================
-- EXEMPLOS DE CONSULTAS COM JOINS PARA PRÁTICA
-- ============================================================================

-- 1. INNER JOIN: Listar todos os pedidos com nome do cliente
-- Resultado: Apenas pedidos que têm clientes válidos
SELECT
    p.NUM_PEDIDO,
    p.DATA_PEDIDO,
    c.NOME AS NOME_CLIENTE,
    c.CIDADE,
    c.UF
FROM
    PEDIDO AS p
INNER JOIN
    CLIENTE AS c ON p.ID_CLIENTE = c.ID_CLIENTE
ORDER BY
    p.NUM_PEDIDO;



-- 2. LEFT JOIN: Listar todos os clientes e quantos pedidos cada um fez
-- Resultado: Todos os clientes, incluindo aqueles sem pedidos
SELECT
    c.NOME AS NOME_CLIENTE,
    c.CIDADE,
    COUNT(p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    SUM(CASE WHEN p.NUM_PEDIDO IS NOT NULL THEN 1 ELSE 0 END) AS PEDIDOS_CONFIRMADOS
FROM
    CLIENTE AS c
LEFT JOIN
    PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE
GROUP BY
    c.ID_CLIENTE, c.NOME, c.CIDADE
ORDER BY
    TOTAL_PEDIDOS DESC;



-- 3. INNER JOIN com múltiplas tabelas: Relatório detalhado de vendas
-- Resultado: Cliente, vendedor, produto, quantidade e valor total
SELECT
    c.NOME AS CLIENTE,
    v.NOME AS VENDEDOR,
    pr.DESCRICAO AS PRODUTO,
    ip.QUANTIDADE,
    pr.VAL_UNIT,
    (ip.QUANTIDADE * pr.VAL_UNIT) AS VALOR_TOTAL_ITEM,
    p.DATA_PEDIDO,
    p.STATUS
FROM
    PEDIDO AS p
INNER JOIN CLIENTE AS c ON p.ID_CLIENTE = c.ID_CLIENTE
INNER JOIN VENDEDOR AS v ON p.ID_VENDEDOR = v.ID_VENDEDOR
INNER JOIN ITEM_PEDIDO AS ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
INNER JOIN PRODUTO AS pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
ORDER BY
    c.NOME, p.NUM_PEDIDO;



-- 4. Análise de Vendas por Vendedor
-- Resultado: Cada vendedor com total de vendas
SELECT
    v.NOME AS VENDEDOR,
    COUNT(DISTINCT p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    SUM(ip.QUANTIDADE * pr.VAL_UNIT) AS VALOR_TOTAL_VENDIDO,
    ROUND(AVG(ip.QUANTIDADE * pr.VAL_UNIT), 2) AS VALOR_MEDIO_ITEM
FROM
    VENDEDOR AS v
LEFT JOIN PEDIDO AS p ON v.ID_VENDEDOR = p.ID_VENDEDOR
LEFT JOIN ITEM_PEDIDO AS ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
LEFT JOIN PRODUTO AS pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
GROUP BY
    v.ID_VENDEDOR, v.NOME
ORDER BY
    VALOR_TOTAL_VENDIDO DESC;



-- 5. Produtos mais vendidos
-- Resultado: Produtos ordenados por quantidade vendida
SELECT
    pr.DESCRICAO AS PRODUTO,
    SUM(ip.QUANTIDADE) AS TOTAL_VENDIDO,
    COUNT(DISTINCT p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    ROUND(AVG(ip.QUANTIDADE), 2) AS QUANTIDADE_MEDIA
FROM
    PRODUTO AS pr
LEFT JOIN ITEM_PEDIDO AS ip ON pr.ID_PRODUTO = ip.ID_PRODUTO
LEFT JOIN PEDIDO AS p ON ip.NUM_PEDIDO = p.NUM_PEDIDO
GROUP BY
    pr.ID_PRODUTO, pr.DESCRICAO
ORDER BY
    TOTAL_VENDIDO DESC;



-- 6. Clientes por região (UF)
-- Resultado: Total de clientes e pedidos por estado
SELECT
    c.UF,
    COUNT(DISTINCT c.ID_CLIENTE) AS TOTAL_CLIENTES,
    COUNT(DISTINCT p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    SUM(ip.QUANTIDADE * pr.VAL_UNIT) AS VALOR_TOTAL_VENDIDO
FROM
    CLIENTE AS c
LEFT JOIN PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE
LEFT JOIN ITEM_PEDIDO AS ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
LEFT JOIN PRODUTO AS pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
GROUP BY
    c.UF
ORDER BY
    VALOR_TOTAL_VENDIDO DESC;



-- 7. Clientes que nunca fizeram pedidos
-- Resultado: Identifica oportunidades de marketing
SELECT
    c.NOME AS CLIENTE,
    c.CIDADE,
    c.UF,
    c.EMAIL
FROM
    CLIENTE AS c
LEFT JOIN
    PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE
WHERE
    p.NUM_PEDIDO IS NULL
ORDER BY
    c.NOME;



-- 8. Produtos nunca vendidos
-- Resultado: Identifica produtos com baixa demanda
SELECT
    pr.ID_PRODUTO,
    pr.DESCRICAO,
    pr.VAL_UNIT,
    pr.ESTOQUE
FROM
    PRODUTO AS pr
LEFT JOIN
    ITEM_PEDIDO AS ip ON pr.ID_PRODUTO = ip.ID_PRODUTO
WHERE
    ip.ID_ITEM_PEDIDO IS NULL
ORDER BY
    pr.DESCRICAO;



-- 9. Desempenho de vendedores por mês
-- Resultado: Análise temporal de vendas
SELECT
    v.NOME AS VENDEDOR,
    YEAR(p.DATA_PEDIDO) AS ANO,
    MONTH(p.DATA_PEDIDO) AS MES,
    COUNT(DISTINCT p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    SUM(ip.QUANTIDADE * pr.VAL_UNIT) AS VALOR_TOTAL
FROM
    VENDEDOR AS v
LEFT JOIN PEDIDO AS p ON v.ID_VENDEDOR = p.ID_VENDEDOR
LEFT JOIN ITEM_PEDIDO AS ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
LEFT JOIN PRODUTO AS pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
WHERE
    p.DATA_PEDIDO IS NOT NULL
GROUP BY
    v.ID_VENDEDOR, v.NOME, YEAR(p.DATA_PEDIDO), MONTH(p.DATA_PEDIDO)
ORDER BY
    v.NOME, ANO, MES;



-- 10. Clientes de alto valor
-- Resultado: Top clientes por valor gasto
SELECT
    c.NOME AS CLIENTE,
    c.CIDADE,
    c.UF,
    COUNT(DISTINCT p.NUM_PEDIDO) AS TOTAL_PEDIDOS,
    SUM(ip.QUANTIDADE * pr.VAL_UNIT) AS VALOR_TOTAL_GASTO,
    ROUND(AVG(ip.QUANTIDADE * pr.VAL_UNIT), 2) AS VALOR_MEDIO_POR_ITEM
FROM
    CLIENTE AS c
INNER JOIN PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE
INNER JOIN ITEM_PEDIDO AS ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
INNER JOIN PRODUTO AS pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
GROUP BY
    c.ID_CLIENTE, c.NOME, c.CIDADE, c.UF
ORDER BY
    VALOR_TOTAL_GASTO DESC;

-- ============================================================================
-- FIM DO SCRIPT
-- ============================================================================


-- EXERCICIOS:
-- 1 Relatório de Venda
-- Lista pedido, data, cliente e vendedor. 2 INNER JOINs.

SELECT 
    p.NUM_PEDIDO,
    p.DATA_PEDIDO,
    c.NOME AS CLIENTE,
    v.NOME AS VENDEDOR
FROM PEDIDO p
INNER JOIN CLIENTE c ON p.ID_CLIENTE = c.ID_CLIENTE
INNER JOIN VENDEDOR v ON p.ID_VENDEDOR = v.ID_VENDEDOR;

-- 2  Cliente Inativo
-- Clientes que nunca fizeram pedido. LEFT JOIN + WHERE ... IS NULL.

SELECT 
    c.NOME AS CLIENTE
FROM CLIENTE c
LEFT JOIN PEDIDO p ON c.ID_CLIENTE = p.ID_CLIENTE
WHERE p.NUM_PEDIDO IS NULL;


-- 3 RANKING DE VENDAS
-- Nome do vendedor + soma total dos pedidos.

SELECT 
    v.NOME AS VENDEDOR,
    SUM(ip.QUANTIDADE * pr.VAL_UNIT) AS TOTAL_VENDIDO
FROM VENDEDOR v
LEFT JOIN PEDIDO p ON v.ID_VENDEDOR = p.ID_VENDEDOR
LEFT JOIN ITEM_PEDIDO ip ON p.NUM_PEDIDO = ip.NUM_PEDIDO
LEFT JOIN PRODUTO pr ON ip.ID_PRODUTO = pr.ID_PRODUTO
GROUP BY v.ID_VENDEDOR, v.NOME
ORDER BY TOTAL_VENDIDO DESC;

-- 4 PRODUTOS PARADOS 
-- Produtos que nunca foram vendidos

SELECT 
    pr.DESCRICAO AS PRODUTO
FROM PRODUTO pr
LEFT JOIN ITEM_PEDIDO ip ON pr.ID_PRODUTO = ip.ID_PRODUTO
WHERE ip.ID_ITEM_PEDIDO IS NULL;