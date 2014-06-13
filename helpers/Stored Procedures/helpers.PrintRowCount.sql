CREATE PROCEDURE helpers.PrintRowCount
(
	@objectName VARCHAR(MAX)
)
AS
BEGIN	
	DECLARE @sql VARCHAR(MAX)
	DECLARE @count int
	SELECT @sql  = 'SELECT COUNT(*) FROM ' + @objectName
	exec (@sql)
	PRINT 'Count of  ' + 'X'  + ' = '+ CAST(@count AS VARCHAR(MAX))
END