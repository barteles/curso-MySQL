CREATE TABLE sales (
    purchase_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

CREATE TABLE customers (
    customers_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customers_id)
);
    
   CREATE TABLE itens (
    item_code VARCHAR(255),
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255),
    PRIMARY KEY (item_code)
);
    
    CREATE TABLE companies (
    company_id VARCHAR(255) NOT NULL,
    company_name VARCHAR(255),
    headquartes_phone_number INT(12),
    PRIMARY KEY (company_id)
);
    
    /* aqui eu dei DROP para aprender como se exclue uma tabela inteira ( para excluir uma base de dados é a mesma sintaxe) */

DROP TABLE sales;

CREATE TABLE sales (
    purchase_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL
);

    
  /* aqui eu retirei a Foreign key e depois eu a refiz para aprender como se escreve */
  
ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customers_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;    

ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customers_id) ON DELETE CASCADE;

/* aqui eu vou aprender a sintaxe das Unique Keys ou Índices, não pode haver dois resultados iguais em uma Unique Key */

ALTER TABLE customers
ADD UNIQUE KEY (email_adress);

ALTER TABLE customers
DROP INDEX email_adress;

/* não dá para dar DROP quando há Foreign Keys com essa tabela, portanto devo elimina-los antes de droppar a tabela inteira */

drop table customers;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_adress VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);

/* aqui eu adcionei a coluna gênero e vou inserir os primeiros dados da tabela customers */

ALTER TABLE customers
ADD COLUMN gender ENUM('M','F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_adress, number_of_complaints)
VALUES  ('John', 'Macklinley', 'M', 'john.mckliney@365careers.com', 0);

/* aqui irei colocar o 'valor padrão' ou DAFAULT no número de queixas que deverá ser 0, caso haja queixas posteriores esse valor
sera inserido somente no consumidor que fez as queixas */

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;
/*/ vamos verificar se de fato deu certo inserindo dados de um consumidor novo, sem o número de reclamações /*/
INSERT INTO customers (first_name, last_name, gender)
VALUE ('Peter', 'Figaro', 'M');

-- apagando uma variável DEFAULT
ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP default;

/* aqui eu fiz o exercício 56, colocando uma UNIque key na tabela companies e botando uma variável padrão para o nome das empresas */

ALTER TABLE companies
ADD UNIQUE KEY (headquartes_phone_number);
alter table companies
CHANGE COLUMN company_name company_name VARCHAR(255) DEFAULT 'X';

/* exercício 58, agora irei colocar o NAO NULO, aqui a sentença é diferente com o ALTER, devendo usar o comando MODIFY */

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR(255) NOT NULL;

ALTER TABLE companies
MODIFY company_name VARCHAR(255) NULL;


