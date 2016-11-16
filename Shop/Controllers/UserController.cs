using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;


namespace Shop.Controllers
{
    public class UserController : Controller
    {
        QLShopOnlineEntities db = new QLShopOnlineEntities();
        // GET: User
        public ActionResult Index()
        {
            return View();
        }
        #region Đăng nhập (Login)
        [HttpGet]

        public ActionResult Login()
        {
            return View();
        }
       
        [HttpPost]

        public ActionResult Login(FormCollection collection)
        {
            try
            {
                //Lấy giá trị ở Form Login
                var _Email = collection["Email"];
                var _Password = collection["Password"];
                KhachHang kh = db.KhachHangs.SingleOrDefault(n => n.Email == _Email && n.Password == _Password);
                //Tạo biến _UserLogin để kiểm tra tài khoản đăng nhập có trong CSDL không
                // var _UserLogin = db.Customers.SingleOrDefault(k => k.email == _Email && k.password == _Password);
                if (ModelState.IsValid && kh != null)
                {
                        Session["ID"] = kh.IdKH;
                        //Lưu các thông tin vào Session
                        Session["Email"] = kh;
                        Session["emailstring"] = kh.Email;
                        if (Session["Giohang"] == null)
                        {//Chuyển đến trang thông báo Login thành công (Ở đây không dùng được RedirectToAction vì [ChildActionOnly])
                            return Content("<script>alert('Đăng nhập thành công!');window.location='/Home/Index';</script>");
                        }
                        else
                            return Content("<script>alert('Đăng nhập thành công!');window.location='/GioHang/XemGioHang';</script>");
                   }
                else
                    return Content("<script>alert('Tên đăng nhập hoặc mật khẩu không đúng!');window.location='/User/Login';</script>");
            }
            catch
            {
                return Content("<script>alert('Đăng nhập thất bại!');window.location='/User/Login';</script>");
            }
        }


        #endregion
        #region Đăng xuất (Logout)
        public ActionResult Logout()
        {
            Session.RemoveAll();
            Session.Abandon();
            return RedirectToAction("Index", "Home");
        }
        #endregion
        #region Đăng ký (Register)
        public ActionResult Register()
        {
            //Đã Đăng Nhập thì không cho vào Form Đăng Ký
            if (Session["Email"] != null)
                return RedirectToAction("Index");
            return View();
        }

        [HttpPost]
        public ActionResult Register(FormCollection collection, KhachHang kh)
        {

            try
            {
                //Lấy giá trị ở Form Register    
                var _Password = collection["password1"];
                var _RePassword = collection["password2"];
                var _Email = collection["Email"];
                var _Address = collection["Address"];
                var _Phonenumber = collection["Phone"];
                var _Name = collection["name"];
                if (String.IsNullOrEmpty(_Email))
                {
                    return View();
                }
                //Kiểm tra xem tài khoản đã có người sử dụng chưa?
                var _CheckUser = db.KhachHangs.FirstOrDefault(k => k.Email == _Email);
                if (_CheckUser != null)
                    return Content("<script>alert('Email đã có người sử dụng!');window.location='/User/Register';</script>");
                else
                    kh.Email = _Email;

                //Kiểm tra Mật khẩu nhập lại có giống Mật khẩu đăng ký không?
                if(_Password != _RePassword)
                {
                    return Content("<script>alert('Mật khẩu nhập lại không đúng!');window.location='/User/Register';</script>");
                }
                kh.Password = _Password;
                kh.DiaChi = _Address;
                kh.SoDienThoai = _Phonenumber;
                kh.TenKhachHang = _Name;
                db.KhachHangs.Add(kh);
                db.SaveChanges();

                kh = db.KhachHangs.SingleOrDefault(n => n.Email == _Email && n.Password == _Password);

                //Lưu thông tin khách hàng vừa đăng ký vào Session để tự động đăng nhập
                Session["ID"] = kh.IdKH;
                //Lưu các thông tin vào Session
                Session["Email"] = kh;
                Session["emailstring"] = kh.Email;

                return Content("<script>alert('Đăng ký thành công!');window.location='/Home/Index';</script>");
            }
            catch
            {
                return Content("<script>alert('Đăng ký thất bại!');window.location='/User/Register';</script>");
            }
        }
        #endregion

    }
}