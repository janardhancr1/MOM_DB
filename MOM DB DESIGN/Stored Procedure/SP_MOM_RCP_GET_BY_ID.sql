--USE [Momburbia_JANA]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOM_RCP_GET_BY_ID]    Script Date: 10/05/2009 22:47:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[SP_MOM_RCP_GET_BY_ID]
(
	@ID	INT
)
AS
BEGIN

	SELECT   ID
			, NAME
			, DESCRIPTION
			, PHOTO = ISNULL (PHOTO, '../images/nopic.jpg')
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

