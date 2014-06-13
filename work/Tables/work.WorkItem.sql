CREATE TABLE [work].[WorkItem] (
    [WorkItemId]     BIGINT           IDENTITY (1, 1) NOT NULL,
    [WorkflowTaskId] INT              NOT NULL,
    [OriginId]       UNIQUEIDENTIFIER NOT NULL,
    [SystemStatusId] INT              NOT NULL,
    [JsonData]       VARCHAR (MAX)    NOT NULL,
    [RetryCount]     INT              DEFAULT ((0)) NOT NULL,
    [Timeout]        DATETIME         NULL,
    PRIMARY KEY CLUSTERED ([WorkItemId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX__WorkItem__Timeout]
    ON [work].[WorkItem]([Timeout] ASC)
    INCLUDE([SystemStatusId]) WHERE ([SystemStatusId]=(2));


GO
CREATE NONCLUSTERED INDEX [IX__WorkItem__TryGetWork]
    ON [work].[WorkItem]([SystemStatusId] ASC, [WorkflowTaskId] ASC, [WorkItemId] ASC);

