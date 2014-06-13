CREATE TABLE [dbo].[ContractInterestLegSchedule] (
    [ContractInterestLegScheduleId] BIGINT   IDENTITY (1, 1) NOT NULL,
    [ContractId]                    BIGINT   NOT NULL,
    [ContractLegId]                 BIGINT   NOT NULL,
    [AccrualStartDate]              DATETIME NULL,
    [AccrualEndDate]                DATETIME NULL,
    [PayDate]                       DATETIME NULL
);






GO


