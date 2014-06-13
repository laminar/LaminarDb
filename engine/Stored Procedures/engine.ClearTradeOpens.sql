
CREATE PROCEDURE engine.ClearTradeOpens
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM op
    FROM engine.TradeOpen op
    JOIN engine.Trade t
                ON  t.TradeId=op.OpenTradeId
    WHERE
        t.SwapId=@swapId
    AND t.InstrumentId=@instrumentId

    DELETE
    FROM op
    FROM engine.TradeOpen op
    JOIN dbo.Trade t
                ON  t.TradeId=op.OpenTradeId
    WHERE
        t.ContractId=@swapId
    AND t.InstrumentId=@instrumentId


END