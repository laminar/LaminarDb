CREATE FUNCTION work.MakeJSON1
(
    @k1 varchar(100) ,
    @v1 varchar(max) 
)
RETURNS varchar(max)
AS
BEGIN
    DECLARE @json varchar(max) = ''

    SELECT @json = @json + '{"' + @k1 + '":' + @v1 + '}'
    

    RETURN @json
END