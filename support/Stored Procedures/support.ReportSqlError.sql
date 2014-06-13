
CREATE PROCEDURE support.ReportSqlError
AS
BEGIN
      SELECT 'SqlError' as ResultType
      SELECT 
         ERROR_NUMBER() AS ErrorNumber, 
         ERROR_SEVERITY() AS ErrorSeverity, 
         ERROR_STATE() AS ErrorState, 
         ERROR_PROCEDURE() AS ErrorProcedure, 
         ERROR_LINE() AS ErrorLine, 
         ERROR_MESSAGE() AS ErrorMessage;
END