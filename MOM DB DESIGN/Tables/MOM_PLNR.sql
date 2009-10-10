USE [Momburbia]
GO
/****** Object:  Table [dbo].[MOM_PLNR]    Script Date: 08/01/2009 18:45:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOM_PLNR](
	[ID] [int] NULL,
	[MOM_USR_ID] [bigint] NULL,
	[MOM_PLNR_TIME] [datetime] NULL,
	[NOTES] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TIME] [datetime] NULL
) ON [PRIMARY]
