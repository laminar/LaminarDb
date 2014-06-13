CREATE PROCEDURE [sample].[WorkflowSetup]
AS
BEGIN
    SET NOCOUNT ON
    TRUNCATE TABLE work.Origin
    TRUNCATE TABLE work.SystemStatus
    TRUNCATE TABLE work.WorkflowTask
    TRUNCATE TABLE work.WorkflowType
    TRUNCATE TABLE work.WorkItem

    INSERT INTO work.WorkflowType (Name, InitialWorkflowTaskId)
    VALUES
    ('Trade', 1),
    ('Contract', 3)


    INSERT INTO work.WorkflowTask (Name, MaxRetryCount, TimeoutSec, SystemStatusIdOnTimeOut)
    VALUES
    ('Trade.Entry', NULL, 30, 4),
    ('Trade.Approved', NULL, 30, 4),
    ('Contract.Entry', NULL, 30, 4),
    ('Contract.Approved', NULL, 30, 4)


END