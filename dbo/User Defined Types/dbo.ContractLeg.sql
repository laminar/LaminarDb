CREATE TYPE [dbo].[ContractLeg] AS TABLE (
    [ContractLegId] BIGINT      NULL,
    [ContractId]    BIGINT      NULL,
    [Ccy]           VARCHAR (3) NULL);

