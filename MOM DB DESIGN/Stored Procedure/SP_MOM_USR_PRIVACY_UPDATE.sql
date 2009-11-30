set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

ALTER PROC [dbo].[SP_MOM_USR_PRIVACY_UPDATE]
(
	  @MOM_SHW_NAME			NVARCHAR(20)	= NULL
	, @MOM_SHW_DOB			NVARCHAR(20)	= NULL
	, @MOM_SHW_INTRST		NVARCHAR(20)	= NULL
	, @MOM_SHW_EDU			NVARCHAR(20)	= NULL
	, @MOM_SHW_KIDS			NVARCHAR(20)	= NULL
	, @MOM_SHW_KIDS_DOB		NVARCHAR(20)	= NULL
	, @MOM_SHW_KIDS_PHOTO	NVARCHAR(20)	= NULL
	, @MOM_SHW_KIDS_ABOUT	NVARCHAR(20)	= NULL
	, @MOM_SHW_KIDS_CHAN	NVARCHAR(20)	= NULL
	, @MOM_SHW_ACT			NVARCHAR(20)	= NULL
	, @MOM_SHW_TO			NVARCHAR(20)	= NULL
	, @MOM_USR_ID			BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	UPDATE MOM_USR_PRIVACY
	SET		  MOM_SHW_NAME		= @MOM_SHW_NAME
			, MOM_SHW_DOB		= @MOM_SHW_DOB
			, MOM_SHW_INTRST	= @MOM_SHW_INTRST
			, MOM_SHW_EDU		= @MOM_SHW_EDU
			, MOM_SHW_KIDS		= @MOM_SHW_KIDS
			, MOM_SHW_KIDS_DOB	= @MOM_SHW_KIDS_DOB
			, MOM_SHW_KIDS_PHOTO= @MOM_SHW_KIDS_PHOTO
			, MOM_SHW_KIDS_ABOUT= @MOM_SHW_KIDS_ABOUT
			, MOM_SHW_KIDS_CHAN	= @MOM_SHW_KIDS_CHAN
			, MOM_SHW_ACT		= @MOM_SHW_ACT
			, MOM_SHW_TO		= @MOM_SHW_TO
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


