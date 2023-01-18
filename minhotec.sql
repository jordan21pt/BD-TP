CREATE DATABASE IF NOT EXISTS MinhoTec 
DEFAULT CHARACTER SET utf8;
SHOW WARNINGS;

-- Indicação da base de dados de trabalho
USE MinhoTec;
-- -------------------------------------
-- Apagar a Base de dados
-- DROP DATABASE minhotec;

-- -------------------------------------
-- Criação das tabelas da base de dados
-- -------------------------------------
-- Criação da Tabela "Cliente"
-- DROP TABLE Cliente;
-- DESC Cliente;
-- -------------------------------------
CREATE TABLE Cliente(
IdCliente INT NOT NULL,
Nome VARCHAR(75) NOT NULL,
Email VARCHAR(150) NOT NULL,
RuaEndereco VARCHAR(100) NOT NULL,
Telemovel INT NOT NULL,
DataNascimento DATE NOT NULL,
Historico VARCHAR(75),
CodPostalEndereco VARCHAR(75) NOT NULL,
LocalidadeEndereco VARCHAR(75) NOT NULL,
Contribuinte INT NOT NULL,

PRIMARY KEY(IdCliente),
UNIQUE KEY Email(Email),
UNIQUE KEY Contribuinte(Contribuinte));

-- -------------------------------------
-- Criação da Tabela "Fornecedor"
-- DROP TABLE Fornecedor;
-- DESC Fornecedor;
-- -------------------------------------
CREATE TABLE Fornecedor(
IdFornecedor INT NOT NULL,
Designacao VARCHAR(75) NOT NULL,
Contribuinte INT NOT NULL,
Contacto VARCHAR(75) NOT NULL,
CodPostalEndereco VARCHAR(75) NOT NULL,
LocalidadeEndereco VARCHAR(75) NOT NULL,
RuaEndereco VARCHAR(100) NOT NULL,
Email VARCHAR(150) NOT NULL,

PRIMARY KEY(IdFornecedor),
UNIQUE KEY Email(Email),
UNIQUE KEY Contribuinte(Contribuinte));

-- -------------------------------------
-- Criação da Tabela "Funcionario"
-- DROP TABLE Funcionario;
-- DESC Funcionario;
-- -------------------------------------
CREATE TABLE Funcionario (
    IdFuncionario INT NOT NULL,
    Nome VARCHAR(75) NOT NULL,
    Veiculo VARCHAR(75) NOT NULL,
    Email VARCHAR(150) NOT NULL,
    Contacto VARCHAR(75) NOT NULL,
    Contribuinte INT NOT NULL,

    PRIMARY KEY (IdFuncionario),
    UNIQUE KEY Email(Email),
	UNIQUE KEY Contribuinte(Contribuinte));
    
-- -------------------------------------
-- Criação da Tabela "Encomenda"
-- DROP TABLE Encomenda;
-- DESC Encomenda;
-- -------------------------------------
CREATE TABLE Encomenda (
    IdEncomenda INT NOT NULL,
    DataHora_pedido DATETIME NOT NULL,
    Custo DECIMAL(6,2) NOT NULL,
    DataHora_entrega DATETIME DEFAULT NULL,
    IdCliente INT NOT NULL,
    IdFuncionario INT NOT NULL,

    PRIMARY KEY (IdEncomenda),
    FOREIGN KEY (IdCliente)
        REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdFuncionario)
        REFERENCES Funcionario(IdFuncionario));
        
-- -------------------------------------
-- Criação da Tabela "Produto"
-- DROP TABLE Produto;
-- DESC Produto;
-- -------------------------------------      
CREATE TABLE Produto (
    IdProduto INT NOT NULL,
    Nome VARCHAR(75) NOT NULL,
    Preco DECIMAL(6,2) NOT NULL,
    Descricao VARCHAR(75),
    Tipo VARCHAR(75) NOT NULL,
    Stock INT,
    Iva DECIMAL(3,2) NOT NULL,
    Lucro DECIMAL(3,2) NOT NULL,

    PRIMARY KEY (IdProduto));
    
-- -------------------------------------
-- Criação da Tabela "Produto_Fornecedor"
-- DROP TABLE Produto_Fornecedor;
-- DESC Produto_Fornecedor;
-- -------------------------------------
CREATE TABLE Produto_Fornecedor (
    IdProduto INT NOT NULL,
    IdFornecedor INT NOT NULL,
    Quantidade INT NOT NULL,
    Preco DECIMAL(6,2) NOT NULL,
    DataReferencia DATETIME NOT NULL,

    FOREIGN KEY (IdProduto) 
        REFERENCES Produto(IdProduto),
    FOREIGN KEY (IdFornecedor)
        REFERENCES Fornecedor(IdFornecedor));
        
-- -------------------------------------
-- Criação da Tabela "Encomenda_tem_Produto"
-- DROP TABLE Encomenda_tem_Produto;
-- DESC Encomenda_tem_Produto;
-- -------------------------------------
CREATE TABLE Encomenda_tem_Produto(
    IdEncomenda INT NOT NULL,
    IdProduto INT NOT NULL,
    Preco DECIMAL(6,2) NOT NULL,
    Quantidade INT NOT NULL,

    FOREIGN KEY (IdEncomenda)
        REFERENCES Encomenda(IdEncomenda),
    FOREIGN KEY (IdProduto) 
        REFERENCES Produto(IdProduto));
        
-- -------------------------------------
-- Povoamento da Base de Dados
-- -------------------------------------
INSERT INTO Cliente 
	(IdCliente, Nome, Email, RuaEndereco, Telemovel, DataNascimento, Historico, CodPostalEndereco, LocalidadeEndereco, Contribuinte)
    VALUES
		('01', 'Luisa Fernandes', 'luisa.fernandes@email.com', 'Rua dos Pescadores',   '915283746', '2000-01-01', '04',     '4970-163', 'Vila Nova de Cerveira', '123987456'),
        ('02', 'Bruno Almeida',   'bruno.almeida@email.com',   'Rua do Comércio',      '914672938', '1998-06-05', '01, 05', '4800-019', 'Barcelos',              '741852963'),
        ('03', 'Sofia Gomes',     'sofia.gomes@email.com',     'Rua da Fonte',         '963204789', '1995-11-09', NULL,      '4700-227', 'Braga',                 '369258147'),
        ('04', 'Daniel Pereira',  'daniel.pereira@email.com',  'Rua do Calvário',      '930293847', '1990-03-01', '02',     '4810-422', 'Vila Verde',            '258369147'),
        ('05', 'Isabel Costa',    'isabel.costa@email.com',    'Avenida da República', '928364529', '1972-08-06', '03',     '4740-328', 'Esposende',             '159483726');

INSERT INTO Funcionario 
    (IdFuncionario, Nome, Veiculo, Email, Contacto, Contribuinte)
    VALUES
        ('01', 'Graça Freitas',  'AX-12-AB', 'graca.freitas@email.com',  '912345678', '793485061'),
        ('02', 'Maria Santos',   'BI-52-ID', 'maria.santos@email.com',   '918273645', '718304526'),
        ('03', 'João Rodrigues', 'CA-13-GC', 'joao.rodrigues@email.com', '910928374', '847691253'),
        ('04', 'Ana Carvalho',   'DJ-49-FE', 'ana.carvalho@email.com',   '916403829', '547891236');

INSERT INTO Fornecedor
	(IdFornecedor, Designacao, Contribuinte, Contacto, CodPostalEndereco, LocalidadeEndereco, RuaEndereco, Email)
    VALUES
		('01', 'Empresa tvs/video',        '123436219', '912345678', '1234-567', 'Lisboa',  'Rua das Flores',       'empresatvsvideo@gmail.com'),
		('02', 'Empresa som',              '985654821', '923456789', '5678-123', 'Porto',   'Avenida dos Pássaros', 'empresasom@gmail.com'),
		('03', 'Empresa informatica',      '123957456', '934567801', '4567-812', 'Braga',   'Estrada das Árvores',  'empresainformatica@hotmail.com'),
		('04', 'Empresa acessorios',       '741802963', '945678912', '6789-123', 'Coimbra', 'Rua dos Bares',        'empresaacessorios@gmail.com'),
		('05', 'Empresa telecomunicacoes', '369281470', '956789012', '1234-567', 'Faro',    'Rua das Praias',       'empresatelecomunicacoes@email.com');

INSERT INTO Produto
	(IdProduto, Nome, Preco, Descricao, Tipo, Stock, Iva, Lucro)
    VALUES
	    ('01', 'Tv 55 XPTO 4K',            '1999.00', 'tv 55, marca: xpto',            'Tv / Video',       '5',   '0.23', '0.22'),
		('02', 'Tablet 8 okk',             '399.00',  'tablet 8, marca: okk',          'Telecomunicacoes', '15',  '0.23', '0.20'),
		('03', 'Smartphone Marca A Top',   '1299.00', 'smartphone top gama, marca: a', 'Informatica',      '50',  '0.23', '0.15'),
		('04', 'Smartphone Marca A Medio', '799.00',  'smartphone med gama, marca: a', 'Informatica',      '80',  '0.23', '0.25'),
		('05', 'Smartphone Marca B Top',   '1249.00', 'smartphone top gama, marca: b', 'Informatica',      '60',  '0.23', '0.25'),
		('06', 'TV 50 TSV',                '899.00',  'tv 50, marca: tsv',             'Tv / Video',       '8',   '0.23', '0.28'),
		('07', 'Tablet 10 okk',            '599.00',  'tablet 10, marca: okk',         'Telecomunicacoes', '35',  '0.23', '0.20'),
		('08', 'Computador port 14 TSV',   '749.90',  'portatil 14, marca: tsv',       'Informatica',      '40',  '0.23', '0.30'),
		('09', 'Smartphone Marca B Medio', '749.00',  'smartphone med gama, marca: b', 'Telecomunicacoes', '90',  '0.23', '0.32'), 
        ('10', 'TV 60 STK',                '1599.99', 'tv 60, marca: stk',             'Tv / Video',       '8',   '0.23', '0.20'),
		('11', 'Leitor BRAYs STK',         '199.00',  'leitor blueray, marca: stk',    'Tv / Video',       '35',  '0.23', '0.26'),
		('12', 'Leitor CDs AUDVIS',        '79.00',   'leitor cds, marca: audvis',     'Som',              '30',  '0.23', '0.20'),
		('13', 'Leitor LPs AUDVIS',        '239.90',  'leitor lps, marca: audvis',     'Som',              '19',  '0.23', '0.15'),
		('14', 'Protetor ecra medida p',   '19.00',   'protetor ecra pequeno',         'Acessorios',       '130', '0.23', '0.50'),
		('15', 'Protetor ecra medida m',   '29.00',   'protetor ecra medio',           'Acessorios',       '100', '0.23', '0.50'),
		('16', 'Protetor ecra medida g',   '39.00',   'protetor ecra grande',          'Acessorios',       '80',  '0.23', '0.50'),
		('17', 'Capa okk 8',               '19.95',   'capa para tablet okk 8',        'Acessorios',       '20',  '0.23', '0.30'),
		('18', 'Capa A Top',               '29.00',   'capa para smart a top',         'Acessorios',       '30',  '0.23', '0.25'),
		('19', 'Capa B Medio',             '25.90',   'capa para smart b medio',       'Acessorios',       '35',  '0.23', '0.20'),
		('20', 'Kit limp AUDVIS',          '29.00',   'kit limpeza aparelhos audvis',  'Acessorios',       '40',  '0.23', '0.20');
        
INSERT INTO Encomenda
	(IdEncomenda, DataHora_pedido, Custo, DataHora_entrega, IdCliente, IdFuncionario)
    VALUES
		('01', '2022-01-03 10:04:21', '853.90',  '2022-01-05 12:05:10', '02', '01'),
		('02', '2022-02-04 14:30:50', '79.00',   '2022-02-07 16:13:02', '04', '02'),
		('03', '2022-04-12 09:00:01', '1999.00', '2022-04-13 18:30:40', '05', '03'),
		('04', '2022-06-21 15:05:00', '599.00',  '2022-06-23 17:06:30', '01', '04'),
		('05', '2022-07-13 11:31:42', '1313.90', '2022-07-15 13:23:07', '02', '02'),
        ('06', '2022-09-26 10:56:30', '199.00',  null,                  '01', '04'),
		('07', '2022-10-07 14:42:07', '749.90',  null,                  '02', '01'),
		('08', '2022-11-15 09:01:23', '1599.99', null,                  '03', '02'),
		('09', '2022-12-09 15:07:10', '1367.00', null,                  '04', '03'),
		('10', '2022-12-10 11:30:00', '268.90',  null,                  '05', '01');
        
INSERT INTO Encomenda_tem_Produto
	(IdEncomenda, IdProduto, Preco, Quantidade)
	VALUES
		('01', '04', '799.00',  '1'),
        ('01', '19', '25.90',   '1'),
        ('01', '15', '29.00',   '1'),
        ('02', '12', '79.00',   '1'),
        ('03', '01', '1999.00', '1'),
        ('04', '07', '599.00',  '1'),
        ('05', '05', '1249.00', '1'),
        ('05', '16', '39.00',   '1'),
        ('05', '15', '25.90',   '1'),
        ('06', '11', '199.00',  '1'),
        ('07', '08', '749.90',  '1'),
		('08', '10', '1599.99', '1'),
		('09', '03', '1299.00', '1'),
        ('09', '16', '39.00',   '1'),
        ('09', '18', '29.00',   '1'),
        ('10', '13', '239.90',  '1'),
        ('10', '20', '29.00',   '1');

INSERT INTO Produto_Fornecedor 
	(IdProduto, IdFornecedor, Quantidade, Preco, DataReferencia)
    VALUES
		('01', '01', '5',   '1638.52', '2022-12-30 08:47:00'),
		('02', '05', '15',  '332.50',  '2022-12-30 14:11:00'),
		('03', '03', '50',  '1129.57', '2022-12-30 19:34:00'),
		('04', '03', '80',  '639.20',  '2022-12-31 09:21:00'),
		('05', '03', '60',  '999.20',  '2022-12-31 15:55:00'),
		('06', '01', '8',   '702.34',  '2022-12-31 21:08:00'),
		('07', '05', '35',  '499.17',  '2023-01-01 10:42:00'),
		('08', '03', '40',  '576.15',  '2023-01-01 16:16:00'),
		('09', '05', '90',  '567.42',  '2023-01-01 21:29:00'),
		('10', '01', '8',   '1290.83', '2023-01-02 11:03:00'),
		('11', '01', '35',  '157.94',  '2023-01-02 16:37:00'),
		('12', '02', '30',  '65.83',   '2023-01-02 21:50:00'),
		('13', '02', '19',  '208.61',  '2023-01-03 11:24:00'),
		('14', '05', '130', '12.67',   '2023-01-03 16:58:00'),
		('15', '05', '100', '19.33',   '2023-01-03 22:11:00'),
		('16', '05', '80',  '26.00',   '2023-01-04 11:45:00'),
		('17', '05', '20',  '15.35',   '2023-01-04 17:19:00'),
		('18', '05', '30',  '23.2',    '2023-01-04 22:32:00'),
		('19', '05', '35',  '21.58',   '2023-01-05 12:06:00'),
		('20', '05', '40',  '24.17',   '2023-01-05 17:40:00');
        
-- -------------------------------------
-- Queries
-- -------------------------------------

-- ---------------------------------------------------
-- RE01-Apresentar o número de encomendas realizadas, 
--      a quantidade e o valor dos produtos vendidos, 
--      a determinado período.
-- ---------------------------------------------------
SELECT COUNT(distinct a.IdEncomenda) as Encomendas, 
	   SUM(Quantidade) as Quantidades, SUM(Preco) as Preco_Bruto 
	   FROM Encomenda a, Encomenda_tem_produto b
			where (a.IdEncomenda = b.IdEncomenda and DataHora_pedido >= '2022-10-01');

-- ---------------------------------------------------
-- RE02-Lista de clientes, que contenha o identificador, 
--      nome, contacto e e-mail.
-- ---------------------------------------------------
SELECT IdCliente, Nome, Telemovel, Email FROM Cliente;

-- ---------------------------------------------------
-- RE03-Os clientes devem ser inseridos no sistema 
--      quando realizam a primeira encomenda na loja. 
-- 		A cada cliente é pedido o nome, endereço, número, 
-- 		e-mail, contribuinte e data de nascimento.
-- ---------------------------------------------------
SELECT * FROM Cliente
	where (Historico is NULL);
    
-- ---------------------------------------------------
-- RE04-Deve ser possível calcular o tempo de processamento 
-- 		entre o pedido da encomenda e a entrega da mesma.
-- ---------------------------------------------------
SELECT IdEncomenda, (TIMESTAMPDIFF(day, DataHora_pedido, DataHora_entrega)) as 'Dias', 
	   (TIMESTAMPDIFF(hour, DataHora_pedido, DataHora_entrega)
       -(TIMESTAMPDIFF(day, DataHora_pedido, DataHora_entrega)*24)) as 'Horas' FROM Encomenda; 

-- ---------------------------------------------------
-- RE05-O sistema deve ser capaz de listar os produtos 
-- 		por ordem de maior percentagem de lucro.
-- ---------------------------------------------------
SELECT IdProduto, Nome, Preco, Lucro FROM Produto
	ORDER BY (Lucro) DESC;

-- ---------------------------------------------------
-- RE06-Listar os Funcionários que geraram mais receita (lucro das vendas) a empresa.
-- ---------------------------------------------------
SELECT IdFuncionario, sum(cast(c.Preco*Lucro as DECIMAL(6,2))) as 'Receita' 
	FROM Encomenda a, Encomenda_tem_produto b, Produto c
	where (a.IdEncomenda = b.IdEncomenda and b.IdProduto = c.IdProduto)
    GROUP BY (IdFuncionario)
    ORDER BY (Receita) DESC;
    
-- ---------------------------------------------------
-- RE07-Listar os Clientes por maior valor total gasto na loja de todas as encomendas que fez.
-- ---------------------------------------------------
SELECT b.IdCliente, Nome, sum(Custo) as 'Total_Gasto' FROM Cliente a, Encomenda b
	where(a.IdCliente = b.IdCliente)
	 GROUP BY (IdCliente)
     ORDER BY (Total_Gasto) DESC;
	
-- ---------------------------------------------------
-- RE08-O sistema deve listar todos os identificadores dos produtos com stock disponível.
-- ---------------------------------------------------
SELECT IdProduto, Nome, Stock FROM Produto
	where (Stock > 0);

-- ---------------------------------------------------
-- RE09-Qual o fornecedor que vende mais produtos a loja.
-- ---------------------------------------------------
SELECT a.IdFornecedor, Designacao, Count(distinct IdProduto) as 'Produtos' 
	FROM Fornecedor a, Produto_Fornecedor b
	where(a.IdFornecedor = b.IdFornecedor)
    GROUP BY (IdFornecedor)
    ORDER BY (Produtos) DESC;

-- ---------------------------------------------------
-- RE10-Ver o historico de compras de um cliente na loja.
-- ---------------------------------------------------
SELECT a.IdEncomenda, a.IdCliente, b.IdProduto, c.nome 
	FROM Encomenda a, Encomenda_tem_Produto b, Produto c
    where(a.IdCLiente = 2 and a.IdEncomenda = b.IdEncomenda 
		  and b.IdProduto = c.IdProduto and a.DataHora_entrega is not null);
-- ---------------------------------------------------
-- Vistas
-- ---------------------------------------------------    

-- ---------------------------------------------------
-- V01 - Número de vezes que cada produto foi vendido
-- DROP VIEW V01;
-- SELECT * FROM minhotec.v01;
-- ---------------------------------------------------  
CREATE VIEW V01 AS 
	SELECT a.IdProduto, Nome, Count(a.IdProduto) AS Total_Vendas FROM Encomenda_tem_Produto a, Produto b
		where(a.IdProduto = b.IdProduto)
        GROUP BY (IdProduto)
        ORDER BY (Total_Vendas) DESC;
        
-- ---------------------------------------------------
-- V02 - Unidades por encomenda
-- DROP VIEW V02;
-- SELECT * FROM minhotec.v02;
-- ---------------------------------------------------
CREATE VIEW V02 AS 
	SELECT IdEncomenda,  count(IdProduto) AS 'Unidades' FROM Encomenda_tem_Produto
		 GROUP BY (IdEncomenda);

-- ---------------------------------------------------
-- V03 - Média de tempo de entrega de uma encomenda
-- DROP VIEW V03;
-- SELECT * FROM minhotec.v03;
-- ---------------------------------------------------
CREATE VIEW V03 AS 
	SELECT  Cast(Sum(TIMESTAMPDIFF(day, DataHora_pedido, DataHora_entrega))
			/Count(DataHora_entrega) as DECIMAL(2,0)) as 'Dias', 
			Cast(Sum(TIMESTAMPDIFF(hour, DataHora_pedido, DataHora_entrega)
			-(TIMESTAMPDIFF(day, DataHora_pedido, DataHora_entrega)*24))
            /Count(DataHora_entrega) as DECIMAL(2,1)) as 'Horas' FROM Encomenda; 

-- ---------------------------------------------------
-- Procedimentos
-- ---------------------------------------------------
-- Criacao de um procedimento para nos indicar os 3 maiores pagamentos realizados
-- e respetivos clientes.
DELIMITER $$
CREATE PROCEDURE sp3TopPagamentos()
BEGIN
	SELECT b.IdCliente, Nome, Custo AS 'Pagamento' FROM Cliente a, Encomenda b
		where(a.IdCliente = b.IdCliente)
		ORDER BY Pagamento DESC
		LIMIT 3;
END $$

CALL sp3TopPagamentos;
-- ---------------------------------------------------
-- DROP PROCEDURE sp3TopPagamentos;
-- ---------------------------------------------------