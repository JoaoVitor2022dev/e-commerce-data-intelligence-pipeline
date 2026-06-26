SELECT TOP (1000) 
     [customer_id]
    ,[customer_unique_id]
    ,[customer_zip_code_prefix]
    ,[customer_city]
    ,[customer_state]
FROM [olist_ecommerce].[dbo].[olist_customers_dataset];

------------------------------------------------------------------------------------------------------------------------------------------------------
-- PERGUNTA 1: QUANTOS CLIENTES TEM POR ESTADO?
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    [customer_state],
    COUNT([customer_unique_id]) AS [NUMERO_DE_CLIENTE],
    ROUND(COUNT([customer_unique_id]) * 100.0 / (SELECT COUNT([customer_unique_id]) FROM [olist_ecommerce].[dbo].[olist_customers_dataset]), 2) AS [PERCENTUAL]
FROM [olist_ecommerce].[dbo].[olist_customers_dataset]
GROUP BY [customer_state]
ORDER BY [NUMERO_DE_CLIENTE] DESC;

/* RESUMO 1:
   - O número total de clientes é 99.441.
   - A maior parte dos nossos clientes nessa base de dados são do Estado de São Paulo, seguido por RJ e MG.
   - Os estados com os menores números de clientes são RR, AP e AC.
*/ 

------------------------------------------------------------------------------------------------------------------------------------------------------
-- PERGUNTA 2: QUANTOS CLIENTES TEM NAS CIDADES DO ESTADO COM MAIS CLIENTES (SP)?
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    [customer_city],
    COUNT([customer_unique_id]) AS [NUMERO_DE_CLIENTE],
    -- Correção: Agora calcula o percentual de cada cidade em relação ao total do estado de SP
    ROUND(COUNT([customer_unique_id]) * 100.0 / (SELECT COUNT([customer_unique_id]) FROM [olist_ecommerce].[dbo].[olist_customers_dataset] WHERE [customer_state] = 'SP'), 2) AS [PERCENTUAL]
FROM [olist_ecommerce].[dbo].[olist_customers_dataset]
WHERE [customer_state] = 'SP'
GROUP BY [customer_city]
ORDER BY [NUMERO_DE_CLIENTE] DESC;

/* RESUMO 2:
   - As cidades com mais clientes dentro do estado de São Paulo são: São Paulo, Campinas e Guarulhos.
*/

SELECT TOP (1000) 
     [customer_id]              -- ID único gerado para cada pedido/carrinho individual.
    ,[customer_unique_id]       -- ID fixo do cliente real (cadastro único/CPF).
    ,[customer_zip_code_prefix] -- Primeiros 5 dígitos do CEP do endereço de entrega.
    ,[customer_city]            -- Cidade onde o cliente reside.
    ,[customer_state]           -- Estado (UF) onde o cliente reside.
FROM [olist_ecommerce].[dbo].[olist_customers_dataset];