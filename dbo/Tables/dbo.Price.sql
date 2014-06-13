CREATE TABLE [dbo].[Price] (
    [LastActionWhen] DATETIME        NULL,
    [LastActionById] INT             NULL,
    [PriceId]        INT             NULL,
    [Version]        INT             NULL,
    [InstrumentId]   INT             NULL,
    [Source]         VARCHAR (20)    NULL,
    [Date]           DATETIME        NULL,
    [Ccy]            VARCHAR (3)     NULL,
    [Price]          DECIMAL (28, 8) NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Price]
    ON [dbo].[Price]([InstrumentId] ASC, [Date] ASC);

