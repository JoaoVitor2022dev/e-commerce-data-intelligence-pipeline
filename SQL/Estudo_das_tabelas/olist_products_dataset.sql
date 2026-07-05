/*
================================================================================
ANÁLISE EXECUTIVA: DISTRIBUIÇÃO DE PRODUTOS POR CATEGORIA
================================================================================
MÉTRICAS CHAVE:
- Total de Produtos: 32.951 itens únicos cadastrados no catálogo.
- Concentração: Top 5 categorias somam mais de 41% de todo o catálogo.
- Qualidade do Cadastro: Existem 610 produtos sem categoria informada (NULL - 1,85%).

FUNIL DE PRODUTOS POR CATEGORIA (TOP CATEGORIAS):
--------------------------------------------------------------------------------
| CATEGORIA                     | QUANTIDADE | PERCENTUAL | PARTICIPAÇÃO       |
--------------------------------------------------------------------------------
| cama_mesa_banho               |    3.029   |     9,19%  | Líder de catálogo  |
| esporte_lazer                 |    2.867   |     8,70%  | Alta relevância    |
| moveis_decoracao              |    2.657   |     8,06%  | Forte presença     |
| beleza_saude                  |    2.444   |     7,42%  | Curadoria expressa |
| utilidades_domesticas         |    2.335   |     7,09%  | Fechamento do Top 5|
| automotivo                    |    1.900   |     5,77%  | Nicho relevante    |
| informatica_acessorios        |    1.639   |     4,97%  | Tecnologia         |
| brinquedos                    |    1.411   |     4,28%  | Sazonalidade       |
| relogios_presentes            |    1.329   |     4,03%  | Valor agregado     |
| telefonia                     |    1.134   |     3,44%  | Alta rotatividade  |
| NULL (Sem categoria)          |      610   |     1,85%  | Necessita correção |
--------------------------------------------------------------------------------
================================================================================
*/

/*
================================================================================
1. VISÃO GERAL DOS DADOS (Tradução e estrutura das colunas)
================================================================================
*/
SELECT TOP (1000) 
       [product_id]                 -- ID único do produto
      ,[product_category_name]      -- Nome da categoria do produto (ex: beleza, esporte)
      ,[product_name_lenght]        -- Comprimento do nome do produto (em caracteres)
      ,[product_description_lenght] -- Comprimento da descrição do produto (em caracteres)
      ,[product_photos_qty]         -- Quantidade de fotos publicadas no anúncio do produto
      ,[product_weight_g]           -- Peso do produto em gramas (g)
      ,[product_length_cm]          -- Comprimento do produto em centímetros (cm)
      ,[product_height_cm]          -- Altura do produto em centímetros (cm)
      ,[product_width_cm]           -- Largura do produto em centímetros (cm)
  FROM [olist_ecommerce].[dbo].[olist_products_dataset]


/*
================================================================================
2. VERIFICAR PRODUTO POR CATEGORIA E QUANTIDADE
================================================================================
*/
SELECT
      COUNT(*) AS [Quantidade], 
      FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2')  AS [Percentual], 
      [product_category_name]
  FROM [olist_ecommerce].[dbo].[olist_products_dataset]
  GROUP BY [product_category_name]
  ORDER BY [Quantidade] DESC


/*
================================================================================
3. CONTAGEM TOTAL DE REGISTROS DO CATÁLOGO
================================================================================
*/
SELECT 
      COUNT(*) AS [Quantidade_Total]
FROM [olist_ecommerce].[dbo].[olist_products_dataset]

/* RESULTADO DA CONTAGEM:
- Quantidade de registros: 32.951
*/