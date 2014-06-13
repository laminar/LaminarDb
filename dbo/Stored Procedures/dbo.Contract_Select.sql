CREATE PROCEDURE dbo.Contract_Select
(
   @ContractId bigint
)
AS
BEGIN
   select * from dbo.Contract WHERE ContractId = @ContractId
   select * from dbo.ContractLeg WHERE ContractId = @ContractId
   select * from dbo.ContractEquityLegEconomic WHERE ContractId = @ContractId
   select * from dbo.ContractEquityLegSchedule WHERE ContractId = @ContractId
   select * from dbo.ContractInterestLegEconomic WHERE ContractId = @ContractId
   select * from dbo.ContractInterestLegSchedule WHERE ContractId = @ContractId
   
END