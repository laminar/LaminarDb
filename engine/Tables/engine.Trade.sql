CREATE TABLE [engine].[Trade] (
    [TradeId]               BIGINT          NOT NULL,
    [SwapId]                BIGINT          NOT NULL,
    [InstrumentId]          BIGINT          NOT NULL,
    [TradeTypeId]           SMALLINT        NOT NULL,
    [OriginalTradeId]       BIGINT          NULL,
    [EffectiveDateTime]     DATETIME        NOT NULL,
    [Quantity]              DECIMAL (28, 8) NOT NULL,
    [CostPriceCcy]          CHAR (3)        NOT NULL,
    [CostPriceAmount]       DECIMAL (28, 8) NOT NULL,
    [CommissionValueCcy]    CHAR (3)        NULL,
    [CommissionValueAmount] DECIMAL (28, 8) NULL,
    PRIMARY KEY CLUSTERED ([TradeId] ASC)
);

