set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROCEDURE [dbo].[SP_MOM_SEND_MAILS]
	@MOM_USR_ID BIGINT
AS
BEGIN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  
			  ML.ID
			, ML.MOM_USR_ID
			, MOM_TO_EMAIL
			, MOM_SUBJECT
			, MOM_BODY
			, MOM_READ
			, USR.DISPLAY_NAME
			, ML.TIME
	FROM	MOM_MAIL ML 
	INNER JOIN	MOM_USR USR ON ML.MOM_USR_ID = USR.ID
	WHERE	ML.MOM_USR_ID = @MOM_USR_ID
	ORDER BY TIME DESC

END



