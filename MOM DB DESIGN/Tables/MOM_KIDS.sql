IF OBJECT_ID('MOM_KIDS') IS NOT NULL
	DROP TABLE MOM_RCP

CREATE TABLE MOM_KIDS(
	  ID				INT				NOT NULL	IDENTITY(1,1)
	, KID_FIRST_NAME	VARCHAR(100)	NOT NULL
	, KID_GENDER		VARCHAR(255)	NULL
	, KID_DOB			DATETIME		NULL
	, KID_ABOUT			VARCHAR(100)	NULL
	, KID_PHOTO			VARCHAR(100)	NULL
	, MOM_USR_ID		BIGINT			NULL
	, TIME				DATETIME		NOT NULL	DEFAULT (GETDATE())
)