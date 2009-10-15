IF OBJECT_ID('SP_MOM_USR_ADD') IS NOT NULL
	DROP PROC SP_MOM_USR_ADD
GO

CREATE PROC SP_MOM_USR_ADD
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_ANSW_ADD') IS NOT NULL
	DROP PROC SP_MOM_ANSW_ADD
GO

CREATE PROC SP_MOM_ANSW_ADD
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_ANWS_GET_BY_MOM_QSTN_ID') IS NOT NULL
	DROP PROC SP_MOM_ANWS_GET_BY_MOM_QSTN_ID
GO

CREATE PROC SP_MOM_ANWS_GET_BY_MOM_QSTN_ID
(
	@MOM_QSTN_ID	INT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	  A.ANSWER
		, TIME		= DBO.FN_MOM_DATE_DIFF(A.TIME, GETDATE())
		, U.DISPLAY_NAME
		, PICTURE	= ISNULL (U.PICTURE, '../images/q_silhouette.gif')
		, U.ID
	FROM	MOM_ANWS A (NOLOCK)
		INNER JOIN MOM_USR U (NOLOCK)
		ON	A.MOM_USR_ID = U.ID
	WHERE	A.MOM_QSTN_ID = @MOM_QSTN_ID
	AND	A.ABUSE = 0
	ORDER BY	A.TIME DESC
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_BLG_ADD') IS NOT NULL
	DROP PROC SP_MOM_BLG_ADD
GO

CREATE PROC SP_MOM_BLG_ADD
(
	  @MOM_USR_ID	BIGINT	  
	, @TITLE		NVARCHAR (200)
	, @BLOG		TEXT
	, @TAGS		NVARCHAR (200)
	, @PRIVACY	VARCHAR (100)
	, @ALLOW_COMMENTS	BIT
	, @EMAIL_STATUS	BIT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
		
		
		INSERT INTO MOM_BLG
		(
			  MOM_USR_ID
			, TITLE
			, BLOG
			, TAGS
			, PRIVACY
			, ALLOW_COMMENTS
			, EMAIL_STATUS
		)
		VALUES
		(
			  @MOM_USR_ID
			, @TITLE
			, @BLOG
			, @TAGS
			, @PRIVACY
			, @ALLOW_COMMENTS
			, @EMAIL_STATUS
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_BLG_GET') IS NOT NULL
	DROP PROC SP_MOM_BLG_GET
GO

CREATE PROCEDURE SP_MOM_BLG_GET
AS
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT	  MB.ID
		, MB.TITLE
		, MB.BLOG
		, TIME		= DBO.FN_MOM_DATE_DIFF(MB.TIME, GETDATE())
		, MB.RATE
		, MOM_USR_ID	= MU.ID
		, MU.DISPLAY_NAME
	FROM	MOM_BLG MB (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MB.MOM_USR_ID = MU.ID
	WHERE	MB.ABUSE = 0
	AND	MU.BLOCKED = 0
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_CATG_GET') IS NOT NULL
	DROP PROC SP_MOM_CATG_GET
GO

CREATE PROCEDURE SP_MOM_CATG_GET
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	  ID
		, NAME
	FROM	MOM_CATG (NOLOCK)
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRG_CMNT_ADD') IS NOT NULL
	DROP PROC SP_MOM_FRG_CMNT_ADD
GO

CREATE PROC SP_MOM_FRG_CMNT_ADD
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
-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRG_CMNT_DEL_BY_ID') IS NOT NULL
	DROP PROC SP_MOM_FRG_CMNT_DEL_BY_ID
GO

CREATE PROC SP_MOM_FRG_CMNT_DEL_BY_ID
(
	@ID	INT
)
AS
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	BEGIN TRY
	
		UPDATE	MOM_FRG_CMNT
		SET	DELETED = 1
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRG_HIDE_BY_ID') IS NOT NULL
	DROP PROC SP_MOM_FRG_HIDE_BY_ID
GO

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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRND_GET_BY_MOM_USR_ID') IS NOT NULL
	DROP PROC SP_MOM_FRND_GET_BY_MOM_USR_ID
GO

CREATE PROC SP_MOM_FRND_GET_BY_MOM_USR_ID
(
	@MOM_USR_ID	BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	  MF.ID
		, MOM_USR_ID	= MF.FRND_MOM_USR_ID
		, PICTURE	= ISNULL (MU.PICTURE, '../images/q_silhouette.gif')
		, MU.DISPLAY_NAME
		, MU.FULL_NAME
	FROM	MOM_FRND MF (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MF.FRND_MOM_USR_ID = MU.ID
	WHERE	MOM_USR_ID	= @MOM_USR_ID

	UNION ALL

	SELECT	  MF.ID
		, MOM_USR_ID	= MF.MOM_USR_ID
		, MU.PICTURE
		, MU.DISPLAY_NAME
		, MU.FULL_NAME
	FROM	MOM_FRND MF (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MF.MOM_USR_ID = MU.ID
	WHERE	FRND_MOM_USR_ID	= @MOM_USR_ID
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_GRP_ADD') IS NOT NULL
	DROP PROC SP_MOM_GRP_ADD
GO

CREATE PROC SP_MOM_GRP_ADD
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_GRP_GET_BY_MOM_USR_ID') IS NOT NULL
	DROP PROC SP_MOM_GRP_GET_BY_MOM_USR_ID
GO

CREATE PROC SP_MOM_GRP_GET_BY_MOM_USR_ID
(
	@MOM_USR_ID	BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	FRND_MOM_USR_ID
	INTO	#MOM_FRND_TEMP
	FROM	MOM_FRND (NOLOCK)
	WHERE	MOM_USR_ID = @MOM_USR_ID
	AND	BLOCKED = 0
	
	UNION
	
	SELECT	MOM_USR_ID
	FROM	MOM_FRND (NOLOCK)
	WHERE	FRND_MOM_USR_ID = @MOM_USR_ID
	AND	BLOCKED = 0
	
	SELECT	*
	FROM	MOM_GRP (NOLOCK)
	WHERE	MOM_USR_ID = @MOM_USR_ID
	AND	BLOCKED = 0
	
	SELECT	  MOM_GRP_ID	= MG.ID
		, MOM_GRP_NAME	= MG.NAME
		, MG.DESCRIPTION
		, MOM_USR_ID	= MU.ID
		, MOM_USR_NAME	= MU.DISPLAY_NAME
		, MG.MEMBERS
	FROM	#MOM_FRND_TEMP T 
		INNER JOIN MOM_GRP_USR MGU (NOLOCK)
		ON	T.FRND_MOM_USR_ID = MGU.MOM_USR_ID
		INNER JOIN MOM_GRP MG (NOLOCK)
		ON	MGU.MOM_GRP_ID = MG.ID
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MU.ID = MGU.MOM_USR_ID
	WHERE	MGU.BLOCKED	= 0
	AND	MG.BLOCKED	= 0
	AND	DATEDIFF (DD, MGU.TIME, GETDATE()) < 60
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_QSTN_ADD') IS NOT NULL
	DROP PROC SP_MOM_QSTN_ADD
GO

CREATE PROC SP_MOM_QSTN_ADD
(
	  @MOM_USR_ID	BIGINT
	, @MOM_CATG_ID	INT
	, @QUESTION	NVARCHAR (100)
	, @DESCRIPTION	NVARCHAR (2000)
	, @EMAIL_STATUS	BIT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY	
		

			INSERT INTO MOM_QSTN
			(
				  MOM_USR_ID
				, MOM_CATG_ID
				, QUESTION
				, DESCRIPTION
				, EMAIL_STATUS
			)
			VALUES
			(
				  @MOM_USR_ID
				, @MOM_CATG_ID
				, @QUESTION
				, @DESCRIPTION
				, @EMAIL_STATUS
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_QSTN_GET_BY_ID') IS NOT NULL
	DROP PROC SP_MOM_QSTN_GET_BY_ID
GO

CREATE PROC SP_MOM_QSTN_GET_BY_ID
(
	@ID	INT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	  Q.ID
		, Q.QUESTION
		, Q.DESCRIPTION
		, U.DISPLAY_NAME
	FROM	MOM_QSTN Q
		INNER JOIN MOM_USR U
		ON	Q.MOM_USR_ID = U.ID
	WHERE	Q.ID = @ID
	
	SELECT	  A.ANSWER
		, TIME		= DBO.FN_MOM_DATE_DIFF(A.TIME, GETDATE())
		, U.DISPLAY_NAME
		, PICTURE	= ISNULL (U.PICTURE, '../images/q_silhouette.gif')
		, U.ID
	FROM	MOM_ANWS A (NOLOCK)
		INNER JOIN MOM_USR U (NOLOCK)
		ON	A.MOM_USR_ID = U.ID
	WHERE	A.MOM_QSTN_ID = @ID
	AND	A.ABUSE = 0
	ORDER BY	A.TIME DESC
	
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_QSTN_GET_BY_MOM_CATG_ID') IS NOT NULL
	DROP PROC SP_MOM_QSTN_GET_BY_MOM_CATG_ID
GO

CREATE PROC SP_MOM_QSTN_GET_BY_MOM_CATG_ID
(
	  @MOM_CATG_ID	INT = NULL
	, @START_IDX	INT = NULL
	, @END_IDX	INT = NULL
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

--	DECLARE @MOM_QSTN_ANWS TABLE
--	(
--		  MOM_QSTN_ID	INT PRIMARY KEY CLUSTERED
--		, ANSWERS_COUNT	INT
--	)
--	
--	INSERT INTO @MOM_QSTN_ANWS
--	SELECT	  MOM_QSTN_ID
--		, ANSWERS_COUNT = COUNT (1)
--	FROM	MOM_ANWS (NOLOCK)
--	WHERE	ABUSE = 0
--	GROUP BY	  MOM_QSTN_ID
	
	SELECT	  Q.ID
		, Q.QUESTION
		, TIME		= DBO.FN_MOM_DATE_DIFF(Q.TIME, GETDATE())
		, Q.MOM_CATG_ID
		, Q.MOM_USR_ID
		, U.DISPLAY_NAME
		, ANSWERS_COUNT	= ISNULL (Q.ANSWERS_COUNT, 0)
		, PICTURE	= ISNULL (U.PICTURE, '../images/q_silhouette.gif')
	FROM	MOM_QSTN Q (NOLOCK)
		INNER JOIN MOM_USR U (NOLOCK)
		ON	Q.MOM_USR_ID = U.ID
	WHERE	(MOM_CATG_ID = @MOM_CATG_ID OR @MOM_CATG_ID IS NULL)
	AND	ABUSE = 0
	ORDER BY	Q.ID DESC
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_QSTN_MOM_ANWS_GET_BY_MOM_QSTN_ID') IS NOT NULL
	DROP PROC SP_MOM_QSTN_MOM_ANWS_GET_BY_MOM_QSTN_ID
GO

CREATE PROC SP_MOM_QSTN_MOM_ANWS_GET_BY_MOM_QSTN_ID
(
	@ID	INT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	SELECT	  Q.ID
		, Q.QUESTION
		, Q.DESCRIPTION
		, U.DISPLAY_NAME
	FROM	MOM_QSTN Q
		INNER JOIN MOM_USR U
		ON	Q.MOM_USR_ID = U.ID
	WHERE	Q.ID = @ID
	
	SELECT	  A.ANSWER
		, TIME		= DBO.FN_MOM_DATE_DIFF(A.TIME, GETDATE())
		, U.DISPLAY_NAME
		, PICTURE	= ISNULL (U.PICTURE, '../images/q_silhouette.gif')
		, U.ID
	FROM	MOM_ANWS A (NOLOCK)
		INNER JOIN MOM_USR U (NOLOCK)
		ON	A.MOM_USR_ID = U.ID
	WHERE	A.MOM_QSTN_ID = @ID
	AND	A.ABUSE = 0
	ORDER BY	A.TIME DESC
	
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_USR_ACTIVATE') IS NOT NULL
	DROP PROC SP_MOM_USR_ACTIVATE
GO

CREATE PROCEDURE SP_MOM_USR_ACTIVATE
(
	@ID	BIGINT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY
		UPDATE	MOM_USR
		SET	ACTIVE = 1
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_USR_CHECK_BY_EMAIL_ADDR') IS NOT NULL
	DROP PROC SP_MOM_USR_CHECK_BY_EMAIL_ADDR
GO

CREATE PROC SP_MOM_USR_CHECK_BY_EMAIL_ADDR
(
	@EMAIL_ADDR	NVARCHAR (255)
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	
	SELECT	COUNT (1)
	FROM	MOM_USR (NOLOCK)
	WHERE	EMAIL_ADDR = @EMAIL_ADDR

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_USR_LOGIN') IS NOT NULL
	DROP PROC SP_MOM_USR_LOGIN
GO

CREATE PROC SP_MOM_USR_LOGIN
(
	  @EMAIL_ADDR	NVARCHAR (200)
	, @PASSWORD	NVARCHAR (100)
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT	  ID
		, EMAIL_ADDR
		, PASSWORD
		, FIRST_NAME
		, LAST_NAME
		, FULL_NAME
		, SEX
		, DOB
		, DISPLAY_NAME
		, NEWLETTER
		, TIME
		, LAST_LOGIN_DATE
		, ACTIVE
		, BLOCKED
		, PICTURE = ISNULL (PICTURE, '../images/q_silhouette.gif')
		, PICTURE_STATUS
	FROM	MOM_USR (NOLOCK)
	WHERE	EMAIL_ADDR = @EMAIL_ADDR
	AND	PASSWORD = @PASSWORD
	AND	ACTIVE = 1
	AND	BLOCKED = 0

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRG_ADD') IS NOT NULL
	DROP PROC SP_MOM_FRG_ADD
GO

CREATE PROC SP_MOM_FRG_ADD
(
	  @MOM_USR_ID	BIGINT
	, @SHARE		NVARCHAR (255)
	, @TYPE		CHAR (1) = 'D'
	, @TYPE_SHARE	NVARCHAR (4000) = NULL
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
		
	BEGIN TRY	
		

		DECLARE @MOM_FRG_ROW TABLE
		(
			  ID		INT
			, MOM_USR_ID	BIGINT
			, SHARE		NVARCHAR (255)
			, TYPE		CHAR (1)
			, TYPE_SHARE	NVARCHAR (4000)
		)

		INSERT INTO MOM_FRG
		(
			  MOM_USR_ID
			, SHARE
			, TYPE
			, TYPE_SHARE
		)
		OUTPUT	  INSERTED.ID
			, INSERTED.MOM_USR_ID
			, INSERTED.SHARE
			, INSERTED.TYPE
			, INSERTED.TYPE_SHARE
		INTO	@MOM_FRG_ROW
		VALUES
		(
			  @MOM_USR_ID
			, @SHARE
			, @TYPE
			, @TYPE_SHARE
		)
		
		SELECT	*
		FROM	@MOM_FRG_ROW

		
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_FRG_GET_BY_MOM_USR_ID') IS NOT NULL
	DROP PROC SP_MOM_FRG_GET_BY_MOM_USR_ID
GO

CREATE PROC SP_MOM_FRG_GET_BY_MOM_USR_ID
(
	  @MOM_USR_ID	BIGINT
	, @TYPE	CHAR (1)	= NULL
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT	FRND_MOM_USR_ID
	INTO	#MOM_FRND_TEMP
	FROM	MOM_FRND (NOLOCK)
	WHERE	MOM_USR_ID = @MOM_USR_ID
	AND	BLOCKED = 0
	
	UNION
	
	SELECT	MOM_USR_ID
	FROM	MOM_FRND (NOLOCK)
	WHERE	FRND_MOM_USR_ID = @MOM_USR_ID
	AND	BLOCKED = 0
	
	UNION
	
	SELECT	@MOM_USR_ID
	

	SELECT	  MF.ID
		, MF.MOM_USR_ID
		, MF.SHARE
		, TIME	= DBO.FN_MOM_DATE_DIFF(MF.TIME, GETDATE())
		, MU.DISPLAY_NAME
		, PICTURE	= ISNULL (MU.PICTURE, '../images/q_silhouette.gif')
		, MF.TYPE
		, MF.TYPE_SHARE
		, MF.HIDE
	INTO	#MOM_FRG
	FROM	#MOM_FRND_TEMP MFT (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MFT.FRND_MOM_USR_ID = MU.ID
		INNER JOIN MOM_FRG MF (NOLOCK)
		ON	MU.ID = MF.MOM_USR_ID
	WHERE	HIDE = 0
	AND	(MF.TYPE = @TYPE OR @TYPE IS NULL)
	ORDER BY MF.ID DESC
	
	SELECT	*
	FROM	#MOM_FRG
	
	SELECT	  MFC.ID
		, MFC.MOM_FRG_ID
		, MFC.COMMENTS
		, TIME		= DBO.FN_MOM_DATE_DIFF(MFC.TIME, GETDATE())
		, MU.DISPLAY_NAME
		, PICTURE	= ISNULL (MU.PICTURE, '../images/q_silhouette.gif')
		, MFC.MOM_USR_ID
	FROM	#MOM_FRG T
		INNER JOIN MOM_FRG_CMNT MFC (NOLOCK)
		ON	T.ID = MFC.MOM_FRG_ID
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MFC.MOM_USR_ID = MU.ID
	WHERE	MFC.DELETED = 0

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_GET_MAILS') IS NOT NULL
	DROP PROC SP_MOM_GET_MAILS
GO

CREATE PROCEDURE SP_MOM_GET_MAILS
	@MOM_USR_NAME VARCHAR(255) = NULL
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

	SELECT	ML.ID
		, ML.MOM_USR_ID
		, MOM_TO_EMAIL
		, MOM_SUBJECT
		, MOM_BODY
		, MOM_READ
		, USR.DISPLAY_NAME
		, ML.TIME
	FROM	MOM_MAIL ML 
	INNER JOIN	MOM_USR USR ON ML.MOM_USR_ID = USR.ID
	WHERE	MOM_TO_EMAIL LIKE @MOM_USR_NAME
	ORDER BY TIME DESC
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_GET_NEW_MAILS') IS NOT NULL
	DROP PROC SP_MOM_GET_NEW_MAILS
GO

CREATE PROCEDURE SP_MOM_GET_NEW_MAILS
	  @MOM_USR_NAME VARCHAR(255) = NULL
	, @MOM_READ		BIT = NULL
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  COUNT(ML.ID) AS NEWMAILS
	FROM	MOM_MAIL ML 
	INNER JOIN	MOM_USR USR ON ML.MOM_USR_ID = USR.ID
	WHERE	MOM_TO_EMAIL LIKE @MOM_USR_NAME
	AND		MOM_READ = @MOM_READ
	
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_MAIL_ADD') IS NOT NULL
	DROP PROC SP_MOM_MAIL_ADD
GO

CREATE PROCEDURE SP_MOM_MAIL_ADD
	  @MOM_USR_ID	BIGINT
	, @MOM_TO_EMAIL	VARCHAR(255)
	, @MOM_SUBJECT	VARCHAR(100)
	, @MOM_BODY		TEXT
AS
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

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_MAIL_READ') IS NOT NULL
	DROP PROC SP_MOM_MAIL_READ
GO

CREATE PROCEDURE SP_MOM_MAIL_READ
	  @ID			BIGINT
	, @MOM_READ		BIT
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY	
		
			UPDATE MOM_MAIL
			SET 	MOM_READ = @MOM_READ
			WHERE	@ID = @ID
		
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_CMT_ADD') IS NOT NULL
	DROP PROC SP_MOM_RCP_CMT_ADD
GO

CREATE PROCEDURE SP_MOM_RCP_CMT_ADD
	@MOM_RCP_ID INT
	, @MOM_USR_ID BIGINT
	, @COMMENTS TEXT
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	INSERT INTO MOM_RCP_CMT
	(
		  MOM_RCP_ID
		, MOM_USR_ID
		, COMMENTS
	)
	VALUES
	(
		  @MOM_RCP_ID
		, @MOM_USR_ID
		, @COMMENTS
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_COMMENT_GETBY_RCP_ID') IS NOT NULL
	DROP PROC SP_MOM_RCP_COMMENT_GETBY_RCP_ID
GO

CREATE PROCEDURE SP_MOM_RCP_COMMENT_GETBY_RCP_ID
	@MOM_RCP_ID INT
AS
	SELECT 
			  CMT.ID
			, CMT.MOM_RCP_ID
			, CMT.MOM_USR_ID
			, CMT.COMMENTS
			, SUBMITIME = DBO.FN_MOM_DATE_DIFF(CMT.TIME, GETDATE())
			, USR.DISPLAY_NAME AS SUBMITTEDBY
			, PICTURE	= ISNULL (USR.PICTURE, '../images/q_silhouette.gif')
	FROM 
			MOM_RCP_CMT CMT 
			INNER JOIN MOM_USR USR ON CMT.MOM_USR_ID = USR.ID
	WHERE CMT.MOM_RCP_ID = @MOM_RCP_ID
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_SEARCH') IS NOT NULL
	DROP PROC SP_MOM_RCP_SEARCH
GO

CREATE PROCEDURE SP_MOM_RCP_SEARCH
	  @NAME VARCHAR(100) = NULL
	, @DIFFICULTY VARCHAR(100) = NULL
	, @INGREDIENTS TEXT = NULL
	, @VEGE BIT = NULL
	, @VEGAN BIT = NULL
	, @DAIRY BIT = NULL
	, @GLUTEN BIT = NULL
	, @NUT BIT = NULL
	, @PHOTO VARCHAR(255) = NULL
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  
			  ID
			, NAME
			, DESCRIPTION
			, PHOTO = ISNULL (PHOTO, '../images/nopic.jpg')
			, COOK_TM AS COOKINGTIME
			, MOM_USR_ID
			, VIEWS
			, RATING
			, (SELECT FULL_NAME FROM MOM_USR WHERE ID = MOM_USR_ID) AS SUBMITTEDBY
			, (SELECT Count(ID) FROM MOM_RCP_CMT WHERE MOM_RCP_ID = MR.ID) AS COMMENTS
	FROM MOM_RCP MR 
	WHERE (NAME LIKE @NAME OR @NAME IS NULL) 
		  AND ( VEGE = @VEGE OR @VEGE IS NULL)
		  AND ( VEGAN = @VEGAN OR @VEGAN IS NULL)
		  AND ( DAIRY = @DAIRY OR @DAIRY IS NULL)
		  AND ( GLUTEN = @GLUTEN OR @GLUTEN IS NULL)
		  AND ( NUT = @NUT OR @NUT IS NULL)
		  AND ( (PHOTO IS NOT NULL AND @PHOTO IS NOT NULL) OR @PHOTO IS NULL)
		  AND ( DIFFICULTY = @DIFFICULTY OR @DIFFICULTY IS NULL)
		  AND ( (INGREDIENTS LIKE '%@NAME%' AND @INGREDIENTS IS NULL) OR @INGREDIENTS IS NULL)

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_VIEW') IS NOT NULL
	DROP PROC SP_MOM_RCP_VIEW
GO

CREATE PROCEDURE SP_MOM_RCP_VIEW
	  @MOM_RCP_ID	INT
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY	
	
	UPDATE 	MOM_RCP
	SET		VIEWS = VIEWS + 1
	WHERE	ID=@MOM_RCP_ID

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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_USR_GET_BY_NAME') IS NOT NULL
	DROP PROC SP_MOM_USR_GET_BY_NAME
GO

CREATE PROC SP_MOM_USR_GET_BY_NAME
(
	  @DISPLAY_NAME	NVARCHAR (200)
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT	  ID
		, EMAIL_ADDR
		, PASSWORD
		, FIRST_NAME
		, LAST_NAME
		, FULL_NAME
		, SEX
		, DOB
		, DISPLAY_NAME
		, NEWLETTER
		, TIME
		, LAST_LOGIN_DATE
		, ACTIVE
		, BLOCKED
		, PICTURE = ISNULL (PICTURE, '../images/q_silhouette.gif')
		, PICTURE_STATUS
	FROM	MOM_USR (NOLOCK)
	WHERE	DISPLAY_NAME = @DISPLAY_NAME
	AND	ACTIVE = 1
	AND	BLOCKED = 0
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_SEND_MAILS') IS NOT NULL
	DROP PROC SP_MOM_SEND_MAILS
GO

CREATE PROCEDURE SP_MOM_SEND_MAILS
	@MOM_USR_ID BIGINT
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  
			  ML.ID
			, ML.MOM_USR_ID
			, MOM_TO_EMAIL
			, MOM_SUBJECT
			, MOM_BODY
			, MOM_READ
			, USR.DISPLAY_NAME
			, ML.TIME
	FROM	MOM_MAIL ML 
	INNER JOIN	MOM_USR USR ON ML.MOM_USR_ID = USR.ID
	WHERE	ML.MOM_USR_ID = @MOM_USR_ID
	ORDER BY TIME DESC
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_MAIL_GET_BY_ID') IS NOT NULL
	DROP PROC SP_MOM_MAIL_GET_BY_ID
GO

CREATE PROCEDURE SP_MOM_MAIL_GET_BY_ID
	@MAIL_ID BIGINT
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON;

    SELECT  
			  ML.ID
			, ML.MOM_USR_ID
			, MOM_TO_EMAIL
			, MOM_SUBJECT
			, MOM_BODY
			, MOM_READ
			, USR.DISPLAY_NAME
			, ML.TIME
	FROM	MOM_MAIL ML 
	INNER JOIN	MOM_USR USR ON ML.MOM_USR_ID = USR.ID
	WHERE	ML.ID = @MAIL_ID

GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_ADD') IS NOT NULL
	DROP PROC SP_MOM_RCP_ADD
GO

CREATE PROC SP_MOM_RCP_ADD
(
	  @NAME			VARCHAR (100)
	, @DESCRIPTION	VARCHAR (255)
	, @PHOTO		VARCHAR (255) 	= NULL
	, @TAGS			VARCHAR (255) 	= NULL
	, @PREP_TM		VARCHAR (100) 	= NULL
	, @COOK_TM		VARCHAR (100) 	= NULL
	, @SERVE_TO		VARCHAR (100)	= NULL
	, @DIFFICULTY	VARCHAR (100)
	, @INGREDIENTS	TEXT
	, @METHOD		TEXT	
	, @VEGE			BIT	= NULL
	, @VEGAN		BIT	= NULL
	, @DAIRY		BIT	= NULL
	, @GLUTEN		BIT	= NULL
	, @NUT			BIT	= NULL
	, @ALLOW		BIT	= NULL
	, @MOM_USR_ID	BIGINT
	, @NAMESPACE	VARCHAR(50)
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	BEGIN TRAN
	
	BEGIN TRY

	DECLARE @ID INT;

	INSERT INTO MOM_RCP
	(
		  NAME
		, DESCRIPTION
		, PHOTO
		, PREP_TM
		, COOK_TM
		, SERVE_TO
		, DIFFICULTY
		, INGREDIENTS
		, METHOD
		, VEGE
		, VEGAN
		, DAIRY
		, GLUTEN
		, NUT
		, ALLOW
		, MOM_USR_ID

	)
	VALUES
	(
		  @NAME
		, @DESCRIPTION
		, @PHOTO
		, @PREP_TM
		, @COOK_TM
		, @SERVE_TO
		, @DIFFICULTY
		, @INGREDIENTS
		, @METHOD
		, @VEGE
		, @VEGAN
		, @DAIRY
		, @GLUTEN
		, @NUT
		, @ALLOW
		, @MOM_USR_ID
	)

	SET @ID = SCOPE_IDENTITY(); 
	
	DECLARE @TAG VARCHAR(50);
	DECLARE @POS INT;

	SET @TAGS = LTRIM(RTRIM(@TAGS))+ ','
	SET @POS = CHARINDEX(',', @TAGS, 1)

	IF REPLACE(@TAGS, ',', '') <> ''
	BEGIN
		WHILE @POS > 0
		BEGIN
			SET @TAG = LTRIM(RTRIM(LEFT(@TAGS, @POS - 1)))
			IF @TAG <> ''
			BEGIN
				INSERT INTO MOM_TAGS 
				(
					  TAG
					, MOM_ID
					, NAMESPACE
				) 
				VALUES 
				(
					  @TAG
					, @ID
					, @NAMESPACE
				) 
			END
			SET @TAGS = RIGHT(@TAGS, LEN(@TAGS) - @POS)
			SET @POS = CHARINDEX(',', @TAGS, 1)
		END
	END	
	
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

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_RCP_GET_BY_ID') IS NOT NULL
	DROP PROC SP_MOM_RCP_GET_BY_ID
GO

CREATE PROC SP_MOM_RCP_GET_BY_ID
(
	@ID	INT
)
AS	
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	SELECT   ID
			, NAME
			, DESCRIPTION
			, PHOTO = ISNULL (PHOTO, '../images/nopic.jpg')
			, PREP_TM
			, COOK_TM
			, SERVE_TO
			, DIFFICULTY
			, INGREDIENTS
			, METHOD
			, VEGE
			, VEGAN
			, DAIRY
			, GLUTEN
			, NUT
			, ALLOW
			, VIEWS
			, RATING
			, MOM_USR_ID
	FROM MOM_RCP
	WHERE ID = @ID 

	
	SELECT DISTINCT
			MOM_ID,
			NAMESPACE,
			(STUFF(
			(SELECT ', ' + TAG 
			 FROM	MOM_TAGS T2 
			 WHERE T2.NAMESPACE = T1.NAMESPACE 
				   AND T2.MOM_ID = T2.MOM_ID 
			 FOR XML PATH('')),1,2,'')) AS TAGS
	FROM MOM_TAGS T1
	WHERE MOM_ID = @ID
	
GO

-----------------------------------------------------------------------------------------

IF OBJECT_ID('SP_MOM_BLG_MOM_BLG_CMT_GET_BY_MOM_BLG_ID') IS NOT NULL
	DROP PROC SP_MOM_BLG_MOM_BLG_CMT_GET_BY_MOM_BLG_ID
GO

CREATE PROC SP_MOM_BLG_MOM_BLG_CMT_GET_BY_MOM_BLG_ID
(
	  @MOM_BLG_ID	INT
)
AS
	SET TRAN ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON
	
	UPDATE	MOM_BLG
	SET	VIEWS	= ISNULL (VIEWS, 0) + 1
	WHERE	ID = @MOM_BLG_ID
	
	SELECT	  MB.MOM_USR_ID
		, MB.TITLE
		, MB.BLOG
		, TIME		= DBO.FN_MOM_DATE_DIFF(MB.TIME, GETDATE())
		, MU.DISPLAY_NAME
		, PICTURE	= ISNULL (MU.PICTURE, '../images/q_silhouette.gif')
		, VIEWS		= ISNULL (MB.VIEWS, 0)
		, ALLOW_COMMENTS
	FROM	MOM_BLG MB (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MB.MOM_USR_ID = MU.ID
	WHERE	MB.ID = @MOM_BLG_ID
	
	SELECT	  MBC.MOM_USR_ID
		, PICTURE	= ISNULL (MU.PICTURE, '../images/q_silhouette.gif')
		, TIME		= DBO.FN_MOM_DATE_DIFF(MBC.TIME, GETDATE())
		, MU.DISPLAY_NAME
		, MBC.COMMENTS
	FROM	MOM_BLG_CMT MBC (NOLOCK)
		INNER JOIN MOM_USR MU (NOLOCK)
		ON	MBC.MOM_USR_ID = MU.ID
	WHERE	MBC.MOM_BLG_ID = @MOM_BLG_ID
GO

IF OBJECT_ID('SP_MOM_BLG_CMT_ADD') IS NOT NULL
	DROP PROC SP_MOM_BLG_CMT_ADD
GO

CREATE PROC SP_MOM_BLG_CMT_ADD
(
	  @MOM_USR_ID	BIGINT
	, @MOM_BLG_ID	INT
	, @COMMENTS	NTEXT
)
AS
	BEGIN TRAN
	BEGIN TRY
		
		INSERT INTO MOM_BLG_CMT
		(
			  MOM_USR_ID
			, MOM_BLG_ID
			, COMMENTS
		)
		VALUES
		(
			  @MOM_USR_ID
			, @MOM_BLG_ID
			, @COMMENTS
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