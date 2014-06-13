

CREATE PROCEDURE [sample].[DemoCreateClient]

AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.Client ON

    DECLARE 
        @minCount int,
        @maxCount int = null
 
    SELECT @minCount = Value FROM sample.SampleDefaults WHERE Name = 'MinClients'
    SELECT @maxCount = Value FROM sample.SampleDefaults WHERE Name = 'MaxClients'


   DECLARE @count int
   SELECT @maxCount = ISNULL(@maxCount,@minCount)
   select @count = @minCount + ROUND( (@maxCount-@minCount) *RAND(convert(varbinary, newid())), 0)
   
   DECLARE 
      @LastActionWhen DateTime, 
      @LastActionById int
      
   SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
   SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'
   
   DECLARE @i int = 1
   DECLARE 
      @Name varchar(100), 
      @Code varchar(100)
      
   WHILE @i <= @count
   BEGIN
      SELECT 
         @Code = 'C' + convert(varchar(10),@i),
         @Name = 'Client ' + convert(varchar(10),@i)
      INSERT INTO dbo.Client (LastActionWhen,LastActionById,ClientId,Version,Code,Name) SELECT @LastActionWhen, @LastActionById,@i,1,@Code,@Name
      SELECT @i = @i +1
   END
   
   SELECT 'Created ' + convert(varchar(100),@i-1) + ' clients'
   SET IDENTITY_INSERT dbo.Client OFF
END