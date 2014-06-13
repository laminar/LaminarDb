

CREATE PROCEDURE [sample].[DemoSetupAndLoad]
AS
BEGIN
    SET NOCOUNT ON
	TRUNCATE TABLE sample.SampleDefaults

	INSERT INTO sample.SampleDefaults SELECT 'LastActionWhen', getdate()
	INSERT INTO sample.SampleDefaults SELECT 'LastActionById', '1' -- System User
	INSERT INTO sample.SampleDefaults SELECT 'SampleDataLocationRoot', 'C:\Dev\LamUIAlpha\trunk\src\Laminar\Laminar.UI\Laminar.Db\Data\'
    INSERT INTO sample.SampleDefaults SELECT 'DailyTradesMin', 25
    INSERT INTO sample.SampleDefaults SELECT 'DailyTradesMax', 25
    
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 5000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 10000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 20000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 25000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 50000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 75000
    INSERT INTO sample.SampleDefaults SELECT 'RandomTradeAmount', 100000

    INSERT INTO sample.SampleDefaults SELECT 'StartDate', '1 Jan 2013'
    INSERT INTO sample.SampleDefaults SELECT 'EndDate', '31 Dec 2013'

    INSERT INTO sample.SampleDefaults SELECT 'MinBrokers', 100
    INSERT INTO sample.SampleDefaults SELECT 'MaxBrokers', 100
    INSERT INTO sample.SampleDefaults SELECT 'MinClients', 10
    INSERT INTO sample.SampleDefaults SELECT 'MaxClients', 10
    INSERT INTO sample.SampleDefaults SELECT 'MinFundsPerClient', 3
    INSERT INTO sample.SampleDefaults SELECT 'MaxFundsPerClient', 3
    INSERT INTO sample.SampleDefaults SELECT 'MinContractsPerFund', 3
    INSERT INTO sample.SampleDefaults SELECT 'MaxContractsPerFund', 3

    TRUNCATE TABLE dbo.AllocationGroup
    TRUNCATE TABLE dbo.Broker
    TRUNCATE TABLE dbo.BusinessRegion
    TRUNCATE TABLE dbo.Client
    TRUNCATE TABLE dbo.Contract
    TRUNCATE TABLE dbo.ContractEquityLegEconomic
    TRUNCATE TABLE dbo.ContractEquityLegSchedule
    TRUNCATE TABLE dbo.ContractInterestLegEconomic
    TRUNCATE TABLE dbo.ContractInterestLegSchedule
    TRUNCATE TABLE dbo.ContractLeg
    TRUNCATE TABLE dbo.Counterparty
    TRUNCATE TABLE dbo.Country
    TRUNCATE TABLE dbo.Currency
    TRUNCATE TABLE dbo.Custodian
    TRUNCATE TABLE dbo.Fund
    TRUNCATE TABLE dbo.Instrument
    TRUNCATE TABLE dbo.Position
    TRUNCATE TABLE dbo.Price
    TRUNCATE TABLE dbo.SystemUser
    TRUNCATE TABLE dbo.Trade

    exec sample.DemoCreateAllSampleData
END