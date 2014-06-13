CREATE TABLE [engine].[DailyPosition] (
    [DailyPositionId]        BIGINT          NOT NULL,
    [SwapId]                 BIGINT          NOT NULL,
    [InstrumentId]           BIGINT          NOT NULL,
    [Date]                   DATE            NOT NULL,
    [Quantity]               DECIMAL (28, 8) NOT NULL,
    [CostNotionalCcy]        CHAR (3)        NOT NULL,
    [CostNotionalAmount]     DECIMAL (28, 8) NOT NULL,
    [AverageCostPriceCcy]    CHAR (3)        NOT NULL,
    [AverageCostPriceAmount] DECIMAL (28, 8) NOT NULL,
    PRIMARY KEY CLUSTERED ([DailyPositionId] ASC)
);

