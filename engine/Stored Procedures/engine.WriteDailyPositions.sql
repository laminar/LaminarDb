
CREATE PROCEDURE engine.WriteDailyPositions
(
    @dailyPositions     engine.DailyPositionTableType      READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.DailyPosition
    (
        DailyPositionId,
        SwapId,
        InstrumentId,
        [Date],
        Quantity,
        CostNotionalCcy,
        CostNotionalAmount,
        AverageCostPriceCcy,
        AverageCostPriceAmount
    )
    SELECT
        DailyPositionId,
        SwapId,
        InstrumentId,
        [Date],
        Quantity,
        CostNotionalCcy,
        CostNotionalAmount,
        AverageCostPriceCcy,
        AverageCostPriceAmount
    FROM @dailyPositions

END