

 CREATE VIEW dbo.TradeDisplay AS
   SELECT
      t.TradeId as TradeId, t.Version as TradeVersion, 
      t.TradeDate, t.SettleDate,  t.Quantity as TradeQuantity, t.SwapPrice as SwapPrice,  t.SwapPriceCcy,
      i. InstrumentId as InstrumentId, i.Code as InstrumentCode, i.Name as InstrumentName,
      s.ContractId as ContractId, s.Code as ContractCode,
      f.FundId as FundId, f.Code as FundCode,
      c.ClientId as ClientId, c.Code as ClientCode
   FROM dbo.Trade t
   left join dbo.Instrument i on i.InstrumentId = t.InstrumentId
   left join dbo.Contract s on s.ContractId = t.ContractId
   left join dbo.Fund f on f.FundId = s.FundId
   left join dbo.Client c on c.ClientId = f.ClientId