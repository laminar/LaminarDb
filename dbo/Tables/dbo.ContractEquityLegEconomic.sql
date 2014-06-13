CREATE TABLE [dbo].[ContractEquityLegEconomic] (
    [ContractEquityLegEconomicId] BIGINT           IDENTITY (1, 1) NOT NULL,
    [ContractId]                  BIGINT           NOT NULL,
    [ContractLegId]               BIGINT           NOT NULL,
    [AsOfDate]                    DATETIME         NULL,
    [LongEntitlementSpread]       DECIMAL (28, 10) NULL,
    [ShortEntitlementSpread]      DECIMAL (28, 10) NULL,
    [MarginBasis]                 INT              NULL,
    [ResetQuantityBasis]          INT              NULL,
    [RealisedGainPaymentBasis]    INT              NULL,
    [EntitlementPaymentBasis]     INT              NULL,
    [EntitlementFxPaymentBasis]   INT              NULL,
    [EntitlementFxOffsetDays]     INT              NULL,
    [CommissionBasis]             INT              NULL,
    [CommissionPaymentBasis]      INT              NULL,
    [DefaultCommissionAmount]     DECIMAL (28, 10) NULL,
    [IsNetCommission]             BIT              NULL
);






GO


