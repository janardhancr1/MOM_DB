IF OBJECT_ID('MOM_BLK_USRS') IS NOT NULL
	DROP TABLE MOM_BLK_USRS

CREATE TABLE MOM_BLK_USRS(
	  ID				BIGINT		NOT NULL IDENTITY(1,1)
	, MOM_BLK_USR_ID	BIGINT		
	, MOM_USR_ID		BIGINT		
	, TIME				DATETIME	NOT NULL	DEFAULT (GETDATE())
)