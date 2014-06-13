
CREATE PROCEDURE engine.WriteTrades
(
    @trades             engine.TradeTableType        READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.Trade
    (
        TradeId,
        SwapId,
        InstrumentId,

        TradeTypeId,
        OriginalTradeId,
        EffectiveDateTime,
        Quantity,
        CostPriceCcy,
        CostPriceAmount,
        CommissionValueCcy,
        CommissionValueAmount
    )
    SELECT
        TradeId,
        SwapId,
        InstrumentId,
        TradeTypeId,
        OriginalTradeId,
        EffectiveDateTime,
        Quantity,
        CostPriceCcy,
        CostPriceAmount,
        CommissionValueCcy,
        CommissionValueAmount
    FROM @trades

END