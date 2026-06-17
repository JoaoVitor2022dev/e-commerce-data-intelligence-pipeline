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
FROM 'caminho\para\olist_customers_dataset.csv'
WITH 
( 
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
);  

-- SUBINDO OS DADOS DA TABELA olist_geolocation_dataset

CREATE TABLE olist_geolocation_dataset (
    geolocation_id INT IDENTITY(1,1) PRIMARY KEY,
    geolocation_zip_code_prefix NVARCHAR(20),
    geolocation_lat NVARCHAR(100),
    geolocation_lng NVARCHAR(100),
    geolocation_city NVARCHAR(50),
    geolocation_state NVARCHAR(2)
);

BULK INSERT olist_geolocation_dataset 
FROM 'caminho\para\olist_geolocation_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)


-- Subindo os dados da tabela olist_products_dataset 

CREATE TABLE olist_products_dataset (
     product_id  VARCHAR(255) PRIMARY KEY,  
     product_category_name VARCHAR(255),
     product_name_lenght VARCHAR(2),
     product_description_lenght VARCHAR(10), 
     product_photos_qty   VARCHAR(5)
     product_weight_g VARCHAR(10),
     product_length_cm VARCHAR(10),
     product_height_cm  VARCHAR(10),
     product_width_cm VARCHAR(5)
)

BULK INSERT olist_products_dataset
FROM 'caminho\para\olist_products_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)








