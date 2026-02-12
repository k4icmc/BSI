-- sintaxe basica

/*SELECT colunas
FROM tabela1
[TIPO] JOIN	tabela2
ON tabela1 .chave = tabela2 .chave;*/

/* -- SELECIONA O DA TABELA DO MEIO
select p.NUM_PEDIDO, p.PRAZO_ENTREGA, c.NOME AS NOME_CLIENTE, c.CIDADE FROM PEDIDO AS p INNER JOIN CLIENTE AS c ON p.ID_CLIENTE = c.ID_CLIENTE;
*/

/* -- SELECIONA OS DA ESQUERDA
SELECT c.NOME AS NOME_CLIENTE, COUNT(p.NUM_PEDIDO) AS TOTAL_PEDIDOS FROM CLIENTE AS c LEFT JOIN PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE GROUP BY c.ID_CLIENTE, c.NOME ORDER BY TOTAL_PEDIDOS DESC;
*/

-- ENQUANTO O INER JOIN TRAS REASULTADOS COMUNS, O LEFT JOIN TRAS TODOS OS DA ESQUERDA... OU ALGO ASSIM.


/* -- SELECIONA OS DA DIREITA
SELECT p.NUM_PEDIDO, v.NOME AS NOME_VENDEDOR FROM VENDEDOR AS v RIGHT JOIN PEDIDO AS p ON v.ID_VENDEDOR = p.ID_VENDEDOR;
*/

/* -- TUDO QUE FOR IGUAL ELE CONSIDERA COMO UM SÓ.
SELECT c.NOME, p.NUM_PEDIDO FROM CLIENTE AS c LEFT JOIN PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE UNION SELECT c.NOME, p.NUM_PEDIDO FROM CLIENTE AS c RIGHT JOIN PEDIDO AS p ON c.ID_CLIENTE = p.ID_CLIENTE;
*/

/*
-- CROSS JOIN FAZ O RELACIONAMENTO ENTRE AS LINHAS DAS TABELAS.
-- combina cada produto com todos os tamanhos.
SELECT p.NOME_PRODUTO, t.SIGLA_TAMANHO FROM PRODUTOS AS p CROSS JOIN TAMANHOS AS t; 
*/



create database roupas;
use roupas;

-- Criação da tabela 'produto'
CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(255) NOT NULL
);

-- Inserção dos tipos de produto
INSERT INTO produto (nome_produto) VALUES
('regata'),
('baby look'),
('camiseta');

-- Criação da tabela 'tamanho'
CREATE TABLE tamanho (
    id_tamanho INT AUTO_INCREMENT PRIMARY KEY,
    nome_tamanho VARCHAR(50) NOT NULL
);

-- Inserção dos tamanhos
INSERT INTO tamanho (nome_tamanho) VALUES
('PP'),
('P'),
('M'),
('G'),
('GG'),
('XG'),
('XXG'),
('XXXL');

select * from tamanho;


FROM tabela_A
JOIN tabela_B ON tabela_A.id = tabela_B.a_id
JOIN tabela_c ON tabela_B.id = tabela_C.b_id;

SELECT p.NUM_PEDIDO, p.DATA_PEDIDO, c NOME AS CLIENTE, v.NOME AS VENDEDOR, p.VALOR