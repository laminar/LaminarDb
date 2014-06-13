CREATE TABLE [dbo].[ContractEquityLegSchedule] (
    [ContractEquityLegScheduleId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ContractId]                  BIGINT   NULL,
    [ContractLegId]               BIGINT   NULL,
    [ResetDate]                   DATETIME NULL,
    [PayDate]                     DATETIME NULL
);






GO


