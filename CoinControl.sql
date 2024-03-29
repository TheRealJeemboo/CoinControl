USE [CoinControl]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Trans_Category] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Trans_Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Expense]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Expense](
	[Amount] [money] NOT NULL,
	[Trans_Datetime] [datetime] NOT NULL,
	[User_ID] [bigint] NOT NULL,
	[Type] [varchar](20) NOT NULL,
	[Trans_ID] [bigint] NOT NULL,
	[Note] [text] NULL,
	[Payment_ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Expense] PRIMARY KEY CLUSTERED 
(
	[Trans_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Income]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Income](
	[Amount] [money] NOT NULL,
	[Trans_Datetime] [datetime] NOT NULL,
	[User_ID] [bigint] NOT NULL,
	[Type] [varchar](20) NOT NULL,
	[Trans_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Note] [text] NULL,
 CONSTRAINT [PK_Income_1] PRIMARY KEY CLUSTERED 
(
	[Trans_Datetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log](
	[Trans_Datetime] [datetime] NOT NULL,
	[Trans_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[User_ID] [bigint] NOT NULL,
	[Trans_Category] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment_Method]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Method](
	[Amount] [money] NOT NULL,
	[User_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Payment_ID] [bigint] NOT NULL,
 CONSTRAINT [PK_Payment_Method] PRIMARY KEY CLUSTERED 
(
	[Payment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10 Mar 2024 22:36:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[User_ID] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[User_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Expense] ADD  CONSTRAINT [DF_Expense_Trans_Date]  DEFAULT (getdate()) FOR [Trans_Datetime]
GO
ALTER TABLE [dbo].[Income] ADD  CONSTRAINT [DF_Income_Trans_Date]  DEFAULT (getdate()) FOR [Trans_Datetime]
GO
ALTER TABLE [dbo].[Log] ADD  CONSTRAINT [DF_Log_Trans_Date]  DEFAULT (getdate()) FOR [Trans_Datetime]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_Payment_Method] FOREIGN KEY([Payment_ID])
REFERENCES [dbo].[Payment_Method] ([Payment_ID])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_Payment_Method]
GO
ALTER TABLE [dbo].[Expense]  WITH CHECK ADD  CONSTRAINT [FK_Expense_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[Expense] CHECK CONSTRAINT [FK_Expense_User]
GO
ALTER TABLE [dbo].[Income]  WITH CHECK ADD  CONSTRAINT [FK_Income_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[Income] CHECK CONSTRAINT [FK_Income_User]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_Category] FOREIGN KEY([Trans_Category])
REFERENCES [dbo].[Category] ([Trans_Category])
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_Category]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_Expense] FOREIGN KEY([Trans_Datetime])
REFERENCES [dbo].[Expense] ([Trans_Datetime])
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_Expense]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_Income] FOREIGN KEY([Trans_Datetime])
REFERENCES [dbo].[Income] ([Trans_Datetime])
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_Income]
GO
ALTER TABLE [dbo].[Log]  WITH CHECK ADD  CONSTRAINT [FK_Log_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[Log] CHECK CONSTRAINT [FK_Log_User]
GO
ALTER TABLE [dbo].[Payment_Method]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Method_User] FOREIGN KEY([User_ID])
REFERENCES [dbo].[User] ([User_ID])
GO
ALTER TABLE [dbo].[Payment_Method] CHECK CONSTRAINT [FK_Payment_Method_User]
GO
