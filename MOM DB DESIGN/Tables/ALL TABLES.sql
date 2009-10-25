IF OBJECT_ID('MOM_FRG_CMNT') IS NOT NULL
	DROP TABLE MOM_FRG_CMNT

CREATE TABLE MOM_FRG_CMNT
(
	  ID		INT IDENTITY (1, 1)
	, MOM_FRG_ID	INT
	, MOM_USR_ID	BIGINT
	, COMMENTS	NVARCHAR (255)
	, TIME		DATETIME DEFAULT (GETDATE())
	, DELETED	BIT DEFAULT (0)
)

IF OBJECT_ID('MOM_FRG') IS NOT NULL
	DROP TABLE MOM_FRG

CREATE TABLE MOM_FRG
(
	  ID		INT IDENTITY (1, 1)
	, MOM_USR_ID	BIGINT
	, GRP_MOM_USR_ID	BIGINT
	, SHARE		NVARCHAR (255)
	, TYPE		CHAR (1)
	, TYPE_SHARE	NVARCHAR (4000)
	, TIME		DATETIME DEFAULT (GETDATE())
	, HIDE		BIT DEFAULT (0)
	, FRIDGE_OPTION	INT --1 USERS, 2 GROUPS
)

--ALTER TABLE MOM_FRG ADD GRP_MOM_USR_ID BIGINT

IF OBJECT_ID('MOM_QSTN') IS NOT NULL
	DROP TABLE MOM_QSTN

CREATE TABLE MOM_QSTN
(
	  ID		INT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, MOM_CATG_ID	INT
	, QUESTION	NVARCHAR (100)
	, DESCRIPTION	NVARCHAR (2000)
	, EMAIL_STATUS	BIT
	, STATUS		BIT DEFAULT (1)
	, TIME		DATETIME	DEFAULT (GETDATE())
	, ABUSE		BIT DEFAULT(0)	
	, ANSWERS_COUNT	INT
)

CREATE TABLE [dbo].[MOM_PLNR](
	[ID] [int] NULL,
	[MOM_USR_ID] [bigint] NULL,
	[MOM_PLNR_TIME] [datetime] NULL,
	[NOTES] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TIME] [datetime] NULL
)


IF OBJECT_ID('MOM_ANWS') IS NOT NULL
	DROP TABLE MOM_ANWS

CREATE TABLE MOM_ANWS
(
	  ID		INT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, MOM_QSTN_ID	INT
	, ANSWER		NVARCHAR (1000)
	, TIME		DATETIME DEFAULT (GETDATE())
	, ABUSE		BIT DEFAULT (0)
)

IF OBJECT_ID('MOM_CATG') IS NOT NULL
	DROP TABLE MOM_CATG

CREATE TABLE MOM_CATG
(
	  ID	INT IDENTITY(1, 1)
	, NAME	NVARCHAR (100)
	, TIME	DATETIME DEFAULT (GETDATE())
)

INSERT INTO MOM_CATG(NAME) VALUES ('Best of Answers')
INSERT INTO MOM_CATG(NAME) VALUES ('Arts & Humanities')
INSERT INTO MOM_CATG(NAME) VALUES ('Beauty & Style')
INSERT INTO MOM_CATG(NAME) VALUES ('Business & Finance')
INSERT INTO MOM_CATG(NAME) VALUES ('Cars & Transportation')
INSERT INTO MOM_CATG(NAME) VALUES ('Computers & Internet')
INSERT INTO MOM_CATG(NAME) VALUES ('Consumer Electronics')
INSERT INTO MOM_CATG(NAME) VALUES ('Dining Out')
INSERT INTO MOM_CATG(NAME) VALUES ('Education & Reference')
INSERT INTO MOM_CATG(NAME) VALUES ('Entertainment & Music')
INSERT INTO MOM_CATG(NAME) VALUES ('Environment')
INSERT INTO MOM_CATG(NAME) VALUES ('Family & Relationships')
INSERT INTO MOM_CATG(NAME) VALUES ('Food & Drink')
INSERT INTO MOM_CATG(NAME) VALUES ('Games & Recreation')
INSERT INTO MOM_CATG(NAME) VALUES ('Health')
INSERT INTO MOM_CATG(NAME) VALUES ('Home & Garden')
INSERT INTO MOM_CATG(NAME) VALUES ('Local Businesses')
INSERT INTO MOM_CATG(NAME) VALUES ('News & Events')
INSERT INTO MOM_CATG(NAME) VALUES ('Pets')
INSERT INTO MOM_CATG(NAME) VALUES ('Politics & Government')
INSERT INTO MOM_CATG(NAME) VALUES ('Pregnancy & Parenting')
INSERT INTO MOM_CATG(NAME) VALUES ('Science & Mathematics')
INSERT INTO MOM_CATG(NAME) VALUES ('Social Science')
INSERT INTO MOM_CATG(NAME) VALUES ('Society & Culture')
INSERT INTO MOM_CATG(NAME) VALUES ('Sports')
INSERT INTO MOM_CATG(NAME) VALUES ('Travel')


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
	, TYPE		CHAR (1) DEFAULT 'U'
	, TIME		DATETIME DEFAULT(GETDATE())
	, LAST_LOGIN_DATE	DATETIME
	, ACTIVE		BIT DEFAULT (0)
	, BLOCKED	BIT DEFAULT (0)
	, PICTURE	NVARCHAR (255)
	, PICTURE_STATUS	BIT DEFAULT (0)
)

IF OBJECT_ID('MOM_IP_TRK') IS NOT NULL
	DROP TABLE MOM_IP_TRK

CREATE TABLE MOM_IP_TRK
(
	  ID		INT IDENTITY (1, 1)
	, IP_ADR		NVARCHAR (20)
	, SYS_USR	NVARCHAR (100)
	, MOM_USR_ID	BIGINT
	, TIME		DATETIME DEFAULT (GETDATE())
)

IF OBJECT_ID('MOM_BLG') IS NOT NULL
	DROP TABLE MOM_BLG

CREATE TABLE MOM_BLG
(
	  ID		INT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, TITLE		NVARCHAR (100)
	, BLOG		NTEXT
	, TAGS		NVARCHAR (100)
	, PRIVACY	NVARCHAR (50)
	, ALLOW_COMMENTS	BIT
	, EMAIL_STATUS	BIT
	, TIME		DATETIME DEFAULT (GETDATE())
	, ABUSE		BIT DEFAULT (0)
	, VIEWS		INT DEFAULT (0)
	, RATE		SMALLINT
)

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
	, TIME		DATETIME DEFAULT (GETDATE())
)

IF OBJECT_ID('MOM_FRND') IS NOT NULL
	DROP TABLE MOM_FRND

CREATE TABLE MOM_FRND
(
	  ID		BIGINT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, FRND_MOM_USR_ID	BIGINT
	, TIME		DATETIME DEFAULT (GETDATE())
	, BLOCKED	BIT DEFAULT (0)
	, BLOCKED_TIME	DATETIME
)

IF OBJECT_ID('MOM_GRP') IS NOT NULL
	DROP TABLE MOM_GRP
	
CREATE TABLE MOM_GRP
(
	  ID		INT IDENTITY (1, 1)
	, GRP_MOM_USR_ID	BIGINT
	, MOM_USR_ID	BIGINT
	, NAME		NVARCHAR (255)
	, DESCRIPTION	NVARCHAR (500)
	, TYPE		NVARCHAR (50)
	, RECENT_NEWS	NVARCHAR (500)
	, OFFICE		NVARCHAR (100)
	, EMAIL_ADDR	NVARCHAR (255)
	, STREET		NVARCHAR (100)
	, CITY		NVARCHAR (100)
	, PICTURE	VARCHAR (255)
	, MEMBERS	INT
	, TIME		DATETIME DEFAULT (GETDATE()) 
	, BLOCKED	BIT DEFAULT (0)
	, BLOCKED_TIME	DATETIME
)

IF OBJECT_ID('MOM_GRP_USR') IS NOT NULL
	DROP TABLE MOM_GRP_USR
	
CREATE TABLE MOM_GRP_USR
(
	  ID		INT IDENTITY (1, 1)
	, MOM_GRP_ID	INT
	, MOM_USR_ID	BIGINT
	, TIME		DATETIME DEFAULT (GETDATE())
	, BLOCKED	BIT DEFAULT (0)
	, BLOCKED_TIME	DATETIME
)

IF OBJECT_ID('MOM_RCP') IS NOT NULL
	DROP TABLE MOM_RCP

CREATE TABLE MOM_RCP(
	  ID			INT				NOT NULL	IDENTITY(1,1)
	, NAME			VARCHAR(100)	NOT NULL
	, DESCRIPTION	VARCHAR(255)	NULL
	, PHOTO			VARCHAR(255)	NULL
	, PREP_TM		VARCHAR(100)	NULL
	, COOK_TM		VARCHAR(100)	NULL
	, SERVE_TO		VARCHAR(100)	NULL
	, DIFFICULTY	VARCHAR(100)	NOT NULL
	, INGREDIENTS	TEXT			NOT NULL
	, METHOD		TEXT			NOT NULL
	, VEGE			BIT				NULL
	, VEGAN			BIT				NULL
	, DAIRY			BIT				NULL
	, GLUTEN		BIT				NULL
	, NUT			BIT				NULL
	, ALLOW			BIT				NULL
	, VIEWS			BIGINT			NULL		DEFAULT ((0))
	, RATING		FLOAT			NULL		DEFAULT ((0))
	, MOM_USR_ID	BIGINT			NULL
	, TIME			DATETIME		NOT NULL	DEFAULT (GETDATE())
)

IF OBJECT_ID('MOM_FAV_RCP') IS NOT NULL
	DROP TABLE MOM_FAV_RCP


CREATE TABLE MOM_FAV_RCP(
	  ID			INT			NOT NULL	IDENTITY(1,1)
	, MOM_RCP_ID	INT			NOT NULL
	, MOM_USR_ID	BIGINT		NOT NULL
	, TIME			DATETIME	NOT NULL	DEFAULT (GETDATE())
) 

IF OBJECT_ID('MOM_RCP_CMT') IS NOT NULL
	DROP TABLE MOM_RCP_CMT

CREATE TABLE MOM_RCP_CMT(
	  ID			INT			NOT NULL	IDENTITY(1,1)
	, MOM_RCP_ID	INT			NOT NULL
	, MOM_USR_ID	BIGINT		NOT NULL
	, COMMENTS		TEXT		NOT NULL
	, TIME			DATETIME	NOT NULL	DEFAULT (GETDATE())
)

IF OBJECT_ID('MOM_TAGS') IS NOT NULL
	DROP TABLE MOM_TAGS

CREATE TABLE MOM_TAGS(
		  ID			INT				NOT NULL	IDENTITY(1,1)
		, TAG			VARCHAR(100)	NOT NULL
		, NAMESPACE		VARCHAR(50)		NOT NULL
		, MOM_ID		INT				NOT NULL
)

IF OBJECT_ID('MOM_MAIL') IS NOT NULL
	DROP TABLE MOM_MAIL
	
CREATE TABLE MOM_MAIL
(
	  ID			INT				NOT NULL	IDENTITY(1,1)
	, MOM_USR_ID	BIGINT			NOT NULL
	, MOM_TO_EMAIL	VARCHAR(255)	NULL
	, MOM_SUBJECT	VARCHAR(100)	NULL	
	, MOM_BODY		TEXT			NULL	
	, MOM_READ		BIT				NULL		DEFAULT ((0))
	, TIME			DATETIME		NOT NULL	DEFAULT (GETDATE())
)


IF OBJECT_ID('MOM_BLG_CMT') IS NOT NULL
	DROP TABLE MOM_BLG_CMT

CREATE TABLE MOM_BLG_CMT
(
	  ID		INT IDENTITY (1,1)
	, MOM_USR_ID	BIGINT
	, MOM_BLG_ID	INT
	, COMMENTS	NTEXT
	, TIME		DATETIME DEFAULT (GETDATE())
)

IF OBJECT_ID('MOM_TAGS') IS NOT NULL
	DROP TABLE MOM_TAGS

CREATE TABLE MOM_TAGS(
		  ID			INT				NOT NULL	IDENTITY(1,1)
		, TAG			VARCHAR(100)	
		, NAMESPACE		VARCHAR(50)		
		, MOM_ID		INT				
)