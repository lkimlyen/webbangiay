using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;
using System.IO;
using PagedList;
namespace Shop.Controllers.Admin
{
    public class ItemController : BaseAdminController
    {
        // GET: ItemCategories
        private List<LoaiSanPham> getItemCategories(int count)
        {
            return getItemCategories(count, "");
        }
        private List<LoaiSanPham> getAllItemCategories()
        {
            return getItemCategories(-1, "");
        }
        private List<LoaiSanPham> getItemCategories(int count, String keyword)
        {
            var result = data.LoaiSanPhams;
            if (!String.IsNullOrEmpty(keyword))
                result.Where(a => a.TenLoai.Contains(keyword));
            if (count != -1)
                result.Take(count);
            return result.ToList();
        }
        // GET: Item
        private List<SanPham> getItem(int count)
        {
            return getItem(count, "");
        }
        private List<SanPham> getAllItem()
        {
            return getItem(-1, "");
        }
        private List<SanPham> getItem(int count, String keyword)
        {

            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.SanPhams.Where(a => a.TenSanPham.Contains(keyword)).OrderByDescending(a => a.NgayCapNhat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.SanPhams.OrderByDescending(a => a.NgayCapNhat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }


        }
        private SanPham getOneItem(int id)
        {
            var item = from ic in data.SanPhams
                       where ic.IdSanPham == id
                       select ic;
            if (item == null)
            {
                var product = new SanPham();
                product.DonGia = 0;
                product.GiaKhuyenMai = 0;
                return product;
            }
            return item.Single();
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return itemView(1);
        }

        public ActionResult ItemSetStatusEnable(int id)
        {
            SanPham tic = getOneItem(id);
            tic.DaXoa = !tic.DaXoa;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("itemView");
        }

        public ActionResult ItemSetNewEnable(int id)
        {
            SanPham tic = getOneItem(id);
            tic.Moi = !tic.Moi;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("itemView");
        }

        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult itemView(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listItem = getItem(50);
            return View(URLHelper.URL_ADMIN_ITEM, listItem.ToPagedList(pageNum,pageSize));
        }
        [HttpPost]
        public ActionResult itemView(FormCollection form, String btnDel)
        {
            if (btnDel != null)
            {
                //Delete checked items
                string checkedList = form["chk[]"];
                if (!String.IsNullOrEmpty(checkedList))
                {
                    string[] arrayStringCheckedList = checkedList.Split(new char[] { ',' });
                    for (int i = 0; i < arrayStringCheckedList.Length; i++)
                    {
                        try
                        {
                            data.SanPhams.Remove(getOneItem(Int32.Parse(arrayStringCheckedList[i])));
                            data.SaveChanges();
                            ViewBag.AlertSuccess = "Xoá thành công!";
                        }
                        catch (Exception e)
                        {
                            ViewBag.AlertError = "Không xoá được";
                        }
                    }
                }
            }


            var keyword = form["keyword"];
            var listItem = getItem(10, keyword);
            return View(URLHelper.URL_ADMIN_ITEM, listItem);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult itemCreate()
        {
            var product = new SanPham();
            product.DonGia = 0;
            product.GiaKhuyenMai = 0;
            return View(URLHelper.URL_ADMIN_ITEM_M, new Tuple<SanPham, List<LoaiSanPham>>(product, getAllItemCategories()));
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult itemCreate(FormCollection form, HttpPostedFileBase fileUpload)
        {
            SanPham tic = new SanPham();
            var name = form["name"];
            var sort = form["sort"];
            var title = form["title"];
            var description = form["description"];
            var keyword = form["keyword"];
            var price = form["price"];
            var price2 = form["price2"];
            var online_payment = form["online_payment"];
            var detail = form["detail"];
            
            var sold_amount = form["soldamount"];
            var current_amount = form["currentamount"];

            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên sản phẩm!\n";
            }
            if (form["parent"].ToString().Equals("0"))
            {
                err = true;
                ViewData["Error"] += "Vui lòng chọn danh mục!\n";
            }
            else
            {
                tic.IdLoaiSanPham = Int32.Parse(form["parent"]);
            }
            tic.TenSanPham = name;
            tic.DaXoa = false;
            tic.Moi = false;
            tic.NgayCapNhat = DateTime.Now;
            if (!String.IsNullOrEmpty(price))
                tic.DonGia = Int32.Parse(price);
            else
                tic.DonGia = 0;
            if (!String.IsNullOrEmpty(price2))
                tic.GiaKhuyenMai = Int32.Parse(price2);
            else
                tic.GiaKhuyenMai = 0;
           
            if (!String.IsNullOrEmpty(current_amount))
                tic.SoLuongTon = Int32.Parse(current_amount);
            else
                tic.SoLuongTon = 0;
            
            tic.MoTa = detail;
           
            if (form["chkClearImg"] != null)
            {
                tic.HinhAnh = "";
            }
            else if (fileUpload != null)
            {
                var fileName = Path.GetFileName(DateTime.Now.Millisecond + fileUpload.FileName);
                var path = Path.Combine(Server.MapPath(URLHelper.URL_IMAGE_PATH), fileName);
                if (!System.IO.File.Exists(path))
                {
                    fileUpload.SaveAs(path);
                }
                tic.HinhAnh = fileName;
            }
            if (err == false)
            {
                data.SanPhams.Add(tic);
                data.SaveChanges();
                return RedirectToAction("itemView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_ITEM_M, new Tuple<SanPham, List<LoaiSanPham>>(tic, getAllItemCategories()));
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult itemEdit(String id)
        {
            return View(URLHelper.URL_ADMIN_ITEM_M, new Tuple<SanPham, List<LoaiSanPham>>(getOneItem(Int32.Parse(id)), getAllItemCategories()));
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult itemEdit(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return itemCreate(form, fileUpload);
            }
            else
            {
                SanPham tic = getOneItem(Int32.Parse(id));
                var name = form["name"];
                var sort = form["sort"];
                var title = form["title"];
                var description = form["description"];
                var keyword = form["keyword"];
                var price = form["price"];
                var price2 = form["price2"];
                var online_payment = form["online_payment"];
                var detail = form["detail"];
               
                var sold_amount = form["soldamount"];
                var current_amount = form["currentamount"];

                bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên sản phẩm!\n";
                }
                if (form["parent"].ToString().Equals("0"))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng chọn danh mục!\n";
                }
                else
                {
                    tic.IdLoaiSanPham = Int32.Parse(form["parent"]);
                }
                tic.TenSanPham = name;
                tic.NgayCapNhat = DateTime.Now;
                if (!String.IsNullOrEmpty(price))
                    tic.DonGia = Int32.Parse(price);
                else
                    tic.DonGia = 0;
                if (!String.IsNullOrEmpty(price2))
                    tic.GiaKhuyenMai = Int32.Parse(price2);
                else
                    tic.GiaKhuyenMai = 0;
               
                if (!String.IsNullOrEmpty(current_amount))
                    tic.SoLuongTon = Int32.Parse(current_amount);
                else
                    tic.SoLuongTon = 0;

                tic.MoTa = detail;
               
                if (form["chkClearImg"] != null)
                {
                    tic.HinhAnh = "";
                }
                else if (fileUpload != null)
                {
                    var fileName = Path.GetFileName(DateTime.Now.Millisecond + fileUpload.FileName);
                    var path = Path.Combine(Server.MapPath(URLHelper.URL_IMAGE_PATH), fileName);
                    if (!System.IO.File.Exists(path))
                    {
                        fileUpload.SaveAs(path);
                    }
                    String imageOlder = URLHelper.URL_IMAGE_PATH + tic.HinhAnh;
                    if (System.IO.File.Exists(imageOlder))
                    {
                        System.IO.File.Delete(imageOlder);
                    }
                    tic.HinhAnh = fileName;
                }
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("itemView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_ITEM_M, new Tuple<SanPham, List<LoaiSanPham>>(tic, getAllItemCategories()));
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult itemDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.SanPhams.Remove(getOneItem(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return itemView(1);
        }
    }
}