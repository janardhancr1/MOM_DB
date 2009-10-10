IF OBJECT_ID('MOM_FRND_RQST') IS NOT NULL
	DROP TABLE MOM_FRND_RQST

CREATE TABLE MOM_FRND_RQST
(
	  ID		INT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, MOM_FRND_USR_ID	BIGINT
	, SUBJECT	NVARCHAR (100)
	, MESSAGE	NVARCHAR (250)
	, OPENED		BIT
	, FLAG		BIT
	, ARCHIVE	BIT
	, TIME		DATETIME
)