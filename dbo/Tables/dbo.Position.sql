CREATE TABLE [dbo].[Position] (
    [LastActionWhen] DATETIME         NULL,
    [LastActionById] INT              NULL,
    [ContractId]     INT              NULL,
    [InstrumentId]   INT              NULL,
    [Quantity]       DECIMAL (28, 10) NULL,
    [AvgCost]        DECIMAL (28, 10) NULL,
    [PositionDate]   DATETIME         NULL
);


GO
CREATE CLUSTERED INDEX [PK_dbo_Position]
    ON [dbo].[Position]([ContractId] ASC, [InstrumentId] ASC, [PositionDate] ASC);

