CREATE TABLE [dbo].[ContractInterestLegEconomic] (
    [ContractInterestLegEconomicId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [ContractId]                        BIGINT           NOT NULL,
    [ContractLegId]                     BIGINT           NOT NULL,
    [AsOfDate]                          DATETIME         NULL,
    [AccrualBasis]                      INT              NULL,
    [InterestOffsetDays]                INT              NULL,
    [InterestPaymentBasis]              INT              NULL,
    [BorrowCostShortSpread]             DECIMAL (28, 10) NULL,
    [BorrowCostNotionalBasis]           INT              NULL,
    [PayToHoldNotionalBasis]            INT              NULL,
    [SpreadCalculationBasis]            INT              NULL,
    [InterestLongSpread]                DECIMAL (28, 10) NULL,
    [InterestShortSpread]               DECIMAL (28, 10) NULL,
    [IsNewRateOnIntraPeriodIncrease]    BIT              NULL,
    [IsNewRateOnIntraPeriodDecrease]    BIT              NULL,
    [ReferenceInterestRateInstrumentId] BIGINT           NULL,
    [InitialStubRate]                   DECIMAL (28, 10) NULL,
    [FinalStubRate]                     DECIMAL (28, 10) NULL,
    [IsDailyResetting]                  BIT              NULL,
    [IsNetFinancing]                    BIT              NULL,
    [IsFinanceRealisedGains]            BIT              NULL,
    [IsNewRateOnRealisedGains]          BIT              NULL,
    [RealisedGainLongSpread]            DECIMAL (28, 10) NULL,
    [RealisedGainShortSpread]           DECIMAL (28, 10) NULL,
    [IsFinanceDividends]                BIT              NULL,
    [IsNewRateOnDividends]              BIT              NULL,
    [DividendsLongSpread]               DECIMAL (28, 10) NULL,
    [DividendsShortSpread]              DECIMAL (28, 10) NULL
);








GO


