ALTER PROC SP_MOM_BLG_ADD
(
	  @MOM_USR_ID	BIGINT	  
	, @TITLE		NVARCHAR (200)
	, @BLOG		TEXT
	, @TAGS		NVARCHAR (200)
	, @PRIVACY	VARCHAR (100)
	, @ALLOW_COMMENTS	BIT
	, @EMAIL_STATUS	BIT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
		
		
		INSERT INTO MOM_BLG
		(
			  MOM_USR_ID
			, TITLE
			, BLOG
			, TAGS
			, PRIVACY
			, ALLOW_COMMENTS
			, EMAIL_STATUS
		)
		VALUES
		(
			  @MOM_USR_ID
			, @TITLE
			, @BLOG
			, @TAGS
			, @PRIVACY
			, @ALLOW_COMMENTS
			, @EMAIL_STATUS
		)
		
		
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
GO