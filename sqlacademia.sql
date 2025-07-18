-- Criar o banco de dados
CREATE DATABASE ACADEMIA;
GO

-- Usar o banco de dados ACADEMIA
USE ACADEMIA;
GO

--tabela personais
CREATE TABLE personais (
    id_personal INT PRIMARY KEY IDENTITY,
    nome NVARCHAR(100),
    matricula NVARCHAR(50)
);
GO

-- tabela alunos
CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY IDENTITY,
    nome NVARCHAR(100),
    data_nascimento DATE,
    objetivo NVARCHAR(255),
    altura DECIMAL(3, 2),
    data_inicial DATE,
    data_final DATE,
    frequencia_treino NVARCHAR(50),
    pausa_entre_series NVARCHAR(50),
    peso_inicial DECIMAL(5, 2),
    peso DECIMAL(5, 2),
    peso_meta DECIMAL(5, 2),
    id_personal INT,
    FOREIGN KEY (id_personal) REFERENCES personais(id_personal)
);
GO

-- tabela grupos_musculares
CREATE TABLE grupos_musculares (
    id_grupo INT PRIMARY KEY IDENTITY,
    nome NVARCHAR(50)
);
GO

-- Criar tabela exercicios
CREATE TABLE exercicios (
    id_exercicio INT PRIMARY KEY IDENTITY,
    nome_exercicio NVARCHAR(100),
    id_grupo INT,
    descricao TEXT,
    FOREIGN KEY (id_grupo) REFERENCES grupos_musculares(id_grupo)
);
GO

-- tabela fichas_treino
CREATE TABLE fichas_treino (
    id_ficha INT PRIMARY KEY IDENTITY,
    id_aluno INT,
    data_inicial DATE,
    data_final DATE,
    frequencia_treino NVARCHAR(50),
    pausa_entre_series NVARCHAR(50),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);
GO

-- Criar tabela treinos
CREATE TABLE treinos (
    id_treino INT PRIMARY KEY IDENTITY,
    id_ficha INT,
    id_exercicio INT,
    serie INT,
    repeticoes INT,
    ordem INT,
    FOREIGN KEY (id_ficha) REFERENCES fichas_treino(id_ficha),
    FOREIGN KEY (id_exercicio) REFERENCES exercicios(id_exercicio)
);
GO

-- tabela condicionamentos
CREATE TABLE condicionamentos (
    id_condicionamento INT PRIMARY KEY IDENTITY,
    exercicio NVARCHAR(100),
    tempo INT,
    velocidade DECIMAL(5, 2),
    aquecimento NVARCHAR(50),
    id_ficha INT,
    FOREIGN KEY (id_ficha) REFERENCES fichas_treino(id_ficha)
);
GO

-- tabela controle_frequencia
CREATE TABLE controle_frequencia (
    id_controle INT PRIMARY KEY IDENTITY,
    id_aluno INT,
    dia DATE,
    semana INT,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);
GO

-- tabela avaliacoes_fisicas
CREATE TABLE avaliacoes_fisicas (
    id_avaliacao INT PRIMARY KEY IDENTITY,
    id_aluno INT,
    data_avaliacao DATE,
    percentual_gordura DECIMAL(5, 2),
    massa_magra DECIMAL(5, 2),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);
GO

-- Inserir registros na tabela personais
INSERT INTO personais (nome, matricula)
VALUES ('Carlos Santos', 'P001'),
       ('Fernanda Alves', 'P002'),
       ('Jose Lima', 'P003'),
       ('Ana Paula', 'P004');
GO

-- Inserir registros na tabela alunos
INSERT INTO alunos (nome, data_nascimento, objetivo, altura, data_inicial, data_final, frequencia_treino, pausa_entre_series, peso_inicial, peso, peso_meta, id_personal)
VALUES ('Joao Silva', '1994-01-01', 'Perder peso', 1.75, '2024-01-01', '2024-12-31', '3x por semana', '1 min', 80.5, 80.5, 75.0, 1),
       ('Maria Oliveira', '1999-02-01', 'Definir musculatura', 1.65, '2024-02-01', '2024-08-31', '4x por semana', '45 seg', 60.0, 60.0, 58.0, 2),
       ('Carlos Pereira', '1996-03-01', 'Ganhar massa muscular', 1.80, '2024-03-01', '2024-09-30', '5x por semana', '1 min', 90.0, 90.0, 85.0, 3),
       ('Ana Costa', '1992-04-01', 'Melhorar condicionamento', 1.70, '2024-04-01', '2024-10-31', '3x por semana', '1 min', 70.0, 70.0, 65.0, 4),
       ('Felipe Souza', '1997-05-01', 'Perder gordura', 1.85, '2024-05-01', '2024-11-30', '4x por semana', '45 seg', 95.0, 95.0, 90.0, 1),
       ('Juliana Lima', '2002-06-01', 'Definir musculatura', 1.60, '2024-06-01', '2024-12-31', '5x por semana', '1 min', 55.0, 55.0, 53.0, 2),
       ('Bruno Martins', '1989-07-01', 'Melhorar resistencia', 1.75, '2024-07-01', '2024-08-31', '3x por semana', '1 min', 85.0, 85.0, 80.0, 3),
       ('Mariana Almeida', '1995-08-01', 'Perder peso', 1.68, '2024-08-01', '2024-11-30', '4x por semana', '45 seg', 62.0, 62.0, 60.0, 4),
       ('Rafael Torres', '1993-09-01', 'Ganhar forca', 1.90, '2024-09-01', '2024-12-31', '5x por semana', '1 min', 100.0, 100.0, 95.0, 1),
       ('Isabela Mendes', '1998-10-01', 'Definir corpo', 1.62, '2024-10-01', '2024-12-31', '3x por semana', '1 min', 58.0, 58.0, 56.0, 2);
GO

-- Inserir registros na tabela grupos_musculares
INSERT INTO grupos_musculares (nome)
VALUES ('Peitoral'),
       ('Biceps'),
       ('Pernas'),
       ('Costas'),
       ('Ombros'),
       ('Triceps');
GO

-- Inserir registros na tabela exercicios
INSERT INTO exercicios (nome_exercicio, id_grupo, descricao)
VALUES ('Supino Reto', 1, 'Exercicio para desenvolvimento do peitoral'),
       ('Rosca Direta', 2, 'Exercicio para desenvolvimento do biceps'),
       ('Agachamento', 3, 'Exercício para fortalecimento das pernas'),
       ('Puxada Frontal', 4, 'Exercício para desenvolvimento das costas'),
       ('Elevação Lateral', 5, 'Exercício para desenvolvimento dos ombros'),
       ('Leg Press', 3, 'Exercício para fortalecimento das pernas'),
       ('Crucifixo', 1, 'Exercício para desenvolvimento do peitoral'),
       ('Desenvolvimento Militar', 5, 'Exercício para desenvolvimento dos ombros'),
       ('Rosca Scott', 2, 'Exercício para desenvolvimento do bíceps'),
       ('Extensão de Tríceps', 6, 'Exercício para desenvolvimento dos tríceps');
GO

-- Inserir registros na tabela fichas_treino
INSERT INTO fichas_treino (id_aluno)
VALUES (1),
       (2),
       (3),
       (4),
       (5),
       (6),
       (7),
       (8),
       (9),
       (10);
GO

-- Inserir registros na tabela treinos
INSERT INTO treinos (id_ficha, id_exercicio, serie, repeticoes, ordem)
VALUES (1, 1, 3, 12, 1),
       (1, 2, 3, 10, 2),
       (2, 3, 4, 15, 1),
       (2, 4, 4, 10, 2),
       (3, 5, 3, 12, 1),
       (3, 6, 3, 15, 2),
       (4, 7, 4, 10, 1),
       (4, 8, 4, 12, 2),
       (5, 9, 3, 12, 1),
       (5, 10, 3, 15, 2),
       (6, 1, 4, 12, 1),
       (6, 2, 4, 10, 2),
       (7, 3, 4, 15, 1),
       (7, 4, 4, 10, 2),
       (8, 5, 3, 12, 1),
       (8, 6, 3, 15, 2),
       (9, 7, 4, 10, 1),
       (9, 8, 4, 12, 2),
       (10, 9, 3, 12, 1),
       (10, 10, 3, 15, 2);
GO

-- Inserir registros na tabela controle_frequencia
INSERT INTO controle_frequencia (id_aluno, dia, semana)
VALUES (1, '2024-01-01', 1),
       (1, '2024-01-02', 1),
       (2, '2024-01-03', 1),
       (2, '2024-01-04', 1),
       (3, '2024-01-05', 1),
       (3, '2024-01-06', 1),
       (4, '2024-01-07', 1),
       (4, '2024-01-08', 1),
       (5, '2024-01-09', 1),
       (5, '2024-01-10', 1),
       (6, '2024-01-11', 1),
       (6, '2024-01-12', 1),
       (7, '2024-01-13', 1),
       (7, '2024-01-14', 1),
       (8, '2024-01-15', 1),
       (8, '2024-01-16', 1),
       (9, '2024-01-17', 1),
       (9, '2024-01-18', 1),
       (10, '2024-01-19', 1),
       (10, '2024-01-20', 1);
GO


-- Inserir registros na tabela condicionamentos
INSERT INTO condicionamentos (exercicio, tempo, velocidade, aquecimento)
VALUES ('Corrida', 30, 10.0, 'Alongamento'),
       ('Bicicleta', 45, 20.0, 'Alongamento'),
       ('El�ptico', 20, 8.0, 'Alongamento');
GO

-- Inserir registros na tabela avaliacoes_fisicas
INSERT INTO avaliacoes_fisicas (id_aluno, data_avaliacao, percentual_gordura, massa_magra)
VALUES (1, '2024-01-10', 20.5, 60.0),
       (2, '2024-02-15', 18.0, 50.0),
       (3, '2024-03-20', 22.0, 70.0),
       (4, '2024-04-25', 19.5, 65.0),
       (5, '2024-05-30', 21.0, 75.0),
       (6, '2024-06-05', 17.5, 48.0),
       (7, '2024-07-10', 23.0, 72.0),
       (8, '2024-08-15', 16.5, 45.0),
       (9, '2024-09-20', 20.0, 67.0),
       (10, '2024-10-25', 18.5, 52.0);
GO

-- Listar todos os alunos em ordem alfabética de nome
SELECT * FROM alunos
ORDER BY nome;
GO

-- Listar registros de frequencia de um aluno especifico, ordenados por data
SELECT * FROM controle_frequencia
WHERE id_aluno = 1
ORDER BY dia;
GO



-- Listar todas as avaliacoes fisicas de alunos realizadas, ordenadas por data de avaliacao
SELECT *
FROM avaliacoes_fisicas
ORDER BY data_avaliacao;
GO

-- Listar alunos, objetivos, total de exercicios realizados e nome do personal responsavel, ordenados alfabeticamente
SELECT a.nome, a.objetivo, COUNT(t.id_exercicio) AS total_exercicios, p.nome AS personal_responsavel
FROM alunos a
JOIN fichas_treino f ON a.id_aluno = f.id_aluno
JOIN treinos t ON f.id_ficha = t.id_ficha
JOIN personais p ON a.id_personal = p.id_personal
GROUP BY a.nome, a.objetivo, p.nome
ORDER BY a.nome;
GO
