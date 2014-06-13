CREATE PROCEDURE [sample].[ImportInstrument]
(
   @fileName varchar(MAX),
   @CodeSuffix varchar(100),
   @RowTerminator varchar(10) = '\n',
   @Country varchar(3),
   @Ccy varchar(3),
   @Type  varchar(20),
   @truncate bit = 1,
   @debug bit = 0
   
)
AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.Instrument ON

   SELECT  Code,Name 
   INTO #staging
   FROM dbo.Instrument
   WHERE 0=1

   IF @truncate <>0 and @debug=0
   BEGIN
      TRUNCATE TABLE dbo.Instrument
   END

   DECLARE @sql VARCHAR(MAX)
   SELECT @sql = 
   'BULK INSERT #staging ' + CHAR(13) +
   '   FROM ''' + @fileName + '''' + CHAR(13) +
   '   WITH' + CHAR(13) +
   '   (' + CHAR(13) +
   '     FIELDTERMINATOR =''\t'',' + CHAR(13) +
   '     ROWTERMINATOR = ''' + @RowTerminator + ''',' + CHAR(13) +
   '     FIRSTROW = 2' + CHAR(13) +
   '    );' + CHAR(13)

   IF @debug = 0 EXEC (@sql)  
    ELSE SELECT (@sql) 

    IF @debug <> 0
        SELECT * FROM #staging

   ALTER TABLE #staging
   ADD Id int IDENTITY(1,1)

   DECLARE @StartId  int 
   SELECT @StartId = ISNULL(MAX(InstrumentId),0) FROM dbo.Instrument


   DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
    SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
    SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'

   IF @debug = 0
   BEGIN
      INSERT dbo.Instrument (LastActionWhen,LastActionById,InstrumentId,Version,Code,Name,Country,Ccy,[Type] )
      SELECT @LastActionWhen, @LastActionById,Id+@StartId,1,Code+@CodeSuffix,Name,@Country,@Ccy,@Type
      FROM #staging
   END

   SET IDENTITY_INSERT dbo.Instrument OFF
END