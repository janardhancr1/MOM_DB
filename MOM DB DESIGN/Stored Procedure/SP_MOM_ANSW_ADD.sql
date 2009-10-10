ALTER PROC SP_MOM_ANSW_ADD
(
	  @MOM_USR_ID	BIGINT
	, @MOM_QSTN_ID	INT
	, @ANSWER	NVARCHAR (1000)
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
		
		
		INSERT INTO MOM_ANWS
		(
			  MOM_USR_ID
			, MOM_QSTN_ID
			, ANSWER
		)
		VALUES
		(
			  @MOM_USR_ID
			, @MOM_QSTN_ID
			, @ANSWER
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