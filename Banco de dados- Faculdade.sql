CREATE DATABASE FACULDADE;
USE FACULDADE;

CREATE TABLE ALUNO (
	Nome VARCHAR(100),
    Numero_aluno INT PRIMARY KEY,
    Tipo_aluno INT,
    Curso VARCHAR(10)
);

CREATE TABLE DISCIPLINA (
	Nome_disciplina VARCHAR(100),
    Numero_disciplina VARCHAR(10) PRIMARY KEY,
    Creditos INT,
    Departamento VARCHAR(10)
);

CREATE TABLE TURMA (
    Identificacao_turma INT PRIMARY KEY,
    Numero_disciplina VARCHAR(10),
    Semestre VARCHAR(10),
    Ano INT,
    Professor VARCHAR(100),
    FOREIGN KEY (Numero_disciplina) REFERENCES DISCIPLINA(Numero_disciplina)
);

CREATE TABLE HISTORICO_ESCOLAR (
	Numero_Aluno INT,
    Identificacao_Turma INT,
    Nota CHAR(1),
    PRIMARY KEY (Numero_Aluno, Identificacao_Turma),
    FOREIGN KEY (Numero_Aluno) REFERENCES ALUNO(Numero_Aluno),
    FOREIGN KEY (Identificacao_turma) REFERENCES TURMA(Identificacao_turma)
);

CREATE TABLE PRE_REQUISITO(
	Numero_Disciplina VARCHAR(50),
    Numero_Pre_Requisito VARCHAR(50),
    PRIMARY KEY (Numero_Disciplina, Numero_Pre_Requisito),
    FOREIGN KEY (Numero_disciplina) REFERENCES DISCIPLINA(Numero_Disciplina),
    FOREIGN KEY (Numero_Pre_Requisito) REFERENCES DISCIPLINA(Numero_Disciplina)
);