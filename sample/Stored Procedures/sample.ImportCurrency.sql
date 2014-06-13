﻿   


CREATE PROCEDURE [sample].[ImportCurrency]
(
   @fileName varchar(MAX),
   @truncate bit = 1,
   @debug bit = 0
   
)
AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.Currency ON

   SELECT  IsoCode,Name 
   INTO #staging
   FROM dbo.Currency
   WHERE 0=1

   IF @truncate <>0 and @debug=0
   BEGIN
      TRUNCATE TABLE dbo.Currency
   END

   DECLARE @sql VARCHAR(MAX)
   SELECT @sql = 
   'BULK INSERT #staging ' + CHAR(13) +
   '   FROM ''' + @fileName + '''' + CHAR(13) +
   '   WITH' + CHAR(13) +
   '   (' + CHAR(13) +
   '     FIELDTERMINATOR ='','',' + CHAR(13) +
   '     ROWTERMINATOR = ''\n'',' + CHAR(13) +
   '     FIRSTROW = 2' + CHAR(13) +
   '    );' + CHAR(13)

   IF @debug = 0 EXEC (@sql)  
    ELSE SELECT (@sql) 

   IF @debug <> 0
      SELECT * FROM #staging

   ALTER TABLE #staging
   ADD Id int IDENTITY(1,1)

   DECLARE @StartId  int 
   SELECT @StartId = ISNULL(MAX(CurrencyId),0) FROM dbo.Currency


   DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
    SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
    SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'

   IF @debug = 0
   BEGIN
      INSERT dbo.Currency (LastActionWhen,LastActionById,CurrencyId,Version,Name,IsoCode) 
      SELECT @LastActionWhen, @LastActionById,Id+@StartId,1,Name,IsoCode
      FROM #staging
   END

   SET IDENTITY_INSERT dbo.Currency OFF
END