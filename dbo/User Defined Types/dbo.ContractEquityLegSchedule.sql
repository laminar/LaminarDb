CREATE TYPE [dbo].[ContractEquityLegSchedule] AS TABLE (
    [ContractEquityLegScheduleId] BIGINT   NULL,
    [ContractId]                  BIGINT   NULL,
    [ContractLegId]               BIGINT   NULL,
    [ResetDate]                   DATETIME NULL,
    [PayDate]                     DATETIME NULL);

