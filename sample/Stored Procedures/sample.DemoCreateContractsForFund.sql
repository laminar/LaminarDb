
CREATE PROCEDURE [sample].[DemoCreateContractsForFund]
AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.[Contract] ON

      DECLARE 
        @minCount int,
        @maxCount int = null
 
    SELECT @minCount = Value FROM sample.SampleDefaults WHERE Name = 'MinContractsPerFund'
    SELECT @maxCount = Value FROM sample.SampleDefaults WHERE Name = 'MaxContractsPerFund'


   DECLARE @count int
   SELECT @maxCount = ISNULL(@maxCount,@minCount)
   
   DECLARE @PricingCcy varchar(3) = 'GBP'
   
   DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
   SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
   SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'
   
   CREATE TABLE #t ( RowId int IDENTITY(1,1), FundId int, ClientId int )
   INSERT INTO #t (FundId,ClientId) SELECT FundId,ClientId FROM Fund
   
   DECLARE @RowCount INT
   SELECT @RowCount = MAX(RowId) FROM #t
   
   DECLARE @FundId INT
   DECLARE @ClientId INT
   DECLARE @RowId INT = 1
   DECLARE @NewId int = 1
   
   WHILE @RowId <= @RowCount
   BEGIN
      SELECT @FundId = FundId, @ClientId = ClientId From #t WHERE RowId = @RowId

      
      select @count = @minCount + ROUND( (@maxCount-@minCount) *RAND(convert(varbinary, newid())), 0)


      DECLARE @i int = 1
      DECLARE 
         @Name varchar(100), 
         @Code varchar(100)

      WHILE @i <= @count
      BEGIN
         SELECT 
            @Code = 'S' + convert(varchar(10),@ClientId) + '/' ++ convert(varchar(10),@FundId) + '/' + convert(varchar(10),@i),
            @Name = 'Contract ' + convert(varchar(10),@ClientId) + '/' + convert(varchar(10),@FundId) + '/' + convert(varchar(10),@i)
         
       INSERT INTO dbo.Contract (LastActionWhen,LastActionById,ContractId,Version,Code,Name,StartDate,EffectiveDate, EndDate,PayCcy,AccrualBasis,InterestOffsetDays,TradeMatchBasis,BusinessRegionId,Status,ContractProductType,FundId)
       SELECT @LastActionWhen, @LastActionById,@NewId,1,@Code,@Name, '1 Jan  2013','1 Jan  2013', '31 Dec 2013',@PricingCcy,1,0,1,1,null,null,@FundId
         SELECT @i = @i +1
         SELECT @NewId = @NewId  + 1
      END
      --SELECT 'Created ' + convert(varchar(100),@i-1) + ' Contracts for Fund '  + convert(varchar(10),@FundId)
   
      SELECT @RowId = @RowId + 1
      
   END
   
   SELECT 'Created ' + convert(varchar(100),@NewId-1) + ' Contracts for all Funds '  
   SET IDENTITY_INSERT dbo.[Contract] OFF  
END