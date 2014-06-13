
CREATE PROCEDURE engine.WritePayments
(
    @payments       engine.PaymentTableType        READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO engine.Payment
    (
        PaymentId,
        CashId,
        Ccy,
        Amount,
        PayDate
    )
    SELECT
        PaymentId,
        CashId,
        Ccy,
        Amount,
        PayDate
    FROM @payments

END