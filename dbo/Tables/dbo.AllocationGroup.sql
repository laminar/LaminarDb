﻿CREATE TABLE [dbo].[AllocationGroup] (
    [AllocationGroupId] BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]           INT          NULL,
    [LastActionWhen]    DATETIME     NULL,
    [LastActionById]    BIGINT       NULL,
    [Code]              VARCHAR (20) NULL,
    [Name]              VARCHAR (50) NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_AllocationGroup]
    ON [dbo].[AllocationGroup]([AllocationGroupId] ASC);

