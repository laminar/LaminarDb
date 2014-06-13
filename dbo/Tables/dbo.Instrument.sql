CREATE TABLE [dbo].[Instrument] (
    [InstrumentId]   BIGINT           IDENTITY (1, 1) NOT NULL,
    [Version]        INT           NULL,
    [LastActionWhen] DATETIME      NULL,
    [LastActionById] BIGINT           NULL,
    [Type]           VARCHAR (100) NULL,
    [Code]           VARCHAR (100) NULL,
    [Name]           VARCHAR (100) NULL,
    [Country]        VARCHAR (3)   NULL,
    [Ccy]            VARCHAR (3)   NULL
);




GO


