CREATE TABLE [dbo].[BusinessRegion] (
    [BusinessRegionId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]          INT          DEFAULT ((1)) NOT NULL,
    [LastActionWhen]   DATETIME     NULL,
    [LastActionById]   BIGINT       NULL,
    [Code]             VARCHAR (20) NULL,
    [Name]             VARCHAR (50) NULL
);




GO
CREATE CLUSTERED INDEX [PK_dbo_BusinessRegion]
    ON [dbo].[BusinessRegion]([BusinessRegionId] ASC);

