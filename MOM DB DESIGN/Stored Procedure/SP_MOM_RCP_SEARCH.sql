set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROCEDURE [dbo].[SP_MOM_RCP_SEARCH]
	  @NAME VARCHAR(100) = NULL
	, @DIFFICULTY VARCHAR(100) = NULL
	, @INGREDIENTS TEXT = NULL
	, @VEGE BIT = NULL
	, @VEGAN BIT = NULL
	, @DAIRY BIT = NULL
	, @GLUTEN BIT = NULL
	, @NUT BIT = NULL
	, @PHOTO VARCHAR(255) = NULL
AS
BEGIN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  
			  ID
			, NAME
			, DESCRIPTION
			, PHOTO = ISNULL (PHOTO, '../images/nopic.jpg')
			, COOK_TM AS COOKINGTIME
			, MOM_USR_ID
			, VIEWS
			, RATING
			, (SELECT FULL_NAME FROM MOM_USR WHERE ID = MOM_USR_ID) AS SUBMITTEDBY
			, (SELECT Count(ID) FROM MOM_RCP_CMT WHERE MOM_RCP_ID = MR.ID) AS COMMENTS
	FROM MOM_RCP MR 
	WHERE (NAME LIKE @NAME OR @NAME IS NULL) 
		  AND ( VEGE = @VEGE OR @VEGE IS NULL)
		  AND ( VEGAN = @VEGAN OR @VEGAN IS NULL)
		  AND ( DAIRY = @DAIRY OR @DAIRY IS NULL)
		  AND ( GLUTEN = @GLUTEN OR @GLUTEN IS NULL)
		  AND ( NUT = @NUT OR @NUT IS NULL)
		  AND ( (PHOTO IS NOT NULL AND @PHOTO IS NOT NULL) OR @PHOTO IS NULL)
		  AND ( DIFFICULTY = @DIFFICULTY OR @DIFFICULTY IS NULL)
		  AND ( (INGREDIENTS LIKE '%@NAME%' AND @INGREDIENTS IS NULL) OR @INGREDIENTS IS NULL)

END



