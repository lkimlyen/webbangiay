USE [master]
GO
/****** Object:  Database [QLShopOnline]    Script Date: 11/16/2016 12:28:28 PM ******/
CREATE DATABASE [QLShopOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLShopOnline', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QLShopOnline.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLShopOnline_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QLShopOnline_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLShopOnline] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLShopOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLShopOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLShopOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLShopOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLShopOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLShopOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLShopOnline] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLShopOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLShopOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLShopOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLShopOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLShopOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLShopOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLShopOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLShopOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLShopOnline] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLShopOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLShopOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLShopOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLShopOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLShopOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLShopOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLShopOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLShopOnline] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLShopOnline] SET  MULTI_USER 
GO
ALTER DATABASE [QLShopOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLShopOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLShopOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLShopOnline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QLShopOnline] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QLShopOnline]
GO
/****** Object:  Table [dbo].[ChiTietDonDatHang]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonDatHang](
	[IdCTDDH] [int] IDENTITY(1,1) NOT NULL,
	[IdDDH] [int] NULL,
	[IdSanPham] [int] NULL,
	[TenSanPham] [nchar](10) NULL,
	[SoLuong] [int] NULL,
	[DonGia] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCTDDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietPhieuNhap]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuNhap](
	[IdCTPN] [int] IDENTITY(1,1) NOT NULL,
	[IdPN] [int] NULL,
	[DonGiaNhap] [decimal](18, 0) NULL,
	[SoLuongNhap] [int] NULL,
	[IdSanPham] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCTPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonDatHang]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DonDatHang](
	[IdDDH] [int] IDENTITY(1,1) NOT NULL,
	[IdKH] [int] NULL,
	[IdSanPham] [int] NULL,
	[NgayDat] [datetime] NULL,
	[NgayGiao] [datetime] NULL,
	[DaHuy] [bit] NULL,
	[DaXoa] [bit] NULL,
	[TinhTrangGiaoHang] [bit] NULL,
	[DaThanhToan] [bit] NULL,
	[NguoiNhan] [nvarchar](50) NULL,
	[SdtNguoiNhan] [varchar](20) NULL,
	[DiaChiNguoiNhan] [nvarchar](100) NULL,
	[TongTien] [decimal](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KhachHang](
	[IdKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKhachHang] [nvarchar](max) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[Password] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoaiSanPham]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSanPham](
	[IdLoaiSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](max) NULL,
	[ThongTin] [nvarchar](max) NULL,
	[BiDanh] [nvarchar](max) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdLoaiSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaLoaiSanPham]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaLoaiSanPham](
	[IdMLSP] [int] IDENTITY(1,1) NOT NULL,
	[TenLSP] [nvarchar](max) NULL,
	[ThongTin] [nvarchar](max) NULL,
	[Logo] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMLSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhieuNhap]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuNhap](
	[IdPN] [int] IDENTITY(1,1) NOT NULL,
	[NgayNhap] [datetime] NULL,
	[DaXoa] [bit] NULL,
	[IdMLSP] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[IdSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](max) NULL,
	[DonGia] [decimal](18, 0) NULL,
	[NgayCapNhat] [datetime] NULL,
	[MoTa] [nvarchar](max) NULL,
	[LuotXem] [int] NULL,
	[IdLoaiSanPham] [int] NULL,
	[GiaKhuyenMai] [decimal](18, 0) NULL,
	[HinhAnh] [nvarchar](max) NULL,
	[HinhAnh1] [nvarchar](max) NULL,
	[HinhAnh2] [nvarchar](max) NULL,
	[DaXoa] [bit] NULL,
	[Moi] [bit] NULL,
	[IdMLSP] [int] NULL,
	[SoLuongTon] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Slider]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slider](
	[IdSlider] [int] IDENTITY(1,1) NOT NULL,
	[HinhAnh] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdSlider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThanhVien]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhVien](
	[IdTV] [int] NOT NULL,
	[TaiKhoan] [nvarchar](max) NULL,
	[MatKhau] [nvarchar](max) NULL,
	[HoTen] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinTuc]    Script Date: 11/16/2016 12:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinTuc](
	[IdTinTuc] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](max) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[HinhAnhDaiDien] [nvarchar](max) NULL,
	[Moi] [bit] NULL,
	[NoiBat] [bit] NULL,
	[NgayDang] [datetime] NULL,
	[MoTa] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTinTuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ChiTietDonDatHang] ON 

INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (2, 8, NULL, NULL, NULL, NULL)
INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (3, 9, 9, NULL, NULL, NULL)
INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (4, 15, 9, NULL, 1, CAST(1300000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (5, 16, 69, NULL, 1, CAST(1300000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (6, 16, 77, NULL, 1, CAST(1300000 AS Decimal(18, 0)))
INSERT [dbo].[ChiTietDonDatHang] ([IdCTDDH], [IdDDH], [IdSanPham], [TenSanPham], [SoLuong], [DonGia]) VALUES (7, 16, 58, NULL, 1, CAST(1900000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[ChiTietDonDatHang] OFF
SET IDENTITY_INSERT [dbo].[DonDatHang] ON 

INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (1, 5, NULL, CAST(N'2016-11-09 16:33:25.103' AS DateTime), NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (2, 6, NULL, CAST(N'2016-11-09 16:38:26.583' AS DateTime), NULL, 0, 0, 0, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (3, 1, NULL, CAST(N'2016-11-09 16:54:32.210' AS DateTime), NULL, 0, 0, 0, 0, N'lương yến', N'01669380986', N'tphcm', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (4, 1, NULL, CAST(N'2016-11-09 16:58:28.217' AS DateTime), NULL, 0, 0, 0, 0, N'yen yen', N'02154554', N'dsjchsjkdh', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (5, 1, NULL, CAST(N'2016-11-09 17:05:23.300' AS DateTime), NULL, 0, 0, 0, 0, N'yến yến', N'01669380986', N'tp.chm', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (6, 1, NULL, CAST(N'2016-11-09 20:54:15.280' AS DateTime), NULL, 0, 0, 0, 0, N'yenyen', N'245464646', N'jhsadjkahsd', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (7, 1, NULL, CAST(N'2016-11-09 21:00:13.587' AS DateTime), NULL, 0, 0, 0, 0, N'yenyen', N'6454654', N'jsdjashdkk', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (8, 1, NULL, CAST(N'2016-11-09 21:07:16.050' AS DateTime), NULL, 0, 0, 0, 0, N'vxcjvhcxh', N'35656', N'dsdfsdf', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (9, 1, NULL, CAST(N'2016-11-09 21:09:23.553' AS DateTime), NULL, 0, 0, 0, 0, N'jsfkshdfh', N'564564654654', N'jkhjhjsdfh', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (10, 1, NULL, CAST(N'2016-11-09 21:13:03.097' AS DateTime), NULL, 0, 0, 0, 0, N'sadsdsad', N'01669380986', N'fsdgdfgdfg', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (11, 1, NULL, CAST(N'2016-11-09 21:22:18.657' AS DateTime), NULL, 0, 0, 0, 0, N'dsfjsdhjkfhkj', N'jsgjdskgfhsd', N'3454654', CAST(0 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (12, 1, NULL, CAST(N'2016-11-09 21:24:26.113' AS DateTime), NULL, 0, 0, 0, 0, N'dsfsdvsdv', N'45465445', N'dhfuidsufh', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (13, 1, NULL, CAST(N'2016-11-09 21:27:48.927' AS DateTime), NULL, 0, 0, 0, 0, N'sdfjhsdjkfh', N'156456454564', N'jhdkjsfhsjkdhf', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (14, 1, NULL, CAST(N'2016-11-09 21:29:48.037' AS DateTime), NULL, 0, 0, 0, 0, N'dbcdzmv', N'231651654', N'hdgjchdshj', NULL)
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (15, 1, NULL, CAST(N'2016-11-09 21:33:11.650' AS DateTime), NULL, 0, 0, 0, 0, N'vdfbvfd', N'3534534', N'jdshksd', CAST(1300000 AS Decimal(18, 0)))
INSERT [dbo].[DonDatHang] ([IdDDH], [IdKH], [IdSanPham], [NgayDat], [NgayGiao], [DaHuy], [DaXoa], [TinhTrangGiaoHang], [DaThanhToan], [NguoiNhan], [SdtNguoiNhan], [DiaChiNguoiNhan], [TongTien]) VALUES (16, 1, NULL, CAST(N'2016-11-09 23:49:06.077' AS DateTime), NULL, 1, 0, 1, 1, N'sdfdsfsd', N'55646', N'sdgfsdg', CAST(4500000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[DonDatHang] OFF
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([IdKH], [TenKhachHang], [DiaChi], [Email], [SoDienThoai], [Password]) VALUES (1, N'yến ', N'tp.hcm', N'lkimlyen2912@gmail.com', N'01669380986', N'123123')
INSERT [dbo].[KhachHang] ([IdKH], [TenKhachHang], [DiaChi], [Email], [SoDienThoai], [Password]) VALUES (2, NULL, N'tp.hcm', N'luongthiyen@gmail.com', N'01669380986', N'123123')
INSERT [dbo].[KhachHang] ([IdKH], [TenKhachHang], [DiaChi], [Email], [SoDienThoai], [Password]) VALUES (3, N'yenyen', N'tp.hcm', N'luongthiyen2912@gmail.com', N'01669380986', N'hoahong')
INSERT [dbo].[KhachHang] ([IdKH], [TenKhachHang], [DiaChi], [Email], [SoDienThoai], [Password]) VALUES (5, N'lương yến', N'hcm', N'lkimlyen2912@gmail.com', N'01669380986', NULL)
INSERT [dbo].[KhachHang] ([IdKH], [TenKhachHang], [DiaChi], [Email], [SoDienThoai], [Password]) VALUES (6, N'yen yen', N'tphcm', N'lkimlyen2912@gmail.com', N'01669380986', NULL)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
SET IDENTITY_INSERT [dbo].[LoaiSanPham] ON 

INSERT [dbo].[LoaiSanPham] ([IdLoaiSanPham], [TenLoai], [ThongTin], [BiDanh], [Status]) VALUES (2, N'Converse Classic', N'giày nữ', N'Converse Classic', 1)
INSERT [dbo].[LoaiSanPham] ([IdLoaiSanPham], [TenLoai], [ThongTin], [BiDanh], [Status]) VALUES (3, N'Converse Chuck II', N'giày nữ', N'Converse Chuck II', 1)
INSERT [dbo].[LoaiSanPham] ([IdLoaiSanPham], [TenLoai], [ThongTin], [BiDanh], [Status]) VALUES (6, N'Ba Lô Converse', N'', N'Ba Lô Converse', 1)
SET IDENTITY_INSERT [dbo].[LoaiSanPham] OFF
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (3, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.103' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
		SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
	&nbsp;</div>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (4, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.030' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (5, N'CChuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.763' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (6, N'CChuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.780' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (7, N'Chuck Taylor All Star Metallic Rubber', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:10:33.720' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">553269C</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'718553269Cstandard-thumb.png', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (8, N'Chuck Taylor All Star II Shield Canvas', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:12:02.960' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154013V</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'960154013Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (9, N'Chuck Taylor All Star Rubber', CAST(1300000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:13:39.300' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">651794C</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Kids</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'298651794C-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (10, N'Chuck Taylor All Star II Shield Canvas', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:15:28.480' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
	SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154017V</mark></h4>
<p>
	<span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>
', NULL, 3, CAST(0 AS Decimal(18, 0)), N'479154017V-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (47, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (48, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (50, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (51, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (52, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (53, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (55, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (56, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (57, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (58, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (59, N'Chuck Taylor All Star Metallic Rubber', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:10:33.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">553269C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'718553269Cstandard-thumb.png', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (60, N'Chuck Taylor All Star II Shield Canvas', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:12:02.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154013V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'960154013Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (61, N'Chuck Taylor All Star Rubber', CAST(1300000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:13:39.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">651794C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Kids</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'298651794C-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (62, N'Chuck Taylor All Star II Shield Canvas', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:15:28.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154017V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 2, CAST(0 AS Decimal(18, 0)), N'479154017V-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (63, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (64, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (65, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (66, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (67, N'Chuck Taylor All Star Metallic Rubber', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:10:33.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">553269C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'718553269Cstandard-thumb.png', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (68, N'Chuck Taylor All Star II Shield Canvas', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:12:02.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154013V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'960154013Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (69, N'Chuck Taylor All Star Rubber', CAST(1300000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:13:39.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">651794C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Kids</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'298651794C-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (70, N'Chuck Taylor All Star II Shield Canvas', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:15:28.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154017V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'479154017V-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (71, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (72, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (73, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (74, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 101)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (75, N'Chuck Taylor All Star Metallic Rubber', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:10:33.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">553269C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'718553269Cstandard-thumb.png', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (76, N'Chuck Taylor All Star II Shield Canvas', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:12:02.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154013V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'960154013Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (77, N'Chuck Taylor All Star Rubber', CAST(1300000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:13:39.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">651794C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Kids</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'298651794C-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (78, N'Chuck Taylor All Star II Shield Canvas', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:15:28.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154017V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'479154017V-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (79, N'Chuck Taylor All Star II Engineered Canvas', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:00:48.000' AS DateTime), N'<div class="info-left" style="box-sizing: border-box; margin: 0px; padding: 0px 15px 0px 0px; border-width: 0px 1px 0px 0px; border-right-style: solid; border-right-color: rgb(0, 0, 0); vertical-align: middle; display: table-cell; text-align: right; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 <h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px;">
  SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153550V</mark></h4>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Chất liệu: Textile</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px;">Giới t&iacute;nh: Men, Women</span></div>
<div class="info-right" style="box-sizing: border-box; margin: 0px; padding: 0px 0px 0px 15px; border: 0px; vertical-align: middle; display: table-cell; width: 607px; color: rgb(0, 0, 0); font-family: Arial, Helvetica, sans-serif; font-size: medium; line-height: 16px;">
 &nbsp;</div>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'102153550Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (80, N'Chuck Taylor All Star Translucent Rubber', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:03:01.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153806C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'30153806Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (81, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:05:24.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153560V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'762153560Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (82, N'Chuck Taylor All Star II Translucent Rubber', CAST(1900000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:06:45.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">153562V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Synthetic</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Men, Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'779153562Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 10)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (83, N'Chuck Taylor All Star Metallic Rubber', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:10:33.000' AS DateTime), N'	<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">553269C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'718553269Cstandard-thumb.png', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (84, N'Chuck Taylor All Star II Shield Canvas', CAST(1600000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:12:02.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154013V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'960154013Cstandard-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (85, N'Chuck Taylor All Star Rubber', CAST(1300000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:13:39.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">651794C</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Rubber</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Kids</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'298651794C-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (86, N'Chuck Taylor All Star II Shield Canvas', CAST(1500000 AS Decimal(18, 0)), CAST(N'2016-11-03 23:15:28.000' AS DateTime), N'<h4 style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-weight: 400; font-family: MyriadBold; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">
 SKU:&nbsp;<mark style="box-sizing: border-box; vertical-align: baseline; margin: 0px; padding: 0px; border: 0px; background-color: transparent;">154017V</mark></h4>
<p>
 <span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Chất liệu: Canvas</span><span style="box-sizing: border-box; margin: 5px 0px; padding: 0px; border: 0px; vertical-align: baseline; font-family: MyriadBold; display: block; width: 591px; height: auto; font-size: 15px; line-height: 18px; color: rgb(0, 0, 0); text-align: right;">Giới t&iacute;nh: Women</span></p>', NULL, 3, CAST(0 AS Decimal(18, 0)), N'479154017V-thumb.jpg', NULL, NULL, 0, 1, NULL, 1)
INSERT [dbo].[SanPham] ([IdSanPham], [TenSanPham], [DonGia], [NgayCapNhat], [MoTa], [LuotXem], [IdLoaiSanPham], [GiaKhuyenMai], [HinhAnh], [HinhAnh1], [HinhAnh2], [DaXoa], [Moi], [IdMLSP], [SoLuongTon]) VALUES (87, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
INSERT [dbo].[ThanhVien] ([IdTV], [TaiKhoan], [MatKhau], [HoTen]) VALUES (1, N'admin', N'admin', N'yến')
SET IDENTITY_INSERT [dbo].[TinTuc] ON 

INSERT [dbo].[TinTuc] ([IdTinTuc], [TieuDe], [NoiDung], [HinhAnhDaiDien], [Moi], [NoiBat], [NgayDang], [MoTa]) VALUES (2, N'tt1234', N'<p>
	dsvsdvxv</p>
', N'816landing-page-cii-rubber.jpg', 1, 1, CAST(N'2016-11-03 16:58:58.817' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[TinTuc] OFF
ALTER TABLE [dbo].[ChiTietDonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonDatHang_DonDatHang] FOREIGN KEY([IdDDH])
REFERENCES [dbo].[DonDatHang] ([IdDDH])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonDatHang] CHECK CONSTRAINT [FK_ChiTietDonDatHang_DonDatHang]
GO
ALTER TABLE [dbo].[ChiTietDonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonDatHang_SanPham] FOREIGN KEY([IdSanPham])
REFERENCES [dbo].[SanPham] ([IdSanPham])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietDonDatHang] CHECK CONSTRAINT [FK_ChiTietDonDatHang_SanPham]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhieuNhap_ToPhieuNhap] FOREIGN KEY([IdPN])
REFERENCES [dbo].[PhieuNhap] ([IdPN])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [FK_ChiTietPhieuNhap_ToPhieuNhap]
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhieuNhap_ToSanPham] FOREIGN KEY([IdSanPham])
REFERENCES [dbo].[SanPham] ([IdSanPham])
GO
ALTER TABLE [dbo].[ChiTietPhieuNhap] CHECK CONSTRAINT [FK_ChiTietPhieuNhap_ToSanPham]
GO
ALTER TABLE [dbo].[DonDatHang]  WITH CHECK ADD  CONSTRAINT [FK_DonDatHang_KhachHang] FOREIGN KEY([IdKH])
REFERENCES [dbo].[KhachHang] ([IdKH])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DonDatHang] CHECK CONSTRAINT [FK_DonDatHang_KhachHang]
GO
ALTER TABLE [dbo].[PhieuNhap]  WITH CHECK ADD  CONSTRAINT [FK_PhieuNhap_ToMaLoaiSanPham] FOREIGN KEY([IdMLSP])
REFERENCES [dbo].[MaLoaiSanPham] ([IdMLSP])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhieuNhap] CHECK CONSTRAINT [FK_PhieuNhap_ToMaLoaiSanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_MaLoaiSanPham] FOREIGN KEY([IdMLSP])
REFERENCES [dbo].[MaLoaiSanPham] ([IdMLSP])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_MaLoaiSanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_ToLoaiSanPham] FOREIGN KEY([IdLoaiSanPham])
REFERENCES [dbo].[LoaiSanPham] ([IdLoaiSanPham])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_ToLoaiSanPham]
GO
USE [master]
GO
ALTER DATABASE [QLShopOnline] SET  READ_WRITE 
GO
