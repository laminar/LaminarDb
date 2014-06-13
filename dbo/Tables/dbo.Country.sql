CREATE TABLE [dbo].[Country] (
    [CountryId]      BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Name]           VARCHAR (50) NULL,
    [IsoCode]        VARCHAR (3)  NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Country]
    ON [dbo].[Country]([CountryId] ASC);

