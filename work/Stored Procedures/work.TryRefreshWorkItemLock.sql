
CREATE PROCEDURE work.TryRefreshWorkItemLock
(
    @workItemId             INT,
    @timout                 DATETIME    OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION
        
        
        UPDATE wi
        SET
            @timout   = DATEADD(SECOND, wft.TimeOutSec, GETUTCDATE()),
            [Timeout] = DATEADD(SECOND, wft.TimeOutSec, GETUTCDATE())
        FROM work.WorkItem wi
        JOIN work.WorkflowTask wft
                ON  wft.WorkflowTaskId=wi.WorkflowTaskId
        WHERE
            wi.SystemStatusId = 2
        AND wi.WorkItemId = @workItemId
    
        
        SELECT
            CONVERT(BIT, CASE WHEN (@@ROWCOUNT = 1) THEN 1 ELSE 0 END) AS Result


    COMMIT
END