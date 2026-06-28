-- ===================================================================
-- 1. VISÃO GERAL DOS DADOS (AMOSTRAGEM)
-- ===================================================================

SELECT TOP (1000) 
       [order_id]             -- ID único do pedido 
      ,[payment_sequential]   -- Sequência do pagamento (Ex: se o cliente usou 2 cartões, terá a linha 1 e a linha 2)
      ,[payment_type]         -- Tipo/Método de pagamento usado (Ex: credit_card, boleto, voucher)
      ,[payment_installments] -- Número de parcelas escolhidas para o pagamento (Ex: 1x, 10x)
      ,[payment_value]        -- Valor cobrado nesta transação específica
FROM [olist_ecommerce].[dbo].[olist_order_payments_dataset];


-- ===================================================================
-- 2. ANÁLISE DE MÉTODOS DE PAGAMENTO (VOLUME E REPRESENTATIVIDADE)
-- ===================================================================

SELECT 
    COUNT(*) AS [QUANTIDADE_PAGAMENTO],
    [payment_type] AS [FORMA_PAGAMENTO],
    'R$: ' + FORMAT(SUM([payment_value]), 'N2') AS [VALOR_PAGAMENTO],
    FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2') + '%' AS [PERCENTUAL]
FROM [olist_ecommerce].[dbo].[olist_order_payments_dataset]
GROUP BY [payment_type]
ORDER BY [QUANTIDADE_PAGAMENTO] DESC;

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================

A consulta identifica quais métodos de pagamento são mais utilizados
pelos clientes, apresentando a quantidade de transações, o valor total
movimentado e a representatividade percentual de cada forma de pagamento.

INSIGHTS:

• O cartão de crédito é o principal método de pagamento da plataforma,
  concentrando aproximadamente 74% das transações e o maior volume financeiro.

• O boleto bancário aparece como a segunda opção mais utilizada,
  representando cerca de 19% dos pagamentos.

• Voucher e cartão de débito possuem baixa participação, indicando
  que são utilizados apenas por uma pequena parcela dos clientes.

• O tipo "not_defined" possui ocorrência praticamente nula,
  demonstrando boa consistência dos dados.

===================================================================
*/


-- ===================================================================
-- 3. ANÁLISE DE PAGAMENTOS À VISTA X PARCELADOS
-- ===================================================================

SELECT
    COUNT(*) AS [QUANTIDADE_PG],
    CASE
        WHEN [payment_installments] < 2 THEN 'À vista'
        ELSE 'Parcelado'
    END AS [TIPO_DE_ENTRADA],
    'R$: ' + FORMAT(SUM([payment_value]), 'N2') AS [VALOR],
    FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2') + '%' AS [PERCENTUAL]
FROM [olist_ecommerce].[dbo].[olist_order_payments_dataset]
GROUP BY
    CASE
        WHEN [payment_installments] < 2 THEN 'À vista'
        ELSE 'Parcelado'
    END
ORDER BY [QUANTIDADE_PG] DESC;

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================

A consulta classifica os pedidos entre pagamentos à vista e parcelados,
permitindo analisar o comportamento dos clientes em relação às condições
de pagamento.

INSIGHTS:

• A quantidade de pedidos está praticamente equilibrada entre compras
  à vista e parceladas, representando aproximadamente 50% para cada grupo.

• Apesar do equilíbrio na quantidade de transações, os pagamentos
  parcelados concentram um volume financeiro significativamente maior.

• Isso indica que clientes tendem a parcelar compras de maior valor,
  enquanto compras de menor ticket são realizadas, em sua maioria, à vista.

===================================================================
*/
