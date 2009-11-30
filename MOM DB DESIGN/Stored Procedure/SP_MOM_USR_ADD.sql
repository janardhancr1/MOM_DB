set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/*
ADDS ROW TO MOM_USR TABLE
*/
ALTER PROC [dbo].[SP_MOM_USR_ADD]
(
	  @EMAIL_ADDR	NVARCHAR (200)
	, @PASSWORD	NVARCHAR (100)
	, @FIRST_NAME	NVARCHAR (100)
	, @LAST_NAME	NVARCHAR (100)
	, @SEX		NCHAR (1)
	, @DOB		DATETIME
	, @DISPLAY_NAME	NVARCHAR (30)
	, @NEWLETTER	BIT
	, @ID		BIGINT OUT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
	
		INSERT INTO MOM_USR
		(
			  EMAIL_ADDR
			, PASSWORD
			, FIRST_NAME
			, LAST_NAME
			, SEX
			, DOB
			, DISPLAY_NAME
			, FULL_NAME
			, NEWLETTER
		)
		VALUES
		(
			  @EMAIL_ADDR
			, @PASSWORD
			, @FIRST_NAME
			, @LAST_NAME
			, @SEX
			, @DOB
			, @DISPLAY_NAME
			, @FIRST_NAME + ' ' + @LAST_NAME
			, @NEWLETTER
		)
		SET @ID = @@IDENTITY
		
		INSERT INTO MOM_USR_FAV
		(
			MOM_USR_ID
		)
		VALUES
		(
			@ID
		)

		INSERT INTO MOM_USR_PRIVACY
		(
			MOM_USR_ID
		)
		VALUES
		(
			@ID
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

