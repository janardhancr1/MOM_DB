set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROCEDURE [dbo].[SP_MOM_RCP_GET_BY_TAG]
	  @TAGNAME VARCHAR(100) = NULL
AS
BEGIN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

	SELECT  
			  MR.ID
			, NAME
			, DESCRIPTION
			, PHOTO = ISNULL (PHOTO, '../images/nopic.jpg')
			, COOK_TM AS COOKINGTIME
			, MOM_USR_ID
			, VIEWS
			, RATING
			, (SELECT FULL_NAME FROM MOM_USR WHERE ID = MOM_USR_ID) AS SUBMITTEDBY
			, (SELECT Count(ID) FROM MOM_RCP_CMT WHERE MOM_RCP_ID = MR.ID) AS COMMENTS
			, (SELECT DISTINCT (STUFF(
			(SELECT ', ' + TAG 
			 FROM	MOM_TAGS T2 
			 WHERE T2.NAMESPACE = T1.NAMESPACE 
				   AND T2.MOM_ID = T2.MOM_ID 
			 FOR XML PATH('')),1,2,'')) 
			FROM MOM_TAGS T1
			WHERE MOM_ID = MR.ID) AS TAGS
	FROM MOM_RCP MR 
	INNER JOIN MOM_TAGS T1 ON MR.ID = T1.MOM_ID
	WHERE T1.TAG = @TAGNAME

END