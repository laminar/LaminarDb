
CREATE PROCEDURE engine.WriteTradeOpens
(
    @tradeOpens         engine.TradeOpenTableType        READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.TradeOpen
    (
        TradeOpenId,
        OpenTradeId,
        Quantity,
        StartDate,
        EndDate
    )
    SELECT
        TradeOpenId,
        OpenTradeId,
        Quantity,
        StartDate,
        EndDate
    FROM @tradeOpens

END