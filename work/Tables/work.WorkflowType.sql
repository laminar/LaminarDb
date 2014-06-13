CREATE TABLE [work].[WorkflowType] (
    [WorkflowTypeId]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]                  VARCHAR (50)  NOT NULL,
    [InitialWorkflowTaskId] INT           NOT NULL,
    [Description]           VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([WorkflowTypeId] ASC)
);

