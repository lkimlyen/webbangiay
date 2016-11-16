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
    public class MemberController : BaseAdminController
    {
        // GET: Member
        private List<KhachHang> getMember(int count)
        {
            return getMember(count, "");
        }
        private List<KhachHang> getAllMember()
        {
            return getMember(-1, "");
        }
        private List<KhachHang> getMember(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.KhachHangs.Where(a => a.Email.Contains(keyword)).OrderBy(a => a.IdKH);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.KhachHangs.OrderBy(a => a.IdKH);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }
        private KhachHang getOneMember(int id)
        {
            var Member = from ic in data.KhachHangs
                         where ic.IdKH == id
                         select ic;
            if (Member == null)
            {
                return new KhachHang();
            }
            return Member.Single();
        }
        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return MemberView(1);
        }
        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult MemberView(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listMember = getMember(10);
            return View(URLHelper.URL_ADMIN_MEMBER, listMember.ToPagedList(pageNum,pageSize));
        }
        [HttpPost]
        public ActionResult MemberView(FormCollection form, String btnDel)
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
                            data.KhachHangs.Add(getOneMember(Int32.Parse(arrayStringCheckedList[i])));
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
            var listMember = getMember(10, keyword);
            return View(URLHelper.URL_ADMIN_MEMBER, listMember);
        }


        [HttpGet]
        public ActionResult MemberDetailView(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Có lỗi xảy ra!";
            }
            else
            {
                return View(URLHelper.URL_ADMIN_MEMBER_DETAIL, getOneMember(Int32.Parse(id)));
            }
            return MemberView(1);
        }
        /*
      *
      *
      * 
      */
        [HttpPost, ValidateInput(false)]
        public ActionResult MemberDetailView(FormCollection form, HttpPostedFileBase fileUpload)
        {
            var id = form["id"];
            if (id == null)
            {
                return MemberView(form, null);
            }
            else
            {
                KhachHang tic = getOneMember(Int32.Parse(id));
                var name = form["name"];
                var email = form["email"];
                var address = form["address"];
                var phone = form["phone"];

                bool err = false;
                if (String.IsNullOrEmpty(email))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập email khách hàng!\n";
                }
                else
                    tic.Email = email;
                tic.TenKhachHang = name;
                tic.DiaChi = address;
                tic.DiaChi = phone;
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("MemberView");
                }
                else
                {
                    return View(URLHelper.URL_ADMIN_MEMBER_DETAIL, getOneMember(Int32.Parse(id)));
                }
            }
        }

        public ActionResult MemberDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.KhachHangs.Remove(getOneMember(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return MemberView(1);
        }
    }
}