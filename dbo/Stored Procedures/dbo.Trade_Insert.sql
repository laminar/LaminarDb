CREATE PROCEDURE [dbo].[Trade_Insert]
(
   @LastActionWhen       datetime            ,
   @LastActionById       bigint              ,
   @ClientId             bigint              ,
   @FundId               bigint              ,
   @ContractId           bigint              ,
   @AllocationGroupId    bigint              ,
   @TradeDirection       int                 ,
   @InstrumentId         bigint              ,
   @CounterpartyId       bigint              ,
   @CustodianId          bigint              ,
   @Quantity             decimal(28,10)      ,
   @TradeDate            datetime            ,
   @SettleDate           datetime            ,
   @CommissionBasis      int                 ,
   @TotalCommission      decimal(28,10)      ,
   @SettleCcy            varchar(3)          ,
   @SettlePrice          decimal(28,10)      ,
   @SettleFx             decimal(28,10)      ,
   @IsNetPriced          bit                 ,
   @SwapPriceCcy         varchar(3)          ,
   @SwapPrice            decimal(28,10)      ,
   @TradeSpread          decimal(28,10)      ,
   @BorrowCost           decimal(28,10)      ,
   @TotalSettleNotional  decimal(28,10)      ,
   @TotalSwapNotional    decimal(28,10)      ,
   @TradeStatus          int                 ,
   @TradeWorkflowStatus  int                 ,
   @TradeType            int                 ,
   @ReturnValues		 bit =1
)
AS
BEGIN
   SET NOCOUNT ON
   BEGIN TRY
   
      --TODO: validation
      
     DECLARE @keyInfo AS support.KeyInfo
   
   
     BEGIN TRAN    
   
      INSERT dbo.Trade
      (
         LastActionWhen,
         LastActionById,
         ClientId,
         FundId,
         ContractId,
         AllocationGroupId,
         TradeDirection,
         InstrumentId,
         CounterpartyId,
         CustodianId,
         Quantity,
         TradeDate,
         SettleDate,
         CommissionBasis,
         TotalCommission,
         SettleCcy,
         SettlePrice,
         SettleFx,
         IsNetPriced,
         SwapPriceCcy,
         SwapPrice,
         TradeSpread,
         BorrowCost,
         TotalSettleNotional,
         TotalSwapNotional,
         TradeStatus,
         TradeWorkflowStatus,
         TradeType
      )
      OUTPUT inserted.TradeId, inserted.Version INTO @keyInfo
      VALUES
      (
         @LastActionWhen,
         @LastActionById,
         @ClientId,
         @FundId,
         @ContractId,
         @AllocationGroupId,
         @TradeDirection,
         @InstrumentId,
         @CounterpartyId,
         @CustodianId,
         @Quantity,
         @TradeDate,
         @SettleDate,
         @CommissionBasis,
         @TotalCommission,
         @SettleCcy,
         @SettlePrice,
         @SettleFx,
         @IsNetPriced,
         @SwapPriceCcy,
         @SwapPrice,
         @TradeSpread,
         @BorrowCost,
         @TotalSettleNotional,
         @TotalSwapNotional,
         @TradeStatus,
         @TradeWorkflowStatus,
         @TradeType
      )

     DECLARE @json varchar(max) = (SELECT work.MakeJSON2('TradeId', Id, 'Version', Version ) FROM @keyInfo)
     exec work.StartWorkflow 'Trade' , @json
     COMMIT TRAN

     IF @ReturnValues = 1
     BEGIN
      SELECT 'Keys' as ResultType
      SELECT Id,Version FROM @keyInfo
     END
         
   END TRY
   BEGIN CATCH
      IF @@TRANCOUNT > 0
           ROLLBACK TRAN --RollBack in case of Error

      exec support.ReportSqlError
   END CATCH;
END