
CREATE PROCEDURE engine.ReadMarketPrices
(
	@instrumentId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		p.[Date],
		p.Ccy,
		p.Price AS Amount
	FROM dbo.Price p
	WHERE
		p.InstrumentId = @instrumentId

END