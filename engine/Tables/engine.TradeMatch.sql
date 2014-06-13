CREATE TABLE [engine].[TradeMatch] (
    [TradeMatchId] BIGINT          NOT NULL,
    [OpenTradeId]  BIGINT          NOT NULL,
    [CloseTradeId] BIGINT          NOT NULL,
    [Quantity]     DECIMAL (28, 8) NOT NULL,
    [MatchDate]    DATE            NOT NULL,
    PRIMARY KEY CLUSTERED ([TradeMatchId] ASC)
);

