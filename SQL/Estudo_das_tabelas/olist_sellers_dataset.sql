/*
================================================================================
ANÁLISE EXECUTIVA: DISTRIBUIÇÃO GEOGRÁFICA DOS VENDEDORES (SELLERS)
================================================================================
MÉTRICAS CHAVE:
- Total de Vendedores: 3.095 parceiros comerciais únicos ativos na base.
- Concentração de Mercado: São Paulo (SP) domina com quase 60% dos vendedores.
- Força Regional: A região Sul (PR, SC, RS) demonstra grande relevância, 
  com o Paraná (PR) isolado na segunda posição nacional (11,28%).

FUNIL REGIONAL DE VENDEDORES (TOP ESTADOS):
--------------------------------------------------------------------------------
| ESTADO (UF)  | QUANTIDADE | PERCENTUAL | POSICIONAMENTO ESTRATÉGICO         |
--------------------------------------------------------------------------------
| SP           |    1.849   |    59,74%  | Polo Principal: Concentração máxima|
| PR           |      349   |    11,28%  | Vice-Líder: Segundo maior polo     |
| MG           |      244   |     7,88%  | Expressivo: Relevância no Sudeste  |
| SC           |      190   |     6,14%  | Sul Forte: Terceiro polo regional  |
| RJ           |      171   |     5,53%  | Sudeste: Volume moderado de sellers|
| RS           |      129   |     4,17%  | Sul: Fecha o bloco das potências   |
| GO           |       40   |     1,29%  | Centro-Oeste: Início da cauda longa|
| DF           |       30   |     0,97%  | Centro-Oeste: Volume inicial       |
| Outros (18)  |       93   |     3,00%  | Demais Estados somados (N, NE, CO) |
--------------------------------------------------------------------------------
================================================================================
*/


/*
================================================================================
1. VISÃO GERAL DOS DADOS (Tradução e estrutura das colunas)
================================================================================
*/
SELECT TOP (1000) 
       [seller_id]                  -- ID único do vendedor/parceiro comercial
      ,[seller_zip_code_prefix]     -- Cinco primeiros dígitos do CEP do vendedor
      ,[seller_city]                -- Cidade onde o vendedor está registrado
      ,[seller_state]               -- Estado (UF) de origem do vendedor
  FROM [olist_ecommerce].[dbo].[olist_sellers_dataset]


/*
================================================================================
2. LOCALIDADE DE CADA VENDEDOR (Agrupamento por Estado)
================================================================================
*/
SELECT 
      COUNT(*) AS [Quantidade], 
      FORMAT(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 'N2') + '%' AS [Percentual], 
      [seller_state]
  FROM [olist_ecommerce].[dbo].[olist_sellers_dataset]
  GROUP BY [seller_state] 
  ORDER BY [Quantidade] DESC


/*
================================================================================
3. CONTAGEM TOTAL DE VENDEDORES ÚNICOS
================================================================================
*/
SELECT 
      COUNT(DISTINCT [seller_id]) AS [Total_Vendedores]
  FROM [olist_ecommerce].[dbo].[olist_sellers_dataset]

/* RESULTADO DA CONTAGEM:
- Volumetria total do ecossistema: 3.095 vendedores cadastrados.
*/