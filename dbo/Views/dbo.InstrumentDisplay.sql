
CREATE VIEW dbo.InstrumentDisplay as 
	SELECT
	   i.InstrumentId as InstrumentId, i.Version as InstrumentVersion, 
	   i.Code as InstrumentCode, i.Name as InstrumentName,
	   i.LastActionById as LastActionByIdUserId, i.LastActionWhen,
	   i.Ccy as Ccy, i.Country as Country, i.Type as Type, 
	   u.Name as LastActionByIdUserName
	FROM dbo.Instrument i
left join dbo.SystemUser u on i.LastActionById = u.UserId