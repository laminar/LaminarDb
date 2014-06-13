CREATE TABLE [dbo].[Fund] (
    [FundId]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Name]           VARCHAR (50) NULL,
    [Code]           VARCHAR (20) NULL,
    [ClientId]       BIGINT       NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Fund]
    ON [dbo].[Fund]([FundId] ASC);

