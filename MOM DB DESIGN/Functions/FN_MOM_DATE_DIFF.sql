CREATE FUNCTION dbo.FN_MOM_DATE_DIFF 
( 
    @d1 DATETIME, 
    @d2 DATETIME 
) 
RETURNS VARCHAR(255) 
AS 
BEGIN 
    DECLARE @minutes INT, @word VARCHAR(255) 
    SET @minutes = ABS(DATEDIFF(MINUTE, @d1, @d2)) 
    IF @minutes = 0 
        SET @word = '0 minutes.' 
    ELSE 
    BEGIN 
        SET @word = '' 
        IF @minutes >= (24*60) 
        BEGIN
            SET @word = @word  + RTRIM(@minutes/(24*60))+' days ago' 
            RETURN @word
        END
        SET @minutes = @minutes % (24*60) 
        IF @minutes >= 60
        BEGIN
            SET @word = @word  + RTRIM(@minutes/60)+' hours ago' 
            RETURN @word
        END
        SET @minutes = @minutes % 60 
        SET @word = @word + RTRIM(@minutes)+' minutes ago' 
    END 
    RETURN @word 
END 
GO