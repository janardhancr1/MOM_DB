set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROC [dbo].[SP_MOM_KIDS_BY_USR_ID]
(
	@MOM_USR_ID	BIGINT
)
AS
BEGIN
	
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	SELECT   ID
			, KID_FIRST_NAME
			, KID_GENDER
			, KID_PHOTO = ISNULL (KID_PHOTO, '../images/nopic.jpg')
			, KID_DOB
			, KID_ABOUT
			, MOM_USR_ID
	FROM MOM_KIDS
	WHERE MOM_USR_ID = @MOM_USR_ID 


END


