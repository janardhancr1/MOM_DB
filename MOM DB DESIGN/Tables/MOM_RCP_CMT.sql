IF OBJECT_ID('MOM_RCP_CMT') IS NOT NULL
	DROP TABLE MOM_RCP_CMT

CREATE TABLE MOM_RCP_CMT(
	  ID			INT			NOT NULL	IDENTITY(1,1)
	, MOM_RCP_ID	INT			NOT NULL
	, MOM_USR_ID	BIGINT		NOT NULL
	, COMMENTS		TEXT		NOT NULL
	, TIME			DATETIME	NOT NULL	DEFAULT (GETDATE())
)