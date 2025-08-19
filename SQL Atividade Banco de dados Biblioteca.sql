CREATE DATABASE BIBLIOTECA;
GO

USE BIBLIOTECA;
GO

CREATE TABLE CATEGORIA (
    cod INT PRIMARY KEY,
    descricao VARCHAR(100)
);
GO

CREATE TABLE EDITORA (
    id INT PRIMARY KEY,
    nome VARCHAR(100)
);
GO

CREATE TABLE AUTOR (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    nacionalidade VARCHAR(100)
);
GO

CREATE TABLE LIVRO (
    isbn VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(100),
    ano INT,
    FK_EDITORA_id INT,
    FK_CATEGORIA_cod INT,
    FOREIGN KEY (FK_EDITORA_id) REFERENCES EDITORA(id),
    FOREIGN KEY (FK_CATEGORIA_cod) REFERENCES CATEGORIA(cod)
);
GO

CREATE TABLE LIVRO_AUTOR_ESCRITO (
    FK_LIVRO_isbn VARCHAR(13),
    FK_AUTOR_id INT,
    PRIMARY KEY (FK_LIVRO_isbn, FK_AUTOR_id),
    FOREIGN KEY (FK_LIVRO_isbn) REFERENCES LIVRO(isbn),
    FOREIGN KEY (FK_AUTOR_id) REFERENCES AUTOR(id)
);
GO

-- Insercao de categorias
INSERT INTO CATEGORIA (cod, descricao) VALUES (1, 'Literatura Juvenil');
INSERT INTO CATEGORIA (cod, descricao) VALUES (2, 'Ficção Científica');
INSERT INTO CATEGORIA (cod, descricao) VALUES (3, 'Humor');

GO

-- Insercao de editoras
INSERT INTO EDITORA (id, nome) VALUES (1, 'Rocco');
INSERT INTO EDITORA (id, nome) VALUES (2, 'Wmf Martins Fontes');
INSERT INTO EDITORA (id, nome) VALUES (3, 'Casa da Palavra');
INSERT INTO EDITORA (id, nome) VALUES (4, 'Belas Letras');
INSERT INTO EDITORA (id, nome) VALUES (5, 'Matrix');

GO

-- Insercao de autores
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (1, 'J. K. Rowling', 'Inglaterra');
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (2, 'Clive Staples Lewis', 'Inglaterra');
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (3, 'Affonso Solano', 'Brasil');
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (4, 'Marcos Piangers', 'Brasil');
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (5, 'Ciro Botelho – Tiririca', 'Brasil');
INSERT INTO AUTOR (id, nome, nacionalidade) VALUES (6, 'Bianca Mól', 'Brasil');

GO

-- Insercao de Livros
INSERT INTO LIVRO (isbn, titulo, ano, FK_EDITORA_id, FK_CATEGORIA_cod) VALUES 
('8532511015', 'Harry Potter e A Pedra Filosofal', 2000, 1, 1),
('9788578270698', 'As Crônicas de Nárnia', 2009, 2, 1),
('9788577343348', 'O Espadachim de Carvão', 2013, 3, 2),
('9788581742458', 'O Papai É Pop', 2015, 4, 3),
('9788582302026', 'Pior Que Tá Não Fica', 2015, 5, 3),
('9788577345670', 'Garota Desdobrável', 2015, 3, 1),
('8532512062', 'Harry Potter e o prisioneiro de Azkaban', 2000, 1, 1);

GO

INSERT INTO LIVRO_AUTOR_ESCRITO (FK_LIVRO_isbn, FK_AUTOR_id) VALUES
('8532511015', 1),
('9788578270698', 2),
('9788577343348', 3),
('9788581742458', 4),
('9788582302026', 5),
('9788577345670', 6),
('8532512062', 1);

GO

-- Consulta para listar todos os livros com seus dados completos (ISBN, título, ano, editora, autor e categoria)
-- Ordenados em ordem alfabética pelo título do livro
SELECT 
    L.isbn,
    L.titulo,
    L.ano,
    E.nome AS editora,
    A.nome AS autor,
    C.descricao AS categoria
FROM LIVRO L
JOIN EDITORA E ON L.FK_EDITORA_id = E.id
JOIN CATEGORIA C ON L.FK_CATEGORIA_cod = C.cod
JOIN LIVRO_AUTOR_ESCRITO LAE ON L.isbn = LAE.FK_LIVRO_isbn
JOIN AUTOR A ON LAE.FK_AUTOR_id = A.id
ORDER BY L.titulo ASC;

GO

-- Listar todos os livros com seus autores, editoras e categorias, ordenados pelo nome do autor
SELECT 
    L.isbn,
    L.titulo,
    L.ano,
    E.nome AS editora,
    A.nome AS autor,
    C.descricao AS categoria
FROM LIVRO L
JOIN EDITORA E ON L.FK_EDITORA_id = E.id
JOIN CATEGORIA C ON L.FK_CATEGORIA_cod = C.cod
JOIN LIVRO_AUTOR_ESCRITO LAE ON L.isbn = LAE.FK_LIVRO_isbn
JOIN AUTOR A ON LAE.FK_AUTOR_id = A.id
ORDER BY A.nome ASC;

GO

-- Listar todos os livros da categoria 'Literatura Juvenil' ordenados pelo ano de publicação
SELECT 
    L.isbn,
    L.titulo,
    L.ano,
    A.nome AS autor,
    E.nome AS editora,
    C.descricao AS categoria
FROM LIVRO L
JOIN CATEGORIA C ON L.FK_CATEGORIA_cod = C.cod
JOIN LIVRO_AUTOR_ESCRITO LAE ON L.isbn = LAE.FK_LIVRO_isbn
JOIN AUTOR A ON LAE.FK_AUTOR_id = A.id
JOIN EDITORA E ON L.FK_EDITORA_id = E.id
WHERE C.descricao = 'Literatura Juvenil'
ORDER BY L.ano ASC;


GO

-- 5.Mostrar todos os livros publicados por uma editora específica 

SELECT 
    L.isbn,
    L.titulo,
    L.ano,
    A.nome AS nome_autor,
    A.nacionalidade,
    E.nome AS nome_editora,
    C.descricao AS nome_categoria
FROM LIVRO L
JOIN EDITORA E ON L.FK_EDITORA_id = E.id
JOIN CATEGORIA C ON L.FK_CATEGORIA_cod = C.cod
JOIN LIVRO_AUTOR_ESCRITO LAE ON L.isbn = LAE.FK_LIVRO_isbn
JOIN AUTOR A ON LAE.FK_AUTOR_id = A.id
WHERE C.descricao IN ('Humor', 'Ficção Científica')
  AND L.ano BETWEEN 2000 AND 2010
ORDER BY L.ano ASC, L.titulo ASC;


