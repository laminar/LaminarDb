CREATE TABLE [engine].[Cash] (
    [CashId]                BIGINT          NOT NULL,
    [SwapId]                BIGINT          NOT NULL,
    [InstrumentId]          BIGINT          NOT NULL,
    [CashTypeId]            SMALLINT        NOT NULL,
    [Ccy]                   CHAR (3)        NOT NULL,
    [Amount]                DECIMAL (28, 8) NOT NULL,
    [AccrualDate]           DATE            NOT NULL,
    [PaymentScheduleTypeId] SMALLINT        NOT NULL,
    PRIMARY KEY CLUSTERED ([CashId] ASC)
);

