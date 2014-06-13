CREATE TABLE [dbo].[Client] (
    [ClientId]       BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Code]           VARCHAR (20) NULL,
    [Name]           VARCHAR (50) NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Client]
    ON [dbo].[Client]([ClientId] ASC);

