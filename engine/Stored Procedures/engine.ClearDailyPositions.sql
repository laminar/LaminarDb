
CREATE PROCEDURE engine.ClearDailyPositions
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM dp
    FROM engine.DailyPosition dp
    WHERE
        dp.SwapId=@swapId
    AND dp.InstrumentId=@instrumentId

END