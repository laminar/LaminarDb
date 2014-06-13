CREATE TABLE [engine].[TradeMatchOrder] (
    [TradeMatchOrderId] SMALLINT      NOT NULL,
    [Code]              CHAR (4)      NULL,
    [Name]              VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([TradeMatchOrderId] ASC)
);

