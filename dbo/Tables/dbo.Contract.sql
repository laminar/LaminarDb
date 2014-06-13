CREATE TABLE [dbo].[Contract] (
    [ContractId]          BIGINT       IDENTITY (1, 1) NOT NULL,
    [Version]             INT          DEFAULT ((1)) NOT NULL,
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
    [FundId]              BIGINT       NULL
);








GO
CREATE CLUSTERED INDEX [PK_dbo_Contract]
    ON [dbo].[Contract]([ContractId] ASC);

