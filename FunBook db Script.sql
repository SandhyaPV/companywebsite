USE [master]
GO
/****** Object:  Database [dbFunbook]    Script Date: 09-02-2018 3.50.58 PM ******/
CREATE DATABASE [dbFunbook]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbFunbook', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\dbFunbook.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbFunbook_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\dbFunbook_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [dbFunbook] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbFunbook].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbFunbook] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbFunbook] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbFunbook] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbFunbook] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbFunbook] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbFunbook] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbFunbook] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbFunbook] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbFunbook] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbFunbook] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbFunbook] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbFunbook] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbFunbook] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbFunbook] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbFunbook] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbFunbook] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbFunbook] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbFunbook] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbFunbook] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbFunbook] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbFunbook] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbFunbook] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbFunbook] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [dbFunbook] SET  MULTI_USER 
GO
ALTER DATABASE [dbFunbook] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbFunbook] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbFunbook] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbFunbook] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbFunbook] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbFunbook] SET QUERY_STORE = OFF
GO
USE [dbFunbook]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [dbFunbook]
GO
/****** Object:  Table [dbo].[tbl_login]    Script Date: 09-02-2018 3.50.58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_login](
	[lid] [int] NOT NULL,
	[usr_email] [varchar](50) NOT NULL,
	[usr_password] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_login] PRIMARY KEY CLUSTERED 
(
	[usr_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_userdetails]    Script Date: 09-02-2018 3.50.59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_userdetails](
	[rid] [int] NOT NULL,
	[usr_email] [varchar](50) NOT NULL,
	[usr_name] [varchar](50) NULL,
	[is_Superuser] [int] NULL,
 CONSTRAINT [PK_tbl_userdetails] PRIMARY KEY CLUSTERED 
(
	[rid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_userdetails]  WITH CHECK ADD  CONSTRAINT [FK_tbl_userdetails_tbl_login1] FOREIGN KEY([usr_email])
REFERENCES [dbo].[tbl_login] ([usr_email])
GO
ALTER TABLE [dbo].[tbl_userdetails] CHECK CONSTRAINT [FK_tbl_userdetails_tbl_login1]
GO
/****** Object:  StoredProcedure [dbo].[spChecklogin]    Script Date: 09-02-2018 3.50.59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spChecklogin]
(
@email VARCHAR(50),  
@password VARCHAR(50)
)  
AS  
BEGIN  
declare @result int
  select @result=COUNT(*) from tbl_login where usr_email=@email and usr_password=@password
  if(@result=1)
  select 1
  else
  select 0
end  
GO
/****** Object:  StoredProcedure [dbo].[spGetalldetails]    Script Date: 09-02-2018 3.50.59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetalldetails]

AS
BEGIN
	select a.lid,a.usr_email,a.usr_password,b.usr_name,b.is_Superuser from tbl_login a inner join tbl_userdetails b on a.usr_email=b.usr_email 
END
GO
/****** Object:  StoredProcedure [dbo].[spGetusers]    Script Date: 09-02-2018 3.50.59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGetusers]

AS
BEGIN
	select * from tbl_login 
END
GO
/****** Object:  StoredProcedure [dbo].[spUserReg]    Script Date: 09-02-2018 3.50.59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUserReg]
(  
@email VARCHAR(50),  
@name VARCHAR(30),
@password VARCHAR(30)   
)  
AS  
BEGIN  
declare @rgid int,@lgid int,@rresult int,@lresult int
select @rgid=MAX(rid) FROM tbl_userdetails 
select @lgid=MAX(lid) FROM tbl_login


if(@rgid is null)
set @rgid=0;
if(@lgid is null)
set @lgid=0;

insert into tbl_login(lid,usr_email,usr_password) values(@lgid+1, @email,CONVERT(VARCHAR(32), HashBytes('MD5', @password), 2)) 
if(@@ROWCOUNT>0)
set @lresult = 1
else
set @lresult=0
insert into tbl_userdetails(rid,usr_email,usr_name,is_Superuser) values(@rgid+1, @email,@name,'0')
if(@@ROWCOUNT>0)
set @rresult = 1
else
set @rresult=0
if(@lresult=1 and @rresult=1)
 select '1' as result
 else
 select '0' as result
end  
GO
USE [master]
GO
ALTER DATABASE [dbFunbook] SET  READ_WRITE 
GO
