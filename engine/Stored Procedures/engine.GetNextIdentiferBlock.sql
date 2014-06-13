
CREATE PROCEDURE engine.GetNextIdentiferBlock
(
    @entityTypeId           BIGINT,
    @numberRequested        INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @number     INT;

    SELECT
        @number =   CASE
                        WHEN @numberRequested IS NULL THEN IdentifierAutoIncrement
                        WHEN @numberRequested > IdentifierMaxIncrement THEN IdentifierMaxIncrement
                        ELSE @numberRequested
                    END
    FROM engine.EntityIdentifer
    WHERE
        EntityTypeId=@entityTypeId

    -- update the identifier and return the results
    UPDATE ei
    SET
        NextIdentifier = ei.NextIdentifier + @number
    OUTPUT
        deleted.NextIdentifier AS [NextIdentifier],
        @number AS [BlockSize]
    FROM engine.EntityIdentifer ei
    WHERE
        EntityTypeId=@entityTypeId
END