CREATE DATABASE IF NOT EXISTS FACULDADE_EXERCICIO;
USE FACULDADE_EXERCICIO;

-- Criação da tabela ALUNO
CREATE TABLE IF NOT EXISTS ALUNO (
    Nome VARCHAR(100),
    Numero_aluno INT PRIMARY KEY,
    Tipo_aluno INT,
    Curso VARCHAR(10)
);

-- Criação da tabela DISCIPLINA
CREATE TABLE IF NOT EXISTS DISCIPLINA (
    Nome_disciplina VARCHAR(100),
    Numero_disciplina VARCHAR(10) PRIMARY KEY,
    Creditos INT,
    Departamento VARCHAR(10)
);

-- Criação da tabela TURMA
CREATE TABLE IF NOT EXISTS TURMA (
    Identificacao_turma INT PRIMARY KEY,
    Numero_disciplina VARCHAR(10),
    Semestre VARCHAR(10),
    Ano INT,
    Professor VARCHAR(100),
    FOREIGN KEY (Numero_disciplina) REFERENCES DISCIPLINA(Numero_disciplina)
);

-- Criação da tabela HISTORICO_ESCOLAR
CREATE TABLE IF NOT EXISTS HISTORICO_ESCOLAR (
    Numero_Aluno INT,
    Identificacao_Turma INT,
    Nota CHAR(1),
    PRIMARY KEY (Numero_Aluno, Identificacao_Turma),
    FOREIGN KEY (Numero_Aluno) REFERENCES ALUNO(Numero_aluno),
    FOREIGN KEY (Identificacao_Turma) REFERENCES TURMA(Identificacao_turma)
);

-- Criação da tabela PRE_REQUISITO
CREATE TABLE IF NOT EXISTS PRE_REQUISITO(
    Numero_Disciplina VARCHAR(50),
    Numero_Pre_Requisito VARCHAR(50),
    PRIMARY KEY (Numero_Disciplina, Numero_Pre_Requisito),
    FOREIGN KEY (Numero_Disciplina) REFERENCES DISCIPLINA(Numero_disciplina),
    FOREIGN KEY (Numero_Pre_Requisito) REFERENCES DISCIPLINA(Numero_disciplina)
);

-- Inserção dos dados na tabela ALUNO (só Silva e Braga)
INSERT INTO ALUNO (Nome, Numero_aluno, Tipo_aluno, Curso) VALUES
('Silva', 17, 1, 'CC'),
('Braga', 8, 2, 'CC');

-- Inserção dos dados na tabela DISCIPLINA
INSERT INTO DISCIPLINA (Nome_disciplina, Numero_disciplina, Creditos, Departamento) VALUES
('Introd. à ciência da computação', 'CC1310', 4, 'CC'),
('Estruturas de dados', 'CC3320', 4, 'CC'),
('Matemática discreta', 'MAT2410', 3, 'MAT'),
('Banco de dados', 'CC3380', 3, 'CC');

-- Inserção dos dados na tabela TURMA
INSERT INTO TURMA (Identificacao_turma, Numero_disciplina, Semestre, Ano, Professor) VALUES
(85, 'MAT2410', 'Segundo', 2007, 'Kleber'),
(92, 'CC1310', 'Segundo', 2007, 'Anderson'),
(102, 'CC3320', 'Primeiro', 2008, 'Carlos'),
(112, 'MAT2410', 'Segundo', 2008, 'Chang'),
(119, 'CC1310', 'Segundo', 2008, 'Anderson'),
(135, 'CC3380', 'Segundo', 2008, 'Santos');

-- Inserção dos dados na tabela HISTORICO_ESCOLAR
INSERT INTO HISTORICO_ESCOLAR (Numero_aluno, Identificacao_turma, Nota) VALUES
(17, 112, 'B'),
(17, 119, 'C'),
(8, 85, 'A'),
(8, 92, 'A'),
(8, 102, 'B'),
(8, 135, 'A');

-- Inserção dos dados na tabela PRE_REQUISITO
INSERT INTO PRE_REQUISITO (Numero_disciplina, Numero_pre_requisito) VALUES
('CC3380', 'CC3320'),
('CC3380', 'MAT2410'),
('CC3320', 'CC1310');


SELECT 
    A.Nome AS Nome_aluno,
    D.Nome_disciplina,
    D.Numero_disciplina,
    D.Creditos,
    T.Semestre,
    T.Ano,
    HE.Nota
FROM ALUNO A
JOIN HISTORICO_ESCOLAR HE ON A.Numero_aluno = HE.Numero_aluno
JOIN TURMA T ON HE.Identificacao_Turma = T.Identificacao_turma
JOIN DISCIPLINA D ON T.Numero_disciplina = D.Numero_disciplina
WHERE A.Tipo_aluno = 4
  AND A.Curso = 'CC'
ORDER BY A.Nome, T.Ano, T.Semestre;


INSERT INTO ALUNO (Nome, Numero_aluno, Tipo_aluno, Curso) 
VALUES ('Ana Moura', 20, 4, 'CC');

SELECT 
    A.Nome AS Nome_aluno,
    D.Nome_disciplina,
    D.Numero_disciplina,
    D.Creditos,
    T.Semestre,
    T.Ano,
    HE.Nota
FROM ALUNO A
JOIN HISTORICO_ESCOLAR HE ON A.Numero_aluno = HE.Numero_aluno
JOIN TURMA T ON HE.Identificacao_Turma = T.Identificacao_turma
JOIN DISCIPLINA D ON T.Numero_disciplina = D.Numero_disciplina
WHERE A.Tipo_aluno = 4
  AND A.Curso = 'CC'
ORDER BY A.Nome, T.Ano, T.Semestre;


