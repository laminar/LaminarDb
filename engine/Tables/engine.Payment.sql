CREATE TABLE [engine].[Payment] (
    [PaymentId] BIGINT          NOT NULL,
    [CashId]    BIGINT          NOT NULL,
    [Ccy]       CHAR (3)        NOT NULL,
    [Amount]    DECIMAL (28, 8) NOT NULL,
    [PayDate]   DATE            NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentId] ASC)
);

