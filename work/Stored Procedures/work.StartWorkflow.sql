
CREATE PROCEDURE work.StartWorkflow
(
-- TODO: Use ID
--    @workflowTypeId         INT,
    @workflowTypeName       VARCHAR(50),
    @jsonData               VARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;
    

    INSERT INTO work.WorkItem (WorkflowTaskId, OriginId, SystemStatusId, JsonData)
    SELECT
        InitialWorkflowTaskId,
        NEWID(),
        1,
        @jsonData
    FROM work.WorkflowType wf_type
    JOIN work.WorkflowTask wf_task
            ON  wf_task.WorkflowTaskId=wf_type.InitialWorkflowTaskId
    WHERE
        wf_type.Name = @workflowTypeName;

END