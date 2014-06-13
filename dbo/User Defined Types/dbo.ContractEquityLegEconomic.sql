CREATE TYPE [dbo].[ContractEquityLegEconomic] AS TABLE (
    [ContractEquityLegEconomicId] BIGINT           NULL,
    [ContractId]                  BIGINT           NULL,
    [ContractLegId]               BIGINT           NULL,
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
    [IsNetCommission]             BIT              NULL);

