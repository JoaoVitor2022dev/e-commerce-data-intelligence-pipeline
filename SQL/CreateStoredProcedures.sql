
-- 1 - Automação do proedimento de importação de CSV para tabelas do banco de dados
-- O procedimento recebe o nome da tabela e o caminho do arquivo CSV, limpa a tabela e

CREATE PROCEDURE ImportarCSV_Dinamico 
     @NomeTabela    VARCHAR(100), 
     @CaminhoArquivo VARCHAR(MAX) -- Nome correto do parâmetro
AS 
BEGIN
    SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    -- 1. Limpa a tabela antiga
    SET @SQL = 'TRUNCATE TABLE ' + QUOTENAME(@NomeTabela) + '; ';

    -- 2. Monta o BULK INSERT dinâmico (Corrigido @CaminhoArquivo e ''CSV'')
    SET @SQL = @SQL + 'BULK INSERT ' + QUOTENAME(@NomeTabela) + ' 
    FROM ''' + @CaminhoArquivo + ''' 
    WITH 
    (
        FIRSTROW = 2,
        FORMAT = ''CSV'',              
        FIELDTERMINATOR = '','',
        ROWTERMINATOR = ''0x0a'',        
        CODEPAGE = ''65001''          
    );';
 
    -- 3. Executa o comando
    EXEC sp_executesql @SQL;
END;


EXEC ImportarCSV_Dinamico 'product_category_name_translation', 'product_category_name_translation.csv';


