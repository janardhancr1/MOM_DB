ALTER PROC SP_MOM_GRP_ADD
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
BEGIN
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
END