
CREATE PROCEDURE [support].[ReportIncorrectUpdateKeyInfo]
(
   @objectType varchar(100),
   @method varchar(100),
   @Version int,
   @keyInfo support.KeyInfo READONLY
)
AS
BEGIN
   IF  NOT EXISTS (SELECT 1 FROM @keyInfo ) 
   BEGIN
      exec support.ReportValidationError @objectType, @method, 'Id','Id does not exist.'
   END
   ELSE IF  NOT EXISTS (SELECT 1 FROM @keyInfo WHERE Version = @Version)
   BEGIN
      exec support.ReportValidationError @objectType, @method,'Version','Version does not exist.'
   END
   ELSE 
   BEGIN
      exec support.ReportValidationError @objectType, @method, '?','Unknown Issue.'
   END
END