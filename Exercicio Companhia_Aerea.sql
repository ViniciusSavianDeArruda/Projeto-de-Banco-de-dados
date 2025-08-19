CREATE DATABASE COMPANHIA_AEREA;
USE COMPANHIA_AEREA;

CREATE TABLE AEROPORTO (
    Codigo_aeroporto VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(100),
    Cidade VARCHAR(100),
    Estado VARCHAR(50)
);

CREATE TABLE VOO (
    Numero_voo INT PRIMARY KEY,
    Companhia_aerea VARCHAR(100),
    Dias_da_semana VARCHAR(50)
);

CREATE TABLE TRECHO_VOO (
    Numero_voo INT,
    Numero_trecho INT,
    Codigo_aeroporto_partida VARCHAR(10),
    Horario_partida_previsto TIME,
    Codigo_aeroporto_chegada VARCHAR(10),
    Horario_chegada_previsto TIME,
    PRIMARY KEY (Numero_voo, Numero_trecho),
    FOREIGN KEY (Numero_voo) REFERENCES VOO(Numero_voo),
    FOREIGN KEY (Codigo_aeroporto_partida) REFERENCES AEROPORTO(Codigo_aeroporto),
    FOREIGN KEY (Codigo_aeroporto_chegada) REFERENCES AEROPORTO(Codigo_aeroporto)
);

CREATE TABLE TIPO_AERONAVE (
    Nome_tipo_aeronave VARCHAR(50) PRIMARY KEY,
    Qtd_max_assentos INT,
    Companhia VARCHAR(100)
);

CREATE TABLE AERONAVE (
    Codigo_aeronave VARCHAR(20) PRIMARY KEY,
    Numero_total_assentos INT,
    Tipo_aeronave VARCHAR(50),
    FOREIGN KEY (Tipo_aeronave) REFERENCES TIPO_AERONAVE(Nome_tipo_aeronave)
);

CREATE TABLE INSTANCIA_TRECHO (
    Numero_voo INT,
    Numero_trecho INT,
    Data DATE,
    Numero_assentos_disponiveis INT,
    Codigo_aeronave VARCHAR(20),
    Codigo_aeroporto_partida VARCHAR(10),
    Horario_partida TIME,
    Codigo_aeroporto_chegada VARCHAR(10),
    Horario_chegada TIME,
    PRIMARY KEY (Numero_voo, Numero_trecho, Data),
    FOREIGN KEY (Numero_voo, Numero_trecho) REFERENCES TRECHO_VOO(Numero_voo, Numero_trecho),
    FOREIGN KEY (Codigo_aeronave) REFERENCES AERONAVE(Codigo_aeronave),
    FOREIGN KEY (Codigo_aeroporto_partida) REFERENCES AEROPORTO(Codigo_aeroporto),
    FOREIGN KEY (Codigo_aeroporto_chegada) REFERENCES AEROPORTO(Codigo_aeroporto)
);

CREATE TABLE TARIFA (
    Numero_voo INT,
    Codigo_tarifa VARCHAR(10),
    Quantidade INT,
    Restricoes VARCHAR(255),
    PRIMARY KEY (Numero_voo, Codigo_tarifa),
    FOREIGN KEY (Numero_voo) REFERENCES VOO(Numero_voo)
);

CREATE TABLE PODE_POUSAR (
    Nome_tipo_aeronave VARCHAR(50),
    Codigo_aeroporto VARCHAR(10),
    PRIMARY KEY (Nome_tipo_aeronave, Codigo_aeroporto),
    FOREIGN KEY (Nome_tipo_aeronave) REFERENCES TIPO_AERONAVE(Nome_tipo_aeronave),
    FOREIGN KEY (Codigo_aeroporto) REFERENCES AEROPORTO(Codigo_aeroporto)
);

CREATE TABLE RESERVA_ASSENTO (
    Numero_voo INT,
    Numero_trecho INT,
    Data DATE,
    Numero_assento INT,
    Nome_cliente VARCHAR(100),
    Telefone_cliente VARCHAR(20),
    PRIMARY KEY (Numero_voo, Numero_trecho, Data, Numero_assento),
    FOREIGN KEY (Numero_voo, Numero_trecho, Data) REFERENCES INSTANCIA_TRECHO(Numero_voo, Numero_trecho, Data)
);
