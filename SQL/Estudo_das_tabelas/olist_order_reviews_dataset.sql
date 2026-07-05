-- ===================================================================
-- 1. ANÁLISE GERAL DE AVALIAÇÕES (VOLUME E PROPORÇÃO DE NOTAS)
-- ===================================================================

SELECT TOP (1000) [review_id]
      ,[order_id]
      ,[review_score]
      ,[review_comment_title]
      ,[review_comment_message]
      ,[review_creation_date]
      ,[review_answer_timestamp]
  FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]

-- 

SELECT TOP (1000) 
     [review_id]                         -- ID da avaliação (Identificador único de cada comentário/nota)
    ,[order_id]                          -- ID do pedido (Código que liga a avaliação ao pedido feito)
    ,[review_score]                      -- Nota da avaliação (Pontuação dada pelo cliente, geralmente de 1 a 5)
    ,[review_comment_title]              -- Título do comentário (O resumo ou manchete que o cliente escreveu)
    ,[review_comment_message]            -- Mensagem do comentário (O texto completo com a opinião do cliente)
    ,[review_creation_date]              -- Data de criação da avaliação (Quando o formulário de pesquisa foi enviado ao cliente)
    ,[review_answer_timestamp]           -- Data/Hora da resposta (Quando o cliente realmente sentou e escreveu a avaliação)
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]


-- -------------------------------------------------------------------
-- Pergunta 1: Quantas avaliações tem nessa base de dados?
-- -------------------------------------------------------------------

SELECT 
  COUNT(*)
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================
• Total de avaliações registradas: 99.224
===================================================================
*/


-- -------------------------------------------------------------------
-- Pergunta 2: Quantas avaliações de 1 - 5 tem proporcional?
-- -------------------------------------------------------------------

SELECT 
      [review_score] as [Avaliacao], 
      COUNT(*) AS [Quantidade_avaliacoes],
      FORMAT(COUNT(*) * 100.0 /  SUM(COUNT(*)) OVER (), 'N2') AS [Percentual] 
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]
GROUP BY [review_score]
ORDER BY [Quantidade_avaliacoes] DESC

/*
===================================================================

===================================================================
• Avaliação 5: 57.328 (57,78%) -> Maior volumetria da base.
• Avaliação 4: 19.142 (19,29%)
• Avaliação 1: 11.424 (11,51%) -> Alerta para análise de detratores.
• Avaliação 3:  8.179 (8,24%)
• Avaliação 2:  3.151 (3,18%)
===================================================================
*/


-- ===================================================================
-- 2. ANÁLISE TEMPORAL (CRIAÇÃO DE REVIEWS E RESPOSTAS)
-- ===================================================================

SELECT 
    FORMAT(MAX([review_creation_date]), 'dd/MM/yyyy')    AS [Data_inicio_requi], 
    FORMAT(MIN([review_answer_timestamp]), 'dd/MM/yyyy') AS [Data_fim_requi], 
    FORMAT(MAX([review_creation_date]), 'dd/MM/yyyy')    AS [Data_inicio_res], 
    FORMAT(MIN([review_answer_timestamp]), 'dd/MM/yyyy') AS [Data_fim_res] 
FROM  [olist_ecommerce].[dbo].[olist_order_reviews_dataset]

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================
• Início do Período analítico: 07/10/2016
• Fim do Período analítico:    31/08/2018
===================================================================
*/


-- -------------------------------------------------------------------
-- Pergunta: Precisamos verificar a quantidade de comentários em texto
-- -------------------------------------------------------------------

SELECT 
   COUNT([review_comment_message]) AS [Quantidades_de_comentário]
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================
• Total de comentários de texto: 40.977
• Taxa de engajamento: Cerca de 41,3% dos clientes deixaram uma mensagem escrita.
===================================================================
*/


-- -------------------------------------------------------------------
-- Pergunta: Quantos dias tem dentro desse período de datas?
-- -------------------------------------------------------------------

SELECT 
   DATEDIFF(DAY, MIN([review_creation_date]), MAX([review_creation_date])) AS total_dias
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================
• Extensão do intervalo pesquisado:
  - 698 Dias
  - ~22 Meses
  - ~2 Anos
===================================================================
*/


-- -------------------------------------------------------------------
-- Pergunta: Quais são os dias com maior pico de avaliações? (Top 5)
-- -------------------------------------------------------------------

SELECT TOP(5)
    COUNT(*) AS [Contagem],
    FORMAT([review_creation_date], 'dd/MM/yyyy') AS [DATA], 
    FORMAT([review_creation_date], 'yyyy') AS [ANO]
FROM [olist_ecommerce].[dbo].[olist_order_reviews_dataset]
GROUP BY [review_creation_date]
ORDER BY [Contagem] DESC

/*
===================================================================
RESUMO DA ANÁLISE
===================================================================
Rank | Volumetria | Data de Criação | Ano Correspondente
---- | ---------- | --------------- | ------------------
1º   | 463        | 19/12/2017      | 2017
2º   | 452        | 28/08/2018      | 2018
3º   | 440        | 20/12/2017      | 2017
4º   | 434        | 19/05/2018      | 2018
5º   | 425        | 15/05/2018      | 2018
===================================================================
*/

