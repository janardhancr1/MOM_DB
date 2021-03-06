set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROCEDURE [dbo].[SP_MOM_MAIL_ADD]
	  @MOM_USR_ID	BIGINT
	, @MOM_TO_EMAIL	VARCHAR(255)
	, @MOM_SUBJECT	VARCHAR(100)
	, @MOM_BODY		TEXT
AS
BEGIN
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY	
		

			INSERT INTO MOM_MAIL
			(
				  MOM_USR_ID
				, MOM_TO_EMAIL
				, MOM_SUBJECT
				, MOM_BODY
			)
			VALUES
			(
				  @MOM_USR_ID
				, @MOM_TO_EMAIL
				, @MOM_SUBJECT
				, @MOM_BODY
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

END

