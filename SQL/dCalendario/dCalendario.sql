-- 1. Criar a estrutura da tabela dCalendario
CREATE TABLE dCalendario (
    DataKey INT PRIMARY KEY,
    Data DATE,
    Ano INT,
    Mes INT,
    NomeMes VARCHAR(20),
    Dia INT,
    DiaSemana INT,
    NomeDiaSemana VARCHAR(20),
    Trimestre INT
);

-- 2. Declarar as datas limite com base na olist_orders_dataset
DECLARE @DataInicial DATE, @DataFinal DATE;

SELECT 
    @DataInicial = MIN(CAST(order_purchase_timestamp AS DATE)), 
    @DataFinal = MAX(CAST(order_purchase_timestamp AS DATE))
FROM dbo.olist_orders_dataset;

-- 3. Gerar os dados e inserir na dCalendario usando um laço (Loop)
WHILE @DataInicial <= @DataFinal
BEGIN
    INSERT INTO dCalendario (
        DataKey, Data, Ano, Mes, NomeMes, Dia, DiaSemana, NomeDiaSemana, Trimestre
    )
    VALUES (
        CONVERT(VARCHAR(8), @DataInicial, 112), -- Formato AAAAMMDD como chave primária
        @DataInicial,
        YEAR(@DataInicial),
        MONTH(@DataInicial),
        DATENAME(MONTH, @DataInicial),
        DAY(@DataInicial),
        DATEPART(WEEKDAY, @DataInicial),
        DATENAME(WEEKDAY, @DataInicial),
        DATEPART(QUARTER, @DataInicial)
    );

    SET @DataInicial = DATEADD(DAY, 1, @DataInicial);
END;