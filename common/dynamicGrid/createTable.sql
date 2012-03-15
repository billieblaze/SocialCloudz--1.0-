

CREATE TABLE [dbo].[dynamicGrid](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gridName] [varchar](50) NULL,
	[className] [varchar](50) NULL,
	[methodName] [varchar](50) NULL,
	[application] [varchar](50) NULL,
 CONSTRAINT [PK_dynamicGrid_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[DYNAMICGRIDCOLUMNS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[gridName] [nvarchar](50) NULL,
	[name] [nvarchar](100) NULL,
	[hidden] [bit] NOT NULL,
	[viewName] [nvarchar](100) NULL,
	[colOrder] [smallint] NULL,
	[width] [smallint] NULL,
	[PID] [nvarchar](50) NULL,
	[colReorder] [smallint] NULL,
	[label] [nvarchar](100) NULL,
	[formatter] [nvarchar](128) NULL,
	[key] [bit] NULL,
	[classes] [nvarchar](50) NULL,
	[align] [nvarchar](50) NULL,
	[hideDlg] [bit] NULL,
 CONSTRAINT [PK_dynamicGrid] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[DYNAMICGRIDCOLUMNS] ADD  CONSTRAINT [DF_DYNAMICGRIDCOLUMNS_index]  DEFAULT ((0)) FOR [key]
GO

ALTER TABLE [dbo].[DYNAMICGRIDCOLUMNS] ADD  CONSTRAINT [DF_DYNAMICGRIDCOLUMNS_hideDlg]  DEFAULT ((0)) FOR [hideDlg]
GO

