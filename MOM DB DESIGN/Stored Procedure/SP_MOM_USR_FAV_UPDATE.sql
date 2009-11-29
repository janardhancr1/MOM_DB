set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROC [dbo].[SP_MOM_USR_FAV_UPDATE]
(
	  @MOM_FAV_CELEB		TEXT	= NULL
	, @MOM_FAV_MOV			TEXT	= NULL
	, @MOM_FAV_TV			TEXT	= NULL
	, @MOM_FAV_BOOKS		TEXT	= NULL
	, @MOM_FAV_MUSIC		TEXT	= NULL
	, @MOM_USR_ID			BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	UPDATE MOM_USR_FAV
	SET		  MOM_FAV_CELEB = @MOM_FAV_CELEB
			, MOM_FAV_MOV	= @MOM_FAV_MOV
			, MOM_FAV_TV	= @MOM_FAV_TV
			, MOM_FAV_BOOKS = @MOM_FAV_BOOKS
			, MOM_FAV_MUSIC = @MOM_FAV_MUSIC
	WHERE	MOM_USR_ID = @MOM_USR_ID

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

