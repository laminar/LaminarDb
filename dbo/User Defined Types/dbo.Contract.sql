CREATE TYPE [dbo].[Contract] AS TABLE (
    [ContractId]          BIGINT       NULL,
    [Version]             INT          NULL,
    [LastActionWhen]      DATETIME     NULL,
    [LastActionById]      BIGINT       NULL,
    [Code]                VARCHAR (50) NULL,
    [Name]                VARCHAR (50) NULL,
    [StartDate]           DATETIME     NULL,
    [EndDate]             DATETIME     NULL,
    [EffectiveDate]       DATETIME     NULL,
    [PayCcy]              VARCHAR (3)  NULL,
    [AccrualBasis]        INT          NULL,
    [InterestOffsetDays]  INT          NULL,
    [TradeMatchBasis]     INT          NULL,
    [BusinessRegionId]    BIGINT       NULL,
    [Status]              INT          NULL,
    [ContractProductType] VARCHAR (50) NULL,
    [FundId]              BIGINT       NULL);

