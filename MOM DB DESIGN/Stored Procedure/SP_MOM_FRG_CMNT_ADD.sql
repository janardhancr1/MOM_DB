ALTER PROC SP_MOM_FRG_CMNT_ADD
(
	  @MOM_FRG_ID	INT
	, @MOM_USR_ID	BIGINT
	, @COMMENTS	NVARCHAR (255)
	, @ID		INT OUT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY

		INSERT INTO MOM_FRG_CMNT
		(
			  MOM_FRG_ID
			, MOM_USR_ID
			, COMMENTS
		)
		VALUES
		(
			  @MOM_FRG_ID
			, @MOM_USR_ID
			, @COMMENTS
		)
		
		SET @ID = @@IDENTITY
	
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