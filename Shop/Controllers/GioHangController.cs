using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;

namespace WebBanQuanAo.Controllers
{
    public class GioHangController : Controller
    {
        //

        // GET: /GioHang/
        QLShopOnlineEntities db = new QLShopOnlineEntities();
        public List<ItemGioHang> LayGioHang()
        {
            // giỏ hàng đả tồn tại
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if (lstGioHang == null)
            {
                // nếu session giỏ hàng đã tồn tại
                lstGioHang = new List<ItemGioHang>();
                Session["GioHang"] = lstGioHang;

            }
            return lstGioHang;
        }
        // thêm giỏ hàng thông thường (Load lại trang)
        public ActionResult ThemGioHang(int IdSanPham, string strUrl)
        {
            // kiểm tra sản phẩm có tồn tại trong csdl ko
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanpham == null)
            {
                // trang đường dẩn ko hợp lệ
                Response.StatusCode = 404;
                return null;
            }
            // lấy giỏ hàng 
            List<ItemGioHang> lstGioHang = LayGioHang();
            // trường hợp đả tồn tại một sản phẩm trên giỏ hàng
            ItemGioHang sanphamcheck = lstGioHang.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanphamcheck != null)
            {
                // kiểm tra số lượng sản phẩm tồn
                if (sanpham.SoLuongTon < sanphamcheck.SoLuong)
                {
                    return View("ThongBao");
                }
                sanphamcheck.SoLuong++;
                sanphamcheck.TongTien = sanphamcheck.SoLuong * sanphamcheck.DonGia;
                return Redirect(strUrl);
            }
            ItemGioHang itemGH = new ItemGioHang(IdSanPham);
            if (sanpham.SoLuongTon < itemGH.SoLuong)
            {
                return View("ThongBao");
            }
            lstGioHang.Add(itemGH);
            db.SaveChanges();
            return Redirect(strUrl);
        }
        // xây dựng phương thức tính số lương
        public double TinhTongSoLuong()
        {
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if (lstGioHang == null)
            {
                return 0;
            }
            return lstGioHang.Sum(n => n.SoLuong);
        }
        // phương thức tính tiền
        public decimal TongTien()
        {
            List<ItemGioHang> lstGioHang = Session["GioHang"] as List<ItemGioHang>;
            if (lstGioHang == null)
            {
                return 0;
            }
            return lstGioHang.Sum(n => n.TongTien);
        }
        // xây dựng giỏ hàng partial
        public ActionResult GioHangPartial()
        {
            if (TinhTongSoLuong() == 0)
            {
                ViewBag.TongSoLuong = 0;
                ViewBag.TongTien = 0;
                return PartialView();
            }
            ViewBag.TongSoLuong = TinhTongSoLuong();
            ViewBag.TongTien = TongTien();
            return PartialView();
        }

        // Xem giỏ hàng

        public ActionResult XemGioHang()
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            List<ItemGioHang> lstGioHang = LayGioHang();
            return View(lstGioHang);
        }
        [HttpPost]
        public ActionResult XemGioHang(KhachHang khachhang, FormCollection f)
        {
            if (Session["Email"] == null)
                return RedirectToAction("Login", "User");
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            KhachHang KH = (KhachHang)Session["Email"];

            // thêm đơn hàng
            DonDatHang ddh = new DonDatHang();
            //ddh.IdKH =  int.Parse(KH.IdKH.ToString());
            List<ItemGioHang> lstGH = LayGioHang();
            ddh.IdKH = KH.IdKH;
            ddh.NguoiNhan = f["TenKhachHang"];
            ddh.DiaChiNguoiNhan = f["DiaChi"];
            ddh.SdtNguoiNhan = f["SoDienThoai"];
            ddh.NgayDat = DateTime.Now;
            ddh.TinhTrangGiaoHang = false;
            ddh.DaThanhToan = false;
            ddh.DaHuy = false;
            ddh.DaXoa = false;
            db.DonDatHangs.Add(ddh);
            db.SaveChanges();
            // thêm chi tiết đơn đặt hàng
            decimal tong = 0;
            decimal thanhtien = 0;
            foreach (var item in lstGH)
            {
                ChiTietDonDatHang ctdh = new ChiTietDonDatHang();
                ctdh.IdDDH = ddh.IdDDH;
                ctdh.IdSanPham = item.IdSanPham;
               ctdh.SoLuong = (int)item.SoLuong;
                ctdh.DonGia = (decimal)item.DonGia;
                thanhtien = item.SoLuong * item.DonGia;
                tong += thanhtien;
                db.ChiTietDonDatHangs.Add(ctdh);
                db.SaveChanges();
            }
            ddh.TongTien = tong;
            UpdateModel(ddh);
            db.SaveChanges();
            Session["GioHang"] = null;


            return View("ThongBao1");
        }

        [HttpGet]
        public ActionResult SuaGioHang(int IdSanPham)
        {
            // kiểm tra sản phẩm có tồn tại ko
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            // kiểm tra sản phẩm có tồn tại trong csdl ko
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanpham == null)
            {
                // trang đường dẩn ko hợp lệ
                Response.StatusCode = 404;
                return null;
            }
            // lấy list giỏ hàng từ session
            List<ItemGioHang> lstGioHang = LayGioHang();
            // kiểm tra sản phẩm có tồn tại trong giỏ hàng chưa
            ItemGioHang sanphamcheck = lstGioHang.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanphamcheck == null)
            {
                return RedirectToAction("Index", "Home");
            }
            // Lấy list giỏ hàng trên giao diện
            ViewBag.GioHang = lstGioHang;
            // nếu sản phẩm đả tồn tại
            return View(sanphamcheck);
        }
        // cập nhật giỏ hàng
        [HttpPost]
        public ActionResult CapNhatGioHang(ItemGioHang itemGH, FormCollection f)
        {
            // kiểm tra số lượng tồn
            SanPham sanphamcheck = db.SanPhams.SingleOrDefault(n => n.IdSanPham == itemGH.IdSanPham);
            if (sanphamcheck.SoLuongTon < itemGH.SoLuong)
            {
                return View("ThongBao");
            }
            // cập nhật số lượng trong session giỏ hàng
            List<ItemGioHang> lstGH = LayGioHang();
            // lấy sản phẩm cập nhật từ  trong list<GioHang>
            ItemGioHang itemGHUpdate = lstGH.Find(n => n.IdSanPham == itemGH.IdSanPham);
            if(itemGHUpdate != null)
            {
                itemGH.SoLuong = int.Parse(f["txtsoluong"].ToString());
            }
            // cập nhật lại số lượng và tổng tiền
            itemGHUpdate.SoLuong = itemGH.SoLuong;
            itemGHUpdate.TongTien = itemGHUpdate.SoLuong * itemGHUpdate.DonGia;
            return RedirectToAction("XemGioHang");
        }
        public ActionResult XoaGioHang(int IdSanPham)
        {
            // kiểm tra sản phẩm có tồn tại ko
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            // kiểm tra sản phẩm có tồn tại trong csdl ko
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanpham == null)
            {
                // trang đường dẩn ko hợp lệ
                Response.StatusCode = 404;
                return null;
            }
            // lấy list giỏ hàng từ session
            List<ItemGioHang> lstGioHang = LayGioHang();
            // kiểm tra sản phẩm có tồn tại trong giỏ hàng chưa
            ItemGioHang sanphamcheck = lstGioHang.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanphamcheck == null)
            {
                return RedirectToAction("Index", "Home");
            }
            // xóa sản phẩm 
            lstGioHang.Remove(sanphamcheck);
            return RedirectToAction("XemGioHang");
        }
        // xậy dựng action đặt hàng
        public ActionResult DatHang(KhachHang khachhang,FormCollection f)
        {
            if (Session["GioHang"] == null)
            {
                return RedirectToAction("Index", "Home");
            }
            KhachHang KH = (KhachHang)Session["Email"];
          
            // thêm đơn hàng
            DonDatHang ddh = new DonDatHang();
            //ddh.IdKH =  int.Parse(KH.IdKH.ToString());
            List<ItemGioHang> lstGH = LayGioHang();
            ddh.IdKH = KH.IdKH;
            ddh.NguoiNhan = f["TenKhachHang"];
            ddh.DiaChiNguoiNhan = f["DiaChi"];
            ddh.SdtNguoiNhan = f["SoDienThoai"];
            ddh.NgayDat = DateTime.Now;
            ddh.TinhTrangGiaoHang = false;
            ddh.DaThanhToan = false;
            ddh.DaHuy = false;
            ddh.DaXoa = false;
            db.DonDatHangs.Add(ddh);
            db.SaveChanges();
            // thêm chi tiết đơn đặt hàng
            decimal tong = 0;
            decimal thanhtien = 0;
            foreach (var item in lstGH)
            {
                ChiTietDonDatHang ctdh = new ChiTietDonDatHang();
                ctdh.IdDDH = ddh.IdDDH;
                ctdh.IdSanPham = item.IdSanPham;
                ctdh.TenSanPham = item.TenSanPham;
                ctdh.SoLuong = item.SoLuong;
                ctdh.DonGia = item.DonGia;
                db.ChiTietDonDatHangs.Add(ctdh);
                db.SaveChanges();
            }
            ddh.TongTien = tong;
            UpdateModel(ddh);
            db.SaveChanges();
            Session["GioHang"] = null;

            
            return View("ThongBao1");
        }
        // thêm giỏ hàng ajax
        public ActionResult ThemGioHangAjax(int IdSanPham, string strUrl)
        {
            // kiểm tra sản phẩm có tồn tại trong csdl ko
            SanPham sanpham = db.SanPhams.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanpham == null)
            {
                // trang đường dẩn ko hợp lệ
                Response.StatusCode = 404;
                return null;
            }
            // lấy giỏ hàng 

            List<ItemGioHang> lstGioHang = LayGioHang();
            // trường hợp đả tồn tại một sản phẩm trên giỏ hàng
            ItemGioHang sanphamcheck = lstGioHang.SingleOrDefault(n => n.IdSanPham == IdSanPham);
            if (sanphamcheck != null)
            {
                // kiểm tra số lượng sản phẩm tồn
                if (sanpham.SoLuongTon < sanphamcheck.SoLuong)
                {
                    return Content("<script>alert(\"Sản phẩm đả hết hàng !\")</script>");
                }
                sanphamcheck.SoLuong++;
                sanphamcheck.TongTien = sanphamcheck.SoLuong * sanphamcheck.DonGia;
                ViewBag.TongSoLuong = TinhTongSoLuong();
                ViewBag.TongTien = TongTien();
                return PartialView("GioHangPartial");
            }

            ItemGioHang itemGH = new ItemGioHang(IdSanPham);
            if (sanpham.SoLuongTon < itemGH.SoLuong)
            {
                return Content("<script>alert(\"Sản phẩm đả hết hàng !\")</script>");
            }
            lstGioHang.Add(itemGH);
            ViewBag.TongSoLuong = TinhTongSoLuong();
            ViewBag.TongTien = TongTien();
            return PartialView("GioHangPartial");
        }
	}
}