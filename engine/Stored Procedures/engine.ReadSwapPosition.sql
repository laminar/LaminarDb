
CREATE PROCEDURE engine.ReadSwapPosition
(
    @swapId         BIGINT,
    @instrumentId   BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        0 AS PriceDaysOffset,   --TODO: Get real value
        cile.InterestLongSpread AS NotionalLongSpread,
        cile.InterestShortSpread AS NotionalShortSpread,
        cile.ReferenceInterestRateInstrumentId AS NotionalInterestRateTenorId,
        cile.InterestOffsetDays AS NotionalInterestDaysOffset,
        ISNULL(cile.BorrowCostShortSpread, 0) AS BorrowCostSpread,
        cile.ReferenceInterestRateInstrumentId AS UnpaidCashInterestRateTenorId,
        cile.InterestOffsetDays AS UnpaidCashInterestRateDaysOffset,
        cile.AccrualBasis AS AccrualBasisId,
        0 AS IsCompoundInterest,
        1 AS PaymentScheduleSpecifierId,
        c.TradeMatchBasis AS TradeMatchOrderId
    FROM dbo.Contract c
    JOIN dbo.ContractLeg cl ON c.ContractId=cl.ContractId
    JOIN dbo.ContractEquityLegEconomic cele ON c.ContractId=cele.ContractId AND cl.ContractLegId=cele.ContractLegId
    JOIN dbo.ContractInterestLegEconomic cile ON c.ContractId=cile.ContractId AND cl.ContractLegId=cile.ContractLegId
    JOIN dbo.Instrument i ON i.Country='GB' -- TODO: Should join on cl.Country
    WHERE
        c.ContractId = @swapId
    AND i.InstrumentId = @instrumentId

END