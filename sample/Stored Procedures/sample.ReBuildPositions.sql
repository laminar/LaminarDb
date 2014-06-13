
CREATE PROCEDURE [sample].[ReBuildPositions]
(
   @LastActionWhen DateTime, 
   @LastActionById int
)
AS
BEGIN
   TRUNCATE TABLE dbo.Position 

   INSERT INTO dbo.Position 
   (LastActionWhen,LastActionById,ContractId,InstrumentId,Quantity,AvgCost,PositionDate)

   select 
         @LastActionWhen,
         @LastActionById,
         ContractId,
         InstrumentId,
         sum(Quantity) over(partition by ContractId,InstrumentId   order by tradedate rows unbounded preceding),
         CASE WHEN sum(Quantity) over(partition by ContractId,InstrumentId order by tradedate rows unbounded preceding) = 0 THEN 0 ELSE
         sum(Quantity*SwapPrice) over(partition by ContractId,InstrumentId order by tradedate rows unbounded preceding) 
         /sum(Quantity) over(partition by ContractId,InstrumentId order by tradedate rows unbounded preceding) END,
         tradedate
   from dbo.trade 

    SELECT 'Rebuilt ' + CAST((SELECT COUNT(*) FROM dbo.Position) AS VARCHAR(MAX)) + ' Positions'
END