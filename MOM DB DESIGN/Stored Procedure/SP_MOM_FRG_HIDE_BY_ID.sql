CREATE PROC SP_MOM_FRG_HIDE_BY_ID
(
	@ID	INT
)
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	BEGIN TRY
	
		UPDATE	MOM_FRG
		SET	HIDE = 1
		WHERE	ID = @ID
	
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