
CREATE PROCEDURE [sample].[DemoCreateFundForClient]
AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.[Fund] ON

   DECLARE 
        @minCount int,
        @maxCount int = null
 
    SELECT @minCount = Value FROM sample.SampleDefaults WHERE Name = 'MinFundsPerClient'
    SELECT @maxCount = Value FROM sample.SampleDefaults WHERE Name = 'MaxFundsPerClient'


   DECLARE @count int
   SELECT @maxCount = ISNULL(@maxCount,@minCount)
   
   DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
   SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
   SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'
   
   CREATE TABLE #t ( RowId int IDENTITY(1,1), Id int )
   INSERT INTO #t (Id) SELECT ClientId FROM Client
   
   DECLARE @RowCount INT
   SELECT @RowCount = MAX(RowId) FROM #t
   
   DECLARE @ClientId INT
   DECLARE @RowId INT = 1
   DECLARE @NewId int = 1
   
   WHILE @RowId <= @RowCount
   BEGIN
      SELECT @ClientId = Id From #t WHERE RowId = @RowId

      
      select @count = @minCount + ROUND( (@maxCount-@minCount) *RAND(convert(varbinary, newid())), 0)


      DECLARE @i int = 1
      DECLARE 
         @Name varchar(100), 
         @Code varchar(100)

      WHILE @i <= @count
      BEGIN
         SELECT 
            @Code = 'F' + convert(varchar(10),@ClientId) + '/' + convert(varchar(10),@i),
            @Name = 'Fund ' + convert(varchar(10),@ClientId) + '/' + convert(varchar(10),@i)
         INSERT INTO dbo.Fund (LastActionWhen,LastActionById,FundId,Version,ClientId,Code,Name) SELECT @LastActionWhen, @LastActionById,@NewId,1,@ClientId,@Code,@Name
         SELECT @i = @i +1
         SELECT @NewId = @NewId  + 1
      END
      --SELECT 'Created ' + convert(varchar(100),@i-1) + ' Funds for Client '  + convert(varchar(10),@ClientId)
   
      SELECT @RowId = @RowId + 1
      
   END
   
   SELECT 'Created ' + convert(varchar(100),@NewId-1) + ' Funds for all Clients '  
   SET IDENTITY_INSERT dbo.[Fund] OFF
   
END