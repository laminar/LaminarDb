
CREATE PROCEDURE engine.ReadEquityResetSchedule
(
    @swapId                     BIGINT,
    @instrumentId               BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        cels.ResetDate,
        cels.PayDate
    FROM dbo.Contract c
    JOIN dbo.ContractLeg cl ON cl.ContractId=c.ContractId
    JOIN dbo.ContractEquityLegSchedule cels ON cels.ContractId=c.ContractId AND cels.ContractLegId=cl.ContractLegId
    JOIN dbo.Instrument i ON i.Country='GB' -- TODO: cl.Country
    WHERE
        i.InstrumentId = @instrumentId
    AND c.ContractId = @swapId

END