CREATE PROCEDURE RelatorioPerformanceEntrega
AS 
   BEGIN 
         WITH [TABELA_COM_HORAS_DE_ATRASO] AS
                SELECT 
        (
                   CAST([order_delivered_customer_date] AS DATE) AS [HORA_DE_ENTREGUE],
                   CAST([order_estimated_delivery_date] AS DATE) AS [HORA_ESTIMADA], 
                   DATEDIFF(HOUR,
                           [order_delivered_customer_date],
                           [order_estimated_delivery_date]) AS [ATRASO_HORAS]
                FROM [olist_ecommerce].[dbo].[olist_orders_dataset]
) 
SELECT 
    CASE  
         WHEN [ATRASO_HORAS] > 0 THEN 'ATRASADO'
         ELSE 'ENTREGUE NO PRAZO' 
         END AS [STATUS_DE_PRAZO],  
         COUNT(*) AS [Quantidade], 
         FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2') AS [Percentual]
FROM [TABELA_COM_HORAS_DE_ATRASO] 
GROUP BY 
    CASE  
         WHEN [ATRASO_HORAS] > 0 THEN 'ATRASADO'
         ELSE 'ENTREGUE NO PRAZO' 
         END 
   END 
GO   


CREATE PROCEDURE MediaTempoEntregaPorEstado(
    @Status_pedido VARCHAR(15)  
)
AS 
    BEGIN
        WITH [PRAZO_DE_ENTREGA] AS (             
                     SELECT 
                        [order_id],
                         DATEDIFF(DAY, [order_purchase_timestamp], [order_delivered_customer_date]) AS [dias_para_entregar]
                     FROM [olist_ecommerce].[dbo].[olist_orders_dataset]
             )
             SELECT              
                [Clientes].[customer_state]           AS [Estado]
                ,COUNT(*)                               AS [Total_Pedidos]
                 ,AVG([Prazo_entrega].[dias_para_entregar]) AS [Media_Dias_Entrega]
             FROM [olist_ecommerce].[dbo].[olist_orders_dataset] AS [Pedido]
             LEFT JOIN [olist_ecommerce].[dbo].[olist_customers_dataset] AS [Clientes]
                 ON [Pedido].[customer_id] = [Clientes].[customer_id]
             LEFT JOIN [PRAZO_DE_ENTREGA] AS [Prazo_entrega]
                 ON [Pedido].[order_id] = [Prazo_entrega].[order_id]
             WHERE [Pedido].[order_status] = @Status_pedido 
             GROUP BY [Clientes].[customer_state]
             ORDER BY [Media_Dias_Entrega] DESC;
    END 
GO

EXEC RelatorioPerformanceEntrega;
EXEC MediaTempoEntregaPorEstado @Status_pedido = 'delivered'; 


