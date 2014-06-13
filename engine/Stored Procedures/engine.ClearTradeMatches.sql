
CREATE PROCEDURE engine.ClearTradeMatches
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM tm
    FROM engine.TradeMatch tm
    JOIN engine.Trade t
                ON  t.TradeId=tm.OpenTradeId
    WHERE
        t.SwapId=@swapId
    AND t.InstrumentId=@instrumentId

    DELETE
    FROM tm
    FROM engine.TradeMatch tm
    JOIN dbo.Trade t
                ON  t.TradeId=tm.OpenTradeId
    WHERE
        t.ContractId=@swapId
    AND t.InstrumentId=@instrumentId

END