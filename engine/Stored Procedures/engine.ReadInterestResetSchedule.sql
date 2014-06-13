
CREATE PROCEDURE engine.ReadInterestResetSchedule
(
    @swapId                     BIGINT,
    @instrumentId               BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        cils.AccrualEndDate AS ResetDate,   --TODO: Reflect the correct name in code
        cils.PayDate
    FROM dbo.Contract c
    JOIN dbo.ContractLeg cl ON cl.ContractId=c.ContractId
    JOIN dbo.ContractInterestLegSchedule cils ON cils.ContractId=c.ContractId AND cils.ContractLegId=cl.ContractLegId
    JOIN dbo.Instrument i ON i.Country='GB' -- TODO: cl.Country
    WHERE
        i.InstrumentId = @instrumentId
    AND c.ContractId = @swapId

    -- Inject psueudo resets from contract
    UNION
        SELECT
            c.EffectiveDate AS ResetDate,
            c.EffectiveDate AS PayDate
        FROM dbo.Contract c
        WHERE
            c.ContractId = @swapId
    UNION
        SELECT
            c.EndDate AS ResetDate,
            c.EndDate AS PayDate
        FROM dbo.Contract c
        WHERE
            c.ContractId = @swapId

END