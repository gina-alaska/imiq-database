USE [IARCOD]
GO

/****** Object:  UserDefinedFunction [dbo].[DateRange]    Script Date: 01/09/2015 13:50:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[DateRange]
(     
      @Increment              CHAR(1),
      @StartDate              DATETIME,
      @EndDate                DATETIME
)
RETURNS  
@SelectedRange    TABLE 
(IndividualDate DATETIME)
AS 
BEGIN
      ;WITH cteRange (DateRange) AS (
            SELECT @StartDate
            UNION ALL
            SELECT 
                  CASE
                        WHEN @Increment = 'd' THEN DATEADD(dd, 1, DateRange)
                        WHEN @Increment = 'h' THEN DATEADD(hh, 1, DateRange)
                  END
            FROM cteRange
            WHERE DateRange <= 
                  CASE
                        WHEN @Increment = 'd' THEN DATEADD(dd, -1, @EndDate)
                        WHEN @Increment = 'h' THEN DATEADD(hh, -1, @EndDate)
                  END)
          
      INSERT INTO @SelectedRange (IndividualDate)
      SELECT DateRange
      FROM cteRange
      OPTION (MAXRECURSION 32767);
      RETURN
END

GO

