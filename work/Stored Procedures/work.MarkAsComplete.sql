
CREATE PROCEDURE work.MarkAsComplete
(
    @workItemId             INT
)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION
        
        
        UPDATE wi
        SET
            SystemStatusId = 6,         -- Complete
            [Timeout] = NULL
        FROM work.WorkItem wi
        WHERE
            wi.SystemStatusId = 2
        AND wi.WorkItemId = @workItemId


        SELECT
            CONVERT(BIT, CASE WHEN (@@ROWCOUNT = 1) THEN 1 ELSE 0 END) AS Result

    COMMIT
END