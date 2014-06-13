CREATE PROCEDURE [dbo].[Trade_Update]
(
   @TradeId              bigint              ,
   @Version              int                 ,
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
   @SwapPriceCcy				 varchar(3)          ,
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
  
  
      IF NOT EXISTS (SELECT 1 FROM dbo.Trade WHERE TradeId=@TradeId AND Version=@Version )
      BEGIN
         INSERT INTO @keyInfo 
         SELECT TradeId, Version
         FROM dbo.Trade WHERE TradeId=@TradeId 

         exec support.ReportIncorrectUpdateKeyInfo 'Trade', 'Update', @Version,  @keyInfo
         RETURN
      END      
  
      BEGIN TRAN

        
         UPDATE dbo.Trade 
         SET 
            LastActionWhen = @LastActionWhen,
            LastActionById = @LastActionById,
            ClientId = @ClientId,
            FundId = @FundId,
            ContractId = @ContractId,
            AllocationGroupId = @AllocationGroupId,
            TradeDirection = @TradeDirection,
            InstrumentId = @InstrumentId,
            CounterpartyId = @CounterpartyId,
            CustodianId = @CustodianId,
            Quantity = @Quantity,
            TradeDate = @TradeDate,
            SettleDate = @SettleDate,
            CommissionBasis = @CommissionBasis,
            TotalCommission = @TotalCommission,
            SettleCcy = @SettleCcy,
            SettlePrice = @SettlePrice,
            SettleFx = @SettleFx,
            IsNetPriced = @IsNetPriced,
            SwapPriceCcy = @SwapPriceCcy,
            SwapPrice = @SwapPrice,
            TradeSpread = @TradeSpread,
            BorrowCost = @BorrowCost,
            TotalSettleNotional = @TotalSettleNotional,
            TotalSwapNotional = @TotalSwapNotional,
            TradeStatus = @TradeStatus,
            TradeWorkflowStatus = @TradeWorkflowStatus,
            TradeType = @TradeType,
            Version = Version + 1
		 OUTPUT inserted.TradeId, inserted.Version INTO @keyInfo
         WHERE TradeId=@TradeId AND Version=@Version

         DECLARE @json varchar(max) = (SELECT work.MakeJSON2('TradeId', Id, 'Version', Version ) FROM @keyInfo)
         exec work.StartWorkflow 'Trade' , @json
 

         IF @ReturnValues = 1 
         BEGIN
            SELECT 'Keys' as ResultType
            SELECT Id,Version FROM @keyInfo
         END
      COMMIT TRAN
      
   END TRY
   BEGIN CATCH
     IF @@TRANCOUNT > 0
           ROLLBACK TRAN --RollBack in case of Error
      exec support.ReportSqlError   
   END CATCH;

END