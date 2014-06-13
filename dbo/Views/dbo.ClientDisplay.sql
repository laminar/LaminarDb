

CREATE VIEW dbo.ClientDisplay AS
	SELECT
	   c.ClientId as ClientId, c.Version as ClientVersion, 
	   c.Code as ClientCode, c.Name as ClientName,
	   c.LastActionById as LastActionByIdUserId, c.LastActionWhen,
	   u.Name as LastActionByIdUserName
   
	FROM dbo.Client c 
left join dbo.SystemUser u on c.LastActionById = u.UserId