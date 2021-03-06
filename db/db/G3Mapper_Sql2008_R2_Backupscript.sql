USE [master]
GO
DROP DATABASE [AmatG3MapperAppDb]
GO
/****** Object:  Database [AmatG3MapperAppDb]    Script Date: 4/5/2019 5:54:58 PM ******/
CREATE DATABASE [AmatG3MapperAppDb] --ON  PRIMARY 
--( NAME = N'amat_test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\amat_test.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 --LOG ON 
--( NAME = N'amat_test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\amat_test_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AmatG3MapperAppDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET  MULTI_USER 
GO
ALTER DATABASE [AmatG3MapperAppDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AmatG3MapperAppDb] SET DB_CHAINING OFF 
GO
USE [AmatG3MapperAppDb]
GO
/****** Object:  User [amatg3mapperappuser]    Script Date: 4/5/2019 5:55:02 PM ******/
CREATE USER [amatg3mapperappuser] FOR LOGIN [amatg3mapperapp] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'amatg3mapperappuser'
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'amatg3mapperappuser'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'amatg3mapperappuser'
GO
/****** Object:  UserDefinedTableType [dbo].[ChamberConfigList]    Script Date: 4/5/2019 5:55:04 PM ******/
CREATE TYPE [dbo].[ChamberConfigList] AS TABLE(
	[facet_name] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[chamber_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ChamberList]    Script Date: 4/5/2019 5:55:05 PM ******/
CREATE TYPE [dbo].[ChamberList] AS TABLE(
	[id] [bigint] NULL,
	[name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[got_code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[platform_id] [bigint] NULL,
	[appearance_order] [bigint] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FacetList]    Script Date: 4/5/2019 5:55:08 PM ******/
CREATE TYPE [dbo].[FacetList] AS TABLE(
	[id] [bigint] NULL,
	[name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[IdList]    Script Date: 4/5/2019 5:55:09 PM ******/
CREATE TYPE [dbo].[IdList] AS TABLE(
	[id] [bigint] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[NameList]    Script Date: 4/5/2019 5:55:10 PM ******/
CREATE TYPE [dbo].[NameList] AS TABLE(
	[name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ProductConfigList]    Script Date: 4/5/2019 5:55:11 PM ******/
CREATE TYPE [dbo].[ProductConfigList] AS TABLE(
	[product_id] [bigint] NULL,
	[product_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[product_code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nearest_product_config_id] [bigint] NULL,
	[nearest_product_config_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[platform_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[model_svg_filename] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
/****** Object:  StoredProcedure [dbo].[spAddChamber]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE proc [dbo].[spAddChamber]
@Name varchar(50),
@GotCode varchar(50),
@PlatformId bigint
as
begin
    
    
		SET NOCOUNT ON;

		declare @createdId bigint 
		insert into Chamber(name, got_code, platform_id) values(@Name, @GotCode, @PlatformId)
		set @createdId=scope_identity();

		select * from Chamber where id=@createdId;
END;





GO
/****** Object:  StoredProcedure [dbo].[spAddFacet]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spAddFacet]
@Name varchar(50),
@PlatformId bigint
as
begin
    BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;
   

    BEGIN TRY
    
		SET NOCOUNT ON;

		declare @facetId bigint = 0;
		select @facetId = id from Facet where name = @Name;
		if @facetId <= 0
		begin
			insert into Facet(name) values(@Name);
			set @facetId=scope_identity();
		end
		
		declare @existingPlatFormFacetMappingId bigint = 0;
		select @existingPlatFormFacetMappingId = id from PlatformFacetMap where facet_id = @facetId and platform_id = @PlatformId;
		if @existingPlatFormFacetMappingId <= 0
		begin
			insert into PlatformFacetMap(platform_id, facet_id) values(@PlatformId, @facetId);
			set @existingPlatFormFacetMappingId=scope_identity();
		end

		declare @totalFacetsCount int;
		select @totalFacetsCount = count(distinct Facet.id) from Facet INNER JOIN PlatformFacetMap ON Facet.id = PlatformFacetMap.facet_id
		INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id 
		where Platform.id = @PlatformId ;

		update Platform set facets_count = @totalFacetsCount where id = @PlatformId;

		select Facet.id, Facet.name, PlatformFacetMap.platform_id from PlatformFacetMap INNER JOIN Facet on PlatformFacetMap.facet_id = Facet.id
		where PlatformFacetMap.platform_id = @PlatformId and PlatformFacetMap.facet_id = @facetId 


		
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END
    END CATCH
    COMMIT TRANSACTION 
END;









GO
/****** Object:  StoredProcedure [dbo].[spAddFacetsChambersGrouping]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spAddFacetsChambersGrouping]
@ProductConfigId bigint,
@FacetsList IdList READONLY,
@ChambersList IdList READONLY
as
begin

BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;

BEGIN TRY

declare @InputFacetIdsList IdList;
declare @InputChamberIdsList IdList;
insert @InputFacetIdsList select distinct id from @FacetsList;
insert @InputChamberIdsList select distinct id from @ChambersList;


declare @facetListForConfig FacetList;
insert @facetListForConfig exec spGetAllFacetsForProductConfig @ProductConfigId = @ProductConfigId ;

declare @notExistingFacetsCount int
set @notExistingFacetsCount = 0;
select  @notExistingFacetsCount = count(distinct id)  from @InputFacetIdsList where id not in (select id from @facetListForConfig)

if(@notExistingFacetsCount > 0)
begin
	RAISERROR('Invalid Facets selection', 16, 1)
end



declare @notExistingChambersCount int
set @notExistingChambersCount = 0;
select  @notExistingChambersCount = count(distinct id)  from @InputChamberIdsList where id not in (select id from Chamber)

if(@notExistingChambersCount > 0)
begin
	RAISERROR('Invalid Chambers selection', 16, 2)
end



declare @matchingFacetGroupName varchar(10)
SELECT @matchingFacetGroupName =  STUFF((
    SELECT  name
    FROM Facet
	where id in (select distinct id from @FacetsList) order by name
    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 0, '') 


--print @matchingFacetGroupName
declare @matchingFacetGroupId bigint = 0;
set @matchingFacetGroupId = 0;
select @matchingFacetGroupId = id from FacetGroup where name = @matchingFacetGroupName

--print @matchingFacetGroupId
declare @facetGroupId bigint 
if(@matchingFacetGroupId <= 0)
begin
	insert into FacetGroup(name) values(@matchingFacetGroupName)
	set @facetGroupId=scope_identity();

	insert into FacetGroupMap(facet_group_id, facet_id) select @facetGroupId, id from @InputFacetIdsList
end
else 
begin
	set @facetGroupId = @matchingFacetGroupId 
end


declare @allFacetGroupIdsForProductConfig IdList
insert @allFacetGroupIdsForProductConfig(id) select distinct FacetGroup.id as id from FacetGroup INNER JOIN ProductConfigMap ON FacetGroup.id = ProductConfigMap.facet_group_id
INNER JOIN ProductConfig ON ProductConfigMap.product_config_id = ProductConfig.id 
where ProductConfig.id = @ProductConfigId

declare @AlreadyMappedFacetGroupIdCount int = 0
select @AlreadyMappedFacetGroupIdCount = count(id) from @allFacetGroupIdsForProductConfig where id = @facetGroupId 

if(@AlreadyMappedFacetGroupIdCount > 0)
begin
	declare @msg nvarchar(200)
	set @msg =  'There is an existing facet group ' + @matchingFacetGroupName + ' for this product config having chamber mappings. Please delete it first and try again.';
	RAISERROR( @msg, 16, 3)
end


insert into ProductConfigMap(product_config_id, facet_group_id, chamber_id) 
select @ProductConfigId, @facetGroupId, id from @InputChamberIdsList

exec spUpdateMinFacetGroupsCountInPlatformForConfig @ProductConfigId = @ProductConfigId ;

END TRY

BEGIN CATCH 

IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END

DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
	
END CATCH 

COMMIT TRANSACTION 

end;


GO
/****** Object:  StoredProcedure [dbo].[spAddG2Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spAddG2Product]
@Name varchar(100),
@RndProductName varchar(100),
@RndProductCode varchar(50),
@PlatformId bigint
as
begin
    
    
		SET NOCOUNT ON;

		declare @createdId bigint 
		insert into G2ProductType(name, rnd_product_name, rnd_product_code, platform_id) values(@Name, @RndProductName, @RndProductCode, @PlatformId)
		set @createdId=scope_identity();

		select * from G2ProductType where id=@createdId;
END;






GO
/****** Object:  StoredProcedure [dbo].[spAddG3Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spAddG3Product]
@Name varchar(100),
@Code varchar(5),
@G2ProductId bigint
as
begin
    
    
		SET NOCOUNT ON;

		declare @createdId bigint 
		insert into Product(name, code, g2_product_type_id) values(@Name, @Code, @G2ProductId)
		set @createdId=scope_identity();

		select * from Product where id=@createdId;
END;







GO
/****** Object:  StoredProcedure [dbo].[spAddOpportunity]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE proc [dbo].[spAddOpportunity]
@OpId varchar(10),
@ProductInfo ProductConfigList READONLY,
@ChamberConfigInfo ChamberConfigList READONLY,
@CreatedById varchar(50),
@CreatedByName varchar(100),
@OpCreatedId bigint output
as
begin
    BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;
   

    BEGIN TRY
    
		SET NOCOUNT ON;

		insert into Opportunity(op_id, created_by_id, created_by_name, product_name, product_code, nearest_product_config_name, platform_name)
		select @OpId, @CreatedById, @CreatedByName, product_name, product_code, nearest_product_config_name, platform_name from @ProductInfo

		declare @createdId bigint 
		set @createdId=scope_identity();



		insert into OpportunityConfig(opportunity_id,facet_name, chamber_name)
		select @createdId, facet_name, chamber_name from @ChamberConfigInfo

		select @OpCreatedId = @createdId

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END
    END CATCH
    COMMIT TRANSACTION 
END;









GO
/****** Object:  StoredProcedure [dbo].[spAddPlatform]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[spAddPlatform]
@Name varchar(50),
@ModelSvgFilename varchar(50)
as
begin
    
    
		SET NOCOUNT ON;

		declare @createdId bigint 
		insert into Platform(name, model_svg_filename) values(@Name, @ModelSvgFilename)
		set @createdId=scope_identity();

		select * from Platform where id=@createdId;
END;







GO
/****** Object:  StoredProcedure [dbo].[spAddProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spAddProductConfig]
@ProductName varchar(100),
@G3ProductId bigint
as
begin
    
    
		SET NOCOUNT ON;

		declare @createdId bigint 
		insert into ProductConfig(product_name, product_id) values(@ProductName, @G3ProductId)
		set @createdId=scope_identity();

		select * from ProductConfig where id=@createdId;
END;








GO
/****** Object:  StoredProcedure [dbo].[spDeleteChamber]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spDeleteChamber]
@id bigint
AS
BEGIN
    
	delete from Chamber where id = @id

END;




GO
/****** Object:  StoredProcedure [dbo].[spDeleteFacet]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spDeleteFacet]
@Id bigint,
@PlatformId bigint
AS
BEGIN
    
	BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;
   

    BEGIN TRY
    
		SET NOCOUNT ON;

		delete from PlatformFacetMap where facet_id = @Id and platform_id = @PlatformId
		
		declare @existingFacetMappingsCount int = 0;
		select count(PlatformFacetMap.id) from PlatformFacetMap where facet_id = @Id;
		if @existingFacetMappingsCount <= 0
		begin
			delete from Facet where id = @Id
		end

		declare @totalFacetsCount int;
		select @totalFacetsCount = count(distinct Facet.id) from Facet INNER JOIN PlatformFacetMap ON Facet.id = PlatformFacetMap.facet_id
		INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id 
		where Platform.id = @PlatformId ;

		update Platform set facets_count = @totalFacetsCount where id = @PlatformId;

		
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END
    END CATCH
    COMMIT TRANSACTION 

	

END;




GO
/****** Object:  StoredProcedure [dbo].[spDeleteFacetsChambersGrouping]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spDeleteFacetsChambersGrouping]
@ProductConfigId bigint,
@FacetGroupId bigint
as
begin
    
	BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;

BEGIN TRY
    
		SET NOCOUNT ON;

		delete from ProductConfigMap where product_config_id = @ProductConfigId 
		and facet_group_id = @FacetGroupId


exec spUpdateMinFacetGroupsCountInPlatformForConfig @ProductConfigId = @ProductConfigId ;


END TRY

BEGIN CATCH 

IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END

DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
	
END CATCH 

COMMIT TRANSACTION 
		
END;




GO
/****** Object:  StoredProcedure [dbo].[spDeleteG2Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spDeleteG2Product]
@id bigint
AS
BEGIN
    
	delete from G2ProductType where id = @id

END;






GO
/****** Object:  StoredProcedure [dbo].[spDeleteG3Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spDeleteG3Product]
@id bigint
AS
BEGIN
    
	delete from Product where id = @id

END;


GO
/****** Object:  StoredProcedure [dbo].[spDeletePlatform]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spDeletePlatform]
@id bigint
AS
BEGIN
    
	delete from Platform where id = @id

END;





GO
/****** Object:  StoredProcedure [dbo].[spDeleteProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spDeleteProductConfig]
@Id bigint
as
begin
    
    BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;

BEGIN TRY

	delete from ProductConfigMap where product_config_id = @Id
	exec spUpdateMinFacetGroupsCountInPlatformForConfig @ProductConfigId = @Id ;
	delete from ProductConfig where id = @Id

	
END TRY

BEGIN CATCH 

IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END

DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

    -- Use RAISERROR inside the CATCH block to return error
    -- information about the original error that caused
    -- execution to jump to the CATCH block.
    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
	
END CATCH 

COMMIT TRANSACTION 

		
END;




GO
/****** Object:  StoredProcedure [dbo].[spFindChambers]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spFindChambers]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(50) = null,
	@GotCode varchar(50) = null,
	@PlatformId bigint=null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(50),
    @lGotCode NVARCHAR(50),
	@lPlatformId bigint,
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name
    SET @lGotCode = LTRIM(RTRIM(@GotCode))
    SET @lPlatformId = @PlatformId

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'name' AND @SortOrder='ASC')
                  THEN name
        END ASC,
        CASE WHEN @lSortCol = 'name' AND @SortOrder='DESC'
                THEN name
        END DESC,

        CASE WHEN @lSortCol = 'got_code' AND @SortOrder='ASC'
                THEN got_code
        END ASC,
        CASE WHEN @lSortCol = 'got_code' AND @SortOrder='DESC'
                THEN got_code
        END DESC

  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  name,
  got_code,
  platform_id
 FROM Chamber
 WHERE
    ((@lId IS NULL OR id = @lId)
    OR(@lName IS NULL OR name LIKE '%' + @lName + '%')
    OR(@lGotCode IS NULL OR got_code LIKE '%' + @lGotCode + '%'))
	AND (platform_id = @lPlatformId)
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    name,
    got_code,
	platform_id
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END


GO
/****** Object:  StoredProcedure [dbo].[spFindFacets]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spFindFacets]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(50) = null,
	@PlatformId bigint=null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(50),
	@lPlatformId bigint,
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name
	SET @lPlatformId = @PlatformId
    

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN Facet.id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN Facet.id
        END DESC,

        CASE WHEN (@lSortCol = 'name' AND @SortOrder='ASC')
                  THEN Facet.name
        END ASC,
        CASE WHEN @lSortCol = 'name' AND @SortOrder='DESC'
                THEN Facet.name
        END DESC


  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  Facet.id as id,
  Facet.name as name,
  PlatformFacetMap.platform_id as platform_id
 FROM Facet INNER JOIN PlatformFacetMap ON Facet.id = PlatformFacetMap.facet_id
 INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id
 WHERE
    ((@lId IS NULL OR Facet.id = @lId)
    OR(@lName IS NULL OR Facet.name LIKE '%' + @lName + '%'))
    
		AND (PlatformFacetMap.platform_id = @lPlatformId)
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    name,
	platform_id
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END






GO
/****** Object:  StoredProcedure [dbo].[spFindG2Products]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spFindG2Products]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(50) = null,
	@RndProductName varchar(100)=null,
	@RndProductCode varchar(50)=null,
	@PlatformId bigint=null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(50),
	@lRndProductName NVARCHAR(100),
	@lRndProductCode NVARCHAR(50),
	@lPlatformId bigint,
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name
	SET @lRndProductName = @RndProductName
	SET @lRndProductCode = @RndProductCode
	SET @lPlatformId = @PlatformId
    

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'name' AND @SortOrder='ASC')
                  THEN name
        END ASC,
        CASE WHEN @lSortCol = 'name' AND @SortOrder='DESC'
                THEN name
        END DESC,

		CASE WHEN (@lSortCol = 'rnd_product_name' AND @SortOrder='ASC')
                    THEN rnd_product_name
        END ASC,
        CASE WHEN (@lSortCol = 'rnd_product_name' AND @SortOrder='DESC')
                  THEN rnd_product_name
        END DESC,

		CASE WHEN (@lSortCol = 'rnd_product_code' AND @SortOrder='ASC')
                    THEN rnd_product_code
        END ASC,
        CASE WHEN (@lSortCol = 'rnd_product_code' AND @SortOrder='DESC')
                  THEN rnd_product_code
        END DESC


  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  name,
  rnd_product_name,
  rnd_product_code,
  platform_id
 FROM G2ProductType
 WHERE
    ((@lId IS NULL OR id = @lId)
    OR(@lName IS NULL OR name LIKE '%' + @lName + '%')
	OR(@lRndProductName IS NULL OR rnd_product_name LIKE '%' + @lRndProductName + '%')
	OR(@lRndProductCode IS NULL OR rnd_product_code LIKE '%' + @lRndProductCode + '%'))
    
		AND (platform_id = @lPlatformId)
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    name,
	rnd_product_name,
	rnd_product_code,
	platform_id
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END




GO
/****** Object:  StoredProcedure [dbo].[spFindG3Products]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spFindG3Products]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(100) = null,
	@Code varchar(50) = null,
	@G2ProductTypeId bigint=null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(100),
	@lCode NVARCHAR(50),
	@lG2ProductTypeId bigint,
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name
	SET @lCode = @Code
	SET @lG2ProductTypeId = @G2ProductTypeId
    

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'name' AND @SortOrder='ASC')
                  THEN name
        END ASC,
        CASE WHEN @lSortCol = 'name' AND @SortOrder='DESC'
                THEN name
        END DESC,

		CASE WHEN (@lSortCol = 'code' AND @SortOrder='ASC')
                  THEN code
        END ASC,
        CASE WHEN @lSortCol = 'code' AND @SortOrder='DESC'
                THEN code
        END DESC


  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  name,
  code,
  g2_product_type_id
 FROM Product
 WHERE
    ((@lId IS NULL OR id = @lId)
    OR(@lName IS NULL OR name LIKE '%' + @lName + '%')
    OR(@lCode IS NULL OR code LIKE '%' + @lCode + '%'))

	AND (g2_product_type_id = @lG2ProductTypeId)
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    name,
	code,
	g2_product_type_id
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END




GO
/****** Object:  StoredProcedure [dbo].[spFindOpportunities]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spFindOpportunities]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@OpId varchar(50) = null,
	@CreatedById varchar(50) = null,
	@CreatedByName varchar(100) = null,
	@ProductName varchar(50) = null,
	@ProductCode varchar(10) = null,
	@PlatformName varchar(50) = null,
	@NearestProductConfigName varchar(50) = null,
	@CDate datetime = null,
	@MDate datetime = null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
	@lOpId varchar(50),
	@lCreatedById varchar(50),
	@lCreatedByName varchar(100),
	@lProductName varchar(50),
	@lProductCode varchar(10),
	@lPlatformName varchar(50),
	@lNearestProductConfigName varchar(50),
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lOpId = LTRIM(RTRIM(@OpId))
	SET @lCreatedById = LTRIM(RTRIM(@CreatedById))
	SET @lCreatedByName = LTRIM(RTRIM(@CreatedByName))
    SET @lProductName = LTRIM(RTRIM(@ProductName))
    SET @lProductCode = LTRIM(RTRIM(@ProductCode))
	SET @lPlatformName = LTRIM(RTRIM(@PlatformName))
	SET @lNearestProductConfigName = LTRIM(RTRIM(@NearestProductConfigName))

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'op_id' AND @SortOrder='ASC')
                  THEN op_id
        END ASC,
        CASE WHEN @lSortCol = 'op_id' AND @SortOrder='DESC'
                THEN op_id
        END DESC,

		CASE WHEN (@lSortCol = 'created_by_id' AND @SortOrder='ASC')
                  THEN created_by_id
        END ASC,
        CASE WHEN @lSortCol = 'created_by_id' AND @SortOrder='DESC'
                THEN created_by_id
        END DESC,

		CASE WHEN (@lSortCol = 'created_by_name' AND @SortOrder='ASC')
                  THEN created_by_name
        END ASC,
        CASE WHEN @lSortCol = 'created_by_name' AND @SortOrder='DESC'
                THEN created_by_name
        END DESC,

        CASE WHEN @lSortCol = 'product_name' AND @SortOrder='ASC'
                THEN product_name
        END ASC,
        CASE WHEN @lSortCol = 'product_name' AND @SortOrder='DESC'
                THEN product_name
        END DESC,

		 CASE WHEN @lSortCol = 'product_code' AND @SortOrder='ASC'
                THEN product_code
        END ASC,
        CASE WHEN @lSortCol = 'product_code' AND @SortOrder='DESC'
                THEN product_code
        END DESC,

		 CASE WHEN @lSortCol = 'platform_name' AND @SortOrder='ASC'
                THEN platform_name
        END ASC,
        CASE WHEN @lSortCol = 'platform_name' AND @SortOrder='DESC'
                THEN platform_name
        END DESC,

		CASE WHEN @lSortCol = 'nearest_product_config_name' AND @SortOrder='ASC'
                THEN nearest_product_config_name
        END ASC,
        CASE WHEN @lSortCol = 'nearest_product_config_name' AND @SortOrder='DESC'
                THEN nearest_product_config_name
        END DESC

  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  op_id,
  created_by_id,
  created_by_name,
  product_name,
  product_code,
  platform_name,
  nearest_product_config_name,
  c_date,
  m_date
 FROM Opportunity
 WHERE
    (@lId IS NULL OR id = @lId)
    OR(@lOpId IS NULL OR op_id LIKE '%' + @lOpId + '%')
	OR(@lCreatedById IS NULL OR created_by_id LIKE '%' + @lCreatedById + '%')
	OR(@lCreatedByName IS NULL OR created_by_name LIKE '%' + @lCreatedByName + '%')
    OR(@lProductName IS NULL OR product_name LIKE '%' + @lProductName + '%')
	OR(@lProductCode IS NULL OR product_code LIKE '%' + @lProductCode + '%')
	OR(@lPlatformName IS NULL OR platform_name LIKE '%' + @lPlatformName + '%')
	OR(@lNearestProductConfigName IS NULL OR nearest_product_config_name LIKE '%' + @lNearestProductConfigName + '%')
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    op_id,
	created_by_id,
	created_by_name,
    product_name,
	product_code,
	platform_name,
	nearest_product_config_name,
	c_date,
	m_date
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END




GO
/****** Object:  StoredProcedure [dbo].[spFindPlatforms]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spFindPlatforms]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(50) = null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(50),

    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name

    

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'name' AND @SortOrder='ASC')
                  THEN name
        END ASC,
        CASE WHEN @lSortCol = 'name' AND @SortOrder='DESC'
                THEN name
        END DESC


  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  name,
  model_svg_filename,
  facets_count,
  min_facetgroups_count

 FROM Platform
 WHERE
    (@lId IS NULL OR id = @lId)
    OR(@lName IS NULL OR name LIKE '%' + @lName + '%')
    
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    name,
	model_svg_filename,
	facets_count,
	min_facetgroups_count
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END




GO
/****** Object:  StoredProcedure [dbo].[spFindProductConfigs]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spFindProductConfigs]
(
    /* Optional Filters for Dynamic Search*/
	@Id bigint = null,
	@Name varchar(100) = null,
	@G3ProductId bigint=null,
  /*– Pagination Parameters */
	@PageNo INT = 1,
	@PageSize INT = 999999999,
   /*– Sorting Parameters */
   @SortColumn varchar(20) = 'id',
   @SortOrder varchar(4)='ASC'
)
AS
BEGIN
    /*–Declaring Local Variables corresponding to parameters for modification */
    DECLARE
	@lId bigint,
    @lName NVARCHAR(100),
	@lG3ProductId bigint,
    
    @lPageNbr INT,
    @lPageSize INT,
    @lSortCol NVARCHAR(20),
    @lFirstRec INT,
    @lLastRec INT,
    @lTotalRows INT

    /*Setting Local Variables*/
	SET @lId = @Id
    SET @lName = @Name
	SET @lG3ProductId = @G3ProductId    

    SET @lPageNbr = @PageNo
    SET @lPageSize = @PageSize
    SET @lSortCol = LTRIM(RTRIM(@SortColumn))

    SET @lFirstRec = ( @lPageNbr - 1 ) * @lPageSize
    SET @lLastRec = ( @lPageNbr * @lPageSize + 1 )
    SET @lTotalRows = @lFirstRec - @lLastRec + 1

    ; WITH CTE_Results
    AS (
    SELECT ROW_NUMBER() OVER (ORDER BY
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='ASC')
                    THEN id
        END ASC,
        CASE WHEN (@lSortCol = 'id' AND @SortOrder='DESC')
                  THEN id
        END DESC,

        CASE WHEN (@lSortCol = 'product_name' AND @SortOrder='ASC')
                  THEN product_name
        END ASC,
        CASE WHEN @lSortCol = 'product_name' AND @SortOrder='DESC'
                THEN product_name
        END DESC


  ) AS ROWNUM,
  Count(*) over () AS TotalCount,
  id,
  product_name,
  product_id
 FROM ProductConfig
 WHERE
    ((@lId IS NULL OR id = @lId)
    OR(@lName IS NULL OR product_name LIKE '%' + @lName + '%'))

	AND (product_id = @lG3ProductId)
)
SELECT
    TotalCount,
    ROWNUM,
    id,
    product_name,
	product_id
FROM CTE_Results AS CPC
WHERE
        ROWNUM > @lFirstRec
              AND ROWNUM < @lLastRec
 ORDER BY ROWNUM ASC

END





GO
/****** Object:  StoredProcedure [dbo].[spGetAllChambersForProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetAllChambersForProductConfig]
@ProductConfigId bigint
as
begin

select distinct Chamber.id as id, Chamber.name as name, Chamber.got_code as got_code, Chamber.platform_id as platform_id from Chamber
INNER JOIN Platform ON Chamber.platform_id = Platform.id
 INNER JOIN G2ProductType ON Platform.id = G2ProductType.platform_id
INNER JOIN Product ON G2ProductType.id = Product.g2_product_type_id
INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id
where ProductConfig.id = @ProductConfigId



end



GO
/****** Object:  StoredProcedure [dbo].[spGetAllFacetsForPlatform]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spGetAllFacetsForPlatform]
@PlatformId bigint
as
begin

select Facet.name as facet_name from PlatformFacetMap INNER JOIN Facet ON PlatformFacetMap.facet_id = Facet.id
INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id
where Platform.id = @PlatformId order by Facet.name



end

GO
/****** Object:  StoredProcedure [dbo].[spGetAllFacetsForProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spGetAllFacetsForProductConfig]
@ProductConfigId bigint
as
begin

select distinct Facet.id as id, Facet.name as name from Facet INNER JOIN PlatformFacetMap ON Facet.id = PlatformFacetMap.facet_id
INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id
 INNER JOIN G2ProductType ON Platform.id = G2ProductType.platform_id
INNER JOIN Product ON G2ProductType.id = Product.g2_product_type_id
INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id
where ProductConfig.id = @ProductConfigId



end


GO
/****** Object:  StoredProcedure [dbo].[spGetChambersByNameList]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetChambersByNameList]
@ChamberNames NameList READONLY
as
begin
	
	select id, name, got_code from Chamber where name in (select * from @ChamberNames)
	
end


GO
/****** Object:  StoredProcedure [dbo].[spGetChambersByPlatformId]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE proc [dbo].[spGetChambersByPlatformId]
@SelectedPlatformId bigint
as

begin


select distinct Chamber.id as id, Chamber.name as name, Chamber.got_code as got_code, Chamber.platform_id as platform_id, Chamber.appearance_order as appearance_order

from Platform inner join G2ProductType on Platform.id = G2ProductType.platform_id
inner join Product on G2ProductType.id = Product.g2_product_type_id
inner join ProductConfig on Product.id = ProductConfig.product_id
inner join ProductConfigMap on ProductConfig.id = ProductConfigMap.product_config_id
inner join Chamber on ProductConfigMap.chamber_id = Chamber.id

where Platform.id = @SelectedPlatformId

order by appearance_order



end 


GO
/****** Object:  StoredProcedure [dbo].[spGetCompatibleChamberNames]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[spGetCompatibleChamberNames]
@SelectedChambersNameList NameList READONLY,
@SelectedPlatformId bigInt
AS
BEGIN

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRnd @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

DECLARE @CompatibleChamberNames NameList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames

IF (@ValidNonRndProductsCount > 0)
	BEGIN
		
		DECLARE @ValidNonRndProductGroupNames NameList
		INSERT @ValidNonRndProductGroupNames(name) EXEC spGetMatchingFacetGroupsListForValidNonRndProductConfigs @SelectedChambersNameList = @SelectedChambersNameList, @MatchingValidNonRndProductConfigsNameList = @ValidNonRndProductConfigNames, @PlatformId = @SelectedPlatformId

		INSERT @CompatibleChamberNames(name)
		SELECT distinct [dbo].[Chamber].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where ( [dbo].[ProductConfig].[product_name] in (select * from @ValidNonRndProductConfigNames)

		 AND  [dbo].[Platform].[id] = @SelectedPlatformId

		 AND [dbo].[FacetGroup].[name] NOT IN (select * from @ValidNonRndProductGroupNames) )

		 OR [dbo].[Chamber].[name] IN (select * from @SelectedChambersNameList)
  

	END


Select * from @CompatibleChamberNames



END

GO
/****** Object:  StoredProcedure [dbo].[spGetCompatibleChambers]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[spGetCompatibleChambers]
@SelectedChambersIdList IdList READONLY,
@SelectedPlatformId bigInt
AS
BEGIN

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRndV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

DECLARE @CompatibleChambers ChamberList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames

IF (@ValidNonRndProductsCount > 0)
	BEGIN
		
		DECLARE @ValidNonRndProductConfigName varchar(100)
		DECLARE ValidNonRndProductConfigNames_cursor CURSOR FOR SELECT name FROM @ValidNonRndProductConfigNames

		OPEN ValidNonRndProductConfigNames_cursor
		FETCH NEXT FROM ValidNonRndProductConfigNames_cursor INTO @ValidNonRndProductConfigName

		WHILE @@FETCH_STATUS = 0
		BEGIN
    

			DECLARE @ValidNonRndProductGroupNames NameList

			INSERT @ValidNonRndProductGroupNames(name) EXEC spGetMatchingFacetGroupsListForValidNonRndProductConfig @SelectedChambersIdList = @SelectedChambersIdList, @MatchingValidNonRndProductConfigName = @ValidNonRndProductConfigName, @PlatformId = @SelectedPlatformId

			INSERT @CompatibleChambers(id, name, got_code, platform_id, appearance_order)
			SELECT distinct [dbo].[Chamber].[id] as [id], [dbo].[Chamber].[name] as [name], [dbo].[Chamber].[got_code] as [got_code], [dbo].[Chamber].[platform_id] as [platform_id], [dbo].[Chamber].[appearance_order] as [appearance_order]
	   
		   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

		   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
		   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

		   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

		   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

		   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
			 where 
			 
			 ( [dbo].[ProductConfig].[product_name] = @ValidNonRndProductConfigName

			 AND  [dbo].[Platform].[id] = @SelectedPlatformId

			 AND [dbo].[FacetGroup].[name] NOT IN (select * from @ValidNonRndProductGroupNames)

			 AND [dbo].[Chamber].[id] NOT IN (select id from @CompatibleChambers) )


			 OR [dbo].[Chamber].[id] IN (select * from @SelectedChambersIdList)
  
			 
			ORDER BY appearance_order

			DELETE from @ValidNonRndProductGroupNames

			FETCH NEXT FROM ValidNonRndProductConfigNames_cursor INTO @ValidNonRndProductConfigName

		END
		
		CLOSE ValidNonRndProductConfigNames_cursor
		DEALLOCATE ValidNonRndProductConfigNames_cursor
	
	END 
	



	Select * from @CompatibleChambers

END


GO
/****** Object:  StoredProcedure [dbo].[spGetFacetChamberMappingsForProductConfiguration]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[spGetFacetChamberMappingsForProductConfiguration]
@ProductConfigId bigint
as
begin

select Facet.name as facet_name, Chamber.id as chamber_id, Chamber.name as chamber_name, Chamber.got_code as chamber_got_code from Facet LEFT JOIN FacetGroupMap
ON Facet.id = FacetGroupMap.facet_id
INNER JOIN FacetGroup ON FacetGroupMap.facet_group_id = FacetGroup.id
INNER JOIN ProductConfigMap ON ProductConfigMap.facet_group_id = FacetGroup.id
INNER JOIN Chamber ON ProductConfigMap.chamber_id = Chamber.id
where ProductConfigMap.product_config_id = @ProductConfigId order by Facet.name

end
GO
/****** Object:  StoredProcedure [dbo].[spGetFacetChamberMappingsFromCorrespondingEntireG2Matrix]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[spGetFacetChamberMappingsFromCorrespondingEntireG2Matrix]
@ProductConfigId bigint,
@ChamberIdList IdList READONLY
as
begin

select distinct Facet.name as facet_name, Chamber.id as chamber_id, Chamber.name as chamber_name, Chamber.got_code as chamber_got_code from Facet LEFT JOIN FacetGroupMap
ON Facet.id = FacetGroupMap.facet_id
INNER JOIN FacetGroup ON FacetGroupMap.facet_group_id = FacetGroup.id
INNER JOIN ProductConfigMap ON ProductConfigMap.facet_group_id = FacetGroup.id
INNER JOIN Chamber ON ProductConfigMap.chamber_id = Chamber.id 
INNER JOIN ProductConfig ON ProductConfigMap.product_config_id = ProductConfig.id
INNER JOIN Product ON ProductConfig.product_id = Product.id
INNER JOIN G2ProductType ON Product.g2_product_type_id = G2ProductType.id
where G2ProductType.id = (select G2ProductType.id from G2ProductType INNER JOIN Product ON G2ProductType.id = g2_product_type_id
							INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id
							and ProductConfig.id = @ProductConfigId) 

 and  Chamber.id in (select id from @ChamberIdList)
 order by Facet.name

end

GO
/****** Object:  StoredProcedure [dbo].[spGetFacetDependentsCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spGetFacetDependentsCount]
@FacetId bigint,
@PlatformId bigint
as
begin


select  count(distinct ProductConfig.id) as dependents_count from Platform INNER JOIN G2ProductType on Platform.id = G2ProductType.platform_id
INNER JOIN Product ON G2ProductType.id = Product.g2_product_type_id
INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id 
INNER JOIN ProductConfigMap ON ProductConfig.id = ProductConfigMap.product_config_id
 INNER JOIN FacetGroup ON ProductConfigMap.facet_group_id = FacetGroup.id
INNER JOIN FacetGroupMap ON FacetGroup.id = FacetGroupMap.facet_group_id 
INNER JOIN Facet ON FacetGroupMap.facet_id = Facet.id
where Facet.id = @FacetId and Platform.id = @PlatformId

end




GO
/****** Object:  StoredProcedure [dbo].[spGetFacetGroupsAndChamberMappingsForProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetFacetGroupsAndChamberMappingsForProductConfig]
@ProductConfigId bigint
as
begin

select distinct FacetGroup.name as facet_group_name, FacetGroup.id as facet_group_id, '[ ' + Chamber.name + ' (' + Chamber.got_code + ')' +  ' ]' as chambers from Facet LEFT JOIN FacetGroupMap
ON Facet.id = FacetGroupMap.facet_id
INNER JOIN FacetGroup ON FacetGroupMap.facet_group_id = FacetGroup.id
INNER JOIN ProductConfigMap ON ProductConfigMap.facet_group_id = FacetGroup.id
INNER JOIN Chamber ON ProductConfigMap.chamber_id = Chamber.id
where ProductConfigMap.product_config_id = @ProductConfigId order by FacetGroup.name

end


GO
/****** Object:  StoredProcedure [dbo].[spGetG2ProductDependentsCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetG2ProductDependentsCount]
@G2ProductId bigint
as
begin


select  count(distinct Product.name) as dependents_count from Product INNER JOIN G2ProductType ON Product.g2_product_type_id = G2ProductType.id
where G2ProductType.id = @G2ProductId

end



GO
/****** Object:  StoredProcedure [dbo].[spGetG3ProductDependentsCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spGetG3ProductDependentsCount]
@G3ProductId bigint
as
begin


select  count(distinct ProductConfig.id) as dependents_count from ProductConfig INNER JOIN Product ON ProductConfig.product_id = Product.id
where Product.id = @G3ProductId

end




GO
/****** Object:  StoredProcedure [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfig]
@SelectedChambersIdList IdList READONLY,
@MatchingValidNonRndProductConfigName varchar(100),
@PlatformId bigInt
AS
BEGIN

Declare @MatchingFacetGroups NameList

INSERT @MatchingFacetGroups(name)

select  distinct [dbo].[FacetGroup].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[id] in (SELECT * from @SelectedChambersIdList)

		 AND  [dbo].[Platform].[id] = @PlatformId

		 AND [dbo].[ProductConfig].[product_name] = @MatchingValidNonRndProductConfigName


select * from @MatchingFacetGroups
   
END


GO
/****** Object:  StoredProcedure [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfigs]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfigs]
@SelectedChambersNameList NameList READONLY,
@MatchingValidNonRndProductConfigsNameList NameList READONLY,
@PlatformId bigInt
AS
BEGIN

Declare @MatchingFacetGroups NameList

INSERT @MatchingFacetGroups(name)

select  distinct [dbo].[FacetGroup].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[name] in (SELECT * from @SelectedChambersNameList)

		 AND  [dbo].[Platform].[id] = @PlatformId

		 AND [dbo].[ProductConfig].[product_name] in (SELECT * from @MatchingValidNonRndProductConfigsNameList)


select * from @MatchingFacetGroups
   
END
GO
/****** Object:  StoredProcedure [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfigsV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[spGetMatchingFacetGroupsListForValidNonRndProductConfigsV2]
@SelectedChambersIdList IdList READONLY,
@MatchingValidNonRndProductConfigsNameList NameList READONLY,
@PlatformId bigInt
AS
BEGIN

Declare @MatchingFacetGroups NameList

INSERT @MatchingFacetGroups(name)

select  distinct [dbo].[FacetGroup].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[id] in (SELECT * from @SelectedChambersIdList)

		 AND  [dbo].[Platform].[id] = @PlatformId

		 AND [dbo].[ProductConfig].[product_name] in (SELECT * from @MatchingValidNonRndProductConfigsNameList)


select * from @MatchingFacetGroups
   
END

GO
/****** Object:  StoredProcedure [dbo].[spGetMaxMatchingChambersCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetMaxMatchingChambersCount]
@SelectedChambersNameList NameList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int out
AS
BEGIN

SELECT @MaxMatchingChambersCount = MAX([chamberCount]) FROM
(
  SELECT 
	   [dbo].[ProductConfig].[product_name] AS [ProductConfig],
	   
	   COUNT(DISTINCT [dbo].[Chamber].[name]) AS [chamberCount]
	  
	   FROM [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
	  
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]

	   WHERE [dbo].[Chamber].[name] IN (SELECT * from @SelectedChambersNameList)
	   
	   AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) maxChamberMap

END
GO
/****** Object:  StoredProcedure [dbo].[spGetMaxMatchingChambersCountV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[spGetMaxMatchingChambersCountV2]
@SelectedChambersIdList IdList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int out
AS
BEGIN

SELECT @MaxMatchingChambersCount = MAX([chamberCount]) FROM
(
  SELECT 
	   [dbo].[ProductConfig].[product_name] AS [ProductConfig],
	   
	   COUNT(DISTINCT [dbo].[Chamber].[name]) AS [chamberCount]
	  
	   FROM [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
	  
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]

	   WHERE [dbo].[Chamber].[id] IN (SELECT * from @SelectedChambersIdList)
	   
	   AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) maxChamberMap

END

GO
/****** Object:  StoredProcedure [dbo].[spGetPlatformDependentsCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetPlatformDependentsCount]
@PlatformId bigint
as
begin

SELECT
(select  count(distinct Facet.name) as facets_count from PlatformFacetMap INNER JOIN Facet ON PlatformFacetMap.facet_id = Facet.id
INNER JOIN Platform ON PlatformFacetMap.platform_id = Platform.id
where Platform.id = @PlatformId )

+
(
select count(distinct G2ProductType.name) as g2_product_types_count from Platform inner join G2ProductType
ON platform.id = G2ProductType.platform_id where Platform.id = @PlatformId  
)
as dependents_count


end


GO
/****** Object:  StoredProcedure [dbo].[spGetProductConfigNamesByChamberId]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC  [dbo].[spGetProductConfigNamesByChamberId]
@id bigint
AS
BEGIN
    
	select distinct ProductConfig.product_name from ProductConfigMap INNER JOIN Chamber
	ON ProductConfigMap.chamber_id = Chamber.id 
	INNER JOIN ProductConfig ON ProductConfigMap.product_config_id = ProductConfig.id 
	where Chamber.id = @Id

END;




GO
/****** Object:  StoredProcedure [dbo].[spGetProductConfigNamesMaxMatchingChambersCount]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[spGetProductConfigNamesMaxMatchingChambersCount]
@SelectedChambersNameList NameList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int
AS
BEGIN

Declare @ProductConfigNamesMax NameList

INSERT @ProductConfigNamesMax(name)

SELECT productConfigName as name from 

(

select 
	    [dbo].[ProductConfig].[product_name] as productConfigName,
	   
	   count(distinct [dbo].[Chamber].[name]) as [chamberCount]
	   
	   from [dbo].[Platform]  
	   
	   INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]


	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[name] in (select * from @SelectedChambersNameList)
		 
		 AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) ProductChamberCount

	   where chamberCount = @MaxMatchingChambersCount


	Select * from @ProductConfigNamesMax
   
END
GO
/****** Object:  StoredProcedure [dbo].[spGetProductConfigNamesMaxMatchingChambersCountV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[spGetProductConfigNamesMaxMatchingChambersCountV2]
@SelectedChambersIdList IdList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int
AS
BEGIN

Declare @ProductConfigNamesMax NameList

INSERT @ProductConfigNamesMax(name)

SELECT productConfigName as name from 

(

select 
	    [dbo].[ProductConfig].[product_name] as productConfigName,
	   
	   count(distinct [dbo].[Chamber].[name]) as [chamberCount]
	   
	   from [dbo].[Platform]  
	   
	   INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]


	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[id] in (select * from @SelectedChambersIdList)
		 
		 AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) ProductChamberCount

	   where chamberCount = @MaxMatchingChambersCount


	Select * from @ProductConfigNamesMax
   
END

GO
/****** Object:  StoredProcedure [dbo].[spGetProductConfigNamesValidNonRnd]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[spGetProductConfigNamesValidNonRnd]
@SelectedChambersNameList NameList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int
AS
BEGIN

Declare @ProductConfigNamesNonRnd NameList

INSERT @ProductConfigNamesNonRnd(name)

select ProductConfigName as name from 

(

select 
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   
	   count(distinct [dbo].[FacetGroup].[name]) as [matchingGroupsCount]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[name] in (Select * from @SelectedChambersNameList)

		 AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) ProductGroupsCount

	   where matchingGroupsCount = @MaxMatchingChambersCount
	    and @MaxMatchingChambersCount = (select count(distinct name) from @SelectedChambersNameList) 


	select * from @ProductConfigNamesNonRnd
   
END

GO
/****** Object:  StoredProcedure [dbo].[spGetProductConfigNamesValidNonRndV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[spGetProductConfigNamesValidNonRndV2]
@SelectedChambersIdList IdList READONLY,
@PlatformId bigInt,
@MaxMatchingChambersCount int
AS
BEGIN

Declare @ProductConfigNamesNonRnd NameList

INSERT @ProductConfigNamesNonRnd(name)

select ProductConfigName as name from 

(

select 
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   
	   count(distinct [dbo].[FacetGroup].[name]) as [matchingGroupsCount]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[id] in (Select * from @SelectedChambersIdList)

		 AND  [dbo].[Platform].[id] = @PlatformId

	   group by [dbo].[ProductConfig].[product_name]

	   ) ProductGroupsCount

	   where matchingGroupsCount = @MaxMatchingChambersCount
	    and @MaxMatchingChambersCount = (select count(distinct id) from @SelectedChambersIdList) 


	select * from @ProductConfigNamesNonRnd
   
END


GO
/****** Object:  StoredProcedure [dbo].[spGetProductsRndOnly]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE proc [dbo].[spGetProductsRndOnly]
@SelectedChambersNameList NameList READONLY,
@SelectedPlatformId bigint,
@IncludeValidNonRndProductsNotHavingEnoughChamberSelectionsYet bit
as
begin

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRnd @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

DECLARE @CompatibleChamberNames NameList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames

Declare @ProductConfigs ProductConfigList;
Declare @RndProductsExist bit;


IF (@ValidNonRndProductsCount > 0)
	BEGIN
		IF(@IncludeValidNonRndProductsNotHavingEnoughChamberSelectionsYet = 1)
			SET @RndProductsExist = 1
		ELSE
			SET @RndProductsExist = 0
	END
ELSE
	BEGIN
		SET @RndProductsExist = 1
	END




IF (@RndProductsExist = 1)
	BEGIN
		
INSERT @ProductConfigs(product_id, product_name, product_code, nearest_product_config_id, nearest_product_config_name, platform_name, model_svg_filename)

select [ProductId], [ProductName], [ProductCode], [ProductConfigId], [ProductConfigName], [PlatformName], [ModelSvgUrl] from 

(

select distinct 
	   [dbo].[G2ProductType].[id] as [ProductId],
	   [dbo].[G2ProductType].[rnd_product_name] as [ProductName],
	   [dbo].[G2ProductType].[rnd_product_code] as [ProductCode],
	    [dbo].[ProductConfig].[id] as [ProductConfigId],
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   [dbo].[Platform].[name] as [PlatformName],
	   [dbo].[Platform].[model_svg_filename] as [ModelSvgUrl]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

		 where [dbo].[ProductConfig].[product_name] in (select * from @MaxMatchingProductNames)
		 ) RndOnlyProducts

	END

	select * from @ProductConfigs

end







GO
/****** Object:  StoredProcedure [dbo].[spGetProductsRndOnlyV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spGetProductsRndOnlyV2]
@SelectedChambersIdList IdList READONLY,
@SelectedPlatformId bigint,
@IncludeValidNonRndProductsNotHavingEnoughChamberSelectionsYet bit
as
begin

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRndV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

--DECLARE @CompatibleChamberNames NameList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames

Declare @ProductConfigs ProductConfigList;
Declare @RndProductsExist bit;


IF (@ValidNonRndProductsCount > 0)
	BEGIN
		IF(@IncludeValidNonRndProductsNotHavingEnoughChamberSelectionsYet = 1)
			SET @RndProductsExist = 1
		ELSE
			SET @RndProductsExist = 0
	END
ELSE
	BEGIN
		SET @RndProductsExist = 1
	END




IF (@RndProductsExist = 1)
	BEGIN
		
INSERT @ProductConfigs(product_id, product_name, product_code, nearest_product_config_id, nearest_product_config_name, platform_name, model_svg_filename)

select [ProductId], [ProductName], [ProductCode], [ProductConfigId], [ProductConfigName], [PlatformName], [ModelSvgUrl] from 

(

select distinct 
	   [dbo].[G2ProductType].[id] as [ProductId],
	   [dbo].[G2ProductType].[rnd_product_name] as [ProductName],
	   [dbo].[G2ProductType].[rnd_product_code] as [ProductCode],
	    [dbo].[ProductConfig].[id] as [ProductConfigId],
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   [dbo].[Platform].[name] as [PlatformName],
	   [dbo].[Platform].[model_svg_filename] as [ModelSvgUrl]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

		 where [dbo].[ProductConfig].[product_name] in (select * from @MaxMatchingProductNames)
		 ) RndOnlyProducts

	END

	select * from @ProductConfigs

end








GO
/****** Object:  StoredProcedure [dbo].[spGetProductsValidNonRnd]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE proc [dbo].[spGetProductsValidNonRnd]
@SelectedChambersNameList NameList READONLY,
@SelectedPlatformId bigint
as

begin

Declare @MaxMatchingChambersCount int
execute spGetMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out


Declare @ProductConfigs ProductConfigList

INSERT @ProductConfigs(product_id, product_name, product_code, nearest_product_config_id, nearest_product_config_name, platform_name, model_svg_filename)

select [ProductId], [ProductName], [ProductCode], [ProductConfigId], [ProductConfigName], [PlatformName], [ModelSvgUrl] from 

(

select 
	   [dbo].[Product].[id] as [ProductId],
	   [dbo].[Product].[name] as [ProductName],
	   [dbo].[Product].[code] as [ProductCode],
	   [dbo].[ProductConfig].[id] as [ProductConfigId],
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   [dbo].[Platform].[name] as [PlatformName],
	   [dbo].[Platform].[model_svg_filename] as [ModelSvgUrl],

	   count(distinct [dbo].[FacetGroup].[name]) as [matchingGroupsCount]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[name] in (Select * from @SelectedChambersNameList)

		 AND  [dbo].[Platform].[id] = @SelectedPlatformId

	   group by [dbo].[ProductConfig].[id], [dbo].[ProductConfig].[product_name], [dbo].[Product].[id], [dbo].[Product].[name], [dbo].[Product].[code], [dbo].[Platform].[name], [dbo].[Platform].[model_svg_filename]

	   ) ProductGroupsCount

	   where matchingGroupsCount = @MaxMatchingChambersCount
	    and @MaxMatchingChambersCount = (select count(distinct name) from @SelectedChambersNameList)
		

	declare @ProductConfigIdsHavingFullGroupsMatched IdList

	insert @ProductConfigIdsHavingFullGroupsMatched(id)
	select product_config_id from 
	
	(
	select product_config_id, count(facet_group_id) as groupsCount 
	from 
	(
	select product_config_id, facet_group_id from 
	ProductConfig INNER JOIN ProductConfigMap ON ProductConfig.id = ProductConfigMap.product_config_id 
	WHERE product_config_id in (select nearest_product_config_id from @ProductConfigs) 
	group by product_config_id, facet_group_id
	) productConfigGroups 
	group by product_config_id
	) productGroupsCount
	where groupsCount = @MaxMatchingChambersCount 

	select * from @ProductConfigs where nearest_product_config_id in (select * from @ProductConfigIdsHavingFullGroupsMatched)
   

end






GO
/****** Object:  StoredProcedure [dbo].[spGetProductsValidNonRndV2]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spGetProductsValidNonRndV2]
@SelectedChambersIdList IdList READONLY,
@SelectedPlatformId bigint
as

begin

Declare @MaxMatchingChambersCount int
execute spGetMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out


Declare @ProductConfigs ProductConfigList

INSERT @ProductConfigs(product_id, product_name, product_code, nearest_product_config_id, nearest_product_config_name, platform_name, model_svg_filename)

select [ProductId], [ProductName], [ProductCode], [ProductConfigId], [ProductConfigName], [PlatformName], [ModelSvgUrl] from 

(

select 
	   [dbo].[Product].[id] as [ProductId],
	   [dbo].[Product].[name] as [ProductName],
	   [dbo].[Product].[code] as [ProductCode],
	   [dbo].[ProductConfig].[id] as [ProductConfigId],
	   [dbo].[ProductConfig].[product_name] as [ProductConfigName],
	   [dbo].[Platform].[name] as [PlatformName],
	   [dbo].[Platform].[model_svg_filename] as [ModelSvgUrl],

	   count(distinct [dbo].[FacetGroup].[name]) as [matchingGroupsCount]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		 where [dbo].[Chamber].[id] in (Select * from @SelectedChambersIdList)

		 AND  [dbo].[Platform].[id] = @SelectedPlatformId

	   group by [dbo].[ProductConfig].[id], [dbo].[ProductConfig].[product_name], [dbo].[Product].[id], [dbo].[Product].[name], [dbo].[Product].[code], [dbo].[Platform].[name], [dbo].[Platform].[model_svg_filename]

	   ) ProductGroupsCount

	   where matchingGroupsCount = @MaxMatchingChambersCount
	    and @MaxMatchingChambersCount = (select count(distinct id) from @SelectedChambersIdList)
		

	declare @ProductConfigIdsHavingFullGroupsMatched IdList

	insert @ProductConfigIdsHavingFullGroupsMatched(id)
	select product_config_id from 
	
	(
	select product_config_id, count(facet_group_id) as groupsCount 
	from 
	(
	select product_config_id, facet_group_id from 
	ProductConfig INNER JOIN ProductConfigMap ON ProductConfig.id = ProductConfigMap.product_config_id 
	WHERE product_config_id in (select nearest_product_config_id from @ProductConfigs) 
	group by product_config_id, facet_group_id
	) productConfigGroups 
	group by product_config_id
	) productGroupsCount
	where groupsCount = @MaxMatchingChambersCount 

	select * from @ProductConfigs where nearest_product_config_id in (select * from @ProductConfigIdsHavingFullGroupsMatched)
   

end







GO
/****** Object:  StoredProcedure [dbo].[spGetRndTypeOnlyChamberNames]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[spGetRndTypeOnlyChamberNames]
@SelectedChambersNameList NameList READONLY,
@SelectedPlatformId bigInt,
@AlreadyComputedCompatibleChamberNameList NameList READONLY
AS
BEGIN

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRnd @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

DECLARE @RndTypeOnlyChamberNames NameList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames


DECLARE @ProductConfigNamesWithMaxMatchingChambers NameList
INSERT @ProductConfigNamesWithMaxMatchingChambers(name) EXEC spGetProductConfigNamesMaxMatchingChambersCount @SelectedChambersNameList = @SelectedChambersNameList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


IF (@ValidNonRndProductsCount > 0)
	BEGIN


		INSERT @RndTypeOnlyChamberNames(name)
		SELECT distinct [dbo].[Chamber].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		
	   WHERE [dbo].[G2ProductType].[id] IN (



select distinct [dbo].[G2ProductType].[id] AS [G2ProductTypeIds] from

  [dbo].[Platform] INNER JOIN [dbo].[G2ProductType]
  ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

  INNER JOIN [dbo].[Product] ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]

  INNER JOIN [dbo].[ProductConfig] ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

  WHERE [dbo].[ProductConfig].[product_name] in (select * from @ProductConfigNamesWithMaxMatchingChambers)

  )

  AND [dbo].[Chamber].[name] NOT IN (select * from @AlreadyComputedCompatibleChamberNameList)
		
	END
ELSE 
	BEGIN

	
	INSERT @RndTypeOnlyChamberNames(name)
SELECT distinct [dbo].[Chamber].[name] as [name]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		
	   WHERE [dbo].[G2ProductType].[id] IN (



select distinct [dbo].[G2ProductType].[id] AS [G2ProductTypeIds] from

  [dbo].[Platform] INNER JOIN [dbo].[G2ProductType]
  ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

  INNER JOIN [dbo].[Product] ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]

  INNER JOIN [dbo].[ProductConfig] ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

  WHERE [dbo].[ProductConfig].[product_name] in (select * from @MaxMatchingProductNames)

  )

		

	END


Select * from @RndTypeOnlyChamberNames



END
GO
/****** Object:  StoredProcedure [dbo].[spGetRndTypeOnlyChambers]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROC [dbo].[spGetRndTypeOnlyChambers]
@SelectedChambersIdList IdList READONLY,
@SelectedPlatformId bigInt,
@AlreadyComputedCompatibleChamberIdList IdList READONLY
AS
BEGIN

DECLARE @MaxMatchingChambersCount int
DECLARE @MaxMatchingProductNames NameList


EXEC spGetMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount out

INSERT @MaxMatchingProductNames(name) EXEC spGetProductConfigNamesMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


DECLARE @ValidNonRndProductConfigNames NameList
INSERT @ValidNonRndProductConfigNames(name) EXEC spGetProductConfigNamesValidNonRndV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount

DECLARE @RndTypeOnlyChamberNames NameList

DECLARE @ValidNonRndProductsCount int
SELECT @ValidNonRndProductsCount = COUNT(*) from @ValidNonRndProductConfigNames


DECLARE @ProductConfigNamesWithMaxMatchingChambers NameList
INSERT @ProductConfigNamesWithMaxMatchingChambers(name) EXEC spGetProductConfigNamesMaxMatchingChambersCountV2 @SelectedChambersIdList = @SelectedChambersIdList, @PlatformId = @SelectedPlatformId, @MaxMatchingChambersCount = @MaxMatchingChambersCount


IF (@ValidNonRndProductsCount > 0)
	BEGIN


		--INSERT @RndTypeOnlyChamberNames(name)
		SELECT distinct [dbo].[Chamber].[id] as [id], [dbo].[Chamber].[name] as [name], [dbo].[Chamber].[got_code] as [got_code], [dbo].[Chamber].[platform_id] as [platform_id], [dbo].[Chamber].[appearance_order] as [appearance_order]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		
	   WHERE [dbo].[G2ProductType].[id] IN (



select distinct [dbo].[G2ProductType].[id] AS [G2ProductTypeIds] from

  [dbo].[Platform] INNER JOIN [dbo].[G2ProductType]
  ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

  INNER JOIN [dbo].[Product] ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]

  INNER JOIN [dbo].[ProductConfig] ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

  WHERE [dbo].[ProductConfig].[product_name] in (select * from @ProductConfigNamesWithMaxMatchingChambers)

  )

  AND [dbo].[Chamber].[id] NOT IN (select * from @AlreadyComputedCompatibleChamberIdList)

  ORDER BY appearance_order
		
	END
ELSE 
	BEGIN

	
	--INSERT @RndTypeOnlyChamberNames(name)
SELECT distinct [dbo].[Chamber].[id] as [id], [dbo].[Chamber].[name] as [name], [dbo].[Chamber].[got_code] as [got_code], [dbo].[Chamber].[platform_id] as [platform_id], [dbo].[Chamber].[appearance_order] as [appearance_order]
	   
	   from [dbo].[Platform]  INNER JOIN [dbo].[G2ProductType]   ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

	   INNER JOIN [dbo].[Product]   ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]
     
	   INNER JOIN [dbo].[ProductConfig]   ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

	   INNER JOIN [dbo].[ProductConfigMap] ON [dbo].[ProductConfig].[id] = [dbo].[ProductConfigMap].[product_config_id]

	   INNER JOIN [dbo].[FacetGroup] ON [dbo].[ProductConfigMap].[facet_group_id] = [dbo].[FacetGroup].[id]

	   INNER JOIN [dbo].[Chamber] ON [dbo].[ProductConfigMap].[chamber_id] = [dbo].[Chamber].[id]
 
		
	   WHERE [dbo].[G2ProductType].[id] IN (



select distinct [dbo].[G2ProductType].[id] AS [G2ProductTypeIds] from

  [dbo].[Platform] INNER JOIN [dbo].[G2ProductType]
  ON [dbo].[Platform].[id] = [dbo].[G2ProductType].[platform_id]

  INNER JOIN [dbo].[Product] ON [dbo].[G2ProductType].[id] = [dbo].[Product].[g2_product_type_id]

  INNER JOIN [dbo].[ProductConfig] ON [dbo].[Product].[id] = [dbo].[ProductConfig].[product_id]

  WHERE [dbo].[ProductConfig].[product_name] in (select * from @MaxMatchingProductNames)

  )

  ORDER BY appearance_order
		

	END


--Select * from @RndTypeOnlyChamberNames



END


GO
/****** Object:  StoredProcedure [dbo].[spUpdateChamber]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spUpdateChamber]
@id bigint,
@Name varchar(50),
@GotCode varchar(50)
AS
BEGIN
    
	update Chamber set name=@Name, got_code=@GotCode where id = @id

END;




GO
/****** Object:  StoredProcedure [dbo].[spUpdateFacet]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spUpdateFacet]
@id bigint,
@Name varchar(100)
AS
BEGIN
    
	update Facet set name = @Name where id = @id
	
END;
GO
/****** Object:  StoredProcedure [dbo].[spUpdateG2Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spUpdateG2Product]
@id bigint,
@Name varchar(100),
@RndProductName varchar(100),
@RndProductCode varchar(50)
AS
BEGIN
    
	update G2ProductType set name=@Name, rnd_product_name = @RndProductName, rnd_product_code = @RndProductCode where id = @id

END;







GO
/****** Object:  StoredProcedure [dbo].[spUpdateG3Product]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spUpdateG3Product]
@id bigint,
@Name varchar(100),
@Code varchar(5)
AS
BEGIN
    
	update Product set name=@Name, code = @Code where id = @id

END;








GO
/****** Object:  StoredProcedure [dbo].[spUpdateMinFacetGroupsCountInPlatformForConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spUpdateMinFacetGroupsCountInPlatformForConfig]
@ProductConfigId bigint
as
begin
    BEGIN TRANSACTION;
    SAVE TRANSACTION savePoint;
   

    BEGIN TRY
    
		SET NOCOUNT ON;

		
declare @minGroupsCount int;
declare @platformId bigint;

select @platformId =  Platform.id
					from Platform INNER JOIN G2ProductType ON Platform.id = G2ProductType.platform_id
					INNER JOIN Product ON G2ProductType.id = Product.g2_product_type_id
					INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id
					where ProductConfig.id = @ProductConfigId


select @minGroupsCount = MIN(facet_group_count) from
(select Platform.id as platform_id, ProductConfig.id as product_config_id,
 count(distinct ProductConfigMap.facet_group_id) as facet_group_count 
from Platform INNER JOIN G2ProductType ON Platform.id = G2ProductType.platform_id
					INNER JOIN Product ON G2ProductType.id = Product.g2_product_type_id
					INNER JOIN ProductConfig ON Product.id = ProductConfig.product_id
					INNER JOIN ProductConfigMap ON ProductConfig.id = ProductConfigMap.product_config_id
					
					where Platform.id = @platformId

					group by Platform.id, ProductConfig.id) v


update Platform set min_facetgroups_count = @minGroupsCount where id = @platformId



		
		
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION savePoint;
        END
    END CATCH
    COMMIT TRANSACTION 
END;










GO
/****** Object:  StoredProcedure [dbo].[spUpdatePlatform]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE proc [dbo].[spUpdatePlatform]
@id bigint,
@Name varchar(50),
@ModelSvgFilename varchar(50)
AS
BEGIN
    
	update Platform set name=@Name, model_svg_filename = @ModelSvgFilename where id = @id

END;








GO
/****** Object:  StoredProcedure [dbo].[spUpdateProductConfig]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[spUpdateProductConfig]
@Id bigint,
@ProductName varchar(100)
as
begin
    
    
		SET NOCOUNT ON;

		update ProductConfig set product_name = @ProductName where id = @Id
		
END;

GO
/****** Object:  Table [dbo].[Chamber]    Script Date: 4/5/2019 5:55:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Chamber](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[got_code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[platform_id] [bigint] NOT NULL,
	[appearance_order] [bigint] NOT NULL CONSTRAINT [DF_Chamber_appearance_order]  DEFAULT ((9999999999.)),
 CONSTRAINT [PK_Chamber] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facet]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facet](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_Facet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacetGroup]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FacetGroup](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_FacetGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacetGroupMap]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacetGroupMap](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[facet_group_id] [bigint] NOT NULL,
	[facet_id] [bigint] NOT NULL,
 CONSTRAINT [PK_FacetGroupMap] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[G2ProductType]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[G2ProductType](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[rnd_product_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[rnd_product_code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[platform_id] [bigint] NOT NULL,
 CONSTRAINT [PK_G2Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Opportunity]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Opportunity](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[op_id] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[product_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[product_code] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[platform_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[nearest_product_config_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[c_date] [datetime] NULL,
	[m_date] [datetime] NULL,
	[created_by_id] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_by_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Opportunity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OpportunityConfig]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OpportunityConfig](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[facet_name] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[chamber_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[opportunity_id] [bigint] NOT NULL,
 CONSTRAINT [PK_OpportunityConfig] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Platform]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Platform](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[facets_count] [int] NOT NULL DEFAULT ((0)),
	[model_svg_filename] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[min_facetgroups_count] [int] NOT NULL CONSTRAINT [DF_Platform_min_facetgroups_count]  DEFAULT ((0)),
 CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlatformFacetMap]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlatformFacetMap](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[platform_id] [bigint] NOT NULL,
	[facet_id] [bigint] NOT NULL,
 CONSTRAINT [PK_PlatformFacetMap] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[code] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[g2_product_type_id] [bigint] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductConfig]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductConfig](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NOT NULL,
	[product_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_ProductConfig] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProductConfigMap]    Script Date: 4/5/2019 5:55:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductConfigMap](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_config_id] [bigint] NOT NULL,
	[chamber_id] [bigint] NOT NULL,
	[facet_group_id] [bigint] NOT NULL,
 CONSTRAINT [PK_ProductConfigMap] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Chamber] ON 

INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (1, N'DEGAS', N'4G', 1, 190)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (2, N'DUAL MODE DEGAS', N'5Y', 1, 192)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (3, N'H2/O2 DEGAS WITHOUT LAMPS', N'6I', 1, 193)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (4, N'H2/O2 DEGAS WITH LAMPS', N'6V', 1, 194)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (5, N'H2/O2 DEGAS WITH LAMPS AND CU BAKING', N'6Y', 1, 195)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (6, N'AKTIV PRECLEAN EF', N'7J', 1, 188)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (7, N'PRECLEAN XT TURBO', N'5D', 1, 182)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (8, N'AKTIV PRECLEAN', N'6A', 1, 187)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (9, N'ALD2 TAN', N'6D', 1, 167)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (10, N'ALD2 TAN REV 2.0', N'9H', 1, 168)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (11, N'SIP ENCORE II TA(N) REV.2.0', N'6C', 1, 151)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (12, N'SIP Encore3 Ta(N)', N'9E', 1, 152)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (13, N'ENCORE II RFX CU W COIL', N'6L', 1, 144)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (14, N'SIP ENCORE II RFXT CU W COIL', N'7T', 1, 146)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (15, N'SIP ENCORE II RFXTP CU W COIL', N'7X', 1, 149)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (16, N'ACCESS CU', N'9D', 1, 11)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (17, N'ACCESS2 CU', N'9J', 1, 12)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (18, N'AMBER', N'7E', 1, 110)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (19, N'Access3 CU', N'2Z', 1, 13)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (20, N'VOLTA CVD CO', N'7B', 1, 178)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (21, N'VOLTA XT CO', N'9F', 1, 181)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (22, N'SIP ENCORE II TA(N)', N'5P', 1, 150)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (24, N'SIP ENCORE II CU', N'5Q', 1, 142)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (25, N'SIP ENCORE II RF CU', N'6H', 1, 143)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (35, N'ALUMINIUM', N'3A', 1, 18)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (37, N'ALUMINIUM HP', N'5Z', 1, 19)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (38, N'EXECTA PVD AL', N'9W', 1, 129)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (39, N'PVD STANDARD TA(N)', N'5A', 1, 141)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (40, N'TITANIUM/TINITRIDE', N'3G', 1, 154)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (41, N'SIP TTN', N'3I', 1, 153)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (42, N'ALPS ESI', N'6E', 1, 16)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (43, N'ALPS ALUMINUM', N'3Q', 1, 14)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (94, N'ALPS Cobalt', N'4Z', 1, 15)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (95, N'ALPS Nickel', N'5H', 1, 17)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (96, N'Avenir RF DC AL', N'6P', 1, 111)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (97, N'Avenir RF DC HP TIN', N'6S', 1, 112)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (98, N'Avenir RF DC LA', N'6Q', 1, 113)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (99, N'Avenir RF DC LP TIN', N'6R', 1, 114)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (100, N'Avenir RF DC NIPT', N'6T', 1, 115)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (101, N'Avenir RF DC SI', N'9X', 1, 116)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (102, N'Avenir RF DC TI', N'9Y', 1, 117)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (103, N'Cirrus HT CO', N'7U', 1, 119)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (104, N'Cirrus HT Reflow', N'2R', 1, 120)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (105, N'Cirrus HTX TIN', N'7Q', 1, 121)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (106, N'Cirrus RT CO', N'7V', 1, 122)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (107, N'Cirrus TI', N'7F', 1, 123)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (108, N'Clover PVD-Cryo Turbo', N'9T', 1, 124)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (109, N'Clover PVD Cryo', N'9U', 1, 125)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (110, N'Clover PVD MGO', N'9V', 1, 126)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (111, N'Cobalt', N'3K', 1, 127)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (112, N'ESIP', N'6B', 1, 128)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (114, N'AVENIR RF DC TIAL', N'6U', 1, 118)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (115, N'GST REFLOW', N'8H', 1, 131)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (116, N'HAR COBALT PVD', N'6X', 1, 132)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (117, N'ADAMAS', N'2W', 1, 133)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (118, N'IMPULSE ALN', N'7Y', 1, 134)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (119, N'IMPULSE ALOX', N'9G', 1, 135)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (120, N'IMPULSE GST', N'8G', 1, 136)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (121, N'IMPULSE SIN', N'9O', 1, 137)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (122, N'IMPULSE TAOX', N'7C', 1, 138)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (123, N'PVD CLEANW', N'5B', 1, 139)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (124, N'PVD STANDARD CU', N'5E', 1, 140)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (125, N'VECTRA IMP TITANIUM', N'3E', 1, 155)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (126, N'VENTURA CU', N'7G', 1, 156)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (127, N'VENTURA TA(N)', N'7H', 1, 157)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (128, N'VENTURA TI', N'7I', 1, 158)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (129, N'VERSA HP TIN', N'2X', 1, 159)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (130, N'VERSA XLR W PVD', N'6W', 1, 160)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (131, N'VERSA XLR2 W', N'7W', 1, 161)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (132, N'VERSA XT CO', N'7R', 1, 162)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (133, N'ENHANCED CVD TXZ', N'4Y', 1, 163)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (134, N'CENTINEL ALD TIN', N'6K', 1, 169)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (135, N'SICONI PRECLEAN', N'5M', 1, 170)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (136, N'TRILLIUM TI', N'2V', 1, 171)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (137, N'TRILLIUM TIAL', N'7O', 1, 172)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (138, N'TRILLIUM TIN', N'7K', 1, 173)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (139, N'TRILLIUM TIN II', N'9L', 1, 174)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (140, N'TRILLIUM TIN X', N'7S', 1, 175)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (141, N'TRILLIUM W II', N'9N', 1, 176)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (142, N'VOLTA CO FILL', N'9Q', 1, 177)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (143, N'VOLTA CVD W', N'9A', 1, 179)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (144, N'VOLTA SELECTIVE W', N'2S', 1, 180)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (145, N'PRECLEAN XT TURBO EF', N'9I', 1, 183)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (146, N'METAL CLEAN XT', N'9K', 1, 184)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (147, N'TERSA PRECLEAN', N'9S', 1, 185)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (148, N'ANNEAL', N'5X', 1, 186)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (149, N'E2 VOLARIS', N'2Y', 1, 189)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (150, N'DEGAS CD', N'9P', 1, 191)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (151, N'Extensa TTN', N'6F', 1, 130)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (152, N'iSprint SSW', N'2T', 15, 9999999999)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (153, N'iSprint SSW II', N'2U', 15, 9999999999)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (154, N'Trillium TIN HP', N'9R', 15, 9999999999)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (155, N'Trillium TISIN', N'9C', 15, 9999999999)
INSERT [dbo].[Chamber] ([id], [name], [got_code], [platform_id], [appearance_order]) VALUES (156, N'Trillium W', N'9B', 15, 9999999999)
SET IDENTITY_INSERT [dbo].[Chamber] OFF
SET IDENTITY_INSERT [dbo].[Facet] ON 

INSERT [dbo].[Facet] ([id], [name]) VALUES (1, N'1')
INSERT [dbo].[Facet] ([id], [name]) VALUES (2, N'2')
INSERT [dbo].[Facet] ([id], [name]) VALUES (3, N'3')
INSERT [dbo].[Facet] ([id], [name]) VALUES (5, N'4')
INSERT [dbo].[Facet] ([id], [name]) VALUES (6, N'5')
INSERT [dbo].[Facet] ([id], [name]) VALUES (22, N'A')
INSERT [dbo].[Facet] ([id], [name]) VALUES (23, N'B')
INSERT [dbo].[Facet] ([id], [name]) VALUES (7, N'C')
INSERT [dbo].[Facet] ([id], [name]) VALUES (8, N'D')
INSERT [dbo].[Facet] ([id], [name]) VALUES (9, N'E')
INSERT [dbo].[Facet] ([id], [name]) VALUES (10, N'F')
INSERT [dbo].[Facet] ([id], [name]) VALUES (14, N'y')
SET IDENTITY_INSERT [dbo].[Facet] OFF
SET IDENTITY_INSERT [dbo].[FacetGroup] ON 

INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (8, N'1')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (6, N'12')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (38, N'12345')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (37, N'12345CD')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (28, N'135E')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (34, N'14')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (19, N'145')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (23, N'14CD')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (35, N'2')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (9, N'23')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (26, N'235')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (39, N'24')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (36, N'3')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (11, N'34')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (16, N'345')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (14, N'45')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (29, N'A')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (32, N'AB')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (30, N'B')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (31, N'C')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (4, N'CD')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (40, N'CE')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (33, N'D')
INSERT [dbo].[FacetGroup] ([id], [name]) VALUES (1, N'EF')
SET IDENTITY_INSERT [dbo].[FacetGroup] OFF
SET IDENTITY_INSERT [dbo].[FacetGroupMap] ON 

INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (15, 1, 9)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (16, 1, 10)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (13, 4, 7)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (14, 4, 8)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (2, 6, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (3, 6, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (1, 8, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (4, 9, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (5, 9, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (6, 11, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (7, 11, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (8, 14, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (9, 14, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (10, 16, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (11, 16, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (12, 16, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (17, 19, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (18, 19, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (19, 19, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (21, 23, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (22, 23, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (23, 23, 7)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (24, 23, 8)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (29, 26, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (30, 26, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (31, 26, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (32, 28, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (33, 28, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (34, 28, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (35, 28, 9)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (36, 29, 22)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (37, 30, 23)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (38, 31, 7)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (39, 32, 22)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (40, 32, 23)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (41, 33, 8)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (42, 34, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (43, 34, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (44, 35, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (45, 36, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (46, 37, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (47, 37, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (48, 37, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (49, 37, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (50, 37, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (51, 37, 7)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (52, 37, 8)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (53, 38, 1)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (54, 38, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (55, 38, 3)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (56, 38, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (57, 38, 6)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (58, 39, 2)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (59, 39, 5)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (60, 40, 7)
INSERT [dbo].[FacetGroupMap] ([id], [facet_group_id], [facet_id]) VALUES (61, 40, 9)
SET IDENTITY_INSERT [dbo].[FacetGroupMap] OFF
SET IDENTITY_INSERT [dbo].[G2ProductType] ON 

INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (2, N'CUBS', N'CUBS R&D', N'2160', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (3, N'AL', N'AL R&D', N'2157', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (17, N'Emerging', N'Emerging R&D', N'2168', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (18, N'ILB', N'ILB R&D', N'2147', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (19, N'Metal Gate Last', N'Metal Gate Last R&D', N'2152', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (20, N'WCVD', N'WCVD R&D', N'2155', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (21, N'CO Fill', N'CO Fill R&D', N'2159', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (22, N'Metal Gate First', N'Metal Gate First N/A', N'0000', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (23, N'Silicides', N'Silicides N/A', N'0001', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (24, N'TTN', N'TTN N/A', N'0002', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (25, N'Patterning', N'Patterning N/A', N'0003', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (26, N'Capping', N'Capping N/A', N'0004', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (27, N'Selective Fill', N'Integrated Selective W R&D', N'2170', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (28, N'Packaging MDP WLP', N'Packaging N/A', N'0005', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (29, N'TSV', N'Endura TSV R&D', N'2122', 1)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (30, N'Metal Gate Last Product Line', N'Metal Gate R&D', N'3152', 15)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (31, N'WCVD Product Line', N'WCVD Product R&D', N'3155', 15)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (32, N'Producer Metal ILB', N'Producer Metal ILB R&D', N'4147', 16)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (33, N'Producer Metal Gate Last', N'Producer Metal Gate Last', N'4152', 16)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (34, N'Producer Metal WCVD', N'Producer Metal WCVD R&D', N'4155', 16)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (35, N'Producer Metal Selective Fill', N'Producer Metal Selective Fill R&D', N'4170', 16)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (36, N'SAM', N'Producer SAM', N'2140', 16)
INSERT [dbo].[G2ProductType] ([id], [name], [rnd_product_name], [rnd_product_code], [platform_id]) VALUES (37, N'Packaging MDP WLP Product Line', N'Charger R&D', N'2125', 10)
SET IDENTITY_INSERT [dbo].[G2ProductType] OFF
SET IDENTITY_INSERT [dbo].[Opportunity] ON 

INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (30, N'1234', N'CuBS CVD LINER', N'2111', N'Endura', N'CuBs CVD Liner (2111) - 2', CAST(N'2019-03-31 23:03:36.543' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (31, N'1235', N'CuBS CVD LINER', N'2111', N'Endura', N'CuBs CVD Liner (2111) - 2', CAST(N'2019-03-31 23:03:36.560' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (32, N'123456', N'CuBS CVD LINER', N'2111', N'Endura', N'CuBs CVD Liner (2111) - 2', CAST(N'2019-03-31 23:03:36.560' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10032, N'Test1234', N'CuBS CVD LINER', N'2111', N'Endura 2', N'CuBs CVD Liner (2111) - 2', CAST(N'2019-03-31 23:03:36.560' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10033, N'Kashtest ', N'TestG3Product1', N'8881', N'Charger', N'TestG3Product1-Config1', CAST(N'2019-03-31 23:03:36.560' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10034, N'210064792', N'Cubs PVD', N'2110', N'Endura 2', N'CuBs PVD (2110)', CAST(N'2019-03-31 23:03:36.563' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10035, N'Gggg', N'CUBS R&D', N'2160', N'Endura 2', N'CuBs CVD Liner (2111) - 2', CAST(N'2019-03-31 23:03:36.563' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10036, N'123456', N'CUBS R&D', N'2160', N'Endura 2', N'CuBs PVD (2110)', CAST(N'2019-03-31 23:03:36.563' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10037, N'123', N'CuBS ALD BARRIER CVD LINER', N'2112', N'Endura 2', N'CuBs ALD BARRIER CVD Liner (2112)', CAST(N'2019-03-31 23:03:36.563' AS DateTime), CAST(N'2019-03-31 23:06:50.423' AS DateTime), N'', N'')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10038, N'1234', N'CUBS R&D', N'2160', N'Endura 2', N'CuBs ALD BARRIER CVD Liner (2112)', CAST(N'2019-04-01 14:12:38.017' AS DateTime), CAST(N'2019-04-01 14:12:38.020' AS DateTime), N'X098507', N'Sajith Rama Varma')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10039, N'1234', N'CUBS R&D', N'2160', N'Endura 2', N'CuBs REFLOW (2113) - 2', CAST(N'2019-04-01 14:30:22.053' AS DateTime), CAST(N'2019-04-01 14:30:22.057' AS DateTime), N'X098507', N'Sajith Rama Varma')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10040, N'23456', N'CuBS ALD BARRIER CVD LINER', N'2112', N'Endura 2', N'CuBs ALD BARRIER CVD Liner (2112)', CAST(N'2019-04-03 18:50:37.880' AS DateTime), CAST(N'2019-04-03 18:50:37.880' AS DateTime), N'X098507', N'Sajith Rama Varma')
INSERT [dbo].[Opportunity] ([id], [op_id], [product_name], [product_code], [platform_name], [nearest_product_config_name], [c_date], [m_date], [created_by_id], [created_by_name]) VALUES (10041, N'2222', N'CuBS REFLOW', N'2113', N'Endura 2', N'CuBs REFLOW (2113) - 2', CAST(N'2019-04-04 09:35:12.757' AS DateTime), CAST(N'2019-04-04 09:35:12.757' AS DateTime), N'X098507', N'Sajith Rama Varma')
SET IDENTITY_INSERT [dbo].[Opportunity] OFF
SET IDENTITY_INSERT [dbo].[OpportunityConfig] ON 

INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (211, N'1', N'', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (202, N'1', N'9E', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10241, N'1', N'ENCORE II RFX CU W COIL', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (193, N'1', N'SIP ENCORE II TA(N) REV.2.0', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10211, N'1', N'SIP ENCORE II TA(N) REV.2.0', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10223, N'1', N'SIP ENCORE II TA(N) REV.2.0', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10286, N'1', N'SIP ENCORE II TA(N) REV.2.0', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10232, N'1', N'SIP Encore3 Ta(N)', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10250, N'1', N'SIP Encore3 Ta(N)', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10259, N'1', N'SIP Encore3 Ta(N)', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10268, N'1', N'SIP Encore3 Ta(N)', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10277, N'1', N'SIP Encore3 Ta(N)', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (203, N'2', N'ACCESS CU', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10233, N'2', N'ACCESS CU', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10251, N'2', N'ACCESS CU', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10260, N'2', N'ACCESS CU', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10278, N'2', N'ACCESS CU', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10269, N'2', N'Access3 CU', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10287, N'2', N'Access3 CU', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (194, N'2', N'ENCORE II RFX CU W COIL', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (212, N'2', N'ENCORE II RFX CU W COIL', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10212, N'2', N'ENCORE II RFX CU W COIL', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10242, N'2', N'ENCORE II RFX CU W COIL', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10224, N'2', N'SIP ENCORE II TA(N) REV.2.0', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (195, N'3', N'', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (204, N'3', N'', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (213, N'3', N'', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10261, N'3', N'', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10270, N'3', N'', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10279, N'3', N'', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10288, N'3', N'', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10234, N'3', N'ACCESS CU', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10252, N'3', N'ACCESS CU', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10213, N'3', N'ENCORE II RFX CU W COIL', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10243, N'3', N'ENCORE II RFX CU W COIL', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10225, N'3', N'SIP ENCORE II RF CU', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10226, N'4', N'', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10244, N'4', N'ENCORE II RFX CU W COIL', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (196, N'4', N'VOLTA CVD CO', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (214, N'4', N'VOLTA CVD CO', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10214, N'4', N'VOLTA CVD CO', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10235, N'4', N'VOLTA CVD CO', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10253, N'4', N'VOLTA CVD CO', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10262, N'4', N'VOLTA CVD CO', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (205, N'4', N'VOLTA XT CO', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10271, N'4', N'VOLTA XT CO', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10280, N'4', N'VOLTA XT CO', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10289, N'4', N'VOLTA XT CO', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (197, N'5', N'', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (215, N'5', N'', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10227, N'5', N'', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10245, N'5', N'', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10254, N'5', N'', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10263, N'5', N'', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10272, N'5', N'', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10281, N'5', N'', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10290, N'5', N'', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10215, N'5', N'VOLTA CVD CO', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10236, N'5', N'VOLTA CVD CO', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (206, N'5', N'VOLTA XT CO', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10220, N'A', N'testchamber1', 10033)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10221, N'B', N'testchamber4', 10033)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (207, N'C', N'', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10246, N'C', N'', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (216, N'C', N'AKTIV PRECLEAN', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10291, N'C', N'AKTIV PRECLEAN', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10264, N'C', N'ALD2 TAN', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10255, N'C', N'ALD2 TAN REV 2.0', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10282, N'C', N'ALD2 TAN REV 2.0', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (198, N'C', N'PRECLEAN XT TURBO', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10216, N'C', N'PRECLEAN XT TURBO', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10228, N'C', N'PRECLEAN XT TURBO', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10273, N'C', N'PRECLEAN XT TURBO', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10237, N'C', N'SIP Encore3 Ta(N)', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10222, N'C', N'testchamber5', 10033)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (199, N'D', N'', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (208, N'D', N'', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (217, N'D', N'', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10238, N'D', N'', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10247, N'D', N'', 10036)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10265, N'D', N'', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10274, N'D', N'', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10283, N'D', N'', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10292, N'D', N'', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10256, N'D', N'ALD2 TAN REV 2.0', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10217, N'D', N'PRECLEAN XT TURBO', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10229, N'D', N'PRECLEAN XT TURBO', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10266, N'E', N'', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10275, N'E', N'', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10257, N'E', N'AKTIV PRECLEAN EF', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10284, N'E', N'AKTIV PRECLEAN EF', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10293, N'E', N'AKTIV PRECLEAN EF', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (200, N'E', N'DEGAS', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (209, N'E', N'DEGAS', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (218, N'E', N'DEGAS', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10218, N'E', N'DEGAS', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10239, N'E', N'DEGAS', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10230, N'E', N'DUAL MODE DEGAS', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10248, N'E', N'DUAL MODE DEGAS', 10036)
GO
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (201, N'F', N'', 30)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (210, N'F', N'', 31)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (219, N'F', N'', 32)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10240, N'F', N'', 10035)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10267, N'F', N'', 10038)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10276, N'F', N'', 10039)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10285, N'F', N'', 10040)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10294, N'F', N'', 10041)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10258, N'F', N'AKTIV PRECLEAN EF', 10037)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10219, N'F', N'DEGAS', 10032)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10231, N'F', N'DUAL MODE DEGAS', 10034)
INSERT [dbo].[OpportunityConfig] ([id], [facet_name], [chamber_name], [opportunity_id]) VALUES (10249, N'F', N'DUAL MODE DEGAS', 10036)
SET IDENTITY_INSERT [dbo].[OpportunityConfig] OFF
SET IDENTITY_INSERT [dbo].[Platform] ON 

INSERT [dbo].[Platform] ([id], [name], [facets_count], [model_svg_filename], [min_facetgroups_count]) VALUES (1, N'Endura 2', 9, N'b6babbf2-fa08-5b04-b014-501c7511a3bf.svg', 2)
INSERT [dbo].[Platform] ([id], [name], [facets_count], [model_svg_filename], [min_facetgroups_count]) VALUES (10, N'Charger', 3, N'bc294187-81df-5c88-8a9a-450a0e7709ca.svg', 1)
INSERT [dbo].[Platform] ([id], [name], [facets_count], [model_svg_filename], [min_facetgroups_count]) VALUES (15, N'Centura ACP', 4, N'eeab0ca8-fe5a-5dbf-aa4a-ebbdc644172d.svg', 1)
INSERT [dbo].[Platform] ([id], [name], [facets_count], [model_svg_filename], [min_facetgroups_count]) VALUES (16, N'Producer Metal', 3, N'8c3d8b11-f952-5c14-8b11-225c32172631.svg', 0)
SET IDENTITY_INSERT [dbo].[Platform] OFF
SET IDENTITY_INSERT [dbo].[PlatformFacetMap] ON 

INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (4, 1, 1)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (6, 1, 2)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (7, 1, 3)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (8, 1, 5)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (9, 1, 6)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (10, 1, 7)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (11, 1, 8)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (12, 1, 9)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (13, 1, 10)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (26, 10, 7)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (24, 10, 22)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (25, 10, 23)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (29, 15, 7)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (30, 15, 8)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (27, 15, 22)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (28, 15, 23)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (33, 16, 7)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (31, 16, 22)
INSERT [dbo].[PlatformFacetMap] ([id], [platform_id], [facet_id]) VALUES (32, 16, 23)
SET IDENTITY_INSERT [dbo].[PlatformFacetMap] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (1, N'Cubs PVD', N'2110', 2)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (2, N'CuBS CVD LINER', N'2111', 2)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (4, N'CuBS ALD BARRIER CVD LINER', N'2112', 2)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (6, N'CuBS REFLOW', N'2113', 2)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (7, N'Al Slab', N'2109', 3)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (9, N'Al Bondpad', N'2106', 3)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (10, N'Thick Al PVD', N'2156', 3)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (11, N'Al CVD FILL', N'2107', 3)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (18, N'New Memory', N'2136', 17)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (19, N'PVD CIS BSI ARC', N'2147', 17)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (20, N'PVD ALN LED Buffer', N'2167', 17)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (21, N'MRAM', N'2141', 17)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (22, N'Endura TSV R&D', N'2122', 29)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (23, N'ILB', N'2120', 18)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (24, N'ILB Silicide', N'2146', 18)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (25, N'Conformal ALD Silicide', N'2173', 18)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (26, N'ALD TAN Gate Etch Stop', N'2151', 19)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (27, N'Trillium P-Metal', N'2148', 19)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (28, N'Integrated Trillium N-Metal', N'2149', 19)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (29, N'Integrated wFill Liner', N'2154', 20)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (30, N'CO Fill Integrated ', N'2137', 21)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (31, N'CO Fill CVD', N'2158', 21)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (32, N'CO Fill PVD', N'2171', 21)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (33, N'Avenir Gate First', N'2116', 22)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (34, N'Gate Last Al Fill', N'2161', 22)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (35, N'Avenir Gate Last High K-Cap', N'2162', 22)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (36, N'Avenir Gate Last N-Metal', N'2163', 22)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (37, N'NI+CO Silicide', N'2119', 23)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (38, N'PVD W', N'2118', 23)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (39, N'PVD W SIN Bitline Stack', N'2164', 23)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (40, N'CUW PVD Only', N'2115', 24)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (41, N'CUW ILB', N'2165', 24)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (42, N'PVD TTN LB', N'2172', 24)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (43, N'PVD BEOL ESL', N'2134', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (44, N'PVD SIN HM', N'2133', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (45, N'PVD TIN HM', N'2131', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (46, N'PVD TIN HM Cirrus', N'2166', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (47, N'PVD WN HM', N'2132', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (48, N'Patterning MDP', N'2130', 25)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (49, N'CO Capping', N'2139', 26)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (50, N'Integrated Selective W', N'2169', 27)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (51, N'Trillium High K Cap', N'2138', 30)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (52, N'ACP Trillium P Metal', N'3148', 30)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (53, N'Trillium Gate Liner', N'2150', 30)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (54, N'iSprint ALD CVD W', N'2121', 31)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (55, N'iSprint SSW', N'2153', 31)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (56, N'MCVD', N'2114', 34)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (57, N'Producer Metal Integrated Selective W', N'4169', 35)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (58, N'Charger Bump', N'2128', 37)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (59, N'Charger Fanout WLP', N'2126', 37)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (60, N'Charger UBM Etch', N'2123', 37)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (61, N'Charger Fanout Curing', N'2145', 37)
INSERT [dbo].[Product] ([id], [name], [code], [g2_product_type_id]) VALUES (62, N'Charger Bump Curing', N'2144', 37)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductConfig] ON 

INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (1, 1, N'CuBs PVD (2110)')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (2, 2, N'CuBs CVD Liner (2111) - 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (4, 2, N'CuBs CVD Liner (2111) - 2')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (6, 4, N'CuBs ALD BARRIER CVD Liner (2112)')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (7, 6, N'CuBs REFLOW (2113) - 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (8, 6, N'CuBs REFLOW (2113) - 2')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (20, 7, N'AL SLAB (2109) - 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (31, 9, N'Al Bondpad Config - 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (26, 10, N'Thick Al')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (36, 23, N'ILB')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (37, 24, N'ILB Silicide')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (28, 30, N'Co Fill Integrated')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (27, 31, N'Co Fill CVD')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (29, 32, N'Co Fill PVD')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (38, 37, N'NI + CO Silicide')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (32, 49, N'Co Capping 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (33, 49, N'Co Capping 2')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (34, 50, N'Integrated Selective W 1')
INSERT [dbo].[ProductConfig] ([id], [product_id], [product_name]) VALUES (35, 50, N'Integrated Selective W 2')
SET IDENTITY_INSERT [dbo].[ProductConfig] OFF
SET IDENTITY_INSERT [dbo].[ProductConfigMap] ON 

INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (1, 1, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (28, 4, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (53, 7, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (116, 20, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (147, 26, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (166, 27, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (175, 29, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (194, 31, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (211, 33, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (215, 34, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (219, 35, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (223, 36, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (230, 37, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (240, 38, 1, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (2, 1, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (29, 4, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (54, 7, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (117, 20, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (148, 26, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (167, 27, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (169, 28, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (176, 29, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (195, 31, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (212, 33, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (216, 34, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (220, 35, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (224, 36, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (231, 37, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (241, 38, 2, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (3, 1, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (30, 4, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (55, 7, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (118, 20, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (149, 26, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (196, 31, 3, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (4, 1, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (31, 4, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (56, 7, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (119, 20, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (150, 26, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (197, 31, 4, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (5, 1, 5, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (32, 4, 5, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (120, 20, 5, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (151, 26, 5, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (198, 31, 5, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (18, 2, 6, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (44, 6, 6, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (62, 8, 6, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (208, 32, 6, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (6, 1, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (33, 4, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (57, 7, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (63, 8, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (121, 20, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (152, 26, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (199, 31, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (242, 38, 7, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (7, 1, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (34, 4, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (58, 7, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (64, 8, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (122, 20, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (153, 26, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (200, 31, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (213, 33, 8, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (45, 6, 9, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (46, 6, 10, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (9, 1, 11, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (19, 2, 11, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (35, 4, 11, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (47, 6, 11, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (59, 7, 11, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (65, 8, 11, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (10, 1, 12, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (20, 2, 12, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (36, 4, 12, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (48, 6, 12, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (60, 7, 12, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (66, 8, 12, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (13, 1, 13, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (21, 2, 13, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (37, 4, 13, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (14, 1, 14, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (22, 2, 14, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (38, 4, 14, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (15, 1, 15, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (23, 2, 15, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (39, 4, 15, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (16, 1, 16, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (24, 2, 16, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (40, 4, 16, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (49, 6, 16, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (17, 1, 17, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (25, 2, 17, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (41, 4, 17, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (50, 6, 17, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (61, 7, 18, 16)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (68, 8, 19, 9)
GO
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (26, 2, 20, 16)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (42, 4, 20, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (51, 6, 20, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (69, 8, 20, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (209, 32, 20, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (214, 33, 20, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (27, 2, 21, 16)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (43, 4, 21, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (52, 6, 21, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (70, 8, 21, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (8, 1, 22, 6)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (11, 1, 24, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (12, 1, 25, 11)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (126, 20, 35, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (157, 26, 35, 26)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (201, 31, 35, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (127, 20, 37, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (158, 26, 37, 26)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (202, 31, 37, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (128, 20, 38, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (159, 26, 38, 26)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (203, 31, 38, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (204, 31, 39, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (123, 20, 40, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (154, 26, 40, 34)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (205, 31, 40, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (232, 37, 40, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (244, 38, 40, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (124, 20, 41, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (155, 26, 41, 34)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (206, 31, 41, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (125, 20, 42, 19)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (156, 26, 42, 34)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (129, 20, 43, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (245, 38, 94, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (246, 38, 95, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (233, 37, 102, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (177, 29, 104, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (178, 29, 104, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (172, 28, 106, 8)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (174, 28, 106, 14)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (228, 36, 107, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (234, 37, 107, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (235, 37, 125, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (179, 29, 132, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (236, 37, 133, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (171, 28, 134, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (229, 36, 134, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (237, 37, 134, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (225, 36, 135, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (238, 37, 135, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (243, 38, 135, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (168, 27, 142, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (173, 28, 142, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (217, 34, 143, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (218, 34, 144, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (222, 35, 144, 38)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (170, 28, 146, 1)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (221, 35, 146, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (226, 36, 146, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (227, 36, 147, 4)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (239, 37, 147, 37)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (207, 31, 151, 9)
INSERT [dbo].[ProductConfigMap] ([id], [product_config_id], [chamber_id], [facet_group_id]) VALUES (247, 38, 151, 38)
SET IDENTITY_INSERT [dbo].[ProductConfigMap] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_2_Chamber]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[Chamber] ADD  CONSTRAINT [UK_2_Chamber] UNIQUE NONCLUSTERED 
(
	[got_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Facet]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[Facet] ADD  CONSTRAINT [UK_Facet] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_FacetGroup]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[FacetGroup] ADD  CONSTRAINT [UK_FacetGroup] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK_unique_key_group]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[FacetGroupMap] ADD  CONSTRAINT [UK_unique_key_group] UNIQUE NONCLUSTERED 
(
	[facet_group_id] ASC,
	[facet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_1_G2Product]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[G2ProductType] ADD  CONSTRAINT [UK_1_G2Product] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_2_G2Product]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[G2ProductType] ADD  CONSTRAINT [UK_2_G2Product] UNIQUE NONCLUSTERED 
(
	[rnd_product_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_3_G2Product]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[G2ProductType] ADD  CONSTRAINT [UK_3_G2Product] UNIQUE NONCLUSTERED 
(
	[rnd_product_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_group_op_config]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[OpportunityConfig] ADD  CONSTRAINT [UK_group_op_config] UNIQUE NONCLUSTERED 
(
	[facet_name] ASC,
	[chamber_name] ASC,
	[opportunity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_Platform]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[Platform] ADD  CONSTRAINT [UK_Platform] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK_group]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[PlatformFacetMap] ADD  CONSTRAINT [UK_group] UNIQUE NONCLUSTERED 
(
	[platform_id] ASC,
	[facet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_1_Product]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [UK_1_Product] UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_2_Product]    Script Date: 4/5/2019 5:55:22 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_2_Product] ON [dbo].[Product]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [PK_ProductConfig_MultiColumn]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[ProductConfig] ADD  CONSTRAINT [PK_ProductConfig_MultiColumn] UNIQUE NONCLUSTERED 
(
	[product_id] ASC,
	[product_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UK_ProductConfigMap_MultiColumn]    Script Date: 4/5/2019 5:55:22 PM ******/
ALTER TABLE [dbo].[ProductConfigMap] ADD  CONSTRAINT [UK_ProductConfigMap_MultiColumn] UNIQUE NONCLUSTERED 
(
	[chamber_id] ASC,
	[product_config_id] ASC,
	[facet_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Chamber]  WITH CHECK ADD  CONSTRAINT [FK_Chamber_Platform] FOREIGN KEY([platform_id])
REFERENCES [dbo].[Platform] ([id])
GO
ALTER TABLE [dbo].[Chamber] CHECK CONSTRAINT [FK_Chamber_Platform]
GO
ALTER TABLE [dbo].[FacetGroupMap]  WITH CHECK ADD  CONSTRAINT [FK_FacetGroupMap_Facet] FOREIGN KEY([facet_id])
REFERENCES [dbo].[Facet] ([id])
GO
ALTER TABLE [dbo].[FacetGroupMap] CHECK CONSTRAINT [FK_FacetGroupMap_Facet]
GO
ALTER TABLE [dbo].[FacetGroupMap]  WITH CHECK ADD  CONSTRAINT [FK_FacetGroupMap_FacetGroup] FOREIGN KEY([facet_group_id])
REFERENCES [dbo].[FacetGroup] ([id])
GO
ALTER TABLE [dbo].[FacetGroupMap] CHECK CONSTRAINT [FK_FacetGroupMap_FacetGroup]
GO
ALTER TABLE [dbo].[G2ProductType]  WITH CHECK ADD  CONSTRAINT [FK_G2Product_Platform] FOREIGN KEY([platform_id])
REFERENCES [dbo].[Platform] ([id])
GO
ALTER TABLE [dbo].[G2ProductType] CHECK CONSTRAINT [FK_G2Product_Platform]
GO
ALTER TABLE [dbo].[OpportunityConfig]  WITH CHECK ADD  CONSTRAINT [FK_OpportunityConfig_Opportunity] FOREIGN KEY([opportunity_id])
REFERENCES [dbo].[Opportunity] ([id])
GO
ALTER TABLE [dbo].[OpportunityConfig] CHECK CONSTRAINT [FK_OpportunityConfig_Opportunity]
GO
ALTER TABLE [dbo].[PlatformFacetMap]  WITH CHECK ADD  CONSTRAINT [FK_PlatformFacetMap_Facet] FOREIGN KEY([facet_id])
REFERENCES [dbo].[Facet] ([id])
GO
ALTER TABLE [dbo].[PlatformFacetMap] CHECK CONSTRAINT [FK_PlatformFacetMap_Facet]
GO
ALTER TABLE [dbo].[PlatformFacetMap]  WITH CHECK ADD  CONSTRAINT [FK_PlatformFacetMap_Platform] FOREIGN KEY([platform_id])
REFERENCES [dbo].[Platform] ([id])
GO
ALTER TABLE [dbo].[PlatformFacetMap] CHECK CONSTRAINT [FK_PlatformFacetMap_Platform]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_G2ProductType] FOREIGN KEY([g2_product_type_id])
REFERENCES [dbo].[G2ProductType] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_G2ProductType]
GO
ALTER TABLE [dbo].[ProductConfig]  WITH CHECK ADD  CONSTRAINT [FK_ProductConfig_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[ProductConfig] CHECK CONSTRAINT [FK_ProductConfig_Product]
GO
ALTER TABLE [dbo].[ProductConfigMap]  WITH CHECK ADD  CONSTRAINT [FK_ProductConfigMap_Chamber] FOREIGN KEY([chamber_id])
REFERENCES [dbo].[Chamber] ([id])
GO
ALTER TABLE [dbo].[ProductConfigMap] CHECK CONSTRAINT [FK_ProductConfigMap_Chamber]
GO
ALTER TABLE [dbo].[ProductConfigMap]  WITH CHECK ADD  CONSTRAINT [FK_ProductConfigMap_FacetGroup] FOREIGN KEY([facet_group_id])
REFERENCES [dbo].[FacetGroup] ([id])
GO
ALTER TABLE [dbo].[ProductConfigMap] CHECK CONSTRAINT [FK_ProductConfigMap_FacetGroup]
GO
ALTER TABLE [dbo].[ProductConfigMap]  WITH CHECK ADD  CONSTRAINT [FK_ProductConfigMap_ProductConfig] FOREIGN KEY([product_config_id])
REFERENCES [dbo].[ProductConfig] ([id])
GO
ALTER TABLE [dbo].[ProductConfigMap] CHECK CONSTRAINT [FK_ProductConfigMap_ProductConfig]
GO
USE [master]
GO
ALTER DATABASE [AmatG3MapperAppDb] SET  READ_WRITE 
GO
