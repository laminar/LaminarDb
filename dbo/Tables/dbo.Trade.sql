CREATE TABLE [dbo].[Trade] (
    [TradeId]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [Version]             INT              CONSTRAINT [DF_Trade_Version] DEFAULT ((1)) NULL,
    [LastActionWhen]      DATETIME         NULL,
    [LastActionById]      BIGINT           NULL,
    [ClientId]            BIGINT           NULL,
    [FundId]              BIGINT           NULL,
    [ContractId]          BIGINT           NULL,
    [AllocationGroupId]   BIGINT           NULL,
    [TradeDirection]      INT              NULL,
    [InstrumentId]        BIGINT           NULL,
    [CounterpartyId]      BIGINT           NULL,
    [CustodianId]         BIGINT           NULL,
    [Quantity]            DECIMAL (28, 10) NULL,
    [TradeDate]           DATETIME         NULL,
    [SettleDate]          DATETIME         NULL,
    [CommissionBasis]     INT              NULL,
    [TotalCommission]     DECIMAL (28, 10) NULL,
    [SettleCcy]           VARCHAR (3)      NULL,
    [SettlePrice]         DECIMAL (28, 10) NULL,
    [SettleFx]            DECIMAL (28, 10) NULL,
    [IsNetPriced]         BIT              NULL,
    [SwapPriceCcy]        VARCHAR (3)      NULL,
    [SwapPrice]           DECIMAL (28, 10) NULL,
    [TradeSpread]         DECIMAL (28, 10) NULL,
    [BorrowCost]          DECIMAL (28, 10) NULL,
    [TotalSettleNotional] DECIMAL (28, 10) NULL,
    [TotalSwapNotional]   DECIMAL (28, 10) NULL,
    [TradeStatus]         INT              NULL,
    [TradeWorkflowStatus] INT              NULL,
    [TradeType]           INT              NULL
);








GO
CREATE CLUSTERED INDEX [PK_dbo_Trade]
    ON [dbo].[Trade]([ContractId] ASC, [InstrumentId] ASC, [TradeDate] ASC);



