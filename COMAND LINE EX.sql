/* _________________________________________________________________________________________________________________*/
/* Criando a Base de dados  "PSET1_ELMASLI"*/

CREATE DATABASE PSET1_ELMASLI;

/* _________________________________________________________________________________________________________________*/
/* Selecionando o Banco de Dados Criado*/

 USE PSET1_ELMASLI;

/* Criando a Tabela "funcionario":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "cpf", como uma chave primaria .
*/

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário. Será a PK da tabela.';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(30) COMMENT 'Endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento do funcionário.';


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'para a tabela funcionário.';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Descrição do parentesco do dependente com o funcionário.';


CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio DATE,
                PRIMARY KEY (numero_departamento)
);

ALTER TABLE departamento COMMENT 'Tabela que armazena as informaçoẽs dos departamentos.';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento. Deve ser único.';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'onários.';

ALTER TABLE departamento MODIFY COLUMN data_inicio DATE COMMENT 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto. É a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto. Deve ser único.';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';


CREATE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE UNIQUE INDEX projeto_idx1
 ON projeto
 ( nome_projeto );

CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'para a tabela funcionário.';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'ara a tabela projeto.';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'm é uma FK para a tabela departamento.';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento. Faz parte da PK desta tabela.';


ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Inserindo os dados nas TUPLAS, das TABELAS . */

/*cpf || primeiro_nome || nome_meio || data_nascimento || endereco || sexo ||
 salario || cpf_supervisor || numero_departamento  */


/* TUPLA JOÃO */
	insert INTO funcionario values(
    "12345678966", "joão","B","Silva","Rua das Flores,751,São Paulo,SP",
    "M",30.000,"3345555587",5
    );
    
/* _________________________________________________________________________________________________________________*/
    
    /* TUPLA FERNANDO */
    INSERT INTO funcionario VALUES (
		"33344555587", "Fernando","T","Wong","1955-12-08",
		"Rua da Lapa,34, São Paulo,SP","M",40.000,
		"88866555576", 5
    );
 /* _________________________________________________________________________________________________________________*/
      
      /* TUPLA ALICE */
      INSERT INTO funcionario VALUES (
		"99988777767", "Alice","J","Zelaya","1968-01-19",
		"Rua Souza Lima, 35, Curutiba, PR","F",25.000,
		"98765432168", 4
    );

/* _________________________________________________________________________________________________________________*/
    
          /* TUPLA JENNIFER */
      INSERT INTO funcionario VALUES (
		"98765432168", "Jennifer","S","Souza","1941-06-20",
		"Av. Arthur de Lima,54, Santo André,SP","F",43.000,
		"88866555576", 4
    );
    
/* _________________________________________________________________________________________________________________*/
    
          /* TUPLA RONALDO */
      INSERT INTO funcionario VALUES (
		"66688444476", "Ronaldo","K","Lima","1962-09-01",
		"Rua Rebouças,65,Piracicaba,SP","M",38.000,
		"33344555587", 5
    );
    
/* _________________________________________________________________________________________________________________*/
    
          /* TUPLA JOICE */
      INSERT INTO funcionario VALUES (
		"45345345376", "Joice","A","Leite","1972-07-31",
		"Av. Lucas Obes,74,São Paulo,SP","F",25.000,
		"33344555587", 5
    );
/* _________________________________________________________________________________________________________________*/
    
          /* TUPLA ANDRÉ */
      INSERT INTO funcionario VALUES (
		"98798798733", "André","V","Perreira","1969-03-29",
		"Rua Timbira,35,São Paulo,SP","M",25.000,
		"98765432168", 4
    );
    
    /* _________________________________________________________________________________________________________________*/
    
          /* TUPLA JORGE */
      INSERT INTO funcionario VALUES (
		"88866555576", "Jorge","E","Brito","1937-11-10",
		"Rua do Horto,35,São Paulo,SP","M",55.000,
		"", 1);
        
        
   
        
    



    
    
   
