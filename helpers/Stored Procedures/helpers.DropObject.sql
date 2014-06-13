CREATE PROCEDURE helpers.DropObject
(
	@objectName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @objectId int
	DECLARE @type VARCHAR(MAX)
	DECLARE @typeName VARCHAR(MAX)
	DECLARE @sql VARCHAR(MAX)

	SELECT @type= type, @objectId = object_id  FROM sys.objects WHERE object_id = OBJECT_ID(@objectName)

	IF @objectId IS NULL
	BEGIN
		PRINT 'Object does not exist: ' + @objectName
	END
	ELSE
	BEGIN
		IF @type = 'P' 
		BEGIN
			SELECT @typeName = 'Procedure'
			SELECT @sql = 'DROP PROCEDURE ' + @objectName
		END
		ELSE IF @type = 'U' 
		BEGIN
			SELECT @typeName = 'Table'
			SELECT @sql = 'DROP TABLE ' + @objectName
		END
		ELSE IF @type = 'V' 
		BEGIN
			SELECT @typeName = 'View'
			SELECT @sql = 'DROP VIEW ' + @objectName
		END
		ELSE IF @type = 'FN' 
		BEGIN
			SELECT @typeName = 'Function'
			SELECT @sql = 'DROP FUNCTION ' + @objectName
		END
		ELSE
		BEGIN
			PRINT 'Unable to delete object: ' + @objectName
		END

		IF @sql IS NOT NULL
		BEGIN
			PRINT 'Dropping ' + @typeName + ': ' + @objectName
			exec (@sql)
		END
	END

END