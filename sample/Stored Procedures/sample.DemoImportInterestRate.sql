
CREATE PROCEDURE [sample].[DemoImportInterestRate]
AS
BEGIN
   SET NOCOUNT ON
   SET IDENTITY_INSERT dbo.Instrument ON

   DECLARE @fileDir VARCHAR(MAX), @fileName VARCHAR(2000)
   DECLARE @instId int, @symbol varchar(100)

   select @fileDir = 'C:\Dev\LamUIAlpha\trunk\src\Laminar\Laminar.UI\Laminar.Db\Data\HistoricPrices\StLouisFed\'
   select @symbol = 'GBP3MTD156N'
   Select @fileName = @fileDir + @symbol + '.csv'

      DECLARE 
         @LastActionWhen DateTime, 
         @LastActionById int
         
    SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
    SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'

      DECLARE @StartId  int 
   SELECT @StartId = ISNULL(MAX(InstrumentId),0) FROM dbo.Instrument

      select @instid = 1+@StartId

    INSERT dbo.Instrument (LastActionWhen,LastActionById,InstrumentId,Version,Code,Name,Country,Ccy,[Type] )
    SELECT @LastActionWhen, @LastActionById,1+@StartId,1,'GBP3M','GBP 3M Libor','GB','GBP','InterestRate'

   exec sample.ImportStLouisFedInterestRate @fileName, @RowTerminator='\n', @Source='STLF' , @InstrumentId=@InstId,  @Ccy = 'GBP', @EarliestDate='1 Jan 2010', @debug=0, @truncate =0

   UPDATE p
   SET
      Price = p.Price/100.0
   FROM dbo.Price p
   JOIN dbo.Instrument i ON i.InstrumentId=p.InstrumentId
   WHERE
      i.Name='GBP 3M Libor'

    SET IDENTITY_INSERT dbo.Instrument OFF
END