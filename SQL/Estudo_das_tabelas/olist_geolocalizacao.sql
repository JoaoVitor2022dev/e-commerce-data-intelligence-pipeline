-- ===================================================================
-- 1. VISÃO GERAL DOS DADOS (AMOSTRAGEM)
-- ===================================================================

SELECT TOP (1000) 
       [geolocation_zip_code_prefix] -- Os 5 primeiros dígitos do CEP
      ,[geolocation_lat]             -- Latitude (coordenada geográfica)
      ,[geolocation_lng]             -- Longitude (coordenada geográfica)
      ,[geolocation_city]            -- Nome da cidade
      ,[geolocation_state]           -- Sigla do Estado (UF)
FROM [olist_ecommerce].[dbo].[olist_geolocation_dataset];

/*

===================================================================
RESUMO DA TABELA: [olist_geolocation_dataset]
===================================================================

* O que ela representa: 
  Contém a base de geolocalização dos CEPs brasileiros utilizados 
  na plataforma, permitindo mapear a distribuição geográfica de 
  clientes e vendedores através de coordenadas (Latitude/Longitude).

* Principais Informações:
  - Chave de Localização: Prefixo do CEP (5 primeiros dígitos).
  - Dados Geográficos: Coordenadas exatas para plotagem de mapas.
  - Dados Cívicos: Nome da Cidade e Estado correspondente.
===================================================================
*/