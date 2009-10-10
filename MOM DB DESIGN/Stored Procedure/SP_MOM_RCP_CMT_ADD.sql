
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_MOM_RCP_CMT_ADD]
	@MOM_RCP_ID INT
	, @MOM_USR_ID BIGINT
	, @COMMENTS TEXT
AS
BEGIN
INSERT INTO MOM_RCP_CMT
	(
		  MOM_RCP_ID
		, MOM_USR_ID
		, COMMENTS
	)
	VALUES
	(
		  @MOM_RCP_ID
		, @MOM_USR_ID
		, @COMMENTS
	)
END
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

