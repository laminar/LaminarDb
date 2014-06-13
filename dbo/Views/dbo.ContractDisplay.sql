


CREATE  VIEW [dbo].[ContractDisplay]
AS
   select 
      c.ClientId as ClientId,c.code as ClientCode,c.Name as ClientName,
      f.FundId as FundId,f.code as FundCode,f.Name as FundName,
      s.ContractId as ContractId, s.Version as ContractVersion, s.Code as ContractCode,s.Name as ContractName,
      s.StartDate, s.EndDate, s.EffectiveDate,
      s.AccrualBasis,s.TradeMatchBasis,s.PayCcy,
      s.LastActionById as ContractLastActionById, s.LastActionWhen as ContractLastActionWhen
   from dbo.Client c
   left join dbo.Fund f on f.ClientId = c.ClientId
   left join dbo.Contract s on s.FundId  = f.FundId
   left join dbo.SystemUser u on s.LastActionById = u.UserId