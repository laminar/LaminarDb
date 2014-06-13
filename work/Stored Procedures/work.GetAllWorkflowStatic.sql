
CREATE PROCEDURE work.GetAllWorkflowStatic
AS
BEGIN
    SET NOCOUNT ON;
    

    SELECT
        WorkflowTaskId,
        Name
    FROM work.WorkflowTask

END