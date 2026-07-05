/*
================================================================================
ANÁLISE EXECUTIVA: TRADUÇÃO DE CATEGORIAS (DICTIONARY)
================================================================================
MÉTRICAS CHAVE & PROPÓSITO:
- Função Principal: Tabela de De/Para (Dicionário de dados) para internacionalização.
- Objetivo Técnico: Utilizada para realizar JOINs e traduzir os nomes das categorias
  de produtos do português para o inglês, facilitando relatórios globais.

MAPEAMENTO DE EXEMPLOS DE TRADUÇÃO:
--------------------------------------------------------------------------------
| CATEGORIA (PT)         | CATEGORIA (EN)        | APLICAÇÃO EM RELATÓRIOS     |
--------------------------------------------------------------------------------
| beleza_saude           | health_beauty         | Análise de mercado Global   |
| informatica_acessorios | computers_accessories | Padronização internacional  |
| automotivo             | auto                  | Filtros de BI bilingues     |
| cama_mesa_banho        | bed_bath_table        | Unificação de taxonomias    |
| moveis_decoracao       | furniture_decor       | Apresentações executivas    |
--------------------------------------------------------------------------------
================================================================================
*/


/*
================================================================================
1. VISÃO GERAL DOS DADOS (Mapeamento de Tradução)
================================================================================
*/
SELECT TOP (5) 
       [product_category_name]          -- Nome original da categoria em Português
      ,[product_category_name_english]  -- Tradução correspondente da categoria em Inglês
  FROM [olist_ecommerce].[dbo].[product_category_name_translation]

/* RESULTADO COLETADO PARA AUDITORIA:
- beleza_saude           -> health_beauty
- informatica_acessorios -> computers_accessories
- automotivo             -> auto
- cama_mesa_banho        -> bed_bath_table
- moveis_decoracao       -> furniture_decor
*/