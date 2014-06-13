
CREATE PROCEDURE engine.ClearPayments
(
    @swapId                 BIGINT,
    @instrumentId           BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
    FROM p
    FROM engine.Payment p
    JOIN engine.Cash c
                ON  c.CashId=p.CashId
    WHERE
        c.SwapId=@swapId
    AND c.InstrumentId=@instrumentId

END