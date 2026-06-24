/* ============================================================
   PROJETO: ANÁLISE DE DADOS - OLIST E-COMMERCE
   OBJETIVO:
   Realizar uma análise exploratória inicial da base de dados,
   entendendo o volume das tabelas e os principais indicadores
   relacionados aos pedidos e meios de pagamento.
   ============================================================ */


/* ============================================================
   1. VISÃO GERAL DA BASE
   ------------------------------------------------------------
   Objetivo:
   Identificar o volume de registros de cada tabela para
   compreender a dimensão dos dados disponíveis.
   ============================================================ */

SELECT 'customers' AS tabela, COUNT(*) AS total FROM olist_customers_dataset
UNION ALL

SELECT 'geolocation', COUNT(*) FROM olist_geolocation_dataset
UNION ALL

SELECT 'products', COUNT(*) FROM olist_products_dataset
UNION ALL

SELECT 'sellers', COUNT(*) FROM olist_sellers_dataset
UNION ALL

SELECT 'orders', COUNT(*) FROM olist_orders_dataset
UNION ALL

SELECT 'order_items', COUNT(*) FROM olist_order_items_dataset
UNION ALL

SELECT 'payments', COUNT(*) FROM olist_order_payments_dataset
UNION ALL

SELECT 'reviews', COUNT(*) FROM olist_order_reviews_dataset;


/* ============================================================
   2. ANÁLISE DE VENDAS
   ============================================================ */

USE olist_ecommerce;


/* ============================================================
   2.1 EXPLORAÇÃO DA TABELA DE PEDIDOS
   ------------------------------------------------------------
   A tabela olist_orders_dataset é considerada a principal
   tabela do negócio, pois cada registro representa um pedido.

   Principais marcos do ciclo de vida do pedido:

   • order_purchase_timestamp
     Data e hora da compra realizada pelo cliente.

   • order_approved_at
     Momento em que o pagamento foi aprovado.

   • order_delivered_carrier_date
     Data em que o pedido foi enviado para a transportadora.

   • order_delivered_customer_date
     Data efetiva de entrega ao cliente.

   • order_estimated_delivery_date
     Data prevista para entrega.

   Essas informações permitem análises como:
   - Tempo de aprovação do pagamento
   - Tempo de expedição
   - Tempo de entrega
   - Atrasos logísticos
   - Eficiência operacional
   ============================================================ */

SELECT TOP 10 *
FROM olist_orders_dataset;


/* ============================================================
   2.2 DISTRIBUIÇÃO DOS STATUS DOS PEDIDOS
   ------------------------------------------------------------
   Objetivo:
   Identificar todos os status existentes e quantificar a
   participação de cada um.

   Possíveis insights:
   - Taxa de pedidos entregues
   - Pedidos cancelados
   - Pedidos em processamento
   - Gargalos operacionais
   ============================================================ */

SELECT
     [order_status],
     COUNT(*) AS [Total]
FROM [olist_ecommerce].[dbo].[olist_orders_dataset]
GROUP BY order_status
ORDER BY total DESC;


/* ============================================================
   3. ANÁLISE DOS MEIOS DE PAGAMENTO
   ============================================================ */


/* ============================================================
   3.1 VISUALIZAÇÃO DOS DADOS DE PAGAMENTO
   ------------------------------------------------------------
   Objetivo:
   Verificar a estrutura da tabela responsável pelos
   pagamentos realizados nos pedidos.
   ============================================================ */

SELECT TOP 10 *
FROM olist_order_payments_dataset;


/* ============================================================
   3.2 PARTICIPAÇÃO DOS MEIOS DE PAGAMENTO
   ------------------------------------------------------------
   Objetivo:
   Identificar quais formas de pagamento são mais utilizadas
   pelos clientes da plataforma.

   Métricas:
   • Total de transações por meio de pagamento
   • Percentual de participação sobre o total

   Possíveis insights:
   - Preferência dos clientes
   - Dependência de determinado meio de pagamento
   - Oportunidades para campanhas financeiras
   ============================================================ */

SELECT
    [payment_type],
    COUNT(*) AS [TOTAL],

    -- Percentual de participação sobre o total de pagamentos
    (COUNT(*) * 100.0) /
    (
        SELECT COUNT(*)
        FROM olist_order_payments_dataset
    ) AS [PERCENTUAL]

FROM olist_order_payments_dataset

GROUP BY [payment_type]

ORDER BY [TOTAL] DESC;









