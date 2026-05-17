-- /* 1. Criação do Banco de Dados */
CREATE DATABASE  BRAZILIAN_ECOMMERCE_OLIST;
GO 

USE BRAZILIAN_ECOMMERCE_OLIST;
GO

-- /* 2. Criação da Tabela Dimensão Clientes */ 
-- product_id,"product_category_name","product_name_lenght","product_description_lenght","product_photos_qty","product_weight_g","product_length_cm","product_height_cm","product_width_cm"

-- DROP TABLE Olist_products;
CREATE TABLE Olist_products (
    product_id NVARCHAR(200) PRIMARY KEY,
    product_category_name NVARCHAR(100),
    product_name_lenght INT, 
    product_description_lenght INT, 
    product_photos_qty INT, 
    product_weight_g INT, 
    product_length_cm INT, 
    product_height_cm INT, 
    product_width_cm INT
)

-- /* 3 . Criação da customers */ 
-- customer_id,"customer_unique_id","customer_zip_code_prefix","customer_city","customer_state"

-- DROP TABLE olist_order_customer;
CREATE TABLE olist_order_customer (
    customer_id NVARCHAR(200) PRIMARY KEY,
    customer_unique_id NVARCHAR(200),
    customer_zip_code_prefix NVARCHAR(20),  
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(2)
)


BULK INSERT olist_order_customer
FROM 'list_customers_dataset.csv'

BULK INSERT Olist_products
FROM 'olist_products_dataset.csv'

WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',              -- Esse comando mágico resolve o problema das aspas
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',        -- Se der erro de linha, tente mudar para '0x0a'
    CODEPAGE = '65001'           -- UTF-8 para não quebrar a acentuação
); 
