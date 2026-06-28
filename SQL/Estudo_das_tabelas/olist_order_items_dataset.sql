-- ===================================================================
-- 1. VISÃO GERAL DOS DADOS (AMOSTRAGEM)
-- ===================================================================
SELECT TOP (1000) 
       [order_id]             -- ID único do pedido       
      ,[order_item_id]        -- Sequência do item dentro do mesmo pedido (Ex: 1, 2, 3)
      ,[product_id]           -- ID único do produto
      ,[seller_id]            -- ID único do vendedor 
      ,[shipping_limit_date]  -- Data e hora limite para o vendedor enviar o produto
      ,[price]                -- Preço do produto (valor do item)
      ,[freight_value]        -- Valor do frete cobrado por item
FROM [olist_ecommerce].[dbo].[olist_order_items_dataset];


-- ===================================================================
-- 2. ANÁLISE DE PERÍODO (Métricas de Tempo)

--  Início em 19/09/2016 e Fim em 09/04/2020
-- ===================================================================
SELECT 
    FORMAT(MIN([shipping_limit_date]), 'dd/MM/yyyy') AS [DATA_INICIO], 
    FORMAT(MAX([shipping_limit_date]), 'dd/MM/yyyy') AS [DATA_FINAL], 
    
    -- Diferenças calculadas em dias, meses e anos
    DATEDIFF(DAY,   MIN([shipping_limit_date]), MAX([shipping_limit_date])) AS [TOTAL_DIAS],   --  1.298 dias
    DATEDIFF(MONTH, MIN([shipping_limit_date]), MAX([shipping_limit_date])) AS [TOTAL_MESES],  --  43 meses
    DATEDIFF(YEAR,  MIN([shipping_limit_date]), MAX([shipping_limit_date])) AS [TOTAL_ANOS]    --  4 anos
FROM [olist_ecommerce].[dbo].[olist_order_items_dataset];


-- ===================================================================
-- 3. ANÁLISE FINANCEIRA (Médias de Vendas e Logística)

-- Respostas esperadas -> Ticket Médio: R$ 120,65 | Frete Médio: R$ 19,99
-- ===================================================================

SELECT 
   CONCAT('R$: ', FORMAT(AVG([price]), 'N2'))         AS [TICKET_MEDIO_PRODUTO],
   CONCAT('R$: ', FORMAT(AVG([freight_value]), 'N2')) AS [FRETE_MEDIO]
FROM [olist_ecommerce].[dbo].[olist_order_items_dataset];


