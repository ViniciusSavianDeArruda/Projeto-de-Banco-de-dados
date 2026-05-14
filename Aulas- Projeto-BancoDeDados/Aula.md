# 📦 Projeto de Banco de Dados — Resumo Completo SQL

> Guia de referência cobrindo DDL, DML e Consultas Complexas com MySQL.

---

## 📋 Sumário

1. [Visão Geral](#visão-geral)
2. [DDL — Linguagem de Definição de Dados](#ddl--linguagem-de-definição-de-dados)
   - [Banco de Dados](#banco-de-dados)
   - [Tipos de Dados](#tipos-de-dados)
   - [Restrições (Constraints)](#restrições-constraints)
   - [CREATE TABLE](#create-table)
   - [ALTER TABLE](#alter-table)
   - [Chaves Primárias e Estrangeiras](#chaves-primárias-e-estrangeiras)
   - [DROP, TRUNCATE e RENAME](#drop-truncate-e-rename)
   - [CREATE INDEX](#create-index)
   - [Exemplo Prático — Sistema Empresa](#exemplo-prático--sistema-empresa)
3. [DML — Linguagem de Manipulação de Dados](#dml--linguagem-de-manipulação-de-dados)
   - [INSERT](#insert)
   - [SELECT](#select)
   - [WHERE](#where)
   - [DISTINCT](#distinct)
   - [ORDER BY](#order-by)
   - [BETWEEN](#between)
   - [LIKE](#like)
   - [ANY e ALL](#any-e-all)
   - [UPDATE](#update)
   - [DELETE](#delete)
   - [CAST](#cast)
4. [Consultas Complexas](#consultas-complexas)
   - [Funções de Agregação](#funções-de-agregação)
   - [JOINs](#joins)
   - [GROUP BY e HAVING](#group-by-e-having)
   - [Subconsultas](#subconsultas)
   - [Operadores de Conjunto](#operadores-de-conjunto)
   - [Consultas Correlacionadas](#consultas-correlacionadas)
   - [Expressões CASE](#expressões-case)
   - [Funções de Data](#funções-de-data)
5. [Boas Práticas](#boas-práticas)
6. [Referências](#referências)

---

## Visão Geral

O SQL é dividido em duas grandes famílias de comandos:

| Família | Nome Completo | Foco | Principais Comandos |
|---------|--------------|------|---------------------|
| **DDL** | Data Definition Language | Estrutura do banco | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` |
| **DML** | Data Manipulation Language | Dados dentro das estruturas | `INSERT`, `SELECT`, `UPDATE`, `DELETE` |

---

## DDL — Linguagem de Definição de Dados

### Banco de Dados

#### Criar
```sql
CREATE DATABASE EMPRESA;
```

#### Remover
```sql
DROP DATABASE EMPRESA;
```

---

### Tipos de Dados

#### String / Texto

| Tipo | Descrição |
|------|-----------|
| `CHAR(n)` | String de comprimento **fixo** (0–255 chars). Padrão: 1 |
| `VARCHAR(n)` | String de comprimento **variável** (0–65535 chars) |
| `TINYTEXT` | Até 255 caracteres |
| `TEXT(n)` | Até 65.535 bytes |
| `MEDIUMTEXT` | Até 16.777.215 caracteres |
| `LONGTEXT` | Até 4.294.967.295 caracteres |
| `TINYBLOB` / `BLOB` / `MEDIUMBLOB` / `LONGBLOB` | Equivalentes binários dos TEXT acima |
| `ENUM(v1, v2, ...)` | Um valor de uma lista predefinida (máx. 65535 opções) |
| `SET(v1, v2, ...)` | Zero ou mais valores de uma lista (máx. 64 opções) |

#### Numérico

| Tipo | Intervalo com sinal | Intervalo sem sinal |
|------|---------------------|---------------------|
| `TINYINT` | -128 a 127 | 0 a 255 |
| `SMALLINT` | -32.768 a 32.767 | 0 a 65.535 |
| `MEDIUMINT` | -8.388.608 a 8.388.607 | 0 a 16.777.215 |
| `INT` / `INTEGER` | -2.147.483.648 a 2.147.483.647 | 0 a 4.294.967.295 |
| `BIGINT` | -9,2 × 10¹⁸ a 9,2 × 10¹⁸ | 0 a 18,4 × 10¹⁸ |
| `FLOAT(p)` | Precisão simples (p: 0–24) ou dupla (p: 25–53) | — |
| `DOUBLE(n, d)` | Ponto flutuante de precisão dupla | — |
| `DECIMAL(n, d)` | Número exato. Máx: n=65, d=30 | — |
| `BOOL` / `BOOLEAN` | 0 = falso, ≠0 = verdadeiro | — |

#### Data e Hora

| Tipo | Formato | Intervalo |
|------|---------|-----------|
| `DATE` | `YYYY-MM-DD` | 1000-01-01 a 9999-12-31 |
| `DATETIME(fsp)` | `YYYY-MM-DD hh:mm:ss` | 1000-01-01 00:00:00 a 9999-12-31 23:59:59 |
| `TIMESTAMP(fsp)` | `YYYY-MM-DD hh:mm:ss` | 1970-01-01 00:00:01 UTC a 2038-01-19 03:14:07 UTC |
| `TIME(fsp)` | `hh:mm:ss` | -838:59:59 a 838:59:59 |
| `YEAR` | `YYYY` | 1901 a 2155 |

> `fsp` = precisão de frações de segundo (0–6). `TIMESTAMP` aceita `DEFAULT CURRENT_TIMESTAMP` e `ON UPDATE CURRENT_TIMESTAMP`.

---

### Restrições (Constraints)

As restrições definem regras para os dados de uma coluna e são aplicadas no momento da criação ou alteração de tabelas.

| Restrição | Descrição |
|-----------|-----------|
| `NOT NULL` | A coluna não pode ter valor `NULL` |
| `UNIQUE` | Todos os valores da coluna devem ser diferentes |
| `PRIMARY KEY` | Combinação de `NOT NULL` + `UNIQUE`. Identifica cada linha unicamente |
| `FOREIGN KEY` | Estabelece relação com outra tabela, garantindo integridade referencial |
| `CHECK` | Garante que os valores satisfaçam uma condição específica |
| `DEFAULT` | Define um valor padrão quando nenhum é informado |
| `AUTO_INCREMENT` | Incrementa automaticamente o valor para cada novo registro |

---

### CREATE TABLE

```sql
CREATE TABLE nome_da_tabela (
    nome_coluna1 tipo_de_dado restricoes,
    nome_coluna2 tipo_de_dado restricoes,
    ...
);
```

**Exemplo completo:**
```sql
CREATE TABLE exemplo_tipos (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(100) NOT NULL,
    idade       TINYINT UNSIGNED,
    salario     DECIMAL(10,2),
    ativo       BOOLEAN DEFAULT TRUE,
    nascimento  DATE,
    cadastro    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    obs         TEXT,
    status      ENUM('ativo', 'inativo', 'pendente') DEFAULT 'ativo'
);
```

---

### ALTER TABLE

Modifica a estrutura de uma tabela **já existente**.

#### Adicionar coluna
```sql
ALTER TABLE nome_da_tabela
ADD nome_coluna tipo_de_dado restricoes;

-- Exemplo: adicionar e-mail ao cadastro de funcionários
ALTER TABLE EMPRESA.FUNCIONARIO
ADD Email VARCHAR(255);
```

#### Remover coluna
```sql
ALTER TABLE nome_da_tabela
DROP COLUMN nome_coluna;

-- Exemplo: remover a inicial do meio
ALTER TABLE EMPRESA.FUNCIONARIO
DROP COLUMN Minicial;
```

#### Modificar tipo de dado
```sql
ALTER TABLE nome_da_tabela
MODIFY COLUMN nome_coluna novo_tipo;

-- Exemplo: alterar salário de DECIMAL para FLOAT
ALTER TABLE EMPRESA.FUNCIONARIO
MODIFY COLUMN Salario FLOAT;
```

#### Adicionar chave primária
```sql
ALTER TABLE nome_da_tabela
ADD PRIMARY KEY (nome_coluna);

-- Exemplo: definir CPF como chave primária depois da criação
ALTER TABLE EMPRESA.FUNCIONARIO
ADD PRIMARY KEY (Cpf);
```

#### Adicionar chave estrangeira
```sql
ALTER TABLE nome_da_tabela
ADD CONSTRAINT nome_restricao
FOREIGN KEY (coluna_local) REFERENCES outra_tabela(coluna_referenciada);

-- Exemplo: vincular funcionário ao seu departamento
ALTER TABLE EMPRESA.FUNCIONARIO
ADD CONSTRAINT fk_departamento
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero);
```

> ⚠️ Use com cautela em tabelas com grande volume de dados — algumas operações podem ser custosas em processamento.

---

### Chaves Primárias e Estrangeiras

#### PRIMARY KEY

Identifica de forma única cada registro em uma tabela.

- **Unicidade:** cada valor deve ser único na tabela
- **Não nulidade:** não permite `NULL`
- Pode ser **composta** (múltiplas colunas)

```sql
CREATE TABLE Funcionario (
    FuncionarioID INT,
    Nome          VARCHAR(100),
    PRIMARY KEY (FuncionarioID)
);
```

#### FOREIGN KEY

Estabelece uma relação entre tabelas, garantindo a **integridade referencial**.

- Os valores da coluna FK devem existir na tabela referenciada
- Suporta ações em cascata: `CASCADE`, `SET NULL`, `NO ACTION`
- Pode ser composta (múltiplas colunas)

```sql
CREATE TABLE Pedido (
    PedidoID     INT PRIMARY KEY,
    FuncionarioID INT,
    FOREIGN KEY (FuncionarioID) REFERENCES Funcionario(FuncionarioID)
);
```

---

### DROP, TRUNCATE e RENAME

#### DROP TABLE — remove a tabela e todos os dados
```sql
DROP TABLE nome_da_tabela;
```

#### TRUNCATE TABLE — remove os dados, mantém a estrutura
```sql
TRUNCATE TABLE nome_da_tabela;
```

#### RENAME TABLE — renomeia uma tabela
```sql
RENAME TABLE nome_antigo TO nome_novo;

-- Exemplo:
RENAME TABLE EMPRESA.LOCALIZACAO_DEP TO EMPRESA.LOCAL_DEP;
```

---

### CREATE INDEX

Melhora a performance de consultas em colunas frequentemente pesquisadas.

```sql
CREATE INDEX idx_datanasc ON EMPRESA.FUNCIONARIO (Datanasc);
```

---

### Exemplo Prático — Sistema Empresa

#### FUNCIONARIO
```sql
CREATE TABLE EMPRESA.FUNCIONARIO (
    Pnome          VARCHAR(15) NOT NULL,
    Minicial       CHAR,
    Unome          VARCHAR(15) NOT NULL,
    Cpf            CHAR(11),
    Datanasc       DATE,
    Endereco       VARCHAR(255),
    Sexo           CHAR,
    Salario        DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr            INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);
```

#### DEPARTAMENTO
```sql
CREATE TABLE EMPRESA.DEPARTAMENTO (
    Dnome              VARCHAR(15) NOT NULL,
    Dnumero            INT,
    Cpf_gerente        CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf)
);
```

#### Adicionando FK de FUNCIONARIO → DEPARTAMENTO
```sql
ALTER TABLE EMPRESA.FUNCIONARIO
ADD CONSTRAINT Dnr
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero);
```

#### LOCALIZACAO_DEP
```sql
CREATE TABLE EMPRESA.LOCALIZACAO_DEP (
    Dnumero INT          NOT NULL,
    Dlocal  VARCHAR(15)  NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);
```

#### PROJETO
```sql
CREATE TABLE EMPRESA.PROJETO (
    Projnome   VARCHAR(15) NOT NULL,
    Projnumero INT         NOT NULL,
    Projlocal  VARCHAR(15),
    Dnum       INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO(Dnumero)
);
```

#### TRABALHA_EM
```sql
CREATE TABLE EMPRESA.TRABALHA_EM (
    Fcpf  CHAR(11)     NOT NULL,
    Pnr   INT          NOT NULL,
    Horas DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Pnr)  REFERENCES PROJETO(Projnumero)
);
```

#### DEPENDENTE
```sql
USE EMPRESA;

CREATE TABLE DEPENDENTE (
    Fcpf            CHAR(11)    NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo            CHAR,
    Datanasc        DATE,
    Parentesco      VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);
```

---

## DML — Linguagem de Manipulação de Dados

### INSERT

Adiciona novos registros a uma tabela.

#### Especificando colunas (recomendado)
```sql
INSERT INTO nome_da_tabela (coluna1, coluna2, ...)
VALUES (valor1, valor2, ...);

-- Exemplo:
INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES ('Matriz', 1);
```

#### Inserindo em todas as colunas
```sql
INSERT INTO nome_da_tabela
VALUES (valor1, valor2, ...);

-- Exemplo:
INSERT INTO FUNCIONARIO
VALUES ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10',
        'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL, 1);
```

---

### SELECT

Consulta dados de uma tabela.

```sql
-- Colunas específicas
SELECT coluna1, coluna2 FROM nome_da_tabela;

-- Todas as colunas
SELECT * FROM nome_da_tabela;
```

**Exemplos:**
```sql
-- Listar nome e salário de todos os funcionários
SELECT Pnome, Unome, Salario
FROM FUNCIONARIO;

-- Listar todos os dados de todos os departamentos
SELECT * FROM DEPARTAMENTO;
```

---

### WHERE

Filtra registros com base em condições.

```sql
SELECT coluna1, coluna2
FROM nome_da_tabela
WHERE condição;
```

#### Operadores disponíveis

| Operador | Descrição |
|----------|-----------|
| `=` | Igual |
| `>` / `<` | Maior / Menor que |
| `>=` / `<=` | Maior ou igual / Menor ou igual |
| `<>` ou `!=` | Diferente |
| `BETWEEN` | Dentro de um intervalo |
| `LIKE` | Corresponde a um padrão |
| `IN` | Dentro de uma lista de valores |

**Exemplos:**
```sql
-- Funcionários do departamento 5
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Dnr = 5;

-- Funcionários com salário acima de 40000
SELECT Pnome, Unome, Salario FROM FUNCIONARIO WHERE Salario > 40000;

-- Funcionários do sexo feminino dos departamentos 1 ou 3
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Sexo = 'F' AND Dnr IN (1, 3);
```

---

### DISTINCT

Retorna apenas valores únicos (sem duplicatas).

```sql
SELECT DISTINCT coluna1, coluna2
FROM nome_da_tabela;
```

**Exemplos:**
```sql
-- Listar apenas os sexos cadastrados (sem repetir)
SELECT DISTINCT Sexo FROM FUNCIONARIO;

-- Listar departamentos que têm funcionários alocados (sem repetir)
SELECT DISTINCT Dnr FROM FUNCIONARIO;
```

---

### ORDER BY

Ordena os resultados em ordem ascendente (`ASC`) ou descendente (`DESC`).

```sql
SELECT coluna1, coluna2
FROM nome_da_tabela
ORDER BY coluna1 ASC, coluna2 DESC;

-- Exemplos:
SELECT * FROM FUNCIONARIO ORDER BY Pnome;            -- Ascendente (padrão)
SELECT * FROM FUNCIONARIO ORDER BY Salario DESC;     -- Descendente
SELECT * FROM FUNCIONARIO ORDER BY Dnr ASC, Salario DESC; -- Múltiplas colunas
```

---

### BETWEEN

Seleciona valores dentro de um intervalo (inclusive).

```sql
SELECT nome_coluna
FROM nome_da_tabela
WHERE nome_coluna BETWEEN valor1 AND valor2;

-- Exemplo:
SELECT * FROM FUNCIONARIO
WHERE Salario BETWEEN 30000 AND 50000;
```

---

### LIKE

Busca por padrão em uma coluna de texto.

```sql
SELECT coluna1
FROM nome_da_tabela
WHERE coluna LIKE padrão;
```

#### Wildcards

| Wildcard | Significado | Exemplo |
|----------|-------------|---------|
| `%` | Zero ou mais caracteres | `'a%'` → começa com "a" |
| `_` | Exatamente um caractere | `'_r%'` → "r" na 2ª posição |

**Exemplos comuns:**
- `LIKE 'a%'` — começa com "a"
- `LIKE '%a'` — termina com "a"
- `LIKE '%or%'` — contém "or"

**Exemplos com a tabela FUNCIONARIO:**
```sql
-- Funcionários cujo primeiro nome começa com 'J'
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Pnome LIKE 'J%';

-- Funcionários cujo sobrenome termina com 'a'
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Unome LIKE '%a';

-- Funcionários que moram em São Paulo
SELECT Pnome, Unome, Endereco FROM FUNCIONARIO WHERE Endereco LIKE '%São Paulo%';

-- Funcionários com nome de 5 letras
SELECT Pnome FROM FUNCIONARIO WHERE Pnome LIKE '_____';
```

---

### ANY e ALL

Usados para comparar um valor com um conjunto retornado por uma subconsulta.

#### ANY — verdadeiro se **qualquer** valor satisfizer a condição
```sql
SELECT nome_coluna
FROM nome_da_tabela
WHERE nome_coluna operador ANY (
    SELECT nome_coluna FROM nome_da_tabela WHERE condição
);

-- Exemplo: funcionários com salário maior que o de ALGUM funcionário do departamento 3
SELECT Pnome, Unome, Salario
FROM FUNCIONARIO
WHERE Salario > ANY (
    SELECT Salario FROM FUNCIONARIO WHERE Dnr = 3
);
```

#### ALL — verdadeiro se **todos** os valores satisfizerem a condição
```sql
SELECT ALL nome_coluna
FROM nome_da_tabela
WHERE condição;

-- Exemplo: funcionários com salário maior que o de TODOS os funcionários do departamento 3
SELECT Pnome, Unome, Salario
FROM FUNCIONARIO
WHERE Salario > ALL (
    SELECT Salario FROM FUNCIONARIO WHERE Dnr = 3
);
```

---

### UPDATE

Modifica registros existentes em uma tabela.

```sql
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2
WHERE condição;

-- Exemplo:
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
```

> ⚠️ **Sempre use `WHERE`!** Sem ele, todos os registros da tabela serão atualizados.

---

### DELETE

Remove registros de uma tabela.

```sql
-- Registro específico
DELETE FROM nome_da_tabela WHERE condição;

-- Exemplo:
DELETE FROM Funcionario
WHERE nome = 'Juca' AND cpf = '00000000000';

-- Todos os registros (mantém a estrutura)
DELETE FROM nome_da_tabela;
```

> ⚠️ **Sempre use `WHERE`!** Sem ele, todos os registros serão removidos. Para apagar tudo com mais eficiência, prefira `TRUNCATE TABLE`.

---

### CAST

Converte explicitamente um valor de um tipo de dado para outro.

```sql
CAST(valor AS tipo_de_dado)
```

#### Exemplos de conversão

```sql
-- String → Inteiro
SELECT CAST('123' AS INT);                         -- 123

-- String → Decimal
SELECT CAST('45.67' AS DECIMAL(5,2));              -- 45.67

-- Número → String
SELECT CAST(123.45 AS VARCHAR(10));                -- '123.45'

-- String → Data
SELECT CAST('2023-09-11' AS DATE);                 -- 2023-09-11

-- Data → String
SELECT CAST(CURRENT_DATE AS VARCHAR(10));          -- '2023-09-11'

-- Uso em cálculo
SELECT CAST('100' AS INT) + CAST('50' AS INT);     -- 150
```

---

## Consultas Complexas

### Funções de Agregação

Realizam cálculos em conjuntos de valores e retornam um único resultado.

| Função | Descrição |
|--------|-----------|
| `COUNT()` | Conta o número de registros |
| `SUM()` | Soma valores numéricos |
| `AVG()` | Calcula a média |
| `MAX()` | Retorna o maior valor |
| `MIN()` | Retorna o menor valor |

**Exemplos:**
```sql
-- Contar total de funcionários
SELECT COUNT(*) AS total_funcionarios FROM FUNCIONARIO;

-- Somar a folha salarial total
SELECT SUM(Salario) AS folha_total FROM FUNCIONARIO;

-- Calcular salário médio
SELECT AVG(Salario) AS salario_medio FROM FUNCIONARIO;

-- Maior e menor salário registrado
SELECT MAX(Salario) AS maior_salario, MIN(Salario) AS menor_salario
FROM FUNCIONARIO;

-- Salário médio por departamento (combinando com GROUP BY)
SELECT Dnr, AVG(Salario) AS salario_medio
FROM FUNCIONARIO
GROUP BY Dnr;
```

---

### JOINs

Combinam dados de múltiplas tabelas com base em relacionamentos.

#### INNER JOIN — apenas registros com correspondência em ambas as tabelas
```sql
SELECT f.Pnome, f.Unome, d.Dnome
FROM FUNCIONARIO f
INNER JOIN DEPARTAMENTO d ON f.Dnr = d.Dnumero;
```

#### LEFT JOIN — todos da esquerda + correspondentes da direita (NULL se não houver)
```sql
SELECT f.Pnome, f.Unome, d.Dnome
FROM FUNCIONARIO f
LEFT JOIN DEPARTAMENTO d ON f.Dnr = d.Dnumero;
```

#### RIGHT JOIN — todos da direita + correspondentes da esquerda (NULL se não houver)
```sql
SELECT f.Pnome, f.Unome, d.Dnome
FROM FUNCIONARIO f
RIGHT JOIN DEPARTAMENTO d ON f.Dnr = d.Dnumero;
```

#### FULL OUTER JOIN — todos os registros de ambas as tabelas
```sql
SELECT f.Pnome, f.Unome, d.Dnome
FROM FUNCIONARIO f
FULL OUTER JOIN DEPARTAMENTO d ON f.Dnr = d.Dnumero;
```

---

### GROUP BY e HAVING

#### GROUP BY — agrupa registros com valores iguais
```sql
SELECT Dnr, COUNT(*) AS total_funcionarios
FROM FUNCIONARIO
GROUP BY Dnr;
```

#### HAVING — filtra grupos (equivalente ao `WHERE` para grupos)
```sql
SELECT Dnr, AVG(Salario) AS salario_medio
FROM FUNCIONARIO
GROUP BY Dnr
HAVING AVG(Salario) > 40000;
```

> 💡 `WHERE` filtra **linhas** antes do agrupamento. `HAVING` filtra **grupos** depois do agrupamento.

---

### Subconsultas

Consultas aninhadas dentro de outras consultas.

#### Subconsulta simples
```sql
-- Funcionários que ganham acima da média
SELECT Pnome, Unome, Salario
FROM FUNCIONARIO
WHERE Salario > (SELECT AVG(Salario) FROM FUNCIONARIO);
```

#### Com IN
```sql
-- Funcionários que trabalham em projetos 1, 2 ou 3
SELECT Pnome, Unome
FROM FUNCIONARIO
WHERE Cpf IN (
    SELECT Fcpf FROM TRABALHA_EM WHERE Pnr IN (1, 2, 3)
);
```

#### Com EXISTS
```sql
-- Funcionários que possuem dependentes
SELECT f.Pnome, f.Unome
FROM FUNCIONARIO f
WHERE EXISTS (
    SELECT 1 FROM DEPENDENTE d WHERE d.Fcpf = f.Cpf
);
```

---

### Operadores de Conjunto

| Operador | Descrição |
|----------|-----------|
| `UNION` | Une resultados de duas consultas, **removendo** duplicatas |
| `UNION ALL` | Une resultados **mantendo** duplicatas |
| `INTERSECT` | Retorna apenas registros que aparecem em **ambas** as consultas |
| `EXCEPT` / `MINUS` | Retorna registros da 1ª consulta que **não estão** na 2ª |

```sql
-- UNION
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Dnr = 1
UNION
SELECT Pnome, Unome FROM FUNCIONARIO WHERE Salario > 50000;

-- INTERSECT
SELECT Cpf FROM FUNCIONARIO WHERE Dnr = 1
INTERSECT
SELECT Fcpf FROM TRABALHA_EM WHERE Horas > 20;

-- EXCEPT
SELECT Cpf FROM FUNCIONARIO
EXCEPT
SELECT Fcpf FROM DEPENDENTE;
```

---

### Consultas Correlacionadas

Subconsultas que referenciam colunas da consulta externa, avaliadas linha a linha.

```sql
-- Funcionários com salário acima da média do seu próprio departamento
SELECT f1.Pnome, f1.Unome, f1.Salario, f1.Dnr
FROM FUNCIONARIO f1
WHERE f1.Salario > (
    SELECT AVG(f2.Salario)
    FROM FUNCIONARIO f2
    WHERE f2.Dnr = f1.Dnr
);
```

---

### Expressões CASE

Lógica condicional dentro de consultas.

```sql
-- Classificar faixa salarial
SELECT Pnome, Unome, Salario,
       CASE
           WHEN Salario > 50000 THEN 'Alto'
           WHEN Salario > 30000 THEN 'Médio'
           ELSE 'Baixo'
       END AS faixa_salarial
FROM FUNCIONARIO;

-- Traduzir número do departamento para nome
SELECT Pnome, Unome,
       CASE
           WHEN Dnr = 1 THEN 'Administração'
           WHEN Dnr = 2 THEN 'Pesquisa'
           WHEN Dnr = 3 THEN 'Desenvolvimento'
           ELSE 'Outros'
       END AS nome_departamento
FROM FUNCIONARIO;
```

---

### Funções de Data

```sql
-- Data, hora e timestamp atuais
SELECT CURRENT_DATE, CURRENT_TIME, NOW();

-- Extrair partes de uma data
SELECT Pnome,
       YEAR(Datanasc)  AS ano,
       MONTH(Datanasc) AS mes,
       DAY(Datanasc)   AS dia
FROM FUNCIONARIO;

-- Calcular diferença entre datas
SELECT Pnome, DATEDIFF(YEAR, Datanasc, CURRENT_DATE) AS idade
FROM FUNCIONARIO;

-- Adicionar intervalo de tempo
SELECT DATEADD(YEAR, 1, Datanasc) AS data_mais_um_ano
FROM FUNCIONARIO;
```

---

## Boas Práticas

### DDL
- 🗂️ Planeje a estrutura das tabelas com antecedência para minimizar o uso de `ALTER TABLE`
- 🔑 Sempre defina `PRIMARY KEY` para identificação única dos registros
- 🔗 Use `FOREIGN KEY` para garantir integridade referencial entre tabelas
- ✅ Aplique `NOT NULL` e `UNIQUE` onde fizer sentido
- 📊 Crie índices (`CREATE INDEX`) em colunas frequentemente usadas em filtros e ordenações

### DML
- ⚠️ **Sempre** use `WHERE` em `UPDATE` e `DELETE` para evitar alterações em massa não intencionais
- 🔍 Teste com `SELECT` antes de executar `UPDATE` ou `DELETE` críticos
- 💾 Faça backup antes de operações destrutivas em produção
- 📝 Prefira especificar nomes de colunas explicitamente no `INSERT`
- 📈 Use `LIMIT` para inspecionar grandes conjuntos de dados antes de processá-los

---

## Referências

| Recurso | URL |
|---------|-----|
| W3Schools SQL Tutorial | https://www.w3schools.com/sql/ |
| MySQL Official Documentation | https://dev.mysql.com/doc/ |
| PostgreSQL Documentation | https://www.postgresql.org/docs/ |
| SQLZoo (prática interativa) | https://sqlzoo.net/ |
| Stanford Databases Course | https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/about |
| Oracle SQL Documentation | https://docs.oracle.com/en/database/oracle/oracle-database/ |
