set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROC [dbo].[SP_MOM_RCP_GET_BY_ID]
(
	@ID	INT
)
AS
BEGIN

	SELECT   ID
			, NAME
			, DESCRIPTION
			, PHOTO
			, TAGS
			, PREP_TM
			, COOK_TM
			, SERVE_TO
			, DIFFICULTY
			, INGREDIENTS
			, METHOD
			, VEGE
			, VEGAN
			, DAIRY
			, GLUTEN
			, NUT
			, ALLOW
			, MOM_USR_ID
	FROM MOM_RCP
	WHERE ID = @ID 
	
END

