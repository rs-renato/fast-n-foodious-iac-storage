
-- Tabela CATEGORIA_PRODUTO -- sem auto_increment porque o conteúdo da tabela é fixa
CREATE TABLE IF NOT EXISTS CATEGORIA_PRODUTO (
                                                 ID INT PRIMARY KEY, 
                                                 NOME VARCHAR(255) NOT NULL UNIQUE
);

-- Tabela PRODUTO
CREATE TABLE IF NOT EXISTS PRODUTO (
                                       ID INT PRIMARY KEY AUTO_INCREMENT,
                                       PRODUTO_CATEGORIA_ID INT NOT NULL,
                                       NOME VARCHAR(255) NOT NULL UNIQUE,
                                       DESCRICAO VARCHAR(255) NOT NULL,
                                       PRECO DECIMAL(5,2) NOT NULL,
                                       IMAGEM TEXT,
                                       ATIVO BOOLEAN NOT NULL DEFAULT TRUE,
                                       FOREIGN KEY (PRODUTO_CATEGORIA_ID) REFERENCES CATEGORIA_PRODUTO(ID)
);