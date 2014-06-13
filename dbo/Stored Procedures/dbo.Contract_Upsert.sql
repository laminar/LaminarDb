CREATE PROCEDURE [dbo].[Contract_Upsert]
(
	@contract As dbo.Contract READONLY,
	@legs As dbo.ContractLeg READONLY,
	@equityLegEconomics As dbo.ContractEquityLegEconomic READONLY,
	@equityLegSchedule As dbo.ContractEquityLegSchedule READONLY,
	@interestLegEconomics As dbo.ContractInterestLegEconomic READONLY,
	@interestLegSchedule As dbo.ContractInterestLegSchedule READONLY,
	@ReturnValues bit =1
)
AS
BEGIN
	SET NOCOUNT ON

	IF ( SELECT COUNT(*) FROM @Contract )<>1
	BEGIN
		exec support.ReportValidationError  'Contract', 'Upsert', null, 'There must be exactly 1 Contract.'
		RETURN
	END

    DECLARE @keyInfo AS support.KeyInfo
  
	DECLARE @contractId bigint, @version int
	SELECT  @contractId = ContractID , @version = Version FROM @contract
  
    IF (@contractId IS NOT NULL ) AND NOT EXISTS (SELECT 1 FROM dbo.Contract WHERE ContractId=@contractId AND Version=@version )
    BEGIN
        INSERT INTO @keyInfo 
        SELECT ContractId, Version
        FROM dbo.Contract WHERE ContractId=@ContractId 

        exec support.ReportIncorrectUpdateKeyInfo 'Contract', 'Update', @Version,  @keyInfo
        RETURN
    END      

	IF ( (SELECT COUNT(*) FROM @legs WHERE ContractLegId IS NULL)> 0 OR ( (SELECT COUNT(ContractLegId) FROM @legs) <> (SELECT COUNT(DISTINCT ContractLegId) FROM @legs))) 
	BEGIN
		exec support.ReportValidationError  'Contract', 'Upsert', null, 'Contract Leg Id must be unique for each ContractLeg and Not Null.'
		RETURN
	END

	IF ( SELECT COUNT(*)
	FROM
		(
		SELECT ContractLegId FROM @equityLegEconomics WHERE ContractLegId NOT IN (SELECT ContractLegId FROM @legs)
		UNION 
		SELECT ContractLegId FROM @equityLegSchedule WHERE ContractLegId NOT IN (SELECT ContractLegId FROM @legs)
		UNION ALL
		SELECT ContractLegId FROM @interestLegEconomics WHERE ContractLegId NOT IN (SELECT ContractLegId FROM @legs)
		UNION ALL
		SELECT ContractLegId FROM @interestLegSchedule WHERE ContractLegId NOT IN (SELECT ContractLegId FROM @legs)
		) u ) > 0 
	BEGIN
		exec support.ReportValidationError  'Contract', 'Upsert', null, 'All Contract Leg data should have a valid contract leg id.'
		RETURN	
	END

	IF EXISTS ( SELECT * FROM
		(
		SELECT ISNULL(ContractId,0) as ContractId FROM @equityLegEconomics
		UNION
		SELECT ISNULL(ContractId,0) FROM @equityLegSchedule
		UNION
		SELECT ISNULL(ContractId,0) FROM @interestLegEconomics
		UNION
		SELECT ISNULL(ContractId,0) FROM @interestLegSchedule
		) u
		WHERE u.ContractId <> ISNULL(@ContractId,0) )
	BEGIN
		exec support.ReportValidationError  'Contract', 'Upsert', null, 'All Contract Ids should be the same.'
		RETURN	
	END
	
	DECLARE @contractIdTable AS support.keyInfo

	BEGIN TRY
		BEGIN TRAN
		IF @contractId IS NULL
		BEGIN
			DELETE @keyInfo
			INSERT dbo.Contract 
			(
				LastActionWhen, LastActionById, Code, Name, StartDate, EndDate, EffectiveDate, PayCcy,
				AccrualBasis, InterestOffsetDays, TradeMatchBasis, BusinessRegionId, Status, ContractProductType, FundId
			)
			OUTPUT inserted.ContractId, inserted.Version
			INTO @keyInfo
			SELECT 
				LastActionWhen, LastActionById, Code, Name, StartDate, EndDate, EffectiveDate, PayCcy,
				AccrualBasis, InterestOffsetDays, TradeMatchBasis, BusinessRegionId, Status, ContractProductType, FundId
			FROM @contract

			SELECT @ContractId = Id, @version = Version FROM @keyInfo

		END
		ELSE
		BEGIN
			UPDATE dest SET
				Version				 = dest.Version + 1,
				LastActionWhen       = src.LastActionWhen,
				LastActionById       = src.LastActionById,
				Code                 = src.Code,
				Name                 = src.Name,
				StartDate            = src.StartDate,
				EndDate              = src.EndDate,
				EffectiveDate        = src.EffectiveDate,
				PayCcy               = src.PayCcy,
				AccrualBasis         = src.AccrualBasis,
				InterestOffsetDays   = src.InterestOffsetDays,
				TradeMatchBasis      = src.TradeMatchBasis,
				BusinessRegionId     = src.BusinessRegionId,
				Status               = src.Status,
				ContractProductType  = src.ContractProductType,
				FundId               = src.FundId
			OUTPUT inserted.ContractId, inserted.Version INTO @keyInfo
			FROM dbo.Contract dest
			JOIN @contract src ON dest.ContractId =  src.ContractId
         

			SELECT @ContractId = Id, @Version= Version FROM @keyInfo
			DELETE FROM dbo.ContractLeg WHERE ContractId = @contractId
			DELETE FROM dbo.ContractEquityLegEconomic WHERE ContractId = @contractId
			DELETE FROM dbo.ContractEquityLegSchedule WHERE ContractId = @contractId
			DELETE FROM dbo.ContractInterestLegEconomic WHERE ContractId = @contractId
			DELETE FROM dbo.ContractInterestLegSchedule WHERE ContractId = @contractId
			
		END

		DECLARE @map AS TABLE (rowIndex int IDENTITY(1,1), contractLegId bigint, newContractLegId bigint)

		INSERT INTO @map (contractLegId) SELECT contractLegId FROM @legs
		DECLARE @rowIndex int = 1, @count int
		SELECT @count = COUNT(*) FROM @map

		DECLARE @contractLegKey As support.keyInfo


		WHILE @rowIndex <= @count
		BEGIN

			DELETE FROM @contractLegKey
			INSERT INTO dbo.ContractLeg ([ContractId],[Ccy])
			OUTPUT inserted.ContractLegId, 0 INTO @contractLegKey
			SELECT @contractId, cl.Ccy FROM @legs cl JOIN @map map ON cl.ContractLegId = map.contractLegId and map.rowIndex = @rowIndex

			UPDATE @map SET newContractLegId = Id FROM @contractLegKey

			SELECT @rowIndex = @rowIndex + 1
		END


		INSERT INTO [dbo].[ContractEquityLegEconomic]
		(
			[ContractId],[ContractLegId],[AsOfDate],[LongEntitlementSpread],[ShortEntitlementSpread],[MarginBasis],[ResetQuantityBasis],[RealisedGainPaymentBasis],
			[EntitlementPaymentBasis],[EntitlementFxPaymentBasis],[EntitlementFxOffsetDays],[CommissionBasis],[CommissionPaymentBasis],[DefaultCommissionAmount],[IsNetCommission]
		)
		SELECT 
			@ContractId, map.newContractLegId,[AsOfDate],[LongEntitlementSpread],[ShortEntitlementSpread],[MarginBasis],[ResetQuantityBasis],[RealisedGainPaymentBasis],
			[EntitlementPaymentBasis],[EntitlementFxPaymentBasis],[EntitlementFxOffsetDays],[CommissionBasis],[CommissionPaymentBasis],[DefaultCommissionAmount],[IsNetCommission]
		FROM  @equityLegEconomics tgt
		JOIN @map map ON  tgt.ContractLegId = map.ContractLegId
		
		INSERT INTO [dbo].[ContractEquityLegSchedule] 
		([ContractId],[ContractLegId],[ResetDate],[PayDate])
		SELECT @ContractId, map.newContractLegId, [ResetDate],[PayDate]
		FROM @equityLegSchedule tgt
		JOIN @map map ON  tgt.ContractLegId = map.ContractLegId
			
		INSERT INTO [dbo].[ContractInterestLegEconomic]
		(
			[ContractId],[ContractLegId],[AsOfDate],[AccrualBasis],[InterestOffsetDays],[InterestPaymentBasis],[BorrowCostShortSpread],[BorrowCostNotionalBasis],[PayToHoldNotionalBasis],
			[SpreadCalculationBasis],[InterestLongSpread],[InterestShortSpread],[IsNewRateOnIntraPeriodIncrease],[IsNewRateOnIntraPeriodDecrease],[ReferenceInterestRateInstrumentId],[InitialStubRate],
			[FinalStubRate],[IsDailyResetting],[IsNetFinancing],[IsFinanceRealisedGains],[IsNewRateOnRealisedGains],[RealisedGainLongSpread],[RealisedGainShortSpread],[IsFinanceDividends],
			[IsNewRateOnDividends],[DividendsLongSpread],[DividendsShortSpread]
		)
		SELECT
			@ContractId,map.newContractLegId,[AsOfDate],[AccrualBasis],[InterestOffsetDays],[InterestPaymentBasis],[BorrowCostShortSpread],[BorrowCostNotionalBasis],[PayToHoldNotionalBasis],
			[SpreadCalculationBasis],[InterestLongSpread],[InterestShortSpread],[IsNewRateOnIntraPeriodIncrease],[IsNewRateOnIntraPeriodDecrease],[ReferenceInterestRateInstrumentId],[InitialStubRate],
			[FinalStubRate],[IsDailyResetting],[IsNetFinancing],[IsFinanceRealisedGains],[IsNewRateOnRealisedGains],[RealisedGainLongSpread],[RealisedGainShortSpread],[IsFinanceDividends],
			[IsNewRateOnDividends],[DividendsLongSpread],[DividendsShortSpread]
		FROM @interestLegEconomics tgt
		JOIN @map map ON  tgt.ContractLegId = map.ContractLegId

		INSERT INTO [dbo].[ContractInterestLegSchedule] 
		([ContractId],[ContractLegId],[AccrualStartDate],[AccrualEndDate],[PayDate])
		SELECT @ContractId,map.newContractLegId,[AccrualStartDate],[AccrualEndDate],[PayDate]
		FROM @InterestLegSchedule tgt
		JOIN @map map ON  tgt.ContractLegId = map.ContractLegId
		
        DECLARE @json varchar(max) = (SELECT work.MakeJSON2('ContractId', Id, 'Version', Version ) FROM @keyInfo)
        exec work.StartWorkflow 'Contract' , @json
 
        IF @ReturnValues = 1
        BEGIN
		    SELECT 'Keys' as ResultType
		    SELECT Id,Version FROM @keyInfo
        END
		COMMIT TRAN
	END TRY
	BEGIN CATCH
	SELECT 'TC', @@TRANCOUNT 
		IF @@TRANCOUNT > 0
           ROLLBACK TRAN --RollBack in case of Error
		exec support.ReportSqlError   
	END CATCH;


END