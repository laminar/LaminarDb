CREATE PROCEDURE [sample].[DemoCreateTrades]
AS
BEGIN
    SET NOCOUNT ON
    DECLARE 
        @LastActionWhen DateTime, 
        @LastActionById int,
        @DailyTradesMin int,
        @DailyTradesMax int
      
    SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
    SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'
    SELECT @DailyTradesMin = Value FROM sample.SampleDefaults WHERE Name = 'DailyTradesMin'
    SELECT @DailyTradesMax = Value FROM sample.SampleDefaults WHERE Name = 'DailyTradesMax'

    
    select * into #newtrades from dbo.Trade where 0=1


    create table #randomAmounts
    (
	    rowId int identity(1,1),
	    amount decimal(28,8)
)
    insert into #randomAmounts (amount)
    SELECT  Value FROM sample.SampleDefaults WHERE Name = 'RandomTradeAmount'
    

    DECLARE @randomAmountCount int 
    SELECT @randomAmountCount = COUNT(*) FROM #randomAmounts


    create table #contracts
    (
	    rowId int identity(1,1),
	    ContractId int 
    )

    insert into #contracts  
    (ContractId)
    select  ContractId
    from dbo.Contract

    declare @startDate datetime, @endDate datetime 
    select @startDate =  Value FROM sample.SampleDefaults WHERE Name = 'StartDate'
    select @endDate =  Value FROM sample.SampleDefaults WHERE Name = 'EndDate'
    declare @halfwayDate datetime = round(convert(real,(@endDate - @startDate ))/2,0) +  @StartDate


    create table #randomInstChoices
    (
	    rowId int identity(1,1),
	    instrumentId int 
    )

    create table #randomInstruments
    (
	    rowId int identity(1,1),
	    instrumentId int 
    )

    insert into #randomInstChoices
    (instrumentId)
    select distinct instrumentId from dbo.Price



    declare @tradeId int = 1

    DECLARE @InstId int, @amount decimal(28,8), @price decimal(28,8)
    declare @rowId int = 1
    declare @ContractId int
    declare @lastRowId int
    select @lastRowId = max(rowId) from #contracts

    truncate table dbo.trade

    while @rowId <= @lastRowId 
    begin
        select @ContractId = ContractId from #contracts where rowId = @rowId

        -- pick 10 stocks
        truncate table #randomInstruments 
        insert into #randomInstruments (instrumentId)
        select  instrumentId from #randomInstChoices where rowId in (select top 10 rowId from #randomInstChoices order by newid())   
   


        DECLARE @date datetime
	    SELECT @date  = @startDate
	    WHILE @date <= @enddate
	    BEGIN
		    IF NOT DATEPART(weekday,@date) IN (1,7)
		    BEGIN
			    -- gen 1-5 random trades for one to 1-5 random instruments for random amount for random bu/sell
			    -- @random price between 1 & 2% of close price
			
			    DECLARE @randomTradeCount int
                select @randomTradeCount  = @DailyTradesMin + ROUND( (@DailyTradesMax-@DailyTradesMin) *RAND(convert(varbinary, newid())), 0)

			    DECLARE @sign int = 0
			    DECLARE @tradeCount int = 1
			    WHILE @tradeCount<= @randomTradeCount
			    BEGIN
			     -- bias buy /sells according to date
				    IF (@date<@halfwayDate)
				    BEGIN
					    SELECT @sign = CASE WHEN (RAND() < 0.25 ) THEN -1 ELSE +1 END
				    END
				    ELSE
				    BEGIN
					    SELECT @sign = CASE WHEN (RAND() < 0.75 ) THEN -1 ELSE +1 END
				    END

				    select  @amount = amount * @sign from #randomAmounts where rowId in (select top 1 rowId from #randomAmounts order by newid())   

   
				    select  @InstId = instrumentId from #randomInstruments where rowId in (select top 1 rowId from #randomInstruments order by newid())   


				    SELECT @price = Price from dbo.Price WHERE Date = @date AND InstrumentId = @InstId

				    SELECT @price  = ROUND(@price  * ( 1 + (RAND()-1)*0.05),2) -- 5% variation in price

				    DECLARE @settlementDate datetime = @date +3
				    DECLARE @swapPriceCurrency varchar(3) = 'GBP'

                    SET IDENTITY_INSERT #newTrades ON
				    INSERT INTO #newtrades  
				    ([LastActionWhen],[LastActionById],[TradeId],[Version],[ContractId], [InstrumentId],[Quantity],[SwapPrice],[TradeDate],[SettleDate],[SwapPriceCcy])
				    VALUES
				    (@LastActionWhen,@LastActionById,@tradeId,1,@ContractId, @instId,@amount,@price,@date, @settlementDate,@swapPriceCurrency )
                    SET IDENTITY_INSERT #newTrades OFF

				    select @tradeId  = @tradeId + 1
				    SELECT @tradeCount = @tradeCount + 1
			    END

                SET IDENTITY_INSERT dbo.Trade ON
			    
                insert into dbo.trade  ([LastActionWhen],[LastActionById],[TradeId],[Version],[ContractId], [InstrumentId],[Quantity],[SwapPrice],[TradeDate],[SettleDate],[SwapPriceCcy]) 
                select [LastActionWhen],[LastActionById],[TradeId],[Version],[ContractId], [InstrumentId],[Quantity],[SwapPrice],[TradeDate],[SettleDate],[SwapPriceCcy]
                from #newtrades

                SET IDENTITY_INSERT dbo.Trade OFF
			    truncate table #newtrades

			
		    END

		    SELECT @date = @date + 1
	    END



	    select @rowId  = @rowId +1
    end

    drop table #contracts
    drop table #newtrades 
    drop table #randomAmounts
    Drop table #randomInstChoices
    Drop table #randomInstruments

    SELECT 'Created ' + CAST((SELECT COUNT(*) FROM dbo.Trade) AS VARCHAR(MAX)) + ' Trades'
   
    EXEC sample.ReBuildPositions @LastActionWhen , @LastActionById
 END