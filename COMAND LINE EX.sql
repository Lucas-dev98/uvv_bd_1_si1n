/* _________________________________________________________________________________________________________________*/

/* Criando a Tabela "funcionario":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "cpf", como uma chave primaria .
*/
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1) NOT NULL,
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE NOT NULL,
                endereco VARCHAR(30) NOT NULL,
                sexo CHAR(1) NOT NULL,
                salario DECIMAL(10,2) NOT NULL,
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

/* _________________________________________________________________________________________________________________*/

/*  Alteração da tabela "funcionario", adicionando o comentario no atributo "cpf".  */
	ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'Primary Key em funcionario, no atributo cpf.';

/* _________________________________________________________________________________________________________________*/

/*  Alteração da tabela "funcionario", adicionando o comentario no atributo "primeiro_nome".         */
	ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'primeiro nome do funcionario';

/* _________________________________________________________________________________________________________________*/


 /* Criando a tabela de "dependente":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "cpf_funcionario, nome_dependente", como uma chave primaria .
*/
	CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1) NOT NULL,
                data_nascimento DATE NOT NULL,
                parentesco VARCHAR(15) NOT NULL,
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

/* _________________________________________________________________________________________________________________*/

/* criando a tabela "departamento":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "numero_departamento", como uma chave primaria .
*/
	CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE NOT NULL,
                PRIMARY KEY (numero_departamento)
);

/* _________________________________________________________________________________________________________________*/

/* Criando a restrição de chave unica em "departamento" no atributo "nome_departamento" . */
	CREATE UNIQUE INDEX departamento_idx
		ON departamento
		( nome_departamento );
 
  /* _________________________________________________________________________________________________________________*/


 /* Criando a restrição de chave unica em "departamento" no atributo "nome_departamento" .  */
	CREATE UNIQUE INDEX departamento_idx1
	ON departamento
	( cpf_gerente );
 
/* _________________________________________________________________________________________________________________*/



 /* Criando a tabela de "localizacoes_departamento":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "numero_departamento", "local", como uma chave primaria .
*/
	CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);


/* _________________________________________________________________________________________________________________*/


/* criando a tabela "projeto":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "numero_projeto", como uma chave primaria .
*/
	CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

/* _________________________________________________________________________________________________________________*/


 /* Criando a restrição de chave unica em "projeto" no atributo "nome_projeto" .  */
	CREATE UNIQUE INDEX projeto_idx
	ON projeto
	( nome_projeto );
 
 
 
  /* _________________________________________________________________________________________________________________*/
 
 /* Criando a tabela de "trabalha_em":
	definindo as restriçoes de NOT NULL, definindo tipo dos campos,
    e adicionando o campo "cpf_funcionario, numero_projeto", como uma chave primaria .
*/
	CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);


  /* _________________________________________________________________________________________________________________*/

/* Alternado a tabela "departamento", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "cpf_gerente", que faz referência a chave primaria, "cpf", da tabela "funcionario".
*/
	ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
	FOREIGN KEY (cpf_gerente)
	REFERENCES funcionario (cpf)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;


  /* _________________________________________________________________________________________________________________*/

/* Alternado a tabela "trabalha_em", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "cpf_funcionario", que faz referência a chave primaria, "cpf", da tabela "funcionario".
*/
	ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em__fk
	FOREIGN KEY (cpf_funcionario)
	REFERENCES funcionario (cpf)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;

  /* _________________________________________________________________________________________________________________*/
/* Alternado a tabela "funcionario", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "cpf_supervisor", que faz referência a chave primaria, "cpf", da tabela "funcionario".
*/
	ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
	FOREIGN KEY (cpf_supervisor)
	REFERENCES funcionario (cpf)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;

  /* _________________________________________________________________________________________________________________*/
/* Alternado a tabela "dependente", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "cpf_funcionario", que faz referência a chave primaria, "cpf", da tabela "funcionario".
*/
	ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
	FOREIGN KEY (cpf_funcionario)
	REFERENCES funcionario (cpf)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION;

  /* _________________________________________________________________________________________________________________*/

/* Alternado a tabela "projeto", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "numero_departamento", que faz referência a chave primaria, "numero_departamento", da tabela "departamento".
*/
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


  /* _________________________________________________________________________________________________________________*/


/* Alternado a tabela "localizacoes_departamento", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "numero_departamento", que faz referência a chave primaria, "numero_departamento", da tabela "departamento".
*/
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;


  /* _________________________________________________________________________________________________________________*/

/* Alternado a tabela "trabalha_em", adicionando a restrição/ relacionamento de Chave Estrangeira,
	em "numero_projeto", que faz referência a chave primaria, "numero_projeto", da tabela "projeto".
*/
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em__fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* _________________________________________________________________________________________________________________*/

/* Inserindo os dados nas TUPLAS, das TABELAS . */

/*cpf || primeiro_nome || nome_meio || data_nascimento || endereco || sexo ||
 salario || cpf_supervisor || numero_departamento  */


/* TUPLA JOÃO */
	INSERT INTO funcionario VALUES (
		"12345678966", "João","B","Silva","1965-01-09",
		"Rua das Flores,751, São Paulo,SP","M",30.000,
		"33344555587", 5
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
		"", 1
    );


    
    
    