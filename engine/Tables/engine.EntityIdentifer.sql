CREATE TABLE [engine].[EntityIdentifer] (
    [EntityTypeId]            BIGINT NOT NULL,
    [NextIdentifier]          BIGINT NOT NULL,
    [IdentifierAutoIncrement] INT    NOT NULL,
    [IdentifierMaxIncrement]  INT    NOT NULL,
    PRIMARY KEY CLUSTERED ([EntityTypeId] ASC)
);

