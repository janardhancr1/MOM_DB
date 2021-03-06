IF OBJECT_ID('MOM_USR') IS NOT NULL
	DROP TABLE MOM_USR

CREATE TABLE MOM_USR
(
	  ID		BIGINT IDENTITY(777777, 1)
	, EMAIL_ADDR	NVARCHAR (255)
	, PASSWORD	NVARCHAR (50)
	, FIRST_NAME	NVARCHAR (50)
	, LAST_NAME	NVARCHAR (50)
	, FULL_NAME	NVARCHAR (100)
	, SEX		NCHAR (1)
	, DOB		DATETIME
	, DISPLAY_NAME	NVARCHAR (25)
	, NEWLETTER	BIT DEFAULT (0)
	, TIME		DATETIME DEFAULT(GETDATE())
	, LAST_LOGIN_DATE	DATETIME
	, ACTIVE		BIT DEFAULT (0)
	, BLOCKED	BIT DEFAULT (0)
	, PICTURE	NVARCHAR (255)
	, PICTURE_STATUS	BIT DEFAULT (0)
)