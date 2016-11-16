using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;
using System.Data.SqlClient;
using System.Net.Mail;

namespace Shop.Controllers
{
    public class HomeController : Controller
    {
        //
        QLShopOnlineEntities db = new QLShopOnlineEntities();
        // GET: /Home/

        public ActionResult Index()
        {
            ViewBag.ChuckII = (from s in db.SanPhams
                               where s.IdLoaiSanPham == 3 && s.DaXoa == false && s.Moi == true
                               orderby s.DonGia
                               select s).Take(4).ToList();
            ViewBag.Chuck = (from s in db.SanPhams
                             where s.IdLoaiSanPham == 3 && s.DaXoa == false && s.Moi == true
                             orderby s.DonGia
                             select s).Skip(4).Take(4).ToList();
            ViewBag.Classic = (from s in db.SanPhams
                               where s.IdLoaiSanPham == 2 && s.DaXoa == false && s.Moi == true
                               orderby s.DonGia
                               select s).Take(4).ToList();
            ViewBag.CVClassic = (from s in db.SanPhams
                                 where s.IdLoaiSanPham == 2 && s.DaXoa == false && s.Moi == true
                                 orderby s.DonGia
                                 select s).Skip(4).Take(4).ToList();
            ViewBag.Balo = (from s in db.SanPhams
                            where s.IdLoaiSanPham == 6 && s.DaXoa == false && s.Moi == true
                            orderby s.DonGia
                            select s).Take(4).ToList();
            ViewBag.BaloCV = (from s in db.SanPhams
                              where s.IdLoaiSanPham == 6 && s.DaXoa == false && s.Moi == true
                              orderby s.DonGia
                              select s).Skip(4).Take(4).ToList();


            return View();
        }
        public ActionResult menutop()
        {
            var menu = db.LoaiSanPhams.ToList();
            return PartialView(menu);
            
        }
        public ActionResult ProductType(int id)
        {
            var laysp = from g in db.SanPhams
                        from h in db.LoaiSanPhams
                        where h.IdLoaiSanPham == id && g.IdLoaiSanPham == h.IdLoaiSanPham && g.DaXoa == false && h.Status == true
                        select g;
            Session["loai"] = id;
            LoaiSanPham loai = db.LoaiSanPhams.SingleOrDefault(n => n.IdLoaiSanPham == id);
            ViewBag.TenLoai = loai.TenLoai;
            return View(laysp.ToList());
        }
        public ActionResult MenuPartial()
        {
            // truy vấn list sản phẩm
            var lstSanPham = db.SanPhams;
            return PartialView(lstSanPham);
        }
        public ActionResult Details(int id)
        {
            var CT_SP = (db.SanPhams.First(sp => sp.IdSanPham == id));
            int loai = int.Parse(CT_SP.IdLoaiSanPham.ToString());
            LoaiSanPham loaisp = db.LoaiSanPhams.SingleOrDefault(n => n.IdLoaiSanPham == loai);
            ViewBag.TenLoai = loaisp.TenLoai;
            ViewBag.SP_cungloai = (from s in db.SanPhams
                                   where s.IdSanPham != id && s.IdLoaiSanPham == loai && s.DaXoa == false
                                   select s).ToList();

            return View(CT_SP);

        }
        public ActionResult LienHe()
        {
            return View(new LienHe());
        }
        [HttpGet]
        public ActionResult Search(string txttimkiem)
        {
            string tukhoa = txttimkiem;
            if (String.IsNullOrEmpty(tukhoa))
                tukhoa = "";
            ViewBag.tukhoa = tukhoa;
            Session["timkiem"] = txttimkiem;
            List<SanPham> sp = db.SanPhams.Where(n => n.TenSanPham.Contains(tukhoa)).ToList();
            
            return View(sp.ToList());
        }
    }
}