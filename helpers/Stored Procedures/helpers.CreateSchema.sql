
CREATE PROCEDURE helpers.CreateSchema
(
	@schemaName VARCHAR(MAX)
)
AS
BEGIN
	IF SCHEMA_ID(@schemaName) IS NULL
	BEGIN
		DECLARE @sql  VARCHAR(MAX)
		PRINT 'Creating Schema: ' + @schemaName
		SELECT @sql = 'CREATE SCHEMA ' +@schemaName
		exec (@sql)
	END
	ELSE
	BEGIN
		PRINT 'Schema Already Exists: ' + @schemaName
	END
END