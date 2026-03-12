-- ============================================================================
-- SCRIPT DE CRIAÇÃO E POPULAÇÃO DO BANCO DE DADOS: vendas_db
-- ============================================================================
-- Cenário: Sistema de Vendas de Eletrônicos
-- Objetivo: Banco de dados para exercícios de SQL e JOINs
-- Total de Registros: 2500+
-- ============================================================================

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS vendas_db;
CREATE DATABASE vendas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vendas_db;

-- ============================================================================
-- TABELA: categorias
-- ============================================================================
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: produtos
-- ============================================================================
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco_custo DECIMAL(10, 2) NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    id_categoria INT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    INDEX idx_categoria (id_categoria),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: clientes
-- ============================================================================
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_estado (estado),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: vendedores
-- ============================================================================
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    data_admissao DATE NOT NULL,
    salario_base DECIMAL(10, 2) NOT NULL,
    comissao_percentual DECIMAL(5, 2) NOT NULL DEFAULT 5.00,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: vendas
-- ============================================================================
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    data_venda DATETIME NOT NULL,
    data_entrega DATETIME,
    valor_total DECIMAL(12, 2) NOT NULL,
    desconto DECIMAL(10, 2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'pendente',
    observacoes TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    INDEX idx_cliente (id_cliente),
    INDEX idx_vendedor (id_vendedor),
    INDEX idx_data_venda (data_venda)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: itens_venda
-- ============================================================================
CREATE TABLE itens_venda (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    INDEX idx_venda (id_venda),
    INDEX idx_produto (id_produto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- POPULAÇÃO: CATEGORIAS
-- ============================================================================
INSERT INTO categorias (nome, descricao) VALUES
('Smartphones', 'Telefones inteligentes e acessórios'),
('Notebooks', 'Computadores portáteis e ultrabooks'),
('Tablets', 'Tablets e e-readers'),
('Monitores', 'Monitores e telas'),
('Periféricos', 'Mouses, teclados e outros periféricos'),
('Fones de Ouvido', 'Fones, headsets e caixas de som'),
('Câmeras', 'Câmeras digitais e acessórios'),
('Acessórios', 'Capas, carregadores e cabos'),
('Smartwatches', 'Relógios inteligentes'),
('Impressoras', 'Impressoras e multifuncionais');

-- ============================================================================
-- POPULAÇÃO: PRODUTOS (100 produtos)
-- ============================================================================
INSERT INTO produtos (nome, descricao, preco_custo, preco_venda, estoque, id_categoria) VALUES
('iPhone 15 Pro', 'Smartphone Apple última geração', 2500.00, 4500.00, 150, 1),
('Samsung Galaxy S24', 'Smartphone Samsung topo de linha', 2200.00, 3800.00, 120, 1),
('Google Pixel 8', 'Smartphone Google com IA', 1800.00, 3200.00, 100, 1),
('OnePlus 12', 'Smartphone OnePlus performance', 1600.00, 2800.00, 80, 1),
('Xiaomi 14', 'Smartphone Xiaomi custo-benefício', 1400.00, 2400.00, 200, 1),
('Motorola Edge 50', 'Smartphone Motorola intermediário', 1200.00, 2100.00, 90, 1),
('Samsung Galaxy A54', 'Smartphone Samsung entrada', 800.00, 1500.00, 250, 1),
('iPhone 14', 'Smartphone Apple geração anterior', 2000.00, 3500.00, 100, 1),
('Xiaomi 13', 'Smartphone Xiaomi anterior', 1100.00, 2000.00, 150, 1),
('Realme 12', 'Smartphone Realme budget', 600.00, 1200.00, 300, 1),
('MacBook Pro 16', 'Notebook Apple profissional', 5000.00, 9000.00, 50, 2),
('Dell XPS 15', 'Notebook Dell premium', 4000.00, 7500.00, 60, 2),
('Lenovo ThinkPad X1', 'Notebook Lenovo executivo', 3500.00, 6500.00, 70, 2),
('ASUS VivoBook 15', 'Notebook ASUS intermediário', 2000.00, 3800.00, 100, 2),
('HP Pavilion 15', 'Notebook HP entrada', 1800.00, 3200.00, 120, 2),
('Acer Aspire 5', 'Notebook Acer custo-benefício', 1600.00, 3000.00, 110, 2),
('Samsung Galaxy Book', 'Notebook Samsung 2 em 1', 2500.00, 4800.00, 80, 2),
('MSI GE76 Raider', 'Notebook MSI gamer', 3500.00, 6500.00, 40, 2),
('Positivo Motion', 'Notebook Positivo entrada', 1200.00, 2200.00, 150, 2),
('LG Gram 17', 'Notebook LG ultraportátil', 3000.00, 5500.00, 60, 2),
('iPad Pro 12.9', 'Tablet Apple profissional', 2500.00, 4500.00, 80, 3),
('Samsung Galaxy Tab S9', 'Tablet Samsung premium', 2000.00, 3800.00, 100, 3),
('iPad Air', 'Tablet Apple intermediário', 1800.00, 3200.00, 120, 3),
('Lenovo Tab P12', 'Tablet Lenovo produtivo', 1600.00, 3000.00, 90, 3),
('Samsung Galaxy Tab A', 'Tablet Samsung entrada', 800.00, 1500.00, 200, 3),
('iPad Mini', 'Tablet Apple compacto', 1500.00, 2800.00, 110, 3),
('Amazon Fire Max', 'Tablet Amazon multimídia', 600.00, 1200.00, 150, 3),
('Xiaomi Pad 6', 'Tablet Xiaomi custo-benefício', 1000.00, 1900.00, 130, 3),
('Huawei MatePad Pro', 'Tablet Huawei premium', 1800.00, 3400.00, 70, 3),
('OnePlus Pad', 'Tablet OnePlus performance', 1400.00, 2600.00, 85, 3),
('LG UltraWide 34', 'Monitor LG ultrawide 34 polegadas', 1200.00, 2200.00, 50, 4),
('Dell U2723DE', 'Monitor Dell profissional 27', 1000.00, 1900.00, 60, 4),
('ASUS ProArt 32', 'Monitor ASUS 32 polegadas', 1500.00, 2800.00, 40, 4),
('Samsung Odyssey G9', 'Monitor Samsung gamer 49', 1800.00, 3500.00, 30, 4),
('BenQ EW2880U', 'Monitor BenQ 28 polegadas', 900.00, 1700.00, 70, 4),
('LG 27UP550', 'Monitor LG 27 4K', 1100.00, 2000.00, 65, 4),
('Acer Predator X34', 'Monitor Acer gamer ultrawide', 1400.00, 2600.00, 45, 4),
('HP Z27', 'Monitor HP profissional', 1000.00, 1900.00, 55, 4),
('ViewSonic VP2468', 'Monitor ViewSonic 24', 600.00, 1200.00, 100, 4),
('ASUS PA247CV', 'Monitor ASUS 24 profissional', 700.00, 1400.00, 80, 4),
('Logitech MX Master 3S', 'Mouse Logitech profissional', 150.00, 350.00, 200, 5),
('Corsair K95 Platinum', 'Teclado Corsair mecânico', 400.00, 800.00, 100, 5),
('SteelSeries Rival 600', 'Mouse SteelSeries gamer', 120.00, 280.00, 150, 5),
('Razer DeathAdder V3', 'Mouse Razer gamer', 100.00, 250.00, 180, 5),
('Ducky One 3', 'Teclado Ducky mecânico', 250.00, 550.00, 120, 5),
('Keychron K2', 'Teclado Keychron sem fio', 80.00, 200.00, 200, 5),
('Logitech G Pro X', 'Mouse Logitech gamer', 110.00, 280.00, 160, 5),
('Corsair MM800', 'Mousepad Corsair RGB', 60.00, 150.00, 250, 5),
('BenQ PD Mouse', 'Mouse BenQ profissional', 90.00, 200.00, 140, 5),
('Varmilo VA87M', 'Teclado Varmilo mecânico', 200.00, 450.00, 100, 5),
('Sony WH-1000XM5', 'Fone Sony com cancelamento', 250.00, 550.00, 150, 6),
('Bose QuietComfort 45', 'Fone Bose premium', 280.00, 600.00, 120, 6),
('Apple AirPods Pro', 'Fone Apple sem fio', 200.00, 450.00, 200, 6),
('Sennheiser Momentum 4', 'Fone Sennheiser profissional', 300.00, 650.00, 100, 6),
('JBL Tune 750', 'Fone JBL sem fio', 120.00, 300.00, 180, 6),
('Beats Studio Pro', 'Fone Beats premium', 250.00, 550.00, 140, 6),
('Anker Soundcore Space Q45', 'Fone Anker custo-benefício', 80.00, 200.00, 250, 6),
('Shure AONIC 50', 'Fone Shure profissional', 350.00, 750.00, 80, 6),
('Harman Kardon Soho', 'Fone Harman Kardon premium', 200.00, 450.00, 110, 6),
('Audio-Technica ATH-M50x', 'Fone Audio-Technica estúdio', 180.00, 400.00, 160, 6),
('Canon EOS R5', 'Câmera Canon profissional', 4000.00, 8000.00, 40, 7),
('Nikon Z9', 'Câmera Nikon topo de linha', 3800.00, 7500.00, 35, 7),
('Sony A7R V', 'Câmera Sony mirrorless', 3500.00, 7000.00, 45, 7),
('Canon EOS M50 Mark II', 'Câmera Canon mirrorless', 1200.00, 2500.00, 80, 7),
('Nikon Z50', 'Câmera Nikon mirrorless', 1100.00, 2300.00, 90, 7),
('GoPro Hero 12', 'Câmera GoPro ação', 350.00, 800.00, 200, 7),
('DJI Osmo Action 4', 'Câmera DJI ação', 250.00, 600.00, 150, 7),
('Fujifilm X-T5', 'Câmera Fujifilm mirrorless', 1400.00, 2800.00, 60, 7),
('Panasonic Lumix S5', 'Câmera Panasonic full-frame', 1300.00, 2600.00, 70, 7),
('Olympus OM-1', 'Câmera Olympus mirrorless', 1000.00, 2100.00, 85, 7),
('Capa iPhone 15 Pro', 'Capa proteção iPhone', 20.00, 60.00, 500, 8),
('Carregador USB-C 65W', 'Carregador rápido USB-C', 30.00, 80.00, 400, 8),
('Cabo HDMI 2.1', 'Cabo HDMI 8K', 15.00, 45.00, 600, 8),
('Suporte Universal Tablet', 'Suporte ajustável tablet', 25.00, 70.00, 300, 8),
('Protetor de Tela Vidro', 'Protetor vidro temperado', 10.00, 35.00, 800, 8),
('Hub USB-C 7 em 1', 'Hub multiporta USB-C', 50.00, 120.00, 250, 8),
('Capa Notebook 15 polegadas', 'Capa protetora notebook', 40.00, 100.00, 350, 8),
('Carregador Wireless', 'Carregador wireless 15W', 35.00, 90.00, 400, 8),
('Cabo Lightning Apple', 'Cabo Lightning original', 25.00, 70.00, 500, 8),
('Bateria Portátil 20000mAh', 'Power bank 20000mAh', 60.00, 150.00, 300, 8),
('Apple Watch Series 9', 'Smartwatch Apple premium', 1200.00, 2200.00, 100, 9),
('Samsung Galaxy Watch 6', 'Smartwatch Samsung AMOLED', 900.00, 1700.00, 120, 9),
('Garmin Fenix 7X', 'Smartwatch Garmin esportes', 1000.00, 1900.00, 80, 9),
('Fitbit Sense 2', 'Smartwatch Fitbit saúde', 500.00, 1000.00, 150, 9),
('Amazfit GTR 4', 'Smartwatch Amazfit custo-benefício', 300.00, 700.00, 200, 9),
('Huawei Watch GT 4', 'Smartwatch Huawei elegante', 400.00, 900.00, 140, 9),
('Polar Vantage V3', 'Smartwatch Polar esportes', 800.00, 1600.00, 90, 9),
('Mobvoi TicWatch Pro 5', 'Smartwatch TicWatch Android', 600.00, 1200.00, 110, 9),
('OnePlus Watch 2', 'Smartwatch OnePlus performance', 500.00, 1100.00, 130, 9),
('Realme Watch S', 'Smartwatch Realme budget', 200.00, 500.00, 250, 9),
('HP LaserJet Pro M404n', 'Impressora HP profissional', 800.00, 1600.00, 60, 10),
('Canon imageCLASS MF445dw', 'Impressora Canon multifuncional', 900.00, 1800.00, 50, 10),
('Brother HL-L8360CDW', 'Impressora Brother colorida', 1000.00, 2000.00, 45, 10),
('Xerox VersaLink C405', 'Impressora Xerox corporativa', 1200.00, 2400.00, 40, 10),
('Ricoh MP C3004', 'Impressora Ricoh multifuncional', 1100.00, 2200.00, 50, 10),
('Epson SureColor SC-P9000', 'Impressora Epson fotográfica', 1500.00, 3000.00, 30, 10),
('HP OfficeJet Pro 9015', 'Impressora HP jato tinta', 400.00, 900.00, 100, 10),
('Canon PIXMA TR8520', 'Impressora Canon jato tinta', 350.00, 800.00, 120, 10),
('Brother MFC-L9550CDW', 'Impressora Brother colorida', 1000.00, 2000.00, 55, 10),
('Kyocera ECOSYS M5526cdn', 'Impressora Kyocera corporativa', 950.00, 1900.00, 60, 10);

-- ============================================================================
-- POPULAÇÃO: CLIENTES (300 clientes)
-- ============================================================================
INSERT INTO clientes (nome, email, telefone, endereco, cidade, estado, cep) VALUES
('João Silva', 'joao.silva@email.com', '11987654321', 'Rua A, 100', 'São Paulo', 'SP', '01310100'),
('Maria Santos', 'maria.santos@email.com', '11987654322', 'Rua B, 200', 'São Paulo', 'SP', '01310101'),
('Pedro Oliveira', 'pedro.oliveira@email.com', '11987654323', 'Rua C, 300', 'São Paulo', 'SP', '01310102'),
('Ana Costa', 'ana.costa@email.com', '11987654324', 'Rua D, 400', 'São Paulo', 'SP', '01310103'),
('Carlos Mendes', 'carlos.mendes@email.com', '11987654325', 'Rua E, 500', 'São Paulo', 'SP', '01310104'),
('Fernanda Rocha', 'fernanda.rocha@email.com', '21987654321', 'Av. Principal, 1000', 'Rio de Janeiro', 'RJ', '20040020'),
('Roberto Alves', 'roberto.alves@email.com', '21987654322', 'Av. Secundária, 2000', 'Rio de Janeiro', 'RJ', '20040021'),
('Juliana Ferreira', 'juliana.ferreira@email.com', '21987654323', 'Rua Flores, 300', 'Rio de Janeiro', 'RJ', '20040022'),
('Marcelo Gomes', 'marcelo.gomes@email.com', '21987654324', 'Rua Jardins, 400', 'Rio de Janeiro', 'RJ', '20040023'),
('Beatriz Lima', 'beatriz.lima@email.com', '21987654325', 'Rua Parque, 500', 'Rio de Janeiro', 'RJ', '20040024');

DELIMITER $$

CREATE PROCEDURE populate_clientes()
BEGIN
    DECLARE counter INT DEFAULT 11;
    DECLARE estado_var VARCHAR(2);
    DECLARE cidade_var VARCHAR(100);
    
    WHILE counter <= 300 DO
        SET estado_var = CASE MOD(counter, 5)
            WHEN 0 THEN 'SP'
            WHEN 1 THEN 'RJ'
            WHEN 2 THEN 'MG'
            WHEN 3 THEN 'BA'
            ELSE 'SC'
        END;
        
        SET cidade_var = CASE MOD(counter, 5)
            WHEN 0 THEN 'São Paulo'
            WHEN 1 THEN 'Rio de Janeiro'
            WHEN 2 THEN 'Belo Horizonte'
            WHEN 3 THEN 'Salvador'
            ELSE 'Florianópolis'
        END;
        
        INSERT INTO clientes (nome, email, telefone, endereco, cidade, estado, cep) 
        VALUES (
            CONCAT('Cliente ', counter),
            CONCAT('cliente', counter, '@email.com'),
            CONCAT('11', LPAD(counter, 9, '0')),
            CONCAT('Rua ', counter, ', ', counter * 10),
            cidade_var,
            estado_var,
            CONCAT('0', LPAD(counter, 7, '0'))
        );
        
        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

CALL populate_clientes();
DROP PROCEDURE populate_clientes;

-- ============================================================================
-- POPULAÇÃO: VENDEDORES (50 vendedores)
-- ============================================================================
INSERT INTO vendedores (nome, email, telefone, data_admissao, salario_base, comissao_percentual) VALUES
('Vendedor 1', 'vendedor1@empresa.com', '11999999001', '2023-01-15', 3000.00, 5.00),
('Vendedor 2', 'vendedor2@empresa.com', '11999999002', '2023-02-20', 3200.00, 5.50),
('Vendedor 3', 'vendedor3@empresa.com', '11999999003', '2023-03-10', 3100.00, 5.25),
('Vendedor 4', 'vendedor4@empresa.com', '11999999004', '2023-04-05', 3300.00, 6.00),
('Vendedor 5', 'vendedor5@empresa.com', '11999999005', '2023-05-12', 3150.00, 5.75),
('Vendedor 6', 'vendedor6@empresa.com', '11999999006', '2023-06-18', 3250.00, 5.50),
('Vendedor 7', 'vendedor7@empresa.com', '11999999007', '2023-07-22', 3180.00, 5.80),
('Vendedor 8', 'vendedor8@empresa.com', '11999999008', '2023-08-30', 3220.00, 6.00),
('Vendedor 9', 'vendedor9@empresa.com', '11999999009', '2023-09-14', 3200.00, 5.90),
('Vendedor 10', 'vendedor10@empresa.com', '11999999010', '2023-10-25', 3280.00, 6.10);

DELIMITER $$

CREATE PROCEDURE populate_vendedores()
BEGIN
    DECLARE counter INT DEFAULT 11;
    
    WHILE counter <= 50 DO
        INSERT INTO vendedores (nome, email, telefone, data_admissao, salario_base, comissao_percentual) 
        VALUES (
            CONCAT('Vendedor ', counter),
            CONCAT('vendedor', counter, '@empresa.com'),
            CONCAT('11', LPAD(counter, 9, '0')),
            DATE_SUB(CURDATE(), INTERVAL (counter * 7) DAY),
            3000 + (counter * 10),
            5.00 + (counter * 0.1)
        );
        
        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

CALL populate_vendedores();
DROP PROCEDURE populate_vendedores;

-- ============================================================================
-- POPULAÇÃO: VENDAS (1000 vendas)
-- ============================================================================
DELIMITER $$

CREATE PROCEDURE populate_vendas()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE id_cliente_var INT;
    DECLARE id_vendedor_var INT;
    DECLARE valor_var DECIMAL(12, 2);
    
    WHILE counter <= 1000 DO
        SET id_cliente_var = (counter MOD 300) + 1;
        SET id_vendedor_var = ((counter MOD 50) + 1);
        SET valor_var = 100 + (counter * 7.5);
        
        INSERT INTO vendas (id_cliente, id_vendedor, data_venda, data_entrega, valor_total, desconto, status) 
        VALUES (
            id_cliente_var,
            id_vendedor_var,
            DATE_SUB(NOW(), INTERVAL (counter MOD 365) DAY),
            DATE_SUB(NOW(), INTERVAL ((counter MOD 365) - 5) DAY),
            valor_var,
            valor_var * 0.05,
            CASE (counter MOD 4)
                WHEN 0 THEN 'pendente'
                WHEN 1 THEN 'processando'
                WHEN 2 THEN 'enviado'
                ELSE 'entregue'
            END
        );
        
        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

CALL populate_vendas();
DROP PROCEDURE populate_vendas;


-- ============================================================================
-- POPULAÇÃO: ITENS_VENDA (2700+ itens)
-- ============================================================================
DELIMITER $$

CREATE PROCEDURE populate_itens_venda()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE id_venda_var INT;
    DECLARE id_produto_var INT;
    DECLARE quantidade_var INT;
    
    DECLARE preco_var DECIMAL(10, 2);
    DECLARE subtotal_var DECIMAL(12, 2);
    
    WHILE counter <= 2700 DO
        SET id_venda_var = ((counter - 1) DIV 3) + 1;
        SET id_produto_var = ((counter - 1) MOD 100) + 1;
        SET quantidade_var = (counter MOD 10) + 1;
        
        SELECT preco_venda INTO preco_var FROM produtos WHERE id_produto = id_produto_var LIMIT 1;
        SET subtotal_var = preco_var * quantidade_var;
        
        INSERT INTO itens_venda (id_venda, id_produto, quantidade, preco_unitario, subtotal) 
        VALUES (
            id_venda_var,
            id_produto_var,
            quantidade_var,
            preco_var,
            subtotal_var
        );
        
        SET counter = counter + 1;
    END WHILE;
END$$

DELIMITER ;

CALL populate_itens_venda();
DROP PROCEDURE populate_itens_venda;

SET FOREIGN_KEY_CHECKS=1;

-- ============================================================================
-- VERIFICAÇÃO FINAL
-- ============================================================================
SELECT 'Categorias' as tabela, COUNT(*) as total FROM categorias
UNION ALL
SELECT 'Produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'Clientes', COUNT(*) FROM clientes
UNION ALL
SELECT 'Vendedores', COUNT(*) FROM vendedores
UNION ALL
SELECT 'Vendas', COUNT(*) FROM vendas
UNION ALL
SELECT 'Itens Venda', COUNT(*) FROM itens_venda;




-- questão 1: inner join basico:
-- enunciado: listar o nome de cada cliente, o nome do vendedor e a data de cada venda realizada.alter
-- mostrar apenas as vendas que tem cliente e vendedor validos, ordenar por data da venda em ordem decrescente.
-- solução:

SELECT
    c.nome AS CLIENTE,
    v.nome AS VENDEDOR,
    vn.data_venda
FROM vendas vn
JOIN clientes c ON vn.id_cliente = c.id_cliente
JOIN vendedores v ON vn.id_vendedor = v.id_vendedor
ORDER BY vn.data_venda DESC;



-- questão 2 prova A
-- Todos os vendedores: nome, email, data de admissão, salário base e total de vendas. Incluir sem vendas.
SELECT
    c.id_cliente,
    c.nome AS cliente,
    c.email,
    c.cidade,
    COUNT(vn.id_venda) AS total_vendas,
    COALESCE(SUM(vn.valor_total), 0) AS valor_total
FROM clientes c
LEFT JOIN vendas vn ON c.id_cliente = vn.id_cliente
GROUP BY c.id_cliente, c.nome, c.email, c.cidade
ORDER BY valor_total DESC;



-- questão 3 prova A
-- Todas as categorias: nome, quantidade de produtos e total de itens vendidos. Incluir sem produtos ou sem vendas.
SELECT
    p.id_produto,
    p.nome AS produto,
    cat.nome AS categoria,
    p.preco_venda,
    p.estoque,
    
    COUNT(iv.id_item) AS total_vendido,
    COALESCE(SUM(iv.quantidade), 0) AS quantidade_total
    
FROM produtos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN itens_venda iv ON p.id_produto = iv.id_produto

GROUP BY p.id_produto, p.nome, cat.nome, p.preco_venda, p.estoque
ORDER BY total_vendido DESC;

-- 4. Clientes que compraram: nome, cidade, total de compras e valor total gasto. Ordenar por valor total DESC. Top 20.

select
	v.id_vendedor, 
    v.nome as vendedor,
    count(vn.id_venda) as total_vendas,
sum(vn.valor_total) as valor_total
from vendedores v
join vendas vn on v.id_vendedor = vn.id_vendedor
group by v.id_vendedor, v.nome
order by valor_total desc;



-- 5 prova A.  Análise completa de vendas: cliente, cidade, vendedor, produto, categoria, quantidade, preço unitário e subtotal. Apenas com todas as informações válidas.
SELECT
    c.nome AS cliente,
    c.email,
    c.telefone,
    c.cidade,
    MAX(vn.data_venda) AS ultima_data_compra,
    MAX(vn.valor_total) AS valor_ultima_compra
FROM clientes c
LEFT JOIN vendas vn ON c.id_cliente = vn.id_cliente
GROUP BY c.id_cliente, c.nome, c.email, c.telefone, c.cidade;


-- 6 Todos os itens de venda: ID da venda, nome do produto (se disponível), quantidade, preço unitário e subtotal. Usar RIGHT JOIN.

select
vn.id_venda,
vn.data_venda,
coalesce(c.nome, 'cliente desconhecido') as cliente,
coalesce(v.nome, 'vendedor desconhecido') as vendedor,
vn.valor_total 
from clientes c
right join vendas vn on c.id_cliente = vn.id_cliente
left join vendedores v on vn.id_vendedor = v.id_vendedor;



-- 7. Pares de clientes que compraram os mesmos produtos: nome de cada cliente, produto em comum e quantidade de cada um. Ordenar por produto.
select 
	c.id_cliente,
    c.nome as cliente,
    c.cidade, 
    count(distinct p.id_categoria) as categorias_compradas
    from clientes c 
    join vendas vn on c.id_cliente = vn.id_cliente
    join itens_venda iv on vn.id_venda = iv.id_venda
    join produtos p on iv.id_produto = p.id_produto
    group by c.id_cliente, c.nome, c.cidade
    HAVING count(distinct p.id_categoria) = (select count(*) from categorias)
    order by c.nome;
    
    
-- 8. Todos os produtos e itens de venda: nome do produto, categoria, quantidade vendida e subtotal. Incluir produtos não vendidos e itens sem produto válido.
    
SELECT
    p.nome AS produto,
    cat.nome AS categoria,
    COALESCE(iv.quantidade, 0) AS quantidade_vendida,
    COALESCE(iv.subtotal, 0) AS subtotal
FROM produtos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
RIGHT JOIN itens_venda iv ON p.id_produto = iv.id_produto
ORDER BY p.nome;

    
    
