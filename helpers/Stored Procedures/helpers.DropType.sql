CREATE PROCEDURE helpers.DropType
(
	@typeName VARCHAR(MAX)
)
AS
BEGIN
	DECLARE @typeId int
	DECLARE @sql VARCHAR(MAX)

	SELECT @typeId = TYPE_ID(@typeName)

	IF @typeId IS NULL
	BEGIN
		PRINT 'Type does not exist: ' + @typeName
	END
	ELSE
	BEGIN
		SELECT @sql = 'DROP Type ' + @typeName

		IF @sql IS NOT NULL
		BEGIN
			PRINT 'Dropping ' + 'Type' + ': ' + @typeName
			exec (@sql)
		END
	END

END