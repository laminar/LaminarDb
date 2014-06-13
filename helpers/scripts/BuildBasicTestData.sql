
TRUNCATE TABLE dbo.SystemUser
INSERT dbo.SystemUser
(Version, LastActionWhen, LastActionById, Name,  Code)
VALUES
(1, '1 Jan 2010' , 1, 'SU1', 'SystemUser1')


TRUNCATE TABLE dbo.Client
INSERT dbo.Client 
(Version, LastActionWhen, LastActionById, Code, Name)
VALUES
(1, '1 Jan 2010' , 1, 'C1', 'Client1')


TRUNCATE TABLE dbo.Currency
INSERT dbo.Currency
(Version, LastActionWhen, LastActionById, IsoCode, Name)
VALUES
(1, '1 Jan 2010' , 1, 'GBP', 'Pounds Sterling'),
(1, '1 Jan 2010' , 1, 'USD', 'US Dollars')

TRUNCATE TABLE dbo.Country
INSERT dbo.Country
(Version, LastActionWhen, LastActionById, IsoCode, Name)
VALUES
(1, '1 Jan 2010' , 1, 'GB', 'Great Britain'),
(1, '1 Jan 2010' , 1, 'US', 'United States')


TRUNCATE TABLE dbo.Fund
INSERT dbo.Fund 
(Version, LastActionWhen, LastActionById, Code, Name,ClientId)
VALUES
(1, '1 Jan 2010' , 1, 'F1', 'Fund1',1)




TRUNCATE TABLE dbo.AllocationGroup
INSERT dbo.AllocationGroup
(Version, LastActionWhen, LastActionById, Code, Name)
VALUES
(1, '1 Jan 2010' , 1, 'AG1', 'AllocationGroup1')

TRUNCATE TABLE dbo.Counterparty
INSERT dbo.Counterparty
(Version, LastActionWhen, LastActionById, Code, Name)
VALUES
(1, '1 Jan 2010' , 1, 'CP1', 'Counterparty1')

TRUNCATE TABLE dbo.Custodian
INSERT dbo.Custodian
(Version, LastActionWhen, LastActionById, Code, Name)
VALUES
(1, '1 Jan 2010' , 1, 'CU1', 'Custodian1')

TRUNCATE TABLE dbo.Instrument
INSERT dbo.Instrument
(Version, LastActionWhen, LastActionById, Code, Name,Ccy)
VALUES
(1, '1 Jan 2010' , 1, 'I1', 'Instrument1','GBP'),
(1, '1 Jan 2010' , 1, 'I2', 'Instrument2','USD')


TRUNCATE TABLE dbo.Trade
INSERT dbo.Trade
(Version,LastActionWhen,LastActionById,ContractId,InstrumentId,Quantity,SwapPriceCcy,SwapPrice,TradeDate,SettleDate,TradeType)
VALUES
(1,'1 Jan 2010' , 1, 1, 1, 1000, 'GBP', 1, '1 Jan 2014', '4 Jan 2014', 0)

TRUNCATE TABLE [dbo].[Contract]
TRUNCATE TABLE [dbo].[ContractLeg]
TRUNCATE TABLE [dbo].[ContractEquityLegEconomic]
TRUNCATE TABLE [dbo].[ContractEquityLegSchedule]
TRUNCATE TABLE [dbo].[ContractInterestLegEconomic]
TRUNCATE TABLE [dbo].[ContractInterestLegSchedule]


INSERT INTO [dbo].[Contract]
([LastActionWhen],[LastActionById],[Code],[Name],[StartDate],[EndDate],[EffectiveDate],[PayCcy],[AccrualBasis],[InterestOffsetDays],[TradeMatchBasis],[BusinessRegionId],[Status],[ContractProductType],[FundId])
VALUES
('1 Jan 2010', 1,'Co1', 'Contract1','1 Jan 2010', '31 Dec 2010','1 Jan 2010','GBP',null, null, null, null, null, null, 1)

INSERT INTO [dbo].[ContractLeg]
([ContractId], [Ccy])
VALUES
(1,'GBP')

INSERT INTO [dbo].[ContractEquityLegEconomic]
([ContractId], [ContractLegId] ,[AsOfDate], [LongEntitlementSpread], [ShortEntitlementSpread], [MarginBasis], [ResetQuantityBasis], [RealisedGainPaymentBasis], [EntitlementPaymentBasis], [EntitlementFxPaymentBasis], [EntitlementFxOffsetDays], [CommissionBasis], [CommissionPaymentBasis], [DefaultCommissionAmount], [IsNetCommission])
VALUES
(1, 1, null, null, null, null, null, null, null, null, null, null, null, null, null)



INSERT INTO [dbo].[ContractEquityLegSchedule]([ContractId],[ContractLegId],[ResetDate],[PayDate])
VALUES
(1, 1, null, null)

INSERT INTO [dbo].[ContractInterestLegEconomic]([ContractId],[ContractLegId],[AsOfDate],[AccrualBasis],[InterestOffsetDays],[InterestPaymentBasis],[BorrowCostShortSpread],[BorrowCostNotionalBasis],[PayToHoldNotionalBasis],[SpreadCalculationBasis],[InterestLongSpread],[InterestShortSpread],[IsNewRateOnIntraPeriodIncrease],[IsNewRateOnIntraPeriodDecrease],[ReferenceInterestRateInstrumentId],[InitialStubRate],[FinalStubRate],[IsDailyResetting],[IsNetFinancing],[IsFinanceRealisedGains],[IsNewRateOnRealisedGains],[RealisedGainLongSpread],[RealisedGainShortSpread],[IsFinanceDividends],[IsNewRateOnDividends],[DividendsLongSpread],[DividendsShortSpread])
VALUES
(1, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null)

INSERT INTO [dbo].[ContractInterestLegSchedule]([ContractId],[ContractLegId],[AccrualStartDate],[AccrualEndDate],[PayDate])
VALUES
(1, 1, null, null, null)
