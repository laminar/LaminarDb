
CREATE FUNCTION work.MakeJSON2
(
    @k1 varchar(100) ,
    @v1 varchar(max) ,
    @k2 varchar(100) ,
    @v2 varchar(max) 
)
RETURNS varchar(max)
AS
BEGIN
    DECLARE @json varchar(max) = ''

    SELECT @json = @json + '{"' + @k1 + '":' + @v1 + ','
    SELECT @json = @json + '"'  + @k2 + '":' + @v2 + '}'
    

    RETURN @json
END

--SELECT work.MakeJSON2('TradeId', 17, 'Version', 1 )