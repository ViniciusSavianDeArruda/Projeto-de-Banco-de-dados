# 📊 Projeto e Implementação de Banco de Dados

Este repositório contém os materiais, exercícios e projetos desenvolvidos durante as disciplinas de **Projeto de Banco de Dados** e **Implementação de Banco de Dados** do curso de graduação.

## 📋 Índice

- [Sobre as Disciplinas](#sobre-as-disciplinas)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Projetos Desenvolvidos](#projetos-desenvolvidos)
- [Tecnologias Utilizadas](#tecnologias-utilizadas)
- [Como Executar](#como-executar)
- [Conceitos Abordados](#conceitos-abordados)
- [Contribuição](#contribuição)

## 📚 Sobre as Disciplinas

### Projeto de Banco de Dados
Disciplina focada na **modelagem conceitual e lógica** de sistemas de banco de dados, abordando:
- Análise de requisitos
- Modelo Entidade-Relacionamento (MER)
- Normalização de dados
- Projeto de esquemas relacionais

### Implementação de Banco de Dados
Disciplina prática voltada para a **implementação física** e **administração** de bancos de dados, incluindo:
- Linguagem SQL (DDL, DML, DQL)
- Consultas complexas e otimização
- Stored procedures e triggers
- Administração e manutenção

## 📁 Estrutura do Repositório

```
📦 Database-Projects
├── 📄 README.md
├── 📁 Aulas Implementacao de banco de dados/
│   ├── 📄 Aula banco de dados- Consultas.sql
│   └── 📄 Aula implematacao banco de dados, Consultas complexas.sql
├── 📄 Banco de dados FaculdadeExercicio.sql
├── 📄 Banco de dados- Faculdade.sql
├── 📄 Exercicio Companhia_Aerea.sql
├── 📄 sqlacademia.sql
├── 📄 Empresa.sql
├── 📄 SQL Atividade Banco de dados Biblioteca.sql
├── 📄 MYSQL PROJETOS AULAS.sql.mwb
└── 📄 Modelo conceitual e Modelo logico Academia.pdf
```

## 🚀 Projetos Desenvolvidos

### 1. Sistema Acadêmico - Faculdade
**Arquivos:** `Banco de dados FaculdadeExercicio.sql`, `Banco de dados- Faculdade.sql`

Sistema completo para gestão acadêmica incluindo:
- ✅ Cadastro de alunos e disciplinas
- ✅ Controle de turmas e professores
- ✅ Histórico escolar e notas
- ✅ Sistema de pré-requisitos

**Entidades principais:**
- `ALUNO` - Dados dos estudantes
- `DISCIPLINA` - Matérias oferecidas
- `TURMA` - Turmas por semestre
- `HISTORICO_ESCOLAR` - Notas e aprovações
- `PRE_REQUISITO` - Dependências entre disciplinas

### 2. Sistema de Academia
**Arquivo:** `sqlacademia.sql`

Sistema completo para gestão de academia com:
- ✅ Cadastro de alunos e personal trainers
- ✅ Fichas de treino personalizadas
- ✅ Controle de frequência
- ✅ Avaliações físicas periódicas
- ✅ Exercícios por grupo muscular

**Funcionalidades implementadas:**
- Relatórios de frequência por aluno
- Acompanhamento de evolução física
- Gestão de treinos e exercícios

### 3. Sistema de Companhia Aérea
**Arquivo:** `Exercicio Companhia_Aerea.sql`

Sistema para gestão de voos e reservas:
- ✅ Cadastro de aeroportos e aeronaves
- ✅ Controle de voos e trechos
- ✅ Sistema de reservas de assentos
- ✅ Gestão de tarifas e restrições

### 4. Sistema Empresarial
**Arquivo:** `Empresa.sql`

Modelo para gestão empresarial básica.

### 5. Sistema de Biblioteca
**Arquivo:** `SQL Atividade Banco de dados Biblioteca.sql`

Sistema para controle de acervo e empréstimos bibliotecários.

## 🛠️ Tecnologias Utilizadas

- **SGBD:** MySQL / SQL Server
- **Linguagem:** SQL (DDL, DML, DQL, DCL)
- **Ferramentas:** MySQL Workbench
- **Modelagem:** Modelo Entidade-Relacionamento

## ⚡ Como Executar

### Pré-requisitos
- MySQL Server 8.0+ ou SQL Server
- MySQL Workbench ou SQL Server Management Studio

### Passos para execução

1. **Clone o repositório**
   ```bash
   git clone [url-do-repositorio]
   cd database-projects
   ```

2. **Execute os scripts SQL**
   ```sql
   -- Para cada projeto, execute na ordem:
   -- 1. Criação do banco
   -- 2. Criação das tabelas
   -- 3. Inserção dos dados
   -- 4. Consultas de teste
   ```

3. **Exemplo - Sistema Academia**
   ```sql
   -- Conecte ao MySQL e execute:
   SOURCE sqlacademia.sql;
   
   -- Teste com consultas básicas:
   SELECT * FROM alunos ORDER BY nome;
   ```

## 📖 Conceitos Abordados

### Modelagem de Dados
- [x] Modelo Conceitual (MER)
- [x] Modelo Lógico Relacional
- [x] Normalização (1FN, 2FN, 3FN)
- [x] Integridade Referencial

### SQL Avançado
- [x] Consultas com JOIN (INNER, LEFT, RIGHT)
- [x] Subconsultas (Subqueries)
- [x] Funções de Agregação (COUNT, SUM, AVG)
- [x] Agrupamento (GROUP BY, HAVING)
- [x] Ordenação e Filtros Complexos

### Administração
- [x] Criação e Gerenciamento de Índices
- [x] Controle de Transações
- [x] Backup e Restore
- [x] Otimização de Consultas

## 📊 Estatísticas do Projeto

- **Total de Bancos:** 6 sistemas completos
- **Tabelas Criadas:** 35+ tabelas
- **Consultas Implementadas:** 50+ queries
- **Relacionamentos:** 25+ foreign keys

## 🤝 Contribuição

Este repositório é parte do material acadêmico. Para sugestões ou melhorias:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## 📝 Licença

Este projeto é desenvolvido para fins acadêmicos e educacionais.

## 👨‍💻 Autor

Desenvolvido durante as disciplinas de Projeto e Implementação de Banco de Dados.

---

### 📞 Contato

Para dúvidas sobre implementação ou conceitos abordados, entre em contato através dos canais institucionais da faculdade.

**⭐ Se este repositório foi útil para seus estudos, considere dar uma estrela!**