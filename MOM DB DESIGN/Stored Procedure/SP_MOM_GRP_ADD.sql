ALTER PROC SP_MOM_GRP_ADD
(
	  @NAME		NVARCHAR (255)
	, @MOM_USR_ID	BIGINT
	, @DESCRIPTION	NVARCHAR (500)
	, @TYPE		NVARCHAR (50)
	, @RECENT_NEWS	NVARCHAR (500)	= NULL
	, @OFFICE	NVARCHAR (100)	= NULL
	, @EMAIL_ADDR	NVARCHAR (255)	= NULL	
	, @STREET	NVARCHAR (100)	= NULL
	, @CITY		NVARCHAR (100)	= NULL
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
		
		
		INSERT INTO MOM_GRP
		(
			  MOM_USR_ID
			, NAME
			, DESCRIPTION
			, TYPE
			, RECENT_NEWS
			, OFFICE
			, EMAIL_ADDR
			, STREET
			, CITY
		)
		VALUES
		(
			  @MOM_USR_ID
			, @NAME
			, @DESCRIPTION
			, @TYPE
			, @RECENT_NEWS
			, @OFFICE
			, @EMAIL_ADDR
			, @STREET
			, @CITY
		)
		
		INSERT INTO MOM_GRP_USR
		(
			  MOM_GRP_ID
			, MOM_USR_ID
		)
		VALUES
		(
			  @@IDENTITY
			, @MOM_USR_ID
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