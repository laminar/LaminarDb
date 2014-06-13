CREATE TABLE [engine].[TradeType] (
    [TradeTypeId] SMALLINT      NOT NULL,
    [Code]        CHAR (2)      NULL,
    [Name]        VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([TradeTypeId] ASC)
);

