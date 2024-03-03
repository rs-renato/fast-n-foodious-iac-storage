-- Tabela cliente
CREATE TABLE IF NOT EXISTS CLIENTE (
                                       ID INT PRIMARY KEY AUTO_INCREMENT,
                                       NOME VARCHAR(255) NOT NULL,
                                       EMAIL VARCHAR(255) NOT NULL UNIQUE,
                                       CPF VARCHAR(11) NOT NULL UNIQUE
);

-- Criando um usuário pré-definido para ser utilizado na deleção de clientes
-- (antes de um cliente ser deletado fisicamente, todos os pedidos a ele associados são atualizados para se relacionarem
-- com o usuário pré-definido)
INSERT IGNORE INTO
    CLIENTE (ID, NOME, EMAIL, CPF)
VALUES (1, 'Usuário Deletado (LGPD)', 'deletado.lgpd@fnf.com', '00000000191');

-- Tabela PEDIDO
CREATE TABLE IF NOT EXISTS PEDIDO (
                                       ID INT PRIMARY KEY AUTO_INCREMENT,
                                       PEDIDO_CLIENTE_ID INT NOT NULL,
                                       DATA_INICIO VARCHAR(255) NOT NULL,
                                       ESTADO_PEDIDO INT NOT NULL,
                                       ATIVO BOOLEAN NOT NULL DEFAULT TRUE,
                                       TOTAL DECIMAL(8,2) NULL,
                                       FOREIGN KEY (PEDIDO_CLIENTE_ID) REFERENCES CLIENTE(ID)
);

-- Tabela ITEMS DE PEDIDO
CREATE TABLE IF NOT EXISTS ITEM_PEDIDO (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    PEDIDO_ID INT NOT NULL,
    PRODUTO_ID INT NOT NULL,
    QUANTIDADE INT NOT NULL,
    FOREIGN KEY (PEDIDO_ID) REFERENCES PEDIDO(ID)
);