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
    public class NewsController : BaseAdminController
    {
        // GET: News
        private List<TinTuc> getNews(int count)
        {
            return getNews(count, "");
        }
        private List<TinTuc> getAllNews()
        {
            return getNews(-1, "");
        }
        private List<TinTuc> getNews(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.TinTucs.Where(a => a.TieuDe.Contains(keyword)).OrderByDescending(a => a.NgayDang);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.TinTucs.OrderByDescending(a => a.NgayDang);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }

        public ActionResult NewsSetMoiEnable(int id)
        {
            TinTuc tic = getOneNews(id);
            tic.Moi = !tic.Moi;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("newsView");
        }
        public ActionResult NewsSetNoiBatEnable(int id)
        {
            TinTuc tic = getOneNews(id);
            tic.NoiBat = !tic.NoiBat;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("newsView");
        }

        private TinTuc getOneNews(int id)
        {
            var news = from ic in data.TinTucs
                       where ic.IdTinTuc == id
                       select ic;
            if (news == null)
            {
                return new TinTuc();
            }
            return news.Single();
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return newsView(1);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult newsView(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listNews = getNews(10);
            return View(URLHelper.URL_ADMIN_NEWS, listNews.ToPagedList(pageNum,pageSize));
        }
        [HttpPost]
        public ActionResult newsView(FormCollection form, String btnDel)
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
                            data.TinTucs.Remove(getOneNews(Int32.Parse(arrayStringCheckedList[i])));
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
            var listNews = getNews(10, keyword);
            return View(URLHelper.URL_ADMIN_NEWS, listNews);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult newsCreate()
        {
            return View(URLHelper.URL_ADMIN_NEWS_M, new TinTuc());
        }
        [HttpPost, ValidateInput(false)]
        public ActionResult newsCreate(FormCollection form, HttpPostedFileBase fileUpload)
        {
            TinTuc tic = new TinTuc();
            var name = form["name"];
            var detail = form["detail"];
          
            bool err = false;
            if (String.IsNullOrEmpty(name))
            {
                err = true;
                ViewData["Error"] += "Vui lòng nhập tên tin tức!\n";
            }
            tic.TieuDe = name;
            tic.Moi = false;
            tic.NoiBat = false;
            tic.NgayDang = DateTime.Now;
            tic.NoiDung = detail;
          
            if (form["chkClearImg"] != null)
            {
                tic.HinhAnhDaiDien = "";
            }
            else if (fileUpload != null)
            {
                var fileName = Path.GetFileName(DateTime.Now.Millisecond + fileUpload.FileName);
                var path = Path.Combine(Server.MapPath(URLHelper.URL_IMAGE_PATH), fileName);
                if (!System.IO.File.Exists(path))
                {
                    fileUpload.SaveAs(path);
                }
                tic.HinhAnhDaiDien = fileName;
            }
            if (err == false)
            {
                data.TinTucs.Add(tic);
                data.SaveChanges();
                return RedirectToAction("newsView");
            }
            else
            {
                return View(URLHelper.URL_ADMIN_NEWS_M, tic);
            }
        }
        /*
         *
         *
         * 
         */
        [HttpGet]
        public ActionResult newsEdit(String id)
        {
            return View(URLHelper.URL_ADMIN_NEWS_M, getOneNews(Int32.Parse(id)));
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult newsEdit(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return newsCreate(form, fileUpload);
            }
            else
            {
                TinTuc tic = getOneNews(Int32.Parse(id));
                var name = form["name"];
                var detail = form["detail"];
              
                bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên danh mục!\n";
                }
                tic.TieuDe = name;
                tic.NgayDang = DateTime.Now;
                tic.NoiDung = detail;
               
                if (form["chkClearImg"] != null)
                {
                    tic.HinhAnhDaiDien = "";
                }
                else if (fileUpload != null)
                {
                    var fileName = Path.GetFileName(DateTime.Now.Millisecond + fileUpload.FileName);
                    var path = Path.Combine(Server.MapPath(URLHelper.URL_IMAGE_PATH), fileName);
                    if (!System.IO.File.Exists(path))
                    {
                        fileUpload.SaveAs(path);
                    }
                    String imageOlder = URLHelper.URL_IMAGE_PATH + tic.HinhAnhDaiDien;
                    if (System.IO.File.Exists(imageOlder))
                    {
                        System.IO.File.Delete(imageOlder);
                    }
                    tic.HinhAnhDaiDien = fileName;
                }
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("newsView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_NEWS_M, tic);
                }
            }
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult newsDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.TinTucs.Remove(getOneNews(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return newsView(1);
        }
    }
}