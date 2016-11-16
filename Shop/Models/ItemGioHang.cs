using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shop.Models
{

    public class ItemGioHang
    {

        public int IdSanPham { get; set; }
        public string TenSanPham { get; set; }
        public int SoLuong { get; set; }
        public decimal DonGia { get; set; }
        public decimal TongTien { get; set; }
        public string HinhAnh { get; set; }
        public ItemGioHang(int IdSanPham)
        {
            using (QLShopOnlineEntities db = new QLShopOnlineEntities())
            {
                this.IdSanPham = IdSanPham;
                SanPham sanpham = db.SanPhams.Single(n => n.IdSanPham == IdSanPham);
                this.TenSanPham = sanpham.TenSanPham;
                this.HinhAnh = sanpham.HinhAnh;
                this.DonGia = sanpham.DonGia.Value;
                this.SoLuong = 1;
                this.TongTien = DonGia * SoLuong;
            }
        }
        public ItemGioHang(int IdSanPham, int SL)
        {
            using (QLShopOnlineEntities db = new QLShopOnlineEntities())
            {
                this.IdSanPham = IdSanPham;
                SanPham sanpham = db.SanPhams.Single(n => n.IdSanPham == IdSanPham);
                this.TenSanPham = sanpham.TenSanPham;
                this.HinhAnh = sanpham.HinhAnh;
                this.DonGia = sanpham.DonGia.Value;
                this.SoLuong = SL;
                this.TongTien = DonGia * SoLuong;
            }
        }
        public ItemGioHang()
        {

        }
    }
}