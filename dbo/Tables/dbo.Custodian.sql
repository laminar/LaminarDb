CREATE TABLE [dbo].[Custodian] (
    [CustodianId]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]        INT          NULL,
    [LastActionWhen] DATETIME     NULL,
    [LastActionById] BIGINT       NULL,
    [Code]           VARCHAR (20) NULL,
    [Name]           VARCHAR (50) NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Custodian]
    ON [dbo].[Custodian]([CustodianId] ASC);

