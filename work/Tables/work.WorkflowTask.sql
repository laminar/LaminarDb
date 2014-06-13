CREATE TABLE [work].[WorkflowTask] (
    [WorkflowTaskId]          INT          IDENTITY (1, 1) NOT NULL,
    [Name]                    VARCHAR (50) NOT NULL,
    [MaxRetryCount]           INT          NULL,
    [TimeOutSec]              INT          NOT NULL,
    [SystemStatusIdOnTimeOut] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([WorkflowTaskId] ASC)
);

