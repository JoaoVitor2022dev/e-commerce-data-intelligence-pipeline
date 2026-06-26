/* ============================================================
   1. VERIFICAR O VALOR TOTAL DOS PEDIDOS COM FRETE
   ------------------------------------------------------------
   Objetivo:
    Identificar o valor total dos pedidos, considerando o preço do produto
     e o valor do frete.
   ============================================================ */

CREATE PROCEDURE sp_ValorTotalPorPedido
AS 
  BEGIN
       SELECT 
            [order_id], 
       
            SUM(price) AS [total], 
            
            SUM(freight_value) AS [freight_total],
            
            SUM(price + freight_value) AS [total_com_frete]  
       
       FROM olist_order_items_dataset 

       GROUP BY [order_id]
END 

EXEC sp_ValorTotalPorPedido


/* ============================================================
   1. Verificar as vendas por categoria 
   ------------------------------------------------------------
   Objetivo:    
     Resumo geral das vendas por categoria de produto, considerando
     a quantidade de itens vendidos e o valor das vendas 
   ============================================================ */

CREATE PROCEDURE sp_VendasPorCategoria
AS
  BEGIN
        SELECT 
              [Products_dataset].[product_category_name] AS [Categoria], 
              
              COUNT([Order_items].[order_item_id]) AS [qtd_itens_vendidos], 
              
              SUM([Order_items].[price]) AS [Total_vendas]
        
        FROM olist_order_items_dataset AS [Order_items] 
        
        LEFT JOIN olist_products_dataset AS [Products_dataset]
        
        ON [Order_items].[product_id] = [Products_dataset].[product_id]
        
        GROUP BY [Products_dataset].[product_category_name]
        
        ORDER BY [Total_vendas] DESC 
END 

EXEC sp_VendasPorCategoria










