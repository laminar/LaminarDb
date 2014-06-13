
CREATE PROCEDURE [support].[ReportValidationError]
(
   @objectType varchar(100),
   @method varchar(100),
   @keys varchar(100),
   @message varchar(500)
)
AS
BEGIN
      SELECT 'ValidationError' as ResultType
      SELECT @objectType as ObjectType, @method as Method,  @keys as Keys, @message as Message
END