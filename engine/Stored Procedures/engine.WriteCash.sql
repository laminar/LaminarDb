
CREATE PROCEDURE engine.WriteCash
(
    @cash           engine.CashTableType       READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.Cash
    (
        CashId,
        SwapId,
        InstrumentId,
        CashTypeId,
        Ccy,
        Amount,
        AccrualDate,
        PaymentScheduleTypeId
    )
    SELECT
        CashId,
        SwapId,
        InstrumentId,
        CashTypeId,
        Ccy,
        Amount,
        AccrualDate,
        PaymentScheduleTypeId
    FROM @cash

END