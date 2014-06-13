
CREATE PROCEDURE [sample].[DemoCreateContractDetails]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE 
      @LastActionWhen DateTime, 
      @LastActionById int
         
   SELECT @LastActionWhen = Value FROM sample.SampleDefaults WHERE Name = 'LastActionWhen'
   SELECT @LastActionById = Value FROM sample.SampleDefaults WHERE Name = 'LastActionById'

   DECLARE @InterestRateInstrumentId int
   SELECT @InterestRateInstrumentId = InstrumentId FROM dbo.Instrument WHERE Name = 'GBP 3M Libor'
  

   TRUNCATE TABLE dbo.[ContractLeg]
   TRUNCATE TABLE dbo.[ContractEquityLegEconomic]
   TRUNCATE TABLE dbo.[ContractEquityLegSchedule]
   TRUNCATE TABLE dbo.[ContractInterestLegEconomic]
   TRUNCATE TABLE dbo.[ContractInterestLegSchedule]

   DECLARE @Contracts TABLE (RowId int Identity(1,1) , ContractId int)
   INSERT INTO @Contracts  (ContractId)
   SELECT ContractId FROM dbo.Contract

   DECLARE @rowId int, @maxRowId int
   DECLARE @ContractId int


   SELECT @maxRowId = MAX(RowId) FROM @Contracts
   SELECT @rowId  = 1
   WHILE @rowId <= @maxRowId
   BEGIN
      SELECT @ContractId = ContractId FROM  @Contracts where RowId =@RowId 

      SET IDENTITY_INSERT dbo.[ContractLeg] ON
      INSERT INTO dbo.[ContractLeg] (ContractLegId,ContractId,Ccy)
      VALUES (1,@ContractId, 'GBP')

      SET IDENTITY_INSERT dbo.[ContractLeg] OFF

      SET IDENTITY_INSERT dbo.[ContractEquityLegEconomic] ON

      INSERT INTO dbo.[ContractEquityLegEconomic]
      (
         ContractEquityLegEconomicId,ContractId,ContractLegId,
         AsOfDate,LongEntitlementSpread,ShortEntitlementSpread,MarginBasis,ResetQuantityBasis,RealisedGainPaymentBasis,
         EntitlementPaymentBasis,EntitlementFxPaymentBasis,EntitlementFxOffsetDays,CommissionBasis,CommissionPaymentBasis,DefaultCommissionAmount,IsNetCommission
      )
      VALUES
      (
         1,@ContractId, 1,
         null,0,0,1,1,1,
         1,1,1,1,1,0,0
      )
      SET IDENTITY_INSERT dbo.[ContractEquityLegEconomic] OFF

      SET IDENTITY_INSERT dbo.[ContractEquityLegSchedule] ON
      INSERT INTO dbo.[ContractEquityLegSchedule]
      (
         ContractEquityLegScheduleId,ContractId,ContractLegId,
         ResetDate, PayDate
      )
      VALUES
      ( 1,@ContractId, 1,   '25 Jan 2013', '28 Jan 2013'),
      ( 2,@ContractId, 1,   '25 Feb 2013', '28 Feb 2013'),
      ( 3,@ContractId, 1,   '25 Mar 2013', '28 Mar 2013'),
      ( 4,@ContractId, 1,   '25 Apr 2013', '28 Apr 2013'),
      ( 5,@ContractId, 1,   '25 May 2013', '28 May 2013'),
      ( 6,@ContractId, 1,   '25 Jun 2013', '28 Jun 2013'),
      ( 7,@ContractId, 1,   '25 Jul 2013', '28 Jul 2013'),
      ( 8,@ContractId, 1,   '25 Aug 2013', '28 Aug 2013'),
      ( 9,@ContractId, 1,   '25 Sep 2013', '28 Sep 2013'),
      (10,@ContractId, 1,   '25 Oct 2013', '28 Oct 2013'),
      (11,@ContractId, 1,   '25 Nov 2013', '28 Nov 2013'),
      (12,@ContractId, 1,   '25 Dec 2013', '28 Dec 2013')

      SET IDENTITY_INSERT dbo.[ContractEquityLegSchedule] OFF

      SET IDENTITY_INSERT dbo.[ContractInterestLegEconomic] ON
      INSERT INTO dbo.[ContractInterestLegEconomic]
      (
         ContractInterestLegEconomicId,ContractId,ContractLegId,
         AsOfDate,AccrualBasis,InterestOffsetDays ,InterestPaymentBasis,
         BorrowCostShortSpread,BorrowCostNotionalBasis,
         PayToHoldNotionalBasis,SpreadCalculationBasis,
         InterestLongSpread,InterestShortSpread,
         IsNewRateOnIntraPeriodIncrease,IsNewRateOnIntraPeriodDecrease,
         ReferenceInterestRateInstrumentId,
         InitialStubRate,FinalStubRate,IsDailyResetting,IsNetFinancing,
         IsFinanceRealisedGains,IsNewRateOnRealisedGains,
         RealisedGainLongSpread,RealisedGainShortSpread,
         IsFinanceDividends,IsNewRateOnDividends,
         DividendsLongSpread,DividendsShortSpread
      )
      VALUES
      (
         1,@ContractId, 1,
         null,1,0,1,
         null,null,
         1,1,
         0.02, 0.02,
         0,0,
         @InterestRateInstrumentId,
         null,null,0,0,
         0,0,
         null,null,
         0, 0,
         null,null
      )
      SET IDENTITY_INSERT dbo.[ContractInterestLegEconomic] OFF

      SET IDENTITY_INSERT dbo.[ContractInterestLegSchedule] ON
      INSERT INTO dbo.[ContractInterestLegSchedule]
      (
       ContractInterestLegScheduleId,ContractId,ContractLegId,
         AccrualStartDate ,AccrualEndDate, PayDate
      )
      VALUES
      ( 1,@ContractId, 1,   '01 Jan 2013', '28 Jan 2013', '28 Jan 2013'),
      ( 2,@ContractId, 1,   '01 Feb 2013', '28 Feb 2013', '28 Feb 2013'),
      ( 3,@ContractId, 1,   '01 Mar 2013', '28 Mar 2013', '28 Mar 2013'),
      ( 4,@ContractId, 1,   '01 Apr 2013', '28 Apr 2013', '28 Apr 2013'),
      ( 5,@ContractId, 1,   '01 May 2013', '28 May 2013', '28 May 2013'),
      ( 6,@ContractId, 1,   '01 Jun 2013', '28 Jun 2013', '28 Jun 2013'),
      ( 7,@ContractId, 1,   '01 Jul 2013', '28 Jul 2013', '28 Jul 2013'),
      ( 8,@ContractId, 1,   '01 Aug 2013', '28 Aug 2013', '28 Aug 2013'),
      ( 9,@ContractId, 1,   '01 Sep 2013', '28 Sep 2013', '28 Sep 2013'),
      (10,@ContractId, 1,   '01 Oct 2013', '28 Oct 2013', '28 Oct 2013'),
      (11,@ContractId, 1,   '01 Nov 2013', '28 Nov 2013', '28 Nov 2013'),
      (12,@ContractId, 1,   '01 Dec 2013', '28 Dec 2013', '28 Dec 2013')
      SET IDENTITY_INSERT dbo.[ContractInterestLegSchedule] OFF


      SELECT @rowId  = @rowId + 1
   END
END