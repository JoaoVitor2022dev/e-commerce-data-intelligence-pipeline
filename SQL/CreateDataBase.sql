-- CRIAR O BANCO DE DADOS 
CREATE DATABASE olist_ecommerce; 

-- CONECTAR COM O BANCO DE DADOS
USE olist_ecommerce; 


-- CRIAR AS TABELAS E SUBIR OS DADOS PARA AS TABELAS 
-- DROP TABLE olist_customers_dataset
CREATE TABLE olist_customers_dataset (
      customer_id              NVARCHAR(200) PRIMARY KEY,
      customer_unique_id       NVARCHAR(200),
      customer_zip_code_prefix NVARCHAR(20),
      customer_city            NVARCHAR(100),
      customer_state           NVARCHAR(2)  
)


-- SUBIR OS DADOS COM BULK INSERT 

-- SUBINDO OS DADOS DA TABELA CUSTOMERS 
BULK INSERT olist_customers_dataset
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\olist_customers_dataset.csv'
WITH 
( 
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
);  

-- SUBINDO OS DADOS DA TABELA 


