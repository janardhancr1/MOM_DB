set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROCEDURE [dbo].[SP_MOM_RCP_COMMENT_GETBY_RCP_ID]
	@MOM_RCP_ID INT
AS
BEGIN
	SELECT 
			  CMT.ID
			, CMT.MOM_RCP_ID
			, CMT.MOM_USR_ID
			, CMT.COMMENTS
			, SUBMITIME = DBO.FN_MOM_DATE_DIFF(CMT.TIME, GETDATE())
			, USR.DISPLAY_NAME AS SUBMITTEDBY
			, PICTURE	= ISNULL (USR.PICTURE, '../images/q_silhouette.gif')
	FROM 
			MOM_RCP_CMT CMT 
			INNER JOIN MOM_USR USR ON CMT.MOM_USR_ID = USR.ID
	WHERE CMT.MOM_RCP_ID = @MOM_RCP_ID
END



