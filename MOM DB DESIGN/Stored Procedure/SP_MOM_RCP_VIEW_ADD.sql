--USE [Momburbia_JANA]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOM_RCP_VIEW_ADD]    Script Date: 10/05/2009 22:48:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_MOM_RCP_VIEW_ADD]
	 @MOM_RCP_ID INT
	, @MOM_USR_ID BIGINT
AS
BEGIN
INSERT INTO MOM_RCP_VIEW
	(
		  MOM_RCP_ID
		, MOM_USR_ID
	)
	VALUES
	(
		  @MOM_RCP_ID
		, @MOM_USR_ID
	)
END
