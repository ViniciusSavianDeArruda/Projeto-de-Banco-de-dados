# Banco de Dados - Comandos DDL e Estruturação de Tabelas

Este repositório contém um resumo completo sobre comandos DDL (Data Definition Language) em SQL, com foco na criação, modificação e gerenciamento de tabelas em bancos de dados relacionais.

## 📋 Conteúdo

- [Renomeação de Tabelas](#renomeação-de-tabelas)
- [Modificação de Tabelas](#modificação-de-tabelas)
- [Chaves Primárias e Estrangeiras](#chaves-primárias-e-estrangeiras)
- [Exemplo Prático - Sistema Empresa](#exemplo-prático---sistema-empresa)
- [Operações de Limpeza](#operações-de-limpeza)
- [Índices](#índices)
- [Tipos de Dados MySQL](#tipos-de-dados-mysql)

## 🔄 Renomeação de Tabelas

### RENAME TABLE

Comando utilizado para alterar o nome de uma tabela existente:

```sql
RENAME TABLE table_name TO new_table_name;
```

**Exemplo:**
```sql
RENAME TABLE EMPRESA.LOCALIZACAO_DEP TO EMPRESA.LOCAL_DEP;
```

## ✏️ Modificação de Tabelas

### ALTER TABLE

O comando `ALTER TABLE` é uma ferramenta versátil para modificar a estrutura de tabelas existentes:

#### Adicionar uma Nova Coluna
```sql
ALTER TABLE nome_da_tabela
ADD nome_da_nova_coluna tipo_de_dado restricoes;
```

#### Remover uma Coluna
```sql
ALTER TABLE nome_da_tabela
DROP COLUMN nome_da_coluna;
```

#### Modificar o Tipo de Dado
```sql
ALTER TABLE nome_da_tabela
MODIFY COLUMN nome_da_coluna novo_tipo_de_dado;
```

#### Adicionar Chave Estrangeira
```sql
ALTER TABLE nome_da_tabela
ADD CONSTRAINT nome_da_restricao
FOREIGN KEY (nome_da_coluna) REFERENCES outra_tabela(nome_da_coluna_na_outra_tabela);
```

#### Adicionar Chave Primária
```sql
ALTER TABLE nome_da_tabela
ADD PRIMARY KEY (nome_da_coluna);
```

## 🔑 Chaves Primárias e Estrangeiras

### PRIMARY KEY

A **chave primária** identifica de forma única cada registro em uma tabela:

- **Unicidade**: Garante valores únicos em toda a tabela
- **Não nulidade**: Não permite valores NULL
- **Identificação única**: Meio principal de identificar registros

### FOREIGN KEY

A **chave estrangeira** estabelece relações entre tabelas:

- **Integridade Referencial**: Mantém consistência entre tabelas relacionadas
- **Ligação de Dados**: Conecta dados entre diferentes tabelas
- **Chaves Compostas**: Podem consistir em múltiplas colunas
- **Ações em Cascata**: CASCADE, SET NULL, NO ACTION

## 💼 Exemplo Prático - Sistema Empresa

### Tabela FUNCIONARIO
```sql
CREATE TABLE EMPRESA.FUNCIONARIO (
    Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR,
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);
```

### Tabela DEPARTAMENTO
```sql
CREATE TABLE EMPRESA.DEPARTAMENTO (
    Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(CPF)
);
```

### Tabela LOCALIZACAO_DEP
```sql
CREATE TABLE EMPRESA.LOCALIZACAO_DEP (
    Dnumero INT NOT NULL,
    Dlocal VARCHAR (15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO (Dnumero)
);
```

### Tabela PROJETO
```sql
CREATE TABLE EMPRESA.PROJETO(
    Projnome VARCHAR (15) NOT NULL,
    Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO (Dnumero)
);
```

### Tabela TRABALHA_EM
```sql
CREATE TABLE EMPRESA.TRABALHA_EM(
    Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL (3,1) NOT NULL,
    PRIMARY KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);
```

### Tabela DEPENDENTE
```sql
-- Primeiro selecionar o esquema
USE EMPRESA;

-- Criar a tabela
CREATE TABLE DEPENDENTE(
    Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);
```

## 🗑️ Operações de Limpeza

### DROP TABLE
Remove completamente uma tabela do banco de dados:

```sql
DROP TABLE EMPRESA.DEPENDENTE;
```

### TRUNCATE TABLE
Remove todos os registros da tabela, mantendo sua estrutura:

```sql
TRUNCATE TABLE EMPRESA.TRABALHA_EM;
```

## 📊 Índices

### CREATE INDEX
Melhora a performance de consultas criando índices em colunas específicas:

```sql
CREATE INDEX idx_datanasc ON EMPRESA.FUNCIONARIO (Datanasc);
```

## 📊 Tipos de Dados MySQL

### Tipos de Dados de String/Texto

| Tipo de Dado | Descrição |
|--------------|-----------|
| `CHAR(tamanho)` | String de comprimento fixo (0-255 caracteres). Padrão: 1 |
| `VARCHAR(tamanho)` | String de comprimento variável (0-65535 caracteres) |
| `BINARY(tamanho)` | String de bytes binários de comprimento fixo. Padrão: 1 |
| `VARBINARY(tamanho)` | String de bytes binários de comprimento variável |
| `TINYBLOB` | BLOB pequeno (máximo 255 bytes) |
| `TINYTEXT` | Texto pequeno (máximo 255 caracteres) |
| `TEXT(tamanho)` | Texto médio (máximo 65,535 bytes) |
| `BLOB(tamanho)` | BLOB médio (máximo 65,535 bytes) |
| `MEDIUMTEXT` | Texto grande (máximo 16,777,215 caracteres) |
| `MEDIUMBLOB` | BLOB grande (máximo 16,777,215 bytes) |
| `LONGTEXT` | Texto muito grande (máximo 4,294,967,295 caracteres) |
| `LONGBLOB` | BLOB muito grande (máximo 4,294,967,295 bytes) |
| `ENUM(val1, val2, ...)` | Lista de valores predefinidos (máximo 65535 valores) |
| `SET(val1, val2, ...)` | Conjunto de valores (máximo 64 valores) |

### Tipos de Dados Numéricos

| Tipo de Dado | Descrição | Intervalo |
|--------------|-----------|-----------|
| `BIT(tamanho)` | Valor de bit (1-64 bits). Padrão: 1 | - |
| `TINYINT(tamanho)` | Inteiro muito pequeno | Com sinal: -128 a 127<br>Sem sinal: 0 a 255 |
| `BOOL/BOOLEAN` | Valor booleano | 0 = falso, ≠0 = verdadeiro |
| `SMALLINT(tamanho)` | Inteiro pequeno | Com sinal: -32,768 a 32,767<br>Sem sinal: 0 a 65,535 |
| `MEDIUMINT(tamanho)` | Inteiro médio | Com sinal: -8,388,608 a 8,388,607<br>Sem sinal: 0 a 16,777,215 |
| `INT(tamanho)` | Inteiro padrão | Com sinal: -2,147,483,648 a 2,147,483,647<br>Sem sinal: 0 a 4,294,967,295 |
| `INTEGER(tamanho)` | Equivalente a INT | Mesmo que INT |
| `BIGINT(tamanho)` | Inteiro grande | Com sinal: -9,223,372,036,854,775,808 a 9,223,372,036,854,775,807<br>Sem sinal: 0 a 18,446,744,073,709,551,615 |
| `FLOAT(tamanho, d)` | Ponto flutuante | Precisão simples |
| `FLOAT(p)` | Ponto flutuante | p=0-24: FLOAT, p=25-53: DOUBLE |
| `DOUBLE(tamanho, d)` | Ponto flutuante duplo | Precisão dupla |
| `DECIMAL(tamanho, d)` | Número decimal exato | tamanho máximo: 65, d máximo: 30 |
| `DEC(tamanho, d)` | Equivalente a DECIMAL | Mesmo que DECIMAL |

### Tipos de Dados de Data e Hora

| Tipo de Dado | Descrição | Formato | Intervalo |
|--------------|-----------|---------|-----------|
| `DATE` | Armazena data | YYYY-MM-DD | '1000-01-01' a '9999-12-31' |
| `DATETIME(fsp)` | Data e hora combinadas | YYYY-MM-DD hh:mm:ss | '1000-01-01 00:00:00' a '9999-12-31 23:59:59' |
| `TIMESTAMP(fsp)` | Carimbo de data/hora | YYYY-MM-DD hh:mm:ss | '1970-01-01 00:00:01' UTC a '2038-01-19 03:14:07' UTC |
| `TIME(fsp)` | Armazena horário | hh:mm:ss | '-838:59:59' a '838:59:59' |
| `YEAR` | Armazena ano | YYYY | 1901 a 2155, e 0000 |

#### Características Especiais dos Tipos de Data

- **DATETIME**: Suporta `DEFAULT` e `ON UPDATE` para inicialização automática
- **TIMESTAMP**: Armazena como segundos desde a época Unix, com inicialização automática usando `DEFAULT CURRENT_TIMESTAMP` e `ON UPDATE CURRENT_TIMESTAMP`
- **fsp**: Parâmetro opcional para especificar precisão de frações de segundo (0-6)

### Exemplos Práticos de Uso

```sql
CREATE TABLE exemplo_tipos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade TINYINT UNSIGNED,
    salario DECIMAL(10,2),
    ativo BOOLEAN DEFAULT TRUE,
    data_nascimento DATE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacoes TEXT,
    status ENUM('ativo', 'inativo', 'pendente') DEFAULT 'ativo'
);
```

## 📝 Boas Práticas

### ALTER TABLE
- ⚠️ **Use com cautela**: Operações podem ser custosas em tabelas grandes
- 📋 **Planeje antecipadamente**: Minimize a necessidade de alterações posteriores
- 🔒 **Privilégios necessários**: Algumas operações requerem permissões específicas
- 🔄 **Flexibilidade**: Essencial para manutenção de esquemas adaptáveis

### Integridade de Dados
- 🔑 Sempre defina chaves primárias para identificação única
- 🔗 Use chaves estrangeiras para manter integridade referencial
- ✅ Aplique restrições apropriadas (NOT NULL, UNIQUE)
- 📊 Considere índices para melhorar performance

## 🎯 Resumo

Este material aborda os conceitos fundamentais de DDL em SQL, focando na:

1. **Criação e modificação** de estruturas de tabelas
2. **Definição de relacionamentos** entre entidades
3. **Garantia de integridade** através de restrições
4. **Otimização de consultas** com índices
5. **Manutenção de esquemas** de forma segura e eficiente

Os comandos apresentados são essenciais para qualquer desenvolvedor que trabalhe com bancos de dados relacionais, proporcionando as ferramentas necessárias para criar e manter estruturas de dados robustas e eficientes.

---

## 📊 DML - Linguagem de Manipulação de Dados

A **Linguagem de Manipulação de Dados (DML)** é uma família de sintaxes utilizada em sistemas de gerenciamento de banco de dados SQL para manipular dados dentro de tabelas. Diferente da DDL, que lida com a estrutura do banco de dados, a DML foca na manipulação dos dados contidos nas estruturas existentes.

### 🔧 Comandos Principais

- **INSERT**: Inserir novos registros
- **UPDATE**: Modificar registros existentes
- **DELETE**: Remover registros
- **SELECT**: Consultar dados
- **WHERE**: Filtrar registros
- **DISTINCT**: Retornar valores únicos
- **ANY/ALL**: Verificar condições em subconjuntos
- **LIKE**: Buscar por padrões
- **BETWEEN**: Selecionar intervalos
- **ORDER BY**: Ordenar resultados

## ➕ INSERT

O comando `INSERT INTO` adiciona novos registros a uma tabela.

### Especificando Colunas
```sql
INSERT INTO nome_da_tabela (coluna1, coluna2, coluna3, ...)
VALUES (valor1, valor2, valor3, ...);
```

**Exemplo:**
```sql
INSERT INTO DEPARTAMENTO (Dnome, Dnumero)
VALUES('Matriz', 1);
```

### Inserindo em Todas as Colunas
```sql
INSERT INTO nome_da_tabela
VALUES (valor1, valor2, valor3, ...);
```

**Exemplo:**
```sql
INSERT INTO FUNCIONARIO
VALUES ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 
        'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL, 1);
```

## ✏️ UPDATE

O comando `UPDATE` modifica registros existentes em uma tabela.

### Sintaxe
```sql
UPDATE nome_da_tabela
SET coluna1 = valor1, coluna2 = valor2, ...
WHERE condição;
```

⚠️ **IMPORTANTE**: Sempre use a cláusula `WHERE`! Sem ela, todos os registros serão atualizados.

**Exemplo:**
```sql
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
```

## 🗑️ DELETE

O comando `DELETE` remove registros existentes de uma tabela.

### Sintaxe
```sql
DELETE FROM nome_da_tabela WHERE condição;
```

⚠️ **IMPORTANTE**: Sempre use a cláusula `WHERE`! Sem ela, todos os registros serão deletados.

### Deletar Registros Específicos
```sql
DELETE FROM Funcionario
WHERE nome = 'Juca' AND cpf = '00000000000';
```

### Deletar Todos os Registros
```sql
DELETE FROM nome_da_tabela;
```

## 🔍 SELECT

O comando `SELECT` é usado para consultar dados de um banco de dados.

### Sintaxe Básica
```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela;
```

### Selecionar Todas as Colunas
```sql
SELECT * FROM nome_da_tabela;
```

## 🎯 WHERE

A cláusula `WHERE` filtra registros baseados em condições específicas.

### Sintaxe
```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE condição;
```

### Operadores WHERE

| Operador | Descrição | Exemplo |
|----------|-----------|---------|
| `=` | Igual | `WHERE coluna = valor` |
| `>` | Maior que | `WHERE coluna > valor` |
| `<` | Menor que | `WHERE coluna < valor` |
| `>=` | Maior ou igual | `WHERE coluna >= valor` |
| `<=` | Menor ou igual | `WHERE coluna <= valor` |
| `<>` ou `!=` | Diferente | `WHERE coluna <> valor` |
| `BETWEEN` | Entre um intervalo | `WHERE coluna BETWEEN valor1 AND valor2` |
| `LIKE` | Buscar por padrão | `WHERE coluna LIKE 'padrão%'` |
| `IN` | Múltiplos valores possíveis | `WHERE coluna IN (valor1, valor2)` |

## 🔄 DISTINCT

O comando `SELECT DISTINCT` retorna apenas valores únicos (não duplicados).

### Sintaxe
```sql
SELECT DISTINCT coluna1, coluna2, ...
FROM nome_da_tabela;
```

## 🔍 Operadores ANY e ALL

### ANY
Retorna `TRUE` se **QUALQUER** valor da subconsulta atender à condição.

```sql
SELECT nome_coluna(s)
FROM nome_da_tabela
WHERE nome_coluna operador ANY
  (SELECT nome_coluna
   FROM nome_da_tabela
   WHERE condição);
```

### ALL
Retorna `TRUE` se **TODOS** os valores da subconsulta atenderem à condição.

```sql
SELECT ALL nome_coluna(s)
FROM nome_da_tabela
WHERE condição;
```

## 🔎 LIKE

O operador `LIKE` busca um padrão especificado em uma coluna.

### Sintaxe
```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE colunaN LIKE padrão;
```

### Wildcards Comuns
- `%` - Representa zero ou mais caracteres
- `_` - Representa exatamente um caractere

**Exemplos:**
- `LIKE 'a%'` - Encontra valores que começam com "a"
- `LIKE '%a'` - Encontra valores que terminam com "a"
- `LIKE '%or%'` - Encontra valores que contêm "or"
- `LIKE '_r%'` - Encontra valores com "r" na segunda posição

## 📊 BETWEEN

O operador `BETWEEN` seleciona valores dentro de um intervalo específico.

### Sintaxe
```sql
SELECT nome_coluna(s)
FROM nome_da_tabela
WHERE nome_coluna BETWEEN valor1 AND valor2;
```

**Exemplo:**
```sql
SELECT * FROM FUNCIONARIO
WHERE Salario BETWEEN 30000 AND 50000;
```

## 📈 ORDER BY

A palavra-chave `ORDER BY` ordena o conjunto de resultados em ordem ascendente ou descendente.

### Sintaxe
```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
ORDER BY coluna1, coluna2, ... ASC|DESC;
```

**Exemplos:**
```sql
-- Ordem ascendente (padrão)
SELECT * FROM FUNCIONARIO ORDER BY Pnome;

-- Ordem descendente
SELECT * FROM FUNCIONARIO ORDER BY Salario DESC;

-- Múltiplas colunas
SELECT * FROM FUNCIONARIO ORDER BY Dnr ASC, Salario DESC;
```

## 💡 Boas Práticas DML

### Segurança
- ⚠️ **SEMPRE** use `WHERE` em comandos `UPDATE` e `DELETE`
- 🔒 Teste consultas com `SELECT` antes de executar `UPDATE` ou `DELETE`
- 💾 Faça backup antes de operações críticas

### Performance
- 📊 Use índices em colunas frequentemente consultadas
- 🎯 Seja específico nas condições `WHERE`
- 📈 Use `LIMIT` para consultas grandes

### Manutenibilidade
- 📝 Use nomes de colunas explícitos em `INSERT`
- 🔍 Prefira `DISTINCT` quando necessário para evitar duplicatas
- 📋 Organize consultas complexas com quebras de linha e indentação

---

## 🎯 Resumo Geral

Este material aborda os conceitos fundamentais de SQL, cobrindo tanto **DDL** (estruturação de dados) quanto **DML** (manipulação de dados):

### DDL - Estrutura
1. **Criação e modificação** de tabelas (`CREATE`, `ALTER`, `DROP`)
2. **Definição de relacionamentos** (chaves primárias e estrangeiras)
3. **Garantia de integridade** através de restrições
4. **Otimização** com índices

### DML - Dados
1. **Inserção** de novos registros (`INSERT`)
2. **Consulta** e filtragem de dados (`SELECT`, `WHERE`)
3. **Atualização** de registros existentes (`UPDATE`)
4. **Remoção** de dados (`DELETE`)
5. **Organização** e apresentação de resultados (`ORDER BY`, `DISTINCT`)

Estes comandos formam a base essencial para trabalhar com bancos de dados relacionais, permitindo criar, manter e consultar informações de forma eficiente e segura.