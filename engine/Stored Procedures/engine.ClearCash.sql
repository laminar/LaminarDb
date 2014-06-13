
CREATE PROCEDURE engine.ClearCash
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM c
    FROM engine.Cash c
    WHERE
        c.SwapId=@swapId
    AND c.InstrumentId=@instrumentId

END