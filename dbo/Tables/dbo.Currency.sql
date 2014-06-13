CREATE TABLE [dbo].[Currency] (
    [CurrencyId]     BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Name]           VARCHAR (100) NULL,
    [IsoCode]        VARCHAR (3)  NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Currency]
    ON [dbo].[Currency]([CurrencyId] ASC);

