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
    public class OrderController : BaseAdminController
    {
        // GET: Order
        public List<ChiTietDonDatHang> getListOrderDetailById(int id)
        {
            return data.ChiTietDonDatHangs.OrderByDescending(a => a.IdCTDDH).Where(n => n.IdDDH == id).ToList();
        }

        private List<DonDatHang> getOrder(int count)
        {
            return getOrder(count, null);
        }
        private List<DonDatHang> getAllOrder()
        {
            return getOrder(-1, null);
        }
        private DonDatHang getOneOrder(int id)
        {
            var item = from ic in data.DonDatHangs
                       where ic.IdDDH == id
                       select ic;
            if (item == null)
            {
                return new DonDatHang();
            }
            return item.Single();
        }
        private ChiTietDonDatHang getOneOrderDetail(int id)
        {
            var item = from ic in data.ChiTietDonDatHangs
                       where ic.IdCTDDH == id
                       select ic;
            if (item == null)
            {
                return new ChiTietDonDatHang();
            }
            return item.Single();
        }

        public ActionResult OrderSetStatusEnable(int id)
        {
            DonDatHang tic = getOneOrder(id);
            tic.DaHuy = !tic.DaHuy;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("OrderView");
        }
        public ActionResult OrderSetTinhTrangEnable(int id)
        {
            DonDatHang tic = getOneOrder(id);
            tic.TinhTrangGiaoHang = !tic.TinhTrangGiaoHang;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("OrderView");
        }
        public ActionResult OrderSetDaThanhToanEnable(int id)
        {
            DonDatHang tic = getOneOrder(id);
            tic.DaThanhToan = !tic.DaThanhToan;
            UpdateModel(tic);
            data.SaveChanges();
            return RedirectToAction("OrderView");
        }
       
        private List<DonDatHang> getOrder(int count, String keyword)
        {
            if (!String.IsNullOrEmpty(keyword))
            {
                var result = data.DonDatHangs.Where(a => a.NguoiNhan.Contains(keyword)).OrderByDescending(a => a.NgayDat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
            else
            {
                var result = data.DonDatHangs.OrderByDescending(a => a.NgayDat);
                if (count != -1)
                    result.Take(count);
                return result.ToList();
            }
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult Index()
        {
            return OrderView(1);
        }

        [HttpGet]
        public ActionResult OrderDetail(int id)
        {
            var listOrderDetail = getListOrderDetailById(id);
            List<DataHelper.ShoppingCardItemModel> listShoppingCardModels = DataHelper.ShoppingCardHelper.getInstance().getListShoppingCardItemModelFromListOrderDetails(data, listOrderDetail);
            long totalPrice = 0;
            foreach(DataHelper.ShoppingCardItemModel model in listShoppingCardModels)
            {
                totalPrice += (long)model.total;
            }
            DonDatHang tic = getOneOrder(id);
            ViewBag.id = tic.IdDDH;
            ViewBag.name = tic.NguoiNhan;
            ViewBag.phone = tic.SdtNguoiNhan;
            ViewBag.address = tic.DiaChiNguoiNhan;
         
            ViewBag.TotalPrice = totalPrice;
            return View(URLHelper.URL_ADMIN_ORDER_DETAIL, listShoppingCardModels);
        }
        
      [HttpPost, ValidateInput(false)]
        public ActionResult OrderDetail(FormCollection form)
        {
            var id = form["id"];
            if (id == null)
            {
                ViewData["Error"] += "Có lỗi xảy ra";
                return RedirectToAction("Index");
            }
            else
            {
                DonDatHang tic = getOneOrder(Int32.Parse(id));
                var name = form["TenNguoiNhan"];
                var phone = form["soDT"];
                var address = form["DiaChi"];
             bool err = false;
                if (String.IsNullOrEmpty(name))
                {
                    err = true;
                    ViewData["Error"] += "Vui lòng nhập tên người nhận hàng!\n";
                }
                tic.NguoiNhan = name;
                tic.SdtNguoiNhan = phone;
                tic.DiaChiNguoiNhan = address;
                
                if (err == false)
                {
                    UpdateModel(tic);
                    data.SaveChanges();
                    return RedirectToAction("OrderView");
                }
                else
                {
                    ViewBag.id = id;
                    ViewBag.name = tic.NguoiNhan;
                    ViewBag.phone = tic.SdtNguoiNhan;
                    ViewBag.address = tic.DiaChiNguoiNhan;
                   
                    var listOrderDetail = getListOrderDetailById(Int32.Parse(id));
                    List<DataHelper.ShoppingCardItemModel> listShoppingCardModels = DataHelper.ShoppingCardHelper.getInstance().getListShoppingCardItemModelFromListOrderDetails(data, listOrderDetail);
                    long totalPrice = 0;
                    foreach (DataHelper.ShoppingCardItemModel model in listShoppingCardModels)
                    {
                        totalPrice += (long)model.total;
                    }
                    ViewBag.TotalPrice = totalPrice;
                    return View(URLHelper.URL_ADMIN_ORDER_DETAIL, listShoppingCardModels);

                }
            }
        }

        /*
         * 
         * 
         * 
         */
        [HttpGet]
        public ActionResult OrderView(int ? page)
        {
            int pageNum = (page ?? 1);
            int pageSize = 20;
            var listOrder = getOrder(10);
            return View(URLHelper.URL_ADMIN_ORDER, listOrder.ToPagedList(pageNum, pageSize));
        }
        [HttpPost]
        public ActionResult OrderView(FormCollection form, String btnDel)
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
                            data.DonDatHangs.Remove(getOneOrder(Int32.Parse(arrayStringCheckedList[i])));
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
            var listOrder = getOrder(10, keyword);
            return View(URLHelper.URL_ADMIN_ORDER, listOrder);
        }

        /*
         * 
         * 
         * 
         */
        public ActionResult OrderDelete(String id)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.DonDatHangs.Remove(getOneOrder(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return OrderView(1);
        }

        public ActionResult OrderDetailDelete(String id, int idorder)
        {
            if (String.IsNullOrEmpty(id))
            {
                ViewBag.AlertError = "Không xoá được!";
            }
            else
            {
                try
                {
                    data.ChiTietDonDatHangs.Remove(getOneOrderDetail(Int32.Parse(id)));
                    data.SaveChanges();
                    ViewBag.AlertSuccess = "Xoá thành công!";
                }
                catch (Exception e)
                {
                    ViewBag.AlertError = "Không xoá được";
                }
            }
            return OrderDetail(idorder);
        }
    }
}