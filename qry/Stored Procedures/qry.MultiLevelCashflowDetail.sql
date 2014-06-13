CREATE PROCEDURE qry.MultiLevelCashflowDetail
(
	@ClientId		bigint = NULL,
	@FundId			bigint = NULL,
	@ContractId		bigint = NULL
)
AS
BEGIN
	SELECT
		p.PayDate,
		c.SwapID as ContractId,
		s.Name as ContractName,
		c.InstrumentId as InstrumentId,
		i.Name as InstrumebontName,
		i.Code as RIC,
		p.Ccy,
		p.Amount,
		ct.Name,
		c.AccrualDate
	FROM engine.Cash c
	JOIN engine.CashType ct ON ct.CashTypeId=c.CashTypeId
	JOIN engine.Payment p ON p.CashId = c.CashId
	JOIN dbo.Contract s ON s.ContractId = c.SwapId
	JOIN dbo.Fund f ON f.FundId = s.FundId
	JOIN dbo.Client cl ON cl.ClientId = f.ClientId
	JOIN dbo.Instrument i ON i.InstrumentId = c.InstrumentId
	WHERE ISNULL(@ClientId,cl.ClientId) = cl.ClientId 
	AND   ISNULL(@FundId,f.FundId) = f.FundId
	AND   ISNULL(ContractId,s.ContractId) = s.ContractId
END