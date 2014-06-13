CREATE PROCEDURE [dbo].[Trade_Delete]
(
   @TradeId              bigint              ,
   @Version              int                 ,
   @returnValues bit =1
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

         exec support.ReportIncorrectUpdateKeyInfo 'Trade', 'Delete', @Version,  @keyInfo
         RETURN
      END      
  
  
      BEGIN TRAN


         DELETE  dbo.Trade WHERE TradeId=@TradeId AND Version=@Version

         SELECT 'Keys' as ResultType
         SELECT Id,Version FROM @keyInfo
      COMMIT TRAN
      
  END TRY
  BEGIN CATCH
     IF @@TRANCOUNT > 0
           ROLLBACK TRAN --RollBack in case of Error
      exec support.ReportSqlError   
  END CATCH;

END