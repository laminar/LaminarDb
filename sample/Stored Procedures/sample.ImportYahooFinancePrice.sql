

CREATE PROCEDURE sample.ImportYahooFinancePrice
(
   @fileName varchar(MAX),
   @RowTerminator varchar(10) = '\n',
   @Source varchar(100),
   @EarliestDate datetime,
   @InstrumentId int,
   @Ccy varchar(3),
   @truncate bit = 1,
   @debug bit = 0
   
)
AS
BEGIN
   SET NOCOUNT ON

   CREATE TABLE #staging
   (
      [Date] varchar(100),
      [Open] varchar(100),
      [High] varchar(100),
      [Low] varchar(100),
      [Close] varchar(100),
      [Volume] varchar(100),
      [AdjClose] varchar(100)
   )
   

   IF @truncate <>0 and @debug=0
   BEGIN
      TRUNCATE TABLE dbo.Price
   END

   DECLARE @sql VARCHAR(MAX)
   SELECT @sql = 
   'BULK INSERT #staging ' + CHAR(13) +
   '   FROM ''' + @fileName + '''' + CHAR(13) +
   '   WITH' + CHAR(13) +
   '   (' + CHAR(13) +
   '     FIELDTERMINATOR ='','',' + CHAR(13) +
   '     ROWTERMINATOR = ''' + @RowTerminator + ''',' + CHAR(13) +
   '     FIRSTROW = 2' + CHAR(13) +
   '    );' + CHAR(13)

   IF @debug = 0 EXEC (@sql)  
    ELSE SELECT (@sql) 

   DELETE FROM #staging
   WHERE ISDATE([Date])<>1
   OR ISNUMERIC([AdjClose]) <> 1
   OR (ISDATE([Date])=1 AND [Date]<@EarliestDate)


   ALTER TABLE #staging
   ADD Id int IDENTITY(1,1)

   DECLARE @StartId  int 
   SELECT @StartId = ISNULL(MAX(PriceId),0) FROM dbo.Price


   DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
    SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
    SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'

   IF @debug = 0
   BEGIN
      INSERT dbo.Price (LastActionWhen,LastActionById,PriceId,Version,InstrumentId,Source,Date,Price ,Ccy)
      SELECT @LastActionWhen, @LastActionById,Id+@StartId,1,@InstrumentId,@Source,convert(datetime,[Date]),convert(decimal(28,8),[AdjClose]),@Ccy
      FROM #staging
   END


END