IF OBJECT_ID('MOM_TAGS') IS NOT NULL
	DROP TABLE MOM_TAGS

CREATE TABLE MOM_TAGS(
		  ID			INT				NOT NULL	IDENTITY(1,1)
		, TAG			VARCHAR(100)	NOT NULL
		, NAMESPACE		VARCHAR(50)		NOT NULL
		, MOM_ID		INT				NOT NULL
)