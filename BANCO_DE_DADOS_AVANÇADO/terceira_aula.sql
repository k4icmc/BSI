-- ============================================================================
-- Script de Banco de Dados - Sistema de Vendas
-- SGBD: MySQL
-- Registros: 1000+
-- Descrição: Banco de dados para análise de desempenho de vendas
-- ============================================================================

-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS vendas_db;
USE vendas_db;

-- Desabilitar verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS=0;

-- ============================================================================
-- TABELA: nomeestadoclientes
-- ============================================================================
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    cep VARCHAR(10),
    data_cadastro DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: categorias
-- ============================================================================
DROP TABLE IF EXISTS categorias;
CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: produtos
-- ============================================================================
DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(300),
    preco_custo DECIMAL(10, 2) NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0,
    id_categoria INT NOT NULL,
    data_cadastro DATE NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: vendedores
-- ============================================================================
DROP TABLE IF EXISTS vendedores;
CREATE TABLE vendedores (
    id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_admissao DATE NOT NULL,
    salario_base DECIMAL(10, 2),
    comissao_percentual DECIMAL(5, 2) DEFAULT 5.00,
    ativo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: vendas
-- ============================================================================
DROP TABLE IF EXISTS vendas;
CREATE TABLE vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    data_venda DATE NOT NULL,
    data_entrega DATE,
    valor_total DECIMAL(12, 2) NOT NULL,
    desconto DECIMAL(10, 2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Pendente',
    observacoes VARCHAR(300),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: itens_venda
-- ============================================================================
DROP TABLE IF EXISTS itens_venda;
CREATE TABLE itens_venda (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(12, 2) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- INSERIR DADOS: CATEGORIAS
-- ============================================================================
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Informática', 'Computadores e periféricos'),
('Acessórios', 'Acessórios para eletrônicos'),
('Smartphones', 'Telefones celulares e tablets'),
('Áudio', 'Fones, caixas de som e equipamentos de áudio'),
('Impressoras', 'Impressoras e multifuncionais'),
('Monitores', 'Telas e monitores'),
('Teclados e Mouses', 'Periféricos de entrada'),
('Cabos e Conectores', 'Cabos e adaptadores diversos'),
('Softwares', 'Programas e licenças de software');

-- ============================================================================
-- INSERIR DADOS: PRODUTOS (100 produtos)
-- ============================================================================
INSERT INTO produtos (nome, descricao, preco_custo, preco_venda, estoque, id_categoria, data_cadastro, ativo) VALUES
('Notebook Dell Inspiron 15', 'Notebook com processador i5, 8GB RAM', 2500.00, 3200.00, 45, 2, '2025-01-15', TRUE),
('Notebook Lenovo IdeaPad 3', 'Processador Ryzen 5, 8GB RAM, 256GB SSD', 2200.00, 2900.00, 38, 2, '2025-01-16', TRUE),
('Notebook ASUS VivoBook 15', 'Processador i7, 16GB RAM, 512GB SSD', 3500.00, 4500.00, 25, 2, '2025-01-17', TRUE),
('Monitor LG 24 polegadas', 'Full HD, 75Hz, IPS', 800.00, 1100.00, 60, 7, '2025-01-18', TRUE),
('Monitor Samsung 27 polegadas', '4K, 60Hz, VA', 1200.00, 1600.00, 35, 7, '2025-01-19', TRUE),
('Teclado Mecânico RGB', 'Switches azuis, RGB, USB', 200.00, 350.00, 120, 8, '2025-01-20', TRUE),
('Mouse Logitech MX Master 3', 'Sem fio, 4K DPI, ergonômico', 150.00, 280.00, 85, 8, '2025-01-21', TRUE),
('Webcam Logitech C920', 'Full HD, 30fps, microfone integrado', 200.00, 380.00, 70, 1, '2025-01-22', TRUE),
('Headset Gamer HyperX Cloud', 'Som surround 7.1, microfone destacável', 250.00, 450.00, 55, 5, '2025-01-23', TRUE),
('Caixa de Som JBL Flip 6', 'Portátil, Bluetooth, à prova d água', 180.00, 320.00, 95, 5, '2025-01-24', TRUE),
('Smartphone Samsung Galaxy A52', '128GB, 6.5 polegadas, 5G', 1200.00, 1800.00, 40, 4, '2025-01-25', TRUE),
('Smartphone iPhone 13', '128GB, câmera dupla', 2500.00, 3800.00, 20, 4, '2025-01-26', TRUE),
('Tablet Samsung Galaxy Tab S7', '128GB, 11 polegadas, 5G', 1800.00, 2600.00, 30, 4, '2025-01-27', TRUE),
('Impressora HP DeskJet 2774', 'Multifuncional, colorida, WiFi', 400.00, 650.00, 50, 6, '2025-01-28', TRUE),
('Impressora Canon Pixma MG3670', 'Multifuncional, colorida, WiFi', 350.00, 580.00, 45, 6, '2025-01-29', TRUE),
('Cabo HDMI 2.1 Premium', '8K, 2 metros', 30.00, 85.00, 300, 9, '2025-01-30', TRUE),
('Adaptador USB-C para HDMI', '4K, 60Hz', 25.00, 65.00, 250, 9, '2025-01-31', TRUE),
('Hub USB 3.0 com 7 portas', 'Alimentado, velocidade até 5Gbps', 40.00, 120.00, 180, 9, '2025-02-01', TRUE),
('Carregador Rápido 65W USB-C', 'Compatível com múltiplos dispositivos', 35.00, 95.00, 200, 3, '2025-02-02', TRUE),
('Bateria Externa 20000mAh', 'Carregamento rápido, 2 portas USB', 50.00, 130.00, 150, 3, '2025-02-03', TRUE),
('Mochila para Notebook 15.6', 'Compartimentos múltiplos, à prova d água', 45.00, 120.00, 110, 3, '2025-02-04', TRUE),
('Suporte para Notebook', 'Ajustável, alumínio', 30.00, 85.00, 160, 3, '2025-02-05', TRUE),
('Mousepad Grande RGB', '80x30cm, USB', 35.00, 95.00, 140, 3, '2025-02-06', TRUE),
('Ventilador para Notebook', 'Resfriamento ativo, USB', 25.00, 70.00, 180, 3, '2025-02-07', TRUE),
('Limpador de Tela', 'Spray + pano, 200ml', 8.00, 25.00, 500, 3, '2025-02-08', TRUE),
('Protetor de Tela Vidro Temperado', 'Para smartphone 6.5 polegadas', 15.00, 45.00, 400, 3, '2025-02-09', TRUE),
('Capinha para Smartphone', 'Silicone, várias cores', 10.00, 35.00, 600, 3, '2025-02-10', TRUE),
('Película Protetora para Notebook', 'Antirreflexo, 15.6 polegadas', 20.00, 60.00, 250, 3, '2025-02-11', TRUE),
('Suporte para Celular', 'Ajustável, universal', 12.00, 40.00, 350, 3, '2025-02-12', TRUE),
('Organizador de Cabos', 'Silicone, reutilizável', 8.00, 25.00, 450, 3, '2025-02-13', TRUE),
('Processador Intel Core i5-12400', 'LGA1700, 6 núcleos', 800.00, 1200.00, 15, 2, '2025-02-14', TRUE),
('Processador AMD Ryzen 5 5600X', 'AM4, 6 núcleos', 700.00, 1100.00, 12, 2, '2025-02-15', TRUE),
('Placa Mãe ASUS ROG STRIX B550', 'AM4, PCIe 4.0', 600.00, 950.00, 10, 2, '2025-02-16', TRUE),
('Memória RAM 16GB DDR4', 'Velocidade 3200MHz', 200.00, 380.00, 80, 2, '2025-02-17', TRUE),
('SSD 1TB NVMe M.2', 'Velocidade até 3500MB/s', 250.00, 450.00, 70, 2, '2025-02-18', TRUE),
('HD Externo 2TB', 'USB 3.0, portátil', 200.00, 380.00, 90, 2, '2025-02-19', TRUE),
('Fonte 750W 80+ Gold', 'Modular, ventilador silencioso', 350.00, 650.00, 40, 2, '2025-02-20', TRUE),
('Cooler para CPU', 'Torre, compatível com LGA1700', 80.00, 180.00, 120, 2, '2025-02-21', TRUE),
('Placa de Vídeo RTX 3060', '12GB GDDR6', 1500.00, 2200.00, 8, 2, '2025-02-22', TRUE),
('Placa de Vídeo RTX 4060', '8GB GDDR6', 1800.00, 2600.00, 6, 2, '2025-02-23', TRUE),
('Webcam Razer Kiyo', '1080p, 60fps, anel de luz', 250.00, 450.00, 35, 1, '2025-02-24', TRUE),
('Microfone Condensador USB', 'Cardióide, ganho ajustável', 150.00, 350.00, 60, 5, '2025-02-25', TRUE),
('Fone Bluetooth Sony WH-1000XM4', 'Cancelamento de ruído, 30h bateria', 800.00, 1400.00, 25, 5, '2025-02-26', TRUE),
('Fone Bluetooth JBL Tune 750', 'Cancelamento de ruído, 15h bateria', 300.00, 550.00, 50, 5, '2025-02-27', TRUE),
('Caixa de Som Bluetooth Bose', 'Portátil, som premium', 400.00, 750.00, 30, 5, '2025-02-28', TRUE),
('Smartwatch Samsung Galaxy Watch 5', 'AMOLED, 40mm', 800.00, 1200.00, 20, 4, '2025-03-01', TRUE),
('Smartwatch Apple Watch Series 8', 'Retina, 41mm', 1200.00, 1800.00, 15, 4, '2025-03-02', TRUE),
('Carregador Wireless Rápido', '15W, compatível com Qi', 40.00, 100.00, 200, 3, '2025-03-03', TRUE),
('Estação de Carregamento Múltipla', 'Para 3 dispositivos', 60.00, 150.00, 100, 3, '2025-03-04', TRUE),
('Câmera Digital Sony A6400', '24.2MP, 4K', 2500.00, 3800.00, 10, 1, '2025-03-05', TRUE),
('Câmera Digital Canon EOS M50', '24.1MP, 4K', 2000.00, 3200.00, 12, 1, '2025-03-06', TRUE),
('Lente 18-55mm para câmera', 'Zoom óptico 3x', 400.00, 700.00, 20, 1, '2025-03-07', TRUE),
('Tripé para câmera', 'Alumínio, até 1.6m', 80.00, 180.00, 80, 1, '2025-03-08', TRUE),
('Drone DJI Mini 3 Pro', '4K, até 34 minutos voo', 2000.00, 3200.00, 8, 1, '2025-03-09', TRUE),
('Gimbal para smartphone', '3 eixos, estabilização', 150.00, 350.00, 60, 1, '2025-03-10', TRUE),
('Luz LED para estúdio', 'RGB, 50W, controle remoto', 200.00, 450.00, 45, 1, '2025-03-11', TRUE),
('Fundo para estúdio fotográfico', 'Tecido, 2x3m, suporte', 80.00, 200.00, 30, 1, '2025-03-12', TRUE),
('Roteador WiFi 6 ASUS', 'AX3000, 3 antenas', 300.00, 650.00, 50, 1, '2025-03-13', TRUE),
('Modem Roteador Intelbras', 'WiFi 5, 300Mbps', 150.00, 350.00, 80, 1, '2025-03-14', TRUE),
('Switch de Rede 24 portas', 'Gigabit, gerenciável', 400.00, 900.00, 20, 1, '2025-03-15', TRUE),
('Cabo de Rede Cat6 30m', 'Blindado, velocidade até 10Gbps', 50.00, 120.00, 150, 9, '2025-03-16', TRUE),
('Antena WiFi externa', '9dBi, omnidirecional', 40.00, 100.00, 100, 1, '2025-03-17', TRUE),
('Repetidor WiFi', 'Dual band, 300Mbps', 80.00, 200.00, 120, 1, '2025-03-18', TRUE),
('Webcam Full HD com microfone', 'Ângulo 90 graus', 120.00, 280.00, 100, 1, '2025-03-19', TRUE),
('Teclado sem fio 2.4GHz', 'Bateria 18 meses', 60.00, 150.00, 180, 8, '2025-03-20', TRUE),
('Mouse sem fio 2.4GHz', 'Bateria 18 meses, 1600 DPI', 40.00, 110.00, 220, 8, '2025-03-21', TRUE),
('Combo Teclado + Mouse', 'Sem fio, USB', 80.00, 200.00, 150, 8, '2025-03-22', TRUE),
('Mousepad com carregamento wireless', 'Carrega dispositivos Qi', 50.00, 130.00, 90, 8, '2025-03-23', TRUE),
('Suporte articulado para monitor', 'Ajustável, até 27 polegadas', 120.00, 300.00, 70, 3, '2025-03-24', TRUE),
('Braço articulado para monitor', 'Até 32 polegadas, VESA', 200.00, 500.00, 50, 3, '2025-03-25', TRUE),
('Cadeira gamer', 'Reclinável, apoio para pescoço', 800.00, 1500.00, 30, 3, '2025-03-26', TRUE),
('Mesa para computador', 'Altura ajustável, 1.4m', 400.00, 900.00, 40, 3, '2025-03-27', TRUE),
('Desk Pad grande', '80x40cm, borracha natural', 40.00, 100.00, 200, 3, '2025-03-28', TRUE),
('Organizador de mesa', 'Madeira, 5 compartimentos', 30.00, 80.00, 250, 3, '2025-03-29', TRUE),
('Luminária LED para mesa', 'Ajustável, 3 temperaturas', 50.00, 130.00, 160, 3, '2025-03-30', TRUE),
('Ventilador de mesa USB', 'Silencioso, 3 velocidades', 30.00, 80.00, 200, 3, '2025-03-31', TRUE),
('Umidificador de ar', 'Ultrassônico, 2L', 60.00, 150.00, 120, 3, '2025-04-01', TRUE),
('Purificador de ar', 'HEPA, 3 estágios', 200.00, 450.00, 80, 3, '2025-04-02', TRUE),
('Termômetro digital infravermelho', 'Sem contato, rápido', 40.00, 100.00, 300, 1, '2025-04-03', TRUE),
('Relógio inteligente com GPS', 'Monitor cardíaco, à prova d água', 400.00, 800.00, 35, 4, '2025-04-04', TRUE),
('Pulseira fitness', 'Monitor de atividades, 7 dias bateria', 100.00, 250.00, 150, 4, '2025-04-05', TRUE),
('Balança inteligente', 'Bluetooth, análise corporal', 80.00, 200.00, 100, 4, '2025-04-06', TRUE),
('Lâmpada inteligente RGB', 'WiFi, 16 milhões cores', 40.00, 100.00, 250, 1, '2025-04-07', TRUE),
('Tomada inteligente WiFi', 'Controle remoto, cronômetro', 30.00, 80.00, 300, 1, '2025-04-08', TRUE),
('Fechadura inteligente', 'Biométrica, WiFi', 400.00, 900.00, 25, 1, '2025-04-09', TRUE),
('Câmera de segurança WiFi', '1080p, visão noturna, áudio', 150.00, 350.00, 100, 1, '2025-04-10', TRUE),
('Sensor de movimento', 'WiFi, bateria 2 anos', 40.00, 100.00, 200, 1, '2025-04-11', TRUE),
('Sensor de porta/janela', 'WiFi, magnético', 30.00, 80.00, 250, 1, '2025-04-12', TRUE),
('Hub inteligente', 'Compatível com Alexa e Google', 100.00, 250.00, 80, 1, '2025-04-13', TRUE),
('Caixa de som inteligente', 'Alexa integrada, 360 graus', 200.00, 450.00, 60, 5, '2025-04-14', TRUE),
('Termostato inteligente', 'WiFi, economia de energia', 150.00, 350.00, 70, 1, '2025-04-15', TRUE),
('Relógio despertador inteligente', 'Bluetooth, carregamento wireless', 80.00, 200.00, 120, 4, '2025-04-16', TRUE),
('Ventilador inteligente', 'WiFi, controle por app', 120.00, 300.00, 90, 1, '2025-04-17', TRUE),
('Ar condicionado inteligente', 'WiFi, controle remoto', 1200.00, 2200.00, 15, 1, '2025-04-18', TRUE),
('Geladeira inteligente', 'WiFi, câmera interna', 2000.00, 3800.00, 5, 1, '2025-04-19', TRUE),
('Fogão inteligente', 'WiFi, controle remoto', 1500.00, 2800.00, 8, 1, '2025-04-20', TRUE),
('Máquina de lavar inteligente', 'WiFi, ciclos automáticos', 1800.00, 3200.00, 6, 1, '2025-04-21', TRUE),
('Secadora inteligente', 'WiFi, sensor de umidade', 1600.00, 2900.00, 7, 1, '2025-04-22', TRUE),
('Forno inteligente', 'WiFi, pré-aquecimento remoto', 1200.00, 2200.00, 10, 1, '2025-04-23', TRUE),
('Micro-ondas inteligente', 'WiFi, receitas automáticas', 400.00, 800.00, 30, 1, '2025-04-24', TRUE),
('Cafeteira inteligente', 'WiFi, agendamento', 200.00, 450.00, 80, 1, '2025-04-25', TRUE),
('Chaleira inteligente', 'WiFi, temperatura ajustável', 100.00, 250.00, 120, 1, '2025-04-26', TRUE),
('Liquidificador inteligente', 'WiFi, receitas pré-programadas', 300.00, 650.00, 50, 1, '2025-04-27', TRUE),
('Processador de alimentos inteligente', 'WiFi, múltiplas funções', 250.00, 550.00, 60, 1, '2025-04-28', TRUE),
('Panela de pressão elétrica', 'WiFi, 10 programas', 200.00, 450.00, 75, 1, '2025-04-29', TRUE),
('Fritadeira elétrica inteligente', 'WiFi, sem óleo', 150.00, 350.00, 100, 1, '2025-04-30', TRUE);

-- ============================================================================
-- INSERIR DADOS: CLIENTES (150 clientes)
-- ============================================================================
INSERT INTO clientes (nome, email, telefone, endereco, cidade, estado, cep, data_cadastro, ativo) VALUES
('João Silva', 'joao.silva@email.com', '11987654321', 'Rua A, 123', 'São Paulo', 'SP', '01234567', '2024-01-10', TRUE),
('Maria Santos', 'maria.santos@email.com', '11987654322', 'Rua B, 456', 'São Paulo', 'SP', '01234568', '2024-01-11', TRUE),
('Pedro Oliveira', 'pedro.oliveira@email.com', '11987654323', 'Rua C, 789', 'São Paulo', 'SP', '01234569', '2024-01-12', TRUE),
('Ana Costa', 'ana.costa@email.com', '11987654324', 'Rua D, 101', 'São Paulo', 'SP', '01234570', '2024-01-13', TRUE),
('Carlos Ferreira', 'carlos.ferreira@email.com', '11987654325', 'Rua E, 202', 'São Paulo', 'SP', '01234571', '2024-01-14', TRUE),
('Juliana Gomes', 'juliana.gomes@email.com', '11987654326', 'Rua F, 303', 'São Paulo', 'SP', '01234572', '2024-01-15', TRUE),
('Roberto Alves', 'roberto.alves@email.com', '11987654327', 'Rua G, 404', 'São Paulo', 'SP', '01234573', '2024-01-16', TRUE),
('Fernanda Rocha', 'fernanda.rocha@email.com', '11987654328', 'Rua H, 505', 'São Paulo', 'SP', '01234574', '2024-01-17', TRUE),
('Lucas Martins', 'lucas.martins@email.com', '11987654329', 'Rua I, 606', 'São Paulo', 'SP', '01234575', '2024-01-18', TRUE),
('Beatriz Lima', 'beatriz.lima@email.com', '11987654330', 'Rua J, 707', 'São Paulo', 'SP', '01234576', '2024-01-19', TRUE),
('Felipe Cardoso', 'felipe.cardoso@email.com', '21987654331', 'Avenida K, 808', 'Rio de Janeiro', 'RJ', '20000001', '2024-01-20', TRUE),
('Camila Barbosa', 'camila.barbosa@email.com', '21987654332', 'Avenida L, 909', 'Rio de Janeiro', 'RJ', '20000002', '2024-01-21', TRUE),
('Gustavo Pereira', 'gustavo.pereira@email.com', '21987654333', 'Avenida M, 1010', 'Rio de Janeiro', 'RJ', '20000003', '2024-01-22', TRUE),
('Isabela Mendes', 'isabela.mendes@email.com', '21987654334', 'Avenida N, 1111', 'Rio de Janeiro', 'RJ', '20000004', '2024-01-23', TRUE),
('Thiago Sousa', 'thiago.sousa@email.com', '21987654335', 'Avenida O, 1212', 'Rio de Janeiro', 'RJ', '20000005', '2024-01-24', TRUE),
('Larissa Dias', 'larissa.dias@email.com', '31987654336', 'Rua P, 1313', 'Belo Horizonte', 'MG', '30000001', '2024-01-25', TRUE),
('Matheus Ribeiro', 'matheus.ribeiro@email.com', '31987654337', 'Rua Q, 1414', 'Belo Horizonte', 'MG', '30000002', '2024-01-26', TRUE),
('Sophia Teixeira', 'sophia.teixeira@email.com', '31987654338', 'Rua R, 1515', 'Belo Horizonte', 'MG', '30000003', '2024-01-27', TRUE),
('Vinicius Campos', 'vinicius.campos@email.com', '31987654339', 'Rua S, 1616', 'Belo Horizonte', 'MG', '30000004', '2024-01-28', TRUE),
('Natalia Neves', 'natalia.neves@email.com', '31987654340', 'Rua T, 1717', 'Belo Horizonte', 'MG', '30000005', '2024-01-29', TRUE),
('Diego Lopes', 'diego.lopes@email.com', '41987654341', 'Rua U, 1818', 'Curitiba', 'PR', '80000001', '2024-01-30', TRUE),
('Rafaela Monteiro', 'rafaela.monteiro@email.com', '41987654342', 'Rua V, 1919', 'Curitiba', 'PR', '80000002', '2024-01-31', TRUE),
('Henrique Pinto', 'henrique.pinto@email.com', '41987654343', 'Rua W, 2020', 'Curitiba', 'PR', '80000003', '2024-02-01', TRUE),
('Mariana Duarte', 'mariana.duarte@email.com', '41987654344', 'Rua X, 2121', 'Curitiba', 'PR', '80000004', '2024-02-02', TRUE),
('Bruno Cavalcanti', 'bruno.cavalcanti@email.com', '41987654345', 'Rua Y, 2222', 'Curitiba', 'PR', '80000005', '2024-02-03', TRUE),
('Leticia Machado', 'leticia.machado@email.com', '51987654346', 'Rua Z, 2323', 'Porto Alegre', 'RS', '90000001', '2024-02-04', TRUE),
('Rodrigo Vieira', 'rodrigo.vieira@email.com', '51987654347', 'Avenida AA, 2424', 'Porto Alegre', 'RS', '90000002', '2024-02-05', TRUE),
('Patricia Rocha', 'patricia.rocha@email.com', '51987654348', 'Avenida AB, 2525', 'Porto Alegre', 'RS', '90000003', '2024-02-06', TRUE),
('Marcelo Goulart', 'marcelo.goulart@email.com', '51987654349', 'Avenida AC, 2626', 'Porto Alegre', 'RS', '90000004', '2024-02-07', TRUE),
('Viviane Oliveira', 'viviane.oliveira@email.com', '51987654350', 'Avenida AD, 2727', 'Porto Alegre', 'RS', '90000005', '2024-02-08', TRUE),
('Fabio Correa', 'fabio.correa@email.com', '61987654351', 'Rua AE, 2828', 'Brasília', 'DF', '70000001', '2024-02-09', TRUE),
('Aline Martins', 'aline.martins@email.com', '61987654352', 'Rua AF, 2929', 'Brasília', 'DF', '70000002', '2024-02-10', TRUE),
('Sergio Barros', 'sergio.barros@email.com', '61987654353', 'Rua AG, 3030', 'Brasília', 'DF', '70000003', '2024-02-11', TRUE),
('Claudia Leite', 'claudia.leite@email.com', '61987654354', 'Rua AH, 3131', 'Brasília', 'DF', '70000004', '2024-02-12', TRUE),
('Andres Rojas', 'andres.rojas@email.com', '61987654355', 'Rua AI, 3232', 'Brasília', 'DF', '70000005', '2024-02-13', TRUE),
('Vanessa Souza', 'vanessa.souza@email.com', '71987654356', 'Rua AJ, 3333', 'Salvador', 'BA', '40000001', '2024-02-14', TRUE),
('Leandro Farias', 'leandro.farias@email.com', '71987654357', 'Rua AK, 3434', 'Salvador', 'BA', '40000002', '2024-02-15', TRUE),
('Priscila Nunes', 'priscila.nunes@email.com', '71987654358', 'Rua AL, 3535', 'Salvador', 'BA', '40000003', '2024-02-16', TRUE),
('Cristian Mota', 'cristian.mota@email.com', '71987654359', 'Rua AM, 3636', 'Salvador', 'BA', '40000004', '2024-02-17', TRUE),
('Debora Ramos', 'debora.ramos@email.com', '71987654360', 'Rua AN, 3737', 'Salvador', 'BA', '40000005', '2024-02-18', TRUE),
('Emerson Silva', 'emerson.silva@email.com', '81987654361', 'Rua AO, 3838', 'Fortaleza', 'CE', '60000001', '2024-02-19', TRUE),
('Fernanda Gomes', 'fernanda.gomes@email.com', '81987654362', 'Rua AP, 3939', 'Fortaleza', 'CE', '60000002', '2024-02-20', TRUE),
('Gerson Almeida', 'gerson.almeida@email.com', '81987654363', 'Rua AQ, 4040', 'Fortaleza', 'CE', '60000003', '2024-02-21', TRUE),
('Heloisa Brandao', 'heloisa.brandao@email.com', '81987654364', 'Rua AR, 4141', 'Fortaleza', 'CE', '60000004', '2024-02-22', TRUE),
('Igor Ferreira', 'igor.ferreira@email.com', '81987654365', 'Rua AS, 4242', 'Fortaleza', 'CE', '60000005', '2024-02-23', TRUE),
('Jacqueline Pires', 'jacqueline.pires@email.com', '85987654366', 'Rua AT, 4343', 'Recife', 'PE', '50000001', '2024-02-24', TRUE),
('Kleberson Lopes', 'kleberson.lopes@email.com', '85987654367', 'Rua AU, 4444', 'Recife', 'PE', '50000002', '2024-02-25', TRUE),
('Lidia Carvalho', 'lidia.carvalho@email.com', '85987654368', 'Rua AV, 4545', 'Recife', 'PE', '50000003', '2024-02-26', TRUE),
('Mauricio Tavares', 'mauricio.tavares@email.com', '85987654369', 'Rua AW, 4646', 'Recife', 'PE', '50000004', '2024-02-27', TRUE),
('Neusa Ribeiro', 'neusa.ribeiro@email.com', '85987654370', 'Rua AX, 4747', 'Recife', 'PE', '50000005', '2024-02-28', TRUE),
('Otavio Mendes', 'otavio.mendes@email.com', '92987654371', 'Rua AY, 4848', 'Manaus', 'AM', '69000001', '2024-03-01', TRUE),
('Patricia Cardoso', 'patricia.cardoso@email.com', '92987654372', 'Rua AZ, 4949', 'Manaus', 'AM', '69000002', '2024-03-02', TRUE),
('Quirino Sousa', 'quirino.sousa@email.com', '92987654373', 'Rua BA, 5050', 'Manaus', 'AM', '69000003', '2024-03-03', TRUE),
('Raquel Oliveira', 'raquel.oliveira@email.com', '92987654374', 'Rua BB, 5151', 'Manaus', 'AM', '69000004', '2024-03-04', TRUE),
('Samuel Costa', 'samuel.costa@email.com', '92987654375', 'Rua BC, 5252', 'Manaus', 'AM', '69000005', '2024-03-05', TRUE),
('Tatiana Rocha', 'tatiana.rocha@email.com', '95987654376', 'Rua BD, 5353', 'Boa Vista', 'RR', '69300001', '2024-03-06', TRUE),
('Ulisses Martins', 'ulisses.martins@email.com', '95987654377', 'Rua BE, 5454', 'Boa Vista', 'RR', '69300002', '2024-03-07', TRUE),
('Vanilda Gomes', 'vanilda.gomes@email.com', '95987654378', 'Rua BF, 5555', 'Boa Vista', 'RR', '69300003', '2024-03-08', TRUE),
('Wagner Alves', 'wagner.alves@email.com', '95987654379', 'Rua BG, 5656', 'Boa Vista', 'RR', '69300004', '2024-03-09', TRUE),
('Ximena Pereira', 'ximena.pereira@email.com', '95987654380', 'Rua BH, 5757', 'Boa Vista', 'RR', '69300005', '2024-03-10', TRUE),
('Yuri Barbosa', 'yuri.barbosa@email.com', '63987654381', 'Rua BI, 5858', 'Teresina', 'PI', '64000001', '2024-03-11', TRUE),
('Zelia Neves', 'zelia.neves@email.com', '63987654382', 'Rua BJ, 5959', 'Teresina', 'PI', '64000002', '2024-03-12', TRUE),
('Adalberto Lopes', 'adalberto.lopes@email.com', '63987654383', 'Rua BK, 6060', 'Teresina', 'PI', '64000003', '2024-03-13', TRUE),
('Benedita Teixeira', 'benedita.teixeira@email.com', '63987654384', 'Rua BL, 6161', 'Teresina', 'PI', '64000004', '2024-03-14', TRUE),
('Casimiro Duarte', 'casimiro.duarte@email.com', '63987654385', 'Rua BM, 6262', 'Teresina', 'PI', '64000005', '2024-03-15', TRUE),
('Delfina Machado', 'delfina.machado@email.com', '67987654386', 'Rua BN, 6363', 'Campo Grande', 'MS', '79000001', '2024-03-16', TRUE),
('Evaristo Vieira', 'evaristo.vieira@email.com', '67987654387', 'Rua BO, 6464', 'Campo Grande', 'MS', '79000002', '2024-03-17', TRUE),
('Fatima Rocha', 'fatima.rocha@email.com', '67987654388', 'Rua BP, 6565', 'Campo Grande', 'MS', '79000003', '2024-03-18', TRUE),
('Getulio Correa', 'getulio.correa@email.com', '67987654389', 'Rua BQ, 6666', 'Campo Grande', 'MS', '79000004', '2024-03-19', TRUE),
('Herminia Barros', 'herminia.barros@email.com', '67987654390', 'Rua BR, 6767', 'Campo Grande', 'MS', '79000005', '2024-03-20', TRUE),
('Irineu Cardoso', 'irineu.cardoso@email.com', '62987654391', 'Rua BS, 6868', 'Goiânia', 'GO', '74000001', '2024-03-21', TRUE),
('Joana Leite', 'joana.leite@email.com', '62987654392', 'Rua BT, 6969', 'Goiânia', 'GO', '74000002', '2024-03-22', TRUE),
('Kassio Souza', 'kassio.souza@email.com', '62987654393', 'Rua BU, 7070', 'Goiânia', 'GO', '74000003', '2024-03-23', TRUE),
('Lourdes Farias', 'lourdes.farias@email.com', '62987654394', 'Rua BV, 7171', 'Goiânia', 'GO', '74000004', '2024-03-24', TRUE),
('Moacir Nunes', 'moacir.nunes@email.com', '62987654395', 'Rua BW, 7272', 'Goiânia', 'GO', '74000005', '2024-03-25', TRUE),
('Noelia Mota', 'noelia.mota@email.com', '65987654396', 'Rua BX, 7373', 'Cuiabá', 'MT', '78000001', '2024-03-26', TRUE),
('Olegario Ramos', 'olegario.ramos@email.com', '65987654397', 'Rua BY, 7474', 'Cuiabá', 'MT', '78000002', '2024-03-27', TRUE),
('Palmira Silva', 'palmira.silva@email.com', '65987654398', 'Rua BZ, 7575', 'Cuiabá', 'MT', '78000003', '2024-03-28', TRUE),
('Quirino Gomes', 'quirino.gomes@email.com', '65987654399', 'Rua CA, 7676', 'Cuiabá', 'MT', '78000004', '2024-03-29', TRUE),
('Rosalia Almeida', 'rosalia.almeida@email.com', '65987654400', 'Rua CB, 7777', 'Cuiabá', 'MT', '78000005', '2024-03-30', TRUE),
('Sebastiao Brandao', 'sebastiao.brandao@email.com', '47987654401', 'Rua CC, 7878', 'Joinville', 'SC', '89000001', '2024-03-31', TRUE),
('Teodora Pires', 'teodora.pires@email.com', '47987654402', 'Rua CD, 7979', 'Joinville', 'SC', '89000002', '2024-04-01', TRUE),
('Ubaldo Lopes', 'ubaldo.lopes@email.com', '47987654403', 'Rua CE, 8080', 'Joinville', 'SC', '89000003', '2024-04-02', TRUE),
('Valeria Carvalho', 'valeria.carvalho@email.com', '47987654404', 'Rua CF, 8181', 'Joinville', 'SC', '89000004', '2024-04-03', TRUE),
('Waldemar Tavares', 'waldemar.tavares@email.com', '47987654405', 'Rua CG, 8282', 'Joinville', 'SC', '89000005', '2024-04-04', TRUE),
('Xenia Mendes', 'xenia.mendes@email.com', '85987654406', 'Rua CH, 8383', 'Caucaia', 'CE', '61600001', '2024-04-05', TRUE),
('Yara Cardoso', 'yara.cardoso@email.com', '85987654407', 'Rua CI, 8484', 'Caucaia', 'CE', '61600002', '2024-04-06', TRUE),
('Zacarias Sousa', 'zacarias.sousa@email.com', '85987654408', 'Rua CJ, 8585', 'Caucaia', 'CE', '61600003', '2024-04-07', TRUE),
('Alicia Oliveira', 'alicia.oliveira@email.com', '85987654409', 'Rua CK, 8686', 'Caucaia', 'CE', '61600004', '2024-04-08', TRUE),
('Baltazar Rocha', 'baltazar.rocha@email.com', '85987654410', 'Rua CL, 8787', 'Caucaia', 'CE', '61600005', '2024-04-09', TRUE),
('Cecilia Martins', 'cecilia.martins@email.com', '11987654411', 'Rua CM, 8888', 'Guarulhos', 'SP', '07000001', '2024-04-10', TRUE),
('Donato Gomes', 'donato.gomes@email.com', '11987654412', 'Rua CN, 8989', 'Guarulhos', 'SP', '07000002', '2024-04-11', TRUE),
('Elvira Alves', 'elvira.alves@email.com', '11987654413', 'Rua CO, 9090', 'Guarulhos', 'SP', '07000003', '2024-04-12', TRUE),
('Fabiano Pereira', 'fabiano.pereira@email.com', '11987654414', 'Rua CP, 9191', 'Guarulhos', 'SP', '07000004', '2024-04-13', TRUE),
('Gabriela Neves', 'gabriela.neves@email.com', '11987654415', 'Rua CQ, 9292', 'Guarulhos', 'SP', '07000005', '2024-04-14', TRUE),
('Hilario Dias', 'hilario.dias@email.com', '21987654416', 'Rua CR, 9393', 'Niterói', 'RJ', '24000001', '2024-04-15', TRUE),
('Irene Farias', 'irene.farias@email.com', '21987654417', 'Rua CS, 9494', 'Niterói', 'RJ', '24000002', '2024-04-16', TRUE),
('Jarbas Lopes', 'jarbas.lopes@email.com', '21987654418', 'Rua CT, 9595', 'Niterói', 'RJ', '24000003', '2024-04-17', TRUE),
('Karolina Carvalho', 'karolina.carvalho@email.com', '21987654419', 'Rua CU, 9696', 'Niterói', 'RJ', '24000004', '2024-04-18', TRUE),
('Leonidas Tavares', 'leonidas.tavares@email.com', '21987654420', 'Rua CV, 9797', 'Niterói', 'RJ', '24000005', '2024-04-19', TRUE),
('Marisa Mendes', 'marisa.mendes@email.com', '31987654421', 'Rua CW, 9898', 'Contagem', 'MG', '32000001', '2024-04-20', TRUE),
('Narciso Cardoso', 'narciso.cardoso@email.com', '31987654422', 'Rua CX, 9999', 'Contagem', 'MG', '32000002', '2024-04-21', TRUE),
('Odete Sousa', 'odete.sousa@email.com', '31987654423', 'Rua CY, 10000', 'Contagem', 'MG', '32000003', '2024-04-22', TRUE),
('Percival Oliveira', 'percival.oliveira@email.com', '31987654424', 'Rua CZ, 10101', 'Contagem', 'MG', '32000004', '2024-04-23', TRUE),
('Quincia Rocha', 'quincia.rocha@email.com', '31987654425', 'Rua DA, 10202', 'Contagem', 'MG', '32000005', '2024-04-24', TRUE);

-- ============================================================================
-- INSERIR DADOS: VENDEDORES (30 vendedores)
-- ============================================================================
INSERT INTO vendedores (nome, email, telefone, data_admissao, salario_base, comissao_percentual, ativo) VALUES
('Vendedor 1', 'vendedor1@empresa.com', '11999999001', '2023-01-15', 3000.00, 5.00, TRUE),
('Vendedor 2', 'vendedor2@empresa.com', '11999999002', '2023-01-20', 3000.00, 5.00, TRUE),
('Vendedor 3', 'vendedor3@empresa.com', '11999999003', '2023-02-10', 3200.00, 5.50, TRUE),
('Vendedor 4', 'vendedor4@empresa.com', '11999999004', '2023-02-15', 3200.00, 5.50, TRUE),
('Vendedor 5', 'vendedor5@empresa.com', '11999999005', '2023-03-01', 3500.00, 6.00, TRUE),
('Vendedor 6', 'vendedor6@empresa.com', '11999999006', '2023-03-10', 3500.00, 6.00, TRUE),
('Vendedor 7', 'vendedor7@empresa.com', '11999999007', '2023-04-05', 3000.00, 5.00, TRUE),
('Vendedor 8', 'vendedor8@empresa.com', '11999999008', '2023-04-15', 3200.00, 5.50, TRUE),
('Vendedor 9', 'vendedor9@empresa.com', '11999999009', '2023-05-01', 3500.00, 6.00, TRUE),
('Vendedor 10', 'vendedor10@empresa.com', '11999999010', '2023-05-10', 3000.00, 5.00, TRUE),
('Vendedor 11', 'vendedor11@empresa.com', '21999999011', '2023-06-01', 3200.00, 5.50, TRUE),
('Vendedor 12', 'vendedor12@empresa.com', '21999999012', '2023-06-15', 3500.00, 6.00, TRUE),
('Vendedor 13', 'vendedor13@empresa.com', '21999999013', '2023-07-01', 3000.00, 5.00, TRUE),
('Vendedor 14', 'vendedor14@empresa.com', '21999999014', '2023-07-15', 3200.00, 5.50, TRUE),
('Vendedor 15', 'vendedor15@empresa.com', '21999999015', '2023-08-01', 3500.00, 6.00, TRUE),
('Vendedor 16', 'vendedor16@empresa.com', '31999999016', '2023-08-15', 3000.00, 5.00, TRUE),
('Vendedor 17', 'vendedor17@empresa.com', '31999999017', '2023-09-01', 3200.00, 5.50, TRUE),
('Vendedor 18', 'vendedor18@empresa.com', '31999999018', '2023-09-15', 3500.00, 6.00, TRUE),
('Vendedor 19', 'vendedor19@empresa.com', '31999999019', '2023-10-01', 3000.00, 5.00, TRUE),
('Vendedor 20', 'vendedor20@empresa.com', '31999999020', '2023-10-15', 3200.00, 5.50, TRUE),
('Vendedor 21', 'vendedor21@empresa.com', '41999999021', '2023-11-01', 3500.00, 6.00, TRUE),
('Vendedor 22', 'vendedor22@empresa.com', '41999999022', '2023-11-15', 3000.00, 5.00, TRUE),
('Vendedor 23', 'vendedor23@empresa.com', '41999999023', '2023-12-01', 3200.00, 5.50, TRUE),
('Vendedor 24', 'vendedor24@empresa.com', '41999999024', '2023-12-15', 3500.00, 6.00, TRUE),
('Vendedor 25', 'vendedor25@empresa.com', '51999999025', '2024-01-01', 3000.00, 5.00, TRUE),
('Vendedor 26', 'vendedor26@empresa.com', '51999999026', '2024-01-15', 3200.00, 5.50, TRUE),
('Vendedor 27', 'vendedor27@empresa.com', '51999999027', '2024-02-01', 3500.00, 6.00, TRUE),
('Vendedor 28', 'vendedor28@empresa.com', '51999999028', '2024-02-15', 3000.00, 5.00, TRUE),
('Vendedor 29', 'vendedor29@empresa.com', '61999999029', '2024-03-01', 3200.00, 5.50, TRUE),
('Vendedor 30', 'vendedor30@empresa.com', '61999999030', '2024-03-15', 3500.00, 6.00, TRUE);

-- ============================================================================
-- GERAR 1000+ VENDAS COM ITENS
-- ============================================================================
-- Script Python será usado para gerar os dados de vendas de forma eficiente
-- Aqui criamos um procedimento armazenado para inserir dados em lote

DELIMITER //

CREATE PROCEDURE gerar_vendas_em_lote()
BEGIN
    DECLARE v_contador INT DEFAULT 0;
    DECLARE v_id_cliente INT;
    DECLARE v_id_vendedor INT;
    DECLARE v_id_produto INT;
    DECLARE v_data_venda DATE;
    DECLARE v_quantidade INT;
    DECLARE v_preco_venda DECIMAL(10, 2);
    DECLARE v_subtotal DECIMAL(12, 2);
    DECLARE v_valor_total DECIMAL(12, 2);
    DECLARE v_id_venda INT;
    DECLARE v_num_itens INT;
    DECLARE v_item_contador INT;
    
    WHILE v_contador < 1000 DO
        -- Selecionar cliente aleatório
        SET v_id_cliente = FLOOR(1 + RAND() * 150);
        
        -- Selecionar vendedor aleatório
        SET v_id_vendedor = FLOOR(1 + RAND() * 30);
        
        -- Data da venda entre 2024-01-01 e 2025-02-25
        SET v_data_venda = DATE_ADD('2024-01-01', INTERVAL FLOOR(RAND() * 420) DAY);
        
        -- Inserir venda
        INSERT INTO vendas (id_cliente, id_vendedor, data_venda, valor_total, status)
        VALUES (v_id_cliente, v_id_vendedor, v_data_venda, 0, 'Concluída');
        
        SET v_id_venda = LAST_INSERT_ID();
        SET v_valor_total = 0;
        
        
        -- Gerar entre 1 e 5 itens por venda
        SET v_num_itens = FLOOR(1 + RAND() * 5);
        SET v_item_contador = 0;
        
        WHILE v_item_contador < v_num_itens DO
            -- Selecionar produto aleatório
            SET v_id_produto = FLOOR(1 + RAND() * 100);
            
            -- Quantidade entre 1 e 10
            SET v_quantidade = FLOOR(1 + RAND() * 10);
            
            -- Obter preço do produto
            SELECT preco_venda INTO v_preco_venda FROM produtos WHERE id_produto = v_id_produto;
            
            -- Calcular subtotal
            SET v_subtotal = v_quantidade * v_preco_venda;
            
            -- Inserir item da venda
            INSERT INTO itens_venda (id_venda, id_produto, quantidade, preco_unitario, subtotal)
            VALUES (v_id_venda, v_id_produto, v_quantidade, v_preco_venda, v_subtotal);
            
            -- Acumular valor total
            SET v_valor_total = v_valor_total + v_subtotal;
            
            SET v_item_contador = v_item_contador + 1;
        END WHILE;
        
        -- Atualizar valor total da venda
        UPDATE vendas SET valor_total = v_valor_total WHERE id_venda = v_id_venda;
        
        SET v_contador = v_contador + 1;
    END WHILE;
END //

DELIMITER ;

-- Executar procedimento para gerar vendas
CALL gerar_vendas_em_lote();

-- Reabilitar verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS=1;


-- ============================================================================
-- CRIAR ÍNDICES PARA MELHOR DESEMPENHO
-- ============================================================================
CREATE INDEX idx_vendas_cliente ON vendas(id_cliente);

CREATE INDEX idx_vendas_vendedor ON vendas(id_vendedor);
CREATE INDEX idx_vendas_data ON vendas(data_venda);
CREATE INDEX idx_itens_venda ON itens_venda(id_venda);
CREATE INDEX idx_itens_produto ON itens_venda(id_produto);
CREATE INDEX idx_produtos_categoria ON produtos(id_categoria);
CREATE INDEX idx_clientes_cidade ON clientes(cidade);

-- ============================================================================
-- VERIFICAR QUANTIDADE DE REGISTROS
-- ============================================================================
SELECT 'Clientes' AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'Categorias', COUNT(*) FROM categorias
UNION ALL
SELECT 'Produtos', COUNT(*) FROM produtos
UNION ALL
SELECT 'Vendedores', COUNT(*) FROM vendedores
UNION ALL
SELECT 'Vendas', COUNT(*) FROM vendas
UNION ALL
SELECT 'Itens Venda', COUNT(*) FROM itens_venda;

-- ============================================================================
-- FIM DO SCRIPT
-- ============================================================================









-- 01 - Quem são os nossos melhores clientes?
-- Listar os clientes ordenados pelo valor total comprado (R$) em ordem decrescente.

-- 02 - Qual vendedor é o destaque do mês?
-- Identificar o vendedor que realizou o maior volume total de vendas.

-- 03 - Clientes VIP
-- Liste os nomes dos clientes que gastaram mais de R$ 2.000,00 no total de suas compras.

-- 04 - Produto Estrela
-- Qual é o produto mais vendido em quantidade total? Queremos apenas o campeão.


-- primeira

-- lsite o nome dos clientes que gastaram mais de R$ 2.0000
-- no total de suas compras.alter
select clientes.nome, 
vendas.valor_total, 
vendedores.nome as vendedor, 
vendas.data_venda
from vendas
join clientes on vendas.id_cliente=clientes.id_cliente
join vendedores on vendedores.id_vendedor=vendas.id_vendedor
order by vendas.data_venda desc;


-- segunda questão ⬇️
SELECT 
    vendedores.nome,
    COUNT(vendas.id_venda) AS total_vendas,
    SUM(vendas.valor_total) AS valor_total
FROM vendedores 
JOIN vendas ON vendedores.id_vendedor = vendas.id_vendedor
GROUP BY vendedores.id_vendedor, vendedores.nome
ORDER BY valor_total DESC;
-- LIMIT 1;


-- terceira questão
SELECT
    c.nome AS cliente,
    SUM(v.valor_total) AS valor_total
FROM clientes c
JOIN vendas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome
HAVING SUM(v.valor_total) > 2000
ORDER BY valor_total DESC;


-- quarta questão
SELECT 
	p.nome as produto,
    c.nome as categoria,
    sum(iv.quantidade) AS quantidade_total_vendida
FROM produtos p
JOIN itens_venda iv ON p.id_produto = iv.id_produto
JOIN categorias c on p.id_categoria=c.id_categoria
GROUP BY p.id_produto, p.nome, c.nome
ORDER BY quantidade_total_vendida DESC
LIMIT 1;
