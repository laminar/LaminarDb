
CREATE PROCEDURE engine.WriteTradeMatches
(
    @tradeMatches       engine.TradeMatchTableType        READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.TradeMatch
    (
        TradeMatchId,
        OpenTradeId,
        CloseTradeId,
        Quantity,
        MatchDate
    )
    SELECT
        TradeMatchId,
        OpenTradeId,
        CloseTradeId,
        Quantity,
        MatchDate
    FROM @tradeMatches

END