
CREATE PROCEDURE engine.ReadInterestRates
(
	@interestRateTenorId		BIGINT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		ir.[Date],
		ir.Price AS Rate
	FROM dbo.Price ir
	WHERE
		ir.InstrumentId = @interestRateTenorId

END