USE [IARCOD]
GO

/****** Object:  Table [dbo].[Attributes]    Script Date: 11/20/2012 12:59:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Attributes](
	[AttributeID] [int] IDENTITY(1,1) NOT NULL,
	[AttributeName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Attributes_AttributeID] PRIMARY KEY CLUSTERED 
(
	[AttributeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique integer ID for each attribute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attributes', @level2type=N'COLUMN',@level2name=N'AttributeID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the attribute.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attributes', @level2type=N'COLUMN',@level2name=N'AttributeName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Describes non-numeric data values for a Site.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Attributes'
GO

