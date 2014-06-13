
CREATE FUNCTION sample.GetShortCode
(
   @name varchar(MAX)
)
RETURNS varchar(MAX)
AS
BEGIN
   --Get all upper case letters
   declare @i int, @l int, @code varchar(MAX) =''
   declare @ascii int
   select @i=1, @l=len(@name)

   select @name = replace(@name,'LLC','')
   select @name = replace(@name,'L.L.C.','')
   while @i<=@l
   begin
      select @ascii = ascii(substring(@name,@i,1))
      if(@ascii>=65 and @ascii<=90)
      begin
         select @code = @code + substring(@name,@i,1)
      end
      select @i=@i+1
   end
   RETURN @code
END