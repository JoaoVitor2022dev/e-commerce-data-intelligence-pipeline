 /* 

🟢 PRIORIDADE ALTA

1. Faturamento por categoria

João, preciso saber quais categorias geram mais receita. Cria 
uma procedure que mostre categoria, quantidade vendida e total faturado. 
Ordena por faturamento decrescente.  

*/ 


ALTER PROCEDURE [dbo].[RelatorioFaturamentoPorCategoria] (
    @Status_pedido VARCHAR(15)
)
AS 
BEGIN
    SELECT 
        [product_category_name] AS [Categoria],
        COUNT(*) AS [Quantidade], 
        SUM([price]) AS [Valor_Faturado]
    FROM [olist_order_items_dataset] AS [Itens_pedidos]
    LEFT JOIN [olist_ecommerce].[dbo].[olist_orders_dataset] AS [Pedido]
        ON [Pedido].[order_id] = [Itens_pedidos].[order_id]
    LEFT JOIN [olist_ecommerce].[dbo].[olist_products_dataset] AS [Produto]
        ON [Itens_pedidos].[product_id] = [Produto].[product_id]
    WHERE [order_status] = @Status_pedido
    GROUP BY [product_category_name]
    ORDER BY [Valor_Faturado] DESC;
END

EXEC RelatorioFaturamentoPorCategoria @Status_pedido = 'delivered'







