# 🛒 E-Commerce Data Intelligence Pipeline

## 📝 Visão Geral do Projeto

Este projeto consiste no desenvolvimento de um **Pipeline de Dados End-to-End (E2E)** aplicado a um cenário real de e-commerce, utilizando o dataset público da Olist disponível na plataforma Kaggle.

O objetivo é demonstrar habilidades em engenharia e análise de dados, incluindo modelagem relacional, ETL, análise exploratória e construção de KPIs estratégicos para suporte à tomada de decisão de negócio.

---

## 📊 Fonte dos Dados

Os dados utilizados neste projeto pertencem ao **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente no Kaggle:

🔗 https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

---

## 📁 Estrutura dos Dados

O dataset contém múltiplas tabelas relacionais que simulam um ambiente real de e-commerce.

### 🔗 Ordem de Importação (respeitando chaves estrangeiras)

Para garantir integridade referencial no banco de dados, as tabelas devem ser carregadas na seguinte ordem:

1. `olist_customers_dataset`
2. `olist_geolocation_dataset`
3. `olist_products_dataset`
4. `olist_sellers_dataset`
5. `olist_orders_dataset`
6. `olist_order_items_dataset`
7. `olist_order_payments_dataset`
8. `olist_order_reviews_dataset`

---

## 🛠️ Stack Tecnológica

- 🗄️ Banco de Dados & ETL: SQL Server / T-SQL  
- 🐍 Análise Exploratória: Python (Pandas, Jupyter Notebook)  
- 📊 Visualização de Dados: Power BI (DAX / Modelagem Dimensional)

---

## 🎯 Objetivos do Projeto

- Construir um pipeline de dados end-to-end
- Realizar modelagem relacional do dataset Olist
- Executar processos de ETL para limpeza e integração dos dados
- Desenvolver análise exploratória de dados (EDA)
- Criar KPIs de negócio para e-commerce (vendas, clientes, logística e reviews)
- Suportar decisões estratégicas com base em dados

---

## 📂 Estrutura do Projeto
