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
    public class ItemCategoryController : BaseAdminController
    {
           // GET: ItemCategory
        private List<LoaiSanPham> getItemCategory(int count)
        {
            return getItemCategory(count, "");
        }
        private List<LoaiSanPham> getAllItemCategory()
        {
            return getItemCategory(-1, "");
        }
        private List<LoaiSanPham> getItemCategory(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.LoaiSanPhams.Where(a => a.TenLoai.Contains(keyword));
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.LoaiSanPhams;
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }
        private LoaiSanPham getOneItemCategory(int id)
        {
            var itemCategory = from ic in data.LoaiSanPhams
                               where ic.IdLoaiSanPham == id
                               select ic;
            if (itemCategory == null)
            {
                return new LoaiSanPham();
            }
            return itemCategory.Single();
        }
        
        public ActionResult ItemCategorySetStatusEnable(int id)
        {
            LoaiSanPham tic = getOneItemCategory(id);
           
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("itemCategoryView");
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return itemCategoryView(1);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult itemCategoryView(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listItemCategory = getItemCategory(10);
            return View(URLHelper.URL_ADMIN_ITEM_CATEGORY, listItemCategory.ToPagedList(pageNum,pageSize));
        }
        [HttpPost]
        public ActionResult itemCategoryView(FormCollection form, String btnDel)
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
                            data.LoaiSanPhams.Remove(getOneItemCategory(Int32.Parse(arrayStringCheckedList[i])));
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
            var listItemCategory = getItemCategory(10, keyword);
            return View(URLHelper.URL_ADMIN_ITEM_CATEGORY, listItemCategory);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult itemCategoryCreate()
        {
            return View(URLHelper.URL_ADMIN_ITEM_CATEGORY_M, new LoaiSanPham());
        }
        [HttpPost]
        public ActionResult itemCategoryCreate(FormCollection form, HttpPostedFileBase fileUpload)
        {
            LoaiSanPham tic = new LoaiSanPham();
            var name = form["name"];
            var info = form["info"];
            var bidanh = form["bidanh"]; 
            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
            }
            tic.TenLoai = name;
            tic.ThongTin = info;
            tic.BiDanh = bidanh;
            if (err == false)
            {
                data.LoaiSanPhams.Add(tic);
                data.SaveChanges();
                return RedirectToAction("itemCategoryView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_ITEM_CATEGORY_M, tic);
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult itemCategoryEdit(String id)
        {
            return View(URLHelper.URL_ADMIN_ITEM_CATEGORY_M, getOneItemCategory(Int32.Parse(id)));
        }
        [HttpPost]
        public ActionResult itemCategoryEdit(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return itemCategoryCreate(form, fileUpload);
            }
            else
            {
                LoaiSanPham tic = getOneItemCategory(Int32.Parse(id));
                var name = form["name"];
                var info = form["info"];
                var bidanh = form["bidanh"];
                bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
                }
                tic.TenLoai = name;
                tic.ThongTin = info;
                tic.BiDanh = bidanh;
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("itemCategoryView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_ITEM_CATEGORY_M, tic);
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult itemCategoryDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.LoaiSanPhams.Remove(getOneItemCategory(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return itemCategoryView(1);
        }
    }
}