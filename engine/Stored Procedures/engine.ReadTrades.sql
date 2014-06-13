
CREATE PROCEDURE engine.ReadTrades
(
    @swapId                     BIGINT,
    @instrumentId               BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        t.TradeId AS TradeId,
        1 AS TradeTypeId,
        t.TradeId AS OriginalTradeId,
        t.SettleDate AS EffectiveDateTime,
        t.Quantity AS Quantity,
        t.SwapPriceCcy AS CostPriceCcy,
        t.SwapPrice AS CostPriceAmount,
        NULL AS CommissionCcy,
        NULL AS CommissionAmount
    FROM dbo.Trade t
    WHERE
        t.InstrumentId = @instrumentId
    AND t.ContractId = @swapId

END