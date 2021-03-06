set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



ALTER PROC [dbo].[SP_MOM_RCP_ADD]
(
	  @NAME			VARCHAR (100)
	, @DESCRIPTION	VARCHAR (255)
	, @PHOTO		VARCHAR (255) 	= NULL
	, @TAGS			VARCHAR (255) 	= NULL
	, @PREP_TM		VARCHAR (100) 	= NULL
	, @COOK_TM		VARCHAR (100) 	= NULL
	, @SERVE_TO		VARCHAR (100)	= NULL
	, @DIFFICULTY	VARCHAR (100)
	, @INGREDIENTS	TEXT
	, @METHOD		TEXT	
	, @VEGE			BIT	= NULL
	, @VEGAN		BIT	= NULL
	, @DAIRY		BIT	= NULL
	, @GLUTEN		BIT	= NULL
	, @NUT			BIT	= NULL
	, @ALLOW		BIT	= NULL
	, @MOM_USR_ID	BIGINT
	, @NAMESPACE	VARCHAR(50)
)
AS
BEGIN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	DECLARE @ID INT;

	INSERT INTO MOM_RCP
	(
		  NAME
		, DESCRIPTION
		, PHOTO
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

	)
	VALUES
	(
		  @NAME
		, @DESCRIPTION
		, @PHOTO
		, @PREP_TM
		, @COOK_TM
		, @SERVE_TO
		, @DIFFICULTY
		, @INGREDIENTS
		, @METHOD
		, @VEGE
		, @VEGAN
		, @DAIRY
		, @GLUTEN
		, @NUT
		, @ALLOW
		, @MOM_USR_ID
	)

	SET @ID = SCOPE_IDENTITY(); 
	
	DECLARE @TAG VARCHAR(50);
	DECLARE @POS INT;

	SET @TAGS = LTRIM(RTRIM(@TAGS))+ ','
	SET @POS = CHARINDEX(',', @TAGS, 1)

	IF REPLACE(@TAGS, ',', '') <> ''
	BEGIN
		WHILE @POS > 0
		BEGIN
			SET @TAG = LTRIM(RTRIM(LEFT(@TAGS, @POS - 1)))
			IF @TAG <> ''
			BEGIN
				INSERT INTO MOM_TAGS 
				(
					  TAG
					, MOM_ID
					, NAMESPACE
				) 
				VALUES 
				(
					  @TAG
					, @ID
					, @NAMESPACE
				) 
			END
			SET @TAGS = RIGHT(@TAGS, LEN(@TAGS) - @POS)
			SET @POS = CHARINDEX(',', @TAGS, 1)
		END
	END	
	
	END TRY
	BEGIN CATCH
	
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;
		
		SELECT	  @ErrorMessage = ERROR_MESSAGE()
			, @ErrorSeverity = ERROR_SEVERITY()
			, @ErrorState = ERROR_STATE();
	
		IF @@TRANCOUNT > 0 
			ROLLBACK TRAN
		
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);	
	END CATCH
	
	IF @@TRANCOUNT > 0
		COMMIT TRAN
END
