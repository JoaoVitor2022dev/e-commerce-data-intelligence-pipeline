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


-- olist_sellers_dataset 

CREATE TABLE olist_sellers_dataset (
        seller_id VARCHAR(100),
        seller_zip_code_prefix  VARCHAR(20),
        seller_city VARCHAR(100),
        seller_state VARCHAR(5)
)

BULK INSERT olist_sellers_dataset
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\olist_sellers_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)


CREATE TABLE olist_orders_dataset (
   order_id VARCHAR(50) ,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
)

BULK INSERT olist_products_dataset
FROM 'caminho\para\olist_orders_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)


CREATE TABLE olist_order_items_dataset (
    order_id VARCHAR(50) PRIMARY KEY,
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

BULK INSERT olist_order_items_dataset
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\olist_orders_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)


CREATE TABLE olist_order_payments_dataset (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

BULK INSERT olist_order_payments_dataset
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\olist_order_payments_dataset.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)


-- DROP TABLE olist_order_reviews_dataset
CREATE TABLE olist_order_reviews_dataset (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(100),
    review_comment_message VARCHAR(MAX),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

BULK INSERT olist_order_reviews_dataset
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\olist_order_reviews_dataset.csv'
WITH (
  FIRSTROW = 2,
  FORMAT = 'CSV',              
  FIELDTERMINATOR = ',',
  FIELDQUOTE = '"',            -- Especifica que as colunas de texto estão entre aspas
  ROWTERMINATOR = '\n',        
  CODEPAGE = '65001'           
);


CREATE TABLE product_category_name_translation (
     product_category_name VARCHAR(100), 
     product_category_name_english VARCHAR(100)
)

BULK INSERT product_category_name_translation 
FROM 'C:\Users\jennifer\OneDrive\Desktop\JV\Estudos\Projeto\Base de Dados\product_category_name_translation.csv'
WITH 
(
  FIRSTROW = 2,
  FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
  FIELDTERMINATOR = ',',
  ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
  CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
)

1 - Chaves primarias de cada coluna 

ALTER TABLE olist_customers_dataset ADD CONSTRAINT PK_customers PRIMARY KEY (customer_id);

ALTER TABLE olist_products_dataset ADD CONSTRAINT PK_products PRIMARY KEY (product_id);

ALTER TABLE olist_sellers_dataset ADD CONSTRAINT PK_sellers PRIMARY KEY (seller_id);

ALTER TABLE olist_orders_dataset ADD CONSTRAINT PK_orders PRIMARY KEY (order_id);











