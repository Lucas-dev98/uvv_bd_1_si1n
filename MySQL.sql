/*_______________________________________________________________________________________________________________________________________________*/
/*  Criando o usuario lucas que vai ser o dono do banco de dados. */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE USER lucas;
/*_______________________________________________________________________________________________________________________________________________*/


/*   Criando o banco de dados com nome de pset1_elmari.  */
CREATE DATABASE pset1_elmasri;

/*_______________________________________________________________________________________________________________________________________________*/

/* Gando todas as permissoes para o user lucas.  */
GRANT ALL PRIVILEGES ON elmasri.* TO lucas;

/*_______________________________________________________________________________________________________________________________________________*/


/*  Selecionando o banco de dados pset1_elmari, para ser ultilizado.*/
USE pset1_elmasri;


/*_______________________________________________________________________________________________________________________________________________*/
/* Criando a tabela Funcionario. */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(30),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*  Adicionando comentario no schema do banco de dados na tabela funcionario.  */
/*_______________________________________________________________________________________________________________________________________________*/
ALTER TABLE funcionario COMMENT 'Tabela contendo as tuplas de funcionário.';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário , pk da tabela';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Sobrenome do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(30) COMMENT 'Endereço do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salario do funcionário.';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER COMMENT 'Numero do departamento do funcionário.';


/*_______________________________________________________________________________________________________________________________________________*/
/*   Criando a tabela dependente. */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*   Adicionando comentario no schema do banco de dados na tabela dependente. */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário, é uma pk e uma fk';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente. Faz parte da PK desta tabela.';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'Dependente de funcionario';

/*_______________________________________________________________________________________________________________________________________________*/
/*  Criando a tabela de departamento.*/
/*_______________________________________________________________________________________________________________________________________________*/

CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio DATE,
                PRIMARY KEY (numero_departamento)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*  Adicionando comentario no schema do banco de dados na tabela departamento.     */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE departamento COMMENT 'Tabela contem as informaçoẽs dos departamentos.';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento,a PK desta tabela.';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento, é unico';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento, é uma FK';

ALTER TABLE departamento MODIFY COLUMN data_inicio DATE COMMENT 'Data do incio do gerente no departamento';

/*_______________________________________________________________________________________________________________________________________________*/
/*  Criando restrição de chave unica no atributo nome_departamento da tabela departamento.  */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );
 
/*_______________________________________________________________________________________________________________________________________________*/
/*   Criando a tabela de projeto.            */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*   Adicionando comentario no schema do banco de dados na tabela projeto.             */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE projeto COMMENT 'Tabela que contem as informações dos projetos dos departamentos.';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto, é a PK desta tabela.';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) COMMENT 'Nome do projeto, é unico';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização do projeto.';


/*_______________________________________________________________________________________________________________________________________________*/
/*  Criando restrição de chave unica no atributo nome_projeto da tabela projeto.              */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE INDEX projeto_idx
 ON projeto
 ( nome_projeto );
 
/*_______________________________________________________________________________________________________________________________________________*/
/* Criando restrição de chave unica no atributo nome_projeto da tabela projeto.               */
/*_______________________________________________________________________________________________________________________________________________*/
CREATE UNIQUE INDEX projeto_idx1
 ON projeto
 ( nome_projeto );
 
/*_______________________________________________________________________________________________________________________________________________*/
/*    Criando a tabela trabalha_em.    */
/*_______________________________________________________________________________________________________________________________________________*/
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*   Adicionando comentario no schema do banco de dados na tabela trabalha_em.              */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE trabalha_em COMMENT 'Tabela que contem aonde cada funcionario trabalha';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário é uma PK desta tabela e é uma FK';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto é uma PK desta tabela e é uma FK';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas que os funcionarios trabalharam';

/*_______________________________________________________________________________________________________________________________________________*/
/*   Criando a tabela de localizacoes_departamento.            */
/*_______________________________________________________________________________________________________________________________________________*/

CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

/*_______________________________________________________________________________________________________________________________________________*/
/*   Adicionando comentario no schema do banco de dados na tabela localizacoes_departamento.              */
/*_______________________________________________________________________________________________________________________________________________*/


ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as localizações dos departamentos';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT ' é uma fk para departamento';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento é a PK desta tabela.';

/*_______________________________________________________________________________________________________________________________________________*/
/*  Inserindo os dados das tuplas de funcionario.    */
/*_______________________________________________________________________________________________________________________________________________*/


INSERT INTO funcionario VALUES (
88866555576, 'Jorge' , 'E' , 'Brito' , '1937-11-10' ,'R.do Horto,35,São Paulo,SP','M',55000.00, NULL, 1);

INSERT INTO funcionario VALUES (
98765432168, 'Jennifer' , 'S' , 'Souza' , '1941-06-20' ,'Av.Art.deLima,54,SantoAndré,SP','F',43000.00, 88866555576, 4);

INSERT INTO funcionario VALUES (
33344555587, 'Fernando' , 'T' , 'Wong' , '1955-12-08' ,'R.da Lapa,34,São Paulo,SP','M', 40000.00, 88866555576, 5);

INSERT INTO funcionario VALUES (
98798798733, 'André' , 'V' , 'Pereira' , '1969-03-29' ,'RuaTimbira,35,São Paulo,SP','M',25000.00, 98765432168, 4);

INSERT INTO funcionario VALUES (
45345345376, 'Joice' , 'A' , 'Leite' , '1972-07-31' ,'Av.Lucas Obes,74,São Paulo,SP','F',25000.00, 33344555587, 5);


INSERT INTO funcionario VALUES (
66688444476, 'Ronaldo' , 'K' , 'Lima' , '1962-09-15' ,'Rua Rebouças,65,Piracicaba, SP','M',38000.00, 33344555587, 5);

INSERT INTO funcionario VALUES (
12345678966, 'Joao', 'B', 'Silva', '1965-01-09', 'R. das Flores,751.São Paulo,SP', 'M', 30000.00, 33344555587, 5);

INSERT INTO funcionario VALUES (
99988777767, 'Alice' , 'J' , 'Zelaya' , '1968-01-19' ,'R.Souza Lima,35,Curitiba,PR','F',25000.00, 98765432168, 4);

/*_______________________________________________________________________________________________________________________________________________*/
/*  Inserindo os dados das tuplas de localizacoes_departamento.             */
/*_______________________________________________________________________________________________________________________________________________*/


INSERT INTO localizacoes_departamento VALUES (
1, 'São Paulo');

INSERT INTO localizacoes_departamento VALUES (
4, 'Mauá');

INSERT INTO localizacoes_departamento VALUES (
5 , 'SantoAndré');

INSERT INTO localizacoes_departamento VALUES (
5, 'Itu');

INSERT INTO localizacoes_departamento VALUES (
5, 'São Paulo');

/*_______________________________________________________________________________________________________________________________________________*/
/* Inserindo os dados das tuplas de projeto.              */
/*_______________________________________________________________________________________________________________________________________________*/


INSERT INTO projeto VALUES (1, 'ProdutoX', 'SantoAndré', 5 );

INSERT INTO projeto VALUES (2, 'ProdutoY', 'Itu', 5 );

INSERT INTO projeto VALUES (3, 'ProdutoZ', 'São_Paulo', 5 );

INSERT INTO projeto VALUES (10, 'Informatização', 'Mauá', 4 );

INSERT INTO projeto VALUES (20, 'Reorganização','São_Paulo', 1 );

INSERT INTO projeto VALUES (30, 'Novosbeneficios', 'Mauá', 4 );

/*_______________________________________________________________________________________________________________________________________________*/
/* Inserindo os dados das tuplas de dependente.              */
/*_______________________________________________________________________________________________________________________________________________*/


INSERT INTO dependente VALUES (33344555587, 'Alicia', 'F', '1986-04-05', 'filha');

INSERT INTO dependente VALUES (33344555587, 'Tiago', 'M', '1983-10-25', 'filho');

INSERT INTO dependente VALUES (33344555587, 'Janaína', 'F', '1958-05-03' , 'Esposa');

INSERT INTO dependente VALUES (98765432168, 'Antonio', 'M', '1942-02-28' , 'Marido');

INSERT INTO dependente VALUES (12345678966, 'Michael', 'M', '1988-01-04' , 'Filho');

INSERT INTO dependente VALUES (12345678966, 'Alicia', 'F', '1988-12-30' , 'Filha');

INSERT INTO dependente VALUES (12345678966, 'Elizabeth', 'F', '1967-05-05' , 'Esposa');

/*_______________________________________________________________________________________________________________________________________________*/
/*   Inserindo os dados das tuplas de departamento.            */
/*_______________________________________________________________________________________________________________________________________________*/

INSERT INTO departamento VALUES (5, 'Pesquisa', 33344555587, '1988-05-22');

INSERT INTO departamento VALUES (4, 'Administração', 98765432168 ,'1995-01-01');

INSERT INTO departamento VALUES (1, 'Matriz', 88866555576, '1981-06-19');

/*_______________________________________________________________________________________________________________________________________________*/
/*  Inserindo os dados das tuplas de trabalha_em.             */	
/*_______________________________________________________________________________________________________________________________________________*/


INSERT INTO trabalha_em VALUES (12345678966, 1, 32.5 );

INSERT INTO trabalha_em VALUES (12345678966, 2, 7.5);

INSERT INTO trabalha_em VALUES (66688444476 , 3, 40.0);

INSERT INTO trabalha_em VALUES (45345345376, 1, 20.0);

INSERT INTO trabalha_em VALUES (45345345376, 2, 20.00);

INSERT INTO trabalha_em VALUES (33344555587, 2, 10.0);

INSERT INTO trabalha_em VALUES (33344555587, 3, 10.0);

INSERT INTO trabalha_em VALUES (33344555587, 10, 10.0);

INSERT INTO trabalha_em VALUES (33344555587, 20, 10.0);

INSERT INTO trabalha_em VALUES (99988777767, 30, 30.0);

INSERT INTO trabalha_em VALUES (99988777767, 10, 10.0);

INSERT INTO trabalha_em VALUES (98798798733, 10, 35.0);

INSERT INTO trabalha_em VALUES (98798798733, 30, 5.0);

INSERT INTO trabalha_em VALUES (98765432168, 30, 20.0);

INSERT INTO trabalha_em VALUES (98765432168, 20, 15.0);

INSERT INTO trabalha_em VALUES (88866555576, 10, null);	

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'departamento', e adicionando a foreign key 'funcionario_departamento_fk' em 'cpf_gerente' referente a
	'cpf' da tabela 'funcionario'.   */
/*_______________________________________________________________________________________________________________________________________________*/


ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'dependente' ,e adicionando a foreign key 'funcionario_dependente_fk' em 'cpf_funcionario' referente a
	'cpf' da tabela 'funcionario'.   */
/*_______________________________________________________________________________________________________________________________________________*/


ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'trabalha_em', e adicionando a foreign key 'funcionario_trabalha_em_fk' em 'cpf_funcionario' referente a
	'cpf' da tabela 'funcionario'.   */
/*_______________________________________________________________________________________________________________________________________________*/


ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'funcionario', e adicionando a foreign key 'funcionario_trabalha_em_fk' em 'cpf_funcionario' referente a
	'cpf' da tabela 'funcionario'.   */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'localizacoes_departamento', e adicionando a foreign key 'departamento_localizacoes_departamento_fk' em
	'numero_departamento' referente a 'numero_departamento' da tabela 'departamento'.   */
/*_______________________________________________________________________________________________________________________________________________*/


ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'projeto', e adicionando a foreign key 'departamento_projeto_fk' em
	'numero_departamento' referente a 'numero_departamento' da tabela 'departamento'.   */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'funcionario', e adicionando a foreign key 'departamento_funcionario_fk' em
	'numero_departamento' referente a 'numero_departamento' da tabela 'departamento'.   */
/*_______________________________________________________________________________________________________________________________________________*/
ALTER TABLE funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*    alterando a tabela 'trabalha_em', e adicionando a foreign key 'projeto_trabalha_em_fk' em
	'numero_projeto' referente a 'numero_projeto' da tabela 'projeto'.   */
/*_______________________________________________________________________________________________________________________________________________*/

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/*_______________________________________________________________________________________________________________________________________________*/
/*               */
/*_______________________________________________________________________________________________________________________________________________*/

