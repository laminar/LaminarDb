
CREATE PROCEDURE work.GetAllWork
(
    @workflowTaskIds            dbo.IntList READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE wi
    SET
        wi.SystemStatusId=3             -- Timed-out
    FROM work.WorkItem wi
    WHERE
        wi.SystemStatusId=2             -- Processing
    AND wi.[Timeout]>=GETUTCDATE()


    UPDATE wi
    SET
        wi.SystemStatusId=wft.SystemStatusIdOnTimeOut
    FROM work.WorkItem wi
    JOIN work.WorkflowTask wft
            ON  wft.WorkflowTaskId=wi.WorkflowTaskId
    WHERE
        wi.SystemStatusId = 3           -- Timed-out



    SELECT
        WorkItemId,
        WorkflowTaskId,
        OriginId,
        JsonData
    FROM work.WorkItem wi
    WHERE
        WorkflowTaskId IN (SELECT WorkflowTaskId FROM @workflowTaskIds)
    AND SystemStatusId IN (1, 4)
    ORDER BY WorkItemId ASC
END