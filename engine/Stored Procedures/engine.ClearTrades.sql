
CREATE PROCEDURE engine.ClearTrades
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM t
    FROM engine.Trade t
    WHERE
        t.SwapId=@swapId
    AND t.InstrumentId=@instrumentId

END