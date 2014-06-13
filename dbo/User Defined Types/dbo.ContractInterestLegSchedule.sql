CREATE TYPE [dbo].[ContractInterestLegSchedule] AS TABLE (
    [ContractInterestLegScheduleId] BIGINT   NULL,
    [ContractId]                    BIGINT   NULL,
    [ContractLegId]                 BIGINT   NULL,
    [AccrualStartDate]              DATETIME NULL,
    [AccrualEndDate]                DATETIME NULL,
    [PayDate]                       DATETIME NULL);

