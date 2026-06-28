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
    -- Aplicando o FORMAT para limpar as casas decimais longas da imagem
    FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2') + '%' AS [PERCENTUAL]
FROM [olist_ecommerce].[dbo].[olist_order_payments_dataset]
GROUP BY [payment_type]
ORDER BY [QUANTIDADE_PAGAMENTO] DESC;

/*
===================================================================
RESUMO DA CONSULTA (INSIGHTS DOS DADOS)
===================================================================
* O que essa consulta revela sobre o e-commerce:
  
  - Predominância Absoluta: O cartão de crédito (credit_card) é a forma 
    de pagamento mais utilizada pelos clientes, representando quase 74% 
    de todas as transações da plataforma.
 
  - Segundo Lugar Comercial: O boleto bancário é a segunda opção mais 
    relevante, cobrindo aproximadamente 19% do volume total.
 
  - Baixa Adoção: Cartões de débito (debit_card) e vouchers somados 
    não chegam a atingir 8% da preferência do público consumidor.

===================================================================
*/