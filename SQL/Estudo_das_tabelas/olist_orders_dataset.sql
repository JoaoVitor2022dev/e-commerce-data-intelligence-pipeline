/*
================================================================================
ANÁLISE COMPLETA: BASE DE PEDIDOS (OLIST)
================================================================================
RESUMO DOS INSIGHTS E MÉTRICAS:
- Volume de Vendas: Total de 99.441 pedidos mapeados na base.
- Eficiência Logística: 97,02% dos pedidos foram entregues com sucesso ('delivered').
- Gargalo Comercial: Pedidos cancelados e indisponíveis somam 1,24% (1.234 pedidos).
- Tempo de Processamento: Média de 10 horas para a aprovação do pagamento após a compra.
================================================================================
*/


/*
================================================================================
1. VISÃO GERAL DOS DADOS (Tradução e estrutura das colunas)
================================================================================
*/
SELECT TOP (1000) 
       [order_id]                       -- ID único do pedido
      ,[customer_id]                    -- ID do cliente que fez a compra
      ,[order_status]                   -- Status do pedido (ex: entregue, cancelado, faturado)
      ,[order_purchase_timestamp]       -- Data e hora em que a compra foi realizada
      ,[order_approved_at]              -- Data e hora em que o pagamento foi aprovado
      ,[order_delivered_carrier_date]   -- Data e hora em que o pedido foi entregue à transportadora
      ,[order_delivered_customer_date]  -- Data e hora real da entrega ao cliente
      ,[order_estimated_delivery_date]  -- Data estimada de entrega que foi informada ao cliente
  FROM [olist_ecommerce].[dbo].[olist_orders_dataset]


/*
================================================================================
2. QUANTIDADE E PERCENTUAL DE PEDIDOS POR STATUS
================================================================================
*/
SELECT 
     COUNT(*) AS [Contagem],
     FORMAT(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (), 'N2') AS [Percentual],
     [order_status]
  FROM [olist_ecommerce].[dbo].[olist_orders_dataset]
  GROUP BY [order_status]
  ORDER BY [Contagem] DESC

/*
================================================================================
ANÁLISE EXECUTIVA: DISTRIBUIÇÃO DOS PEDIDOS POR STATUS
================================================================================
MÉTRICAS CHAVE:
- Total de Pedidos: 99.441 registros analisados.
- Sucesso da Operação: 97,02% das compras foram entregues com sucesso.
- Retenção/Perdas: Apenas 1,24% dos pedidos não foram concluídos (Cancelados/Indisponíveis).

FUNIL DE STATUS DO NEGÓCIO:
--------------------------------------------------------------------------------
| STATUS       | CONTAGEM | PERCENTUAL | IMPACTO NO NEGÓCIO                    |
--------------------------------------------------------------------------------
| delivered    |  96.478  |    97,02%  | Sucesso total: Entrega concluída.     |
| shipped      |   1.107  |     1,11%  | Em trânsito: Com a transportadora.    |
| canceled     |     625  |     0,63%  | Perda: Pedido cancelado pelo cliente. |
| unavailable  |     609  |     0,61%  | Erro: Produto indisponível em estoque.|
| invoiced     |     314  |     0,32%  | Faturamento: Nota fiscal emitida.     |
| processing   |     301  |     0,30%  | Logística: Pedido em separação.       |
| created      |       5  |     0,01%  | Inicial: Pedido criado no sistema.    |
| approved     |       2  |     0,00%  | Financeiro: Pagamento confirmado.     |
--------------------------------------------------------------------------------
================================================================================
*/


/*
================================================================================
3. VALIDAÇÃO DAS DATAS (Formatação para o padrão brasileiro)
================================================================================
*/
SELECT TOP (5) 
       [order_id]
      ,[customer_id]
      ,[order_status]
      ,FORMAT([order_purchase_timestamp], 'dd/MM/yyyy hh:mm:ss')
      ,FORMAT([order_approved_at], 'dd/MM/yyyy hh:mm:ss')
      ,FORMAT([order_delivered_carrier_date], 'dd/MM/yyyy hh:mm:ss')
      ,FORMAT([order_delivered_customer_date], 'dd/MM/yyyy hh:mm:ss')
      ,FORMAT([order_estimated_delivery_date], 'dd/MM/yyyy hh:mm:ss')
  FROM [olist_ecommerce].[dbo].[olist_orders_dataset]


/*
================================================================================
4. MÉTRICA DE TEMPO: MÉDIA DE HORAS PARA APROVAÇÃO DE PAGAMENTO
================================================================================
*/
SELECT TOP (1000)
       AVG(DATEDIFF(HOUR,[order_purchase_timestamp], [order_approved_at])) AS [Média_de_horas] 
  FROM [olist_ecommerce].[dbo].[olist_orders_dataset]

/* MÉTRICA ANALISADA:
- O tempo médio entre o cliente finalizar a compra e o sistema confirmar/aprovar 
  o pagamento é de exatamente 10 horas. 
- Nota: Esse tempo pode ser influenciado por boletos bancários (que demoram para compensar) 
  ou análises antifraude no cartão de crédito.
*/