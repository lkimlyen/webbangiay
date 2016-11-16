using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;

namespace Shop.Controllers.Admin
{
    public class AdminController : BaseAdminController
    {
        // GET: Item
        private List<ThanhVien> getAdmin(int count)
        {
            return getAdmin(count, "");
        }
        private List<ThanhVien> getAllAdmins()
        {
            return getAdmin(-1, "");
        }
        private List<ThanhVien> getAdmin(int count, String keyword)
        {

            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.ThanhViens.Where(a => a.TaiKhoan.Contains(keyword)).OrderByDescending(a => a.TaiKhoan);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.ThanhViens.OrderByDescending(a => a.TaiKhoan);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }


        }
        private ThanhVien getOneAdmin(string username)
        {
            var item = from ic in data.ThanhViens
                       where ic.TaiKhoan.Equals(username)
                       select ic;
            if (item == null)
            {
                return new ThanhVien();
            }
            return item.Single();
        }


        // GET: Admin
        public ActionResult Index()
        {
            ViewData["ORDER_COMPLETED_AMOUNT"] = DataHelper.ShoppingCardHelper.getInstance().getPaidOrderAmount(data);
            ViewData["ORDER_AMOUNT"] = DataHelper.ShoppingCardHelper.getInstance().getOrderAmount(data);
            ViewData["MEMBER_AMOUNT"] = DataHelper.AccountHelper.getInstance().getMemberAccountAmount(data);
            ViewData["NEWS_AMOUNT"] = DataHelper.NewsHelper.getInstance().getNewsAmount(data);
            ViewData["ITEM_AMOUNT"] = DataHelper.ProductHelper.getInstance().getProductsAmount(data);
            ViewData["ITEM_CATEGORY_AMOUNT"] = DataHelper.ProductHelper.getInstance().getProductCategoryAmount(data);
            return View();
        }

        [HttpPost]
        public ActionResult Login(FormCollection form)
        {
            var username = form["username"];
            var password = form["password"];
            if (!String.IsNullOrEmpty(username) && !String.IsNullOrEmpty(password) &&
                DataHelper.AccountHelper.getInstance().loginAdmin(data, username, password))
            {
                //TODO, save session here
                Session[Constants.KEY_SESSION_ADMIN_USERNAME] = username;
                return RedirectToAction("Index");
            }
            else
            {
                ViewBag.ErrorMessage = "Vui lòng kiểm tra tên truy cập hoặc mật khẩu.";
                return View();
            }
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult Logout()
        {
            DataHelper.AccountHelper.getInstance().logoutAdmin(this);
            return RedirectToAction("Index");
        }
        
        [HttpGet]
        public ActionResult adminManagementView()
        {
            var listItem = getAdmin(50);
            return View(URLHelper.URL_ADMIN_MANAGEMENT, listItem);
        }
        [HttpPost]
        public ActionResult adminManagementView(FormCollection form, String btnDel)
        {

            if (btnDel != null)
            {
                //Delete all
                DataHelper.AccountHelper.getInstance().deleteAllAdmins(data);
            }

            var keyword = form["keyword"];
            var listItem = getAdmin(10, keyword);
            return View(URLHelper.URL_ADMIN_MANAGEMENT, listItem);
        }

        /*
       * 
       * 
       * 
       */
        [HttpGet]
        public ActionResult adminManagementCreate()
        {
            return View(URLHelper.URL_ADMIN_MANAGEMENT_M, new ThanhVien());
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult adminManagementCreate(FormCollection form)
        {
            ThanhVien tic = new ThanhVien();
            var username = form["username"];
            var password = form["password"];
            var hoten = form["name"];
            var id = form["IdTV"];
            bool err = false;
            if (String.IsNullOrEmpty(username))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập username!\n";
            }
            if (String.IsNullOrEmpty(password))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập mật khẩu!\n";
            }
            tic.TaiKhoan = username;
            tic.MatKhau = password;
            tic.IdTV = int.Parse(id.ToString());
            tic.HoTen = hoten;
            if (err == false)
            {
                data.ThanhViens.Add(tic);
                data.SaveChanges();
                return RedirectToAction("adminManagementView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_MANAGEMENT_M, tic);
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult adminManagementEdit(String username)
        {
            return View(URLHelper.URL_ADMIN_MANAGEMENT_M, getOneAdmin(username));
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult adminManagementEdit(FormCollection form)
        {
            var id = form["id"];
            if (id == null)
            {
                return adminManagementCreate(form);
            }
            else
            {
                ThanhVien tic = getOneAdmin(id);
                var password = form["password"];
                var username = form["username"];
                var hoten = form["name"];
                bool err = false;
                if (String.IsNullOrEmpty(username))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập username!\n";
                }
                if (String.IsNullOrEmpty(password))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập mật khẩu!\n";
                }
                tic.MatKhau = password;
                tic.TaiKhoan = username;

                tic.HoTen = hoten;
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("adminManagementView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_MANAGEMENT_M, tic);
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult adminManagementDelete(String username)
        {
            if (String.IsNullOrEmpty(username))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.ThanhViens.Remove(getOneAdmin(username));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return adminManagementView();
        }
    }
}