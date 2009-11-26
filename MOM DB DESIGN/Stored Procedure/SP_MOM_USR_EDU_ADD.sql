set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


ALTER PROC [dbo].[SP_MOM_USR_EDU_ADD]
(
	  @MOM_SCH_NAME		VARCHAR (50)
	, @MOM_SCH_TYPE		VARCHAR (20)
	, @MOM_SCH_ST		INT				= NULL
	, @MOM_SCH_ED		INT 			= NULL
	, @MOM_USR_ID		BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	INSERT INTO MOM_USR_EDU
	(
		  MOM_SCH_NAME
		, MOM_SCH_TYPE
		, MOM_SCH_ST
		, MOM_SCH_ED
		, MOM_USR_ID
	)
	VALUES
	(
		  @MOM_SCH_NAME
		, @MOM_SCH_TYPE
		, @MOM_SCH_ST
		, @MOM_SCH_ED
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

