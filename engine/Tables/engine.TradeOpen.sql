CREATE TABLE [engine].[TradeOpen] (
    [TradeOpenId] BIGINT          NOT NULL,
    [OpenTradeId] BIGINT          NOT NULL,
    [Quantity]    DECIMAL (28, 8) NOT NULL,
    [StartDate]   DATE            NOT NULL,
    [EndDate]     DATE            NULL,
    PRIMARY KEY CLUSTERED ([TradeOpenId] ASC)
);

