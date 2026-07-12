 /* 
================================================================================
🟢 PRIORIDADE ALTA

2. Ticket médio por pedido

Preciso do valor médio que cada pedido gera (produto + frete). 
Cria uma procedure que calcule isso geral e também por estado do cliente.

================================================================================
*/ 


CREATE PROCEDURE Ticket_medio(
    @Status_pedido VARCHAR(15) 
)
AS 
   BEGIN 
        WITH [Valor_faturado_com_frete] AS (
                  SELECT DISTINCT
                        ([price] + [freight_value]) AS [valor_pedido_com_frete]
                  FROM [olist_ecommerce].[dbo].[olist_order_items_dataset] AS [Itens_pedido] 
                  LEFT JOIN [olist_ecommerce].[dbo].[olist_orders_dataset] AS [Pedido]
                  ON [Itens_pedido].[order_id] = [Pedido].[order_id] 
                  WHERE [order_status] = @Status_pedido
        )
        SELECT 
            'R$: ' + FORMAT(AVG([valor_pedido_com_frete]), 'N2') AS [Média_valor_pedido] 
        FROM [Valor_faturado_com_frete]
END 
GO         

EXEC Ticket_Pedido @Status_pedido = 'delivered'


Ticketmedioporpedido


