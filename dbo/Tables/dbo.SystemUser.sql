CREATE TABLE [dbo].[SystemUser] (
    [UserId]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Name]           VARCHAR (50) NULL,
    [Code]           VARCHAR (20) NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_SystemUser]
    ON [dbo].[SystemUser]([UserId] ASC);

