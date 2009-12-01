set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


CREATE PROC [dbo].[SP_MOM_BLK_USRS_ADD]
(
	  @MOM_BLK_USR_ID	BIGINT
	, @MOM_USR_ID		BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	INSERT INTO MOM_BLK_USRS
	(
		  MOM_BLK_USR_ID
		, MOM_USR_ID
	)
	VALUES
	(
		  @MOM_BLK_USR_ID
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

