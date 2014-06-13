
CREATE VIEW dbo.PriceDisplay AS
	SELECT
	   p.PriceId as PriceId, p.Ccy as PriceCcy, p.Price as Price, p.Date as PriceDate,
	   i.InstrumentId as InstrumentId, i.Code as InstrumentCode, i.Name as InstrumentName,
	   p.LastActionById as LastActionByIdUserId, p.LastActionWhen,
	   u.Name as LastActionByIdUserName
	FROM dbo.Price p
	join  dbo.Instrument i on i.InstrumentId = p.InstrumentId
	left join dbo.SystemUser u on p.LastActionById = u.UserId