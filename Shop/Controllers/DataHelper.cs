using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Shop.Controllers
{
    public class DataHelper
    {
        //Model class
        public class ShoppingCardItemModel
        {
            public String name, image;
            public int id, quantity, orderid, modelid;
            public decimal price, total;
        }

        //Helper classes
        public class GeneralHelper
        {
            static GeneralHelper instance;
            public static GeneralHelper getInstance()
            {
                if (instance == null)
                {
                    instance = new GeneralHelper();
                }
                return instance;
            }

            public void saveCSSFile(string text)
            {
                System.IO.File.WriteAllText(HttpContext.Current.Server.MapPath("~/Content/standalone.4e1f1fad754ebc0bdb148ced149d7f731458555519.css"), text);
            }

            public string readCSSFile()
            {
                return System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/Content/standalone.4e1f1fad754ebc0bdb148ced149d7f731458555519.css"));
            }
        }

        public class NewsHelper
        {
            static NewsHelper instance;
            public static NewsHelper getInstance()
            {
                if (instance == null)
                {
                    instance = new NewsHelper();
                }
                return instance;
            }

            public void deleteAllNews(Models.QLShopOnlineEntities data)
            {
                data.TinTucs.RemoveRange(data.TinTucs);
                data.SaveChanges();

            }
            public int getNewsAmount(Models.QLShopOnlineEntities data)
            {
                return data.TinTucs.Count();
            }

            public Models.TinTuc getNewsById(Models.QLShopOnlineEntities data, int id)
            {
                Models.TinTuc result = data.TinTucs.Where(n => n.IdTinTuc == id).Single();
                return result;
            }
        }

        public class ProductHelper
        {
            static ProductHelper instance;
            public static ProductHelper getInstance()
            {
                if (instance == null)
                {
                    instance = new ProductHelper();
                }
                return instance;
            }

            public void deleteAllProductCategory(Models.QLShopOnlineEntities data)
            {
                deleteAllProduct(data);

                data.LoaiSanPhams.RemoveRange(data.LoaiSanPhams);
                data.SaveChanges();
            }

            public void deleteAllProduct(Models.QLShopOnlineEntities data)
            {
                //ShoppingCardHelper.getInstance().deleteAllChiTietDonDatHangs(data);

                data.SanPhams.RemoveRange(data.SanPhams);
                data.SaveChanges();
            }

            public int getProductsAmount(Models.QLShopOnlineEntities data)
            {
                return data.SanPhams.Count();
            }

            public int getProductCategoryAmount(Models.QLShopOnlineEntities data)
            {
                return data.LoaiSanPhams.Count();
            }


            public Models.SanPham getProductById(Models.QLShopOnlineEntities data, int id)
            {
                Models.SanPham result = data.SanPhams.Where(n => n.IdSanPham == id).Single();
                return result;
            }

            public Models.LoaiSanPham getProductCategoryById(Models.QLShopOnlineEntities data, int id)
            {
                Models.LoaiSanPham result = data.LoaiSanPhams.Where(n => n.IdLoaiSanPham == id).Single();
                return result;
            }

            public List<Models.SanPham> getListAllProducts(Models.QLShopOnlineEntities data)
            {
                return data.SanPhams.OrderByDescending(a => a.NgayCapNhat).ToList();
            }

            public List<Models.SanPham> getListProductsByCategory(Models.QLShopOnlineEntities data, int idProductType)
            {
                return data.SanPhams.OrderByDescending(a => a.NgayCapNhat).Where(n => n.IdLoaiSanPham == idProductType).ToList();
            }

            public List<Models.SanPham> getListOtherProductsByCategory(Models.QLShopOnlineEntities data, int id, int idProductType)
            {
                return data.SanPhams.OrderByDescending(a => a.NgayCapNhat).Where(n => n.IdLoaiSanPham == idProductType && n.IdSanPham != id).ToList();
            }
        }

        public class AccountHelper
        {
            static AccountHelper instance;
            public static AccountHelper getInstance()
            {
                if (instance == null)
                {
                    instance = new AccountHelper();
                }
                return instance;
            }

            public Models.KhachHang getMemberAccountByEmail(Models.QLShopOnlineEntities data, string email)
            {
                Models.KhachHang result = data.KhachHangs.Where(n => n.Email.Equals(email)).Single();
                return result;
            }

            public string getLoggingInMemberEmail(HttpContextBase context)
            {
                Object session = context.Session[Constants.KEY_SESSION_MEMBER_USERNAME];
                if (session != null && !String.IsNullOrEmpty(session.ToString()))
                {
                    return session.ToString();
                }
                return "";
            }

            public bool loginAdmin(Models.QLShopOnlineEntities data, string username, string password)
            {
                return checkThisAdminAccountExist(data, username, password);
            }

            public int getMemberAccountAmount(Models.QLShopOnlineEntities data)
            {
                return data.KhachHangs.Count();
            }

            public bool checkThisAdminAccountExist(Models.QLShopOnlineEntities data, string username, string password)
            {
                var result = data.ThanhViens.Where(a => a.TaiKhoan.Equals(username) && a.MatKhau == password);
                if (result.Count() > 0)
                {
                    return true;
                }
                return false;
            }

            public bool checkIsAdminLoggingIn(HttpContextBase context)
            {
                Object session = context.Session[Constants.KEY_SESSION_ADMIN_USERNAME];
                if (session != null && !String.IsNullOrEmpty(session.ToString()))
                {
                    return true;
                }
                return false;
            }

            public void logoutAdmin(BaseAdminController context)
            {
                context.Session[Constants.KEY_SESSION_ADMIN_USERNAME] = null;
            }

            public void deleteAllKhachHangs(Models.QLShopOnlineEntities data)
            {
                data.KhachHangs.RemoveRange(data.KhachHangs);
                data.SaveChanges();
            }
            
            public void deleteAllAdmins(Models.QLShopOnlineEntities data)
            {
                data.ThanhViens.RemoveRange(data.ThanhViens);
                data.SaveChanges();
            }
        }

        public class ShoppingCardHelper
        {
            static ShoppingCardHelper instance;
            public static ShoppingCardHelper getInstance()
            {
                if (instance == null)
                {
                    instance = new ShoppingCardHelper();
                }
                return instance;
            }

            public void clearShoppingCard(BaseController context)
            {
                context.Session[Constants.KEY_SESSION_SHOPPING_CARD] = new List<Models.ChiTietDonDatHang>();
            }

            public void DeleteItemsFromShoppingCard(BaseController context, int itemId)
            {
                List<Models.ChiTietDonDatHang> shoppingCard = getShoppingCardInSession(context);
                foreach (Models.ChiTietDonDatHang record in shoppingCard.ToList())
                {
                    if (record.IdDDH == itemId)
                    {
                        shoppingCard.Remove(record);
                    }
                }
            }

            public void deleteAllChiTietDonDatHangs(Models.QLShopOnlineEntities data)
            {
                data.ChiTietDonDatHangs.RemoveRange(data.ChiTietDonDatHangs);
                data.SaveChanges();
            }

            public void deleteAllOrders(Models.QLShopOnlineEntities data)
            {
                deleteAllChiTietDonDatHangs(data);

                data.DonDatHangs.RemoveRange(data.DonDatHangs);
                data.SaveChanges();

            }
            public int getOrderAmount(Models.QLShopOnlineEntities data)
            {
                return data.DonDatHangs.Count();
            }

            public int getPaidOrderAmount(Models.QLShopOnlineEntities data)
            {
                List<Models.DonDatHang> listOrder = data.DonDatHangs.ToList();
                int amount = 0;
                foreach (Models.DonDatHang order in listOrder)
                {
                    if (order.DaThanhToan.HasValue && order.DaThanhToan.Value && order.DaHuy.HasValue && order.DaHuy.Value && order.TinhTrangGiaoHang.HasValue && order.TinhTrangGiaoHang.Value)
                    {
                        amount++;
                    }
                }
                return amount;
            }

            public void saveOrder(BaseController context,
                string emailReceiver, string nameReceiver, string phoneReceiver, string addressReceiver,
                string note, string curency)
            {
                //Get member account by session email
                string emailSender = AccountHelper.getInstance().getLoggingInMemberEmail(context.HttpContext);
                Models.KhachHang member = AccountHelper.getInstance().getMemberAccountByEmail(context.db, emailSender);

                //Get shoppingCard in Sesion
                List<Models.ChiTietDonDatHang> listShoppingCard = getShoppingCardInSession(context);
                long totalPrice = 0;
                foreach (Models.ChiTietDonDatHang record in listShoppingCard.ToList())
                {
                    totalPrice += record.SoLuong.Value;
                }

                //Save order
                Models.DonDatHang order = new Models.DonDatHang();
                order.IdKH = member.IdKH;
                order.NgayDat = DateTime.Now;
                
                order.NguoiNhan = emailReceiver;
                order.SdtNguoiNhan = phoneReceiver;
                order.DiaChiNguoiNhan = addressReceiver;
                
                order.TongTien = totalPrice;
                order.DaHuy = false;
                order.DaThanhToan = false;
                order.TinhTrangGiaoHang = false;
                context.db.DonDatHangs.Add(order);
                context.db.SaveChanges(); //Submit change here to get the id of inserted record.

                //Save order_details
                foreach (Models.ChiTietDonDatHang record in listShoppingCard.ToList())
                {
                    record.IdDDH = order.IdDDH;
                    context.db.ChiTietDonDatHangs.Add(record);
                }
                context.db.SaveChanges();
            }

            public void updateShoppingCard(BaseController context, List<Models.ChiTietDonDatHang> shoppingCard)
            {
                context.Session[Constants.KEY_SESSION_SHOPPING_CARD] = shoppingCard;
            }

            public void addItemsToShoppingCard(BaseController context, int itemId, long price, int amount)
            {
                List<Models.ChiTietDonDatHang> shoppingCard = getShoppingCardInSession(context);
                bool doesItemToAddExistInShoppingCard = false;
                foreach (Models.ChiTietDonDatHang record in shoppingCard)
                {
                    if (record.IdSanPham == itemId)
                    {
                        record.SoLuong = record.SoLuong + amount;
                        doesItemToAddExistInShoppingCard = true;
                    }
                }
                if (!doesItemToAddExistInShoppingCard)
                {
                    Models.ChiTietDonDatHang recordInShoppingCard = new Models.ChiTietDonDatHang();
                    recordInShoppingCard.IdSanPham = itemId;
                    recordInShoppingCard.DonGia = price;
                    recordInShoppingCard.SoLuong = amount;
                    shoppingCard.Add(recordInShoppingCard);
                }
            }

            public List<Models.ChiTietDonDatHang> getShoppingCardInSession(BaseController context)
            {
                return getShoppingCardInSessionByHttpContext(context.HttpContext);
            }

            public List<ShoppingCardItemModel> getListShoppingCardItemModelFromListOrderDetails(Models.QLShopOnlineEntities data, List<Models.ChiTietDonDatHang> listChiTietDonDatHangs)
            {
                List<ShoppingCardItemModel> result = new List<ShoppingCardItemModel>();
                foreach (var ChiTietDonDatHang in listChiTietDonDatHangs)
                {
                    Models.SanPham item = ProductHelper.getInstance().getProductById(data, ChiTietDonDatHang.IdSanPham.Value);
                    ShoppingCardItemModel model = new ShoppingCardItemModel();
                    model.id = ChiTietDonDatHang.IdSanPham.Value;
                    model.name = item.TenSanPham;
                    model.image = item.HinhAnh;
                    model.quantity = ChiTietDonDatHang.SoLuong.Value;
                    model.price = item.DonGia.Value;
                    model.total = model.price * model.quantity;
                    model.orderid = ChiTietDonDatHang.IdDDH.HasValue ? ChiTietDonDatHang.IdDDH.Value : 0;
                    model.modelid = ChiTietDonDatHang.IdCTDDH;
                    result.Add(model);
                }

                return result;
            }

            public List<ShoppingCardItemModel> getShoppingCardItemModelsInSession(BaseController context)
            {
                List<Models.ChiTietDonDatHang> listChiTietDonDatHangs = getShoppingCardInSessionByHttpContext(context.HttpContext);
                return getListShoppingCardItemModelFromListOrderDetails(context.db, listChiTietDonDatHangs);
            }

            public List<Models.ChiTietDonDatHang> getShoppingCardInSessionByHttpContext(HttpContextBase context)
            {
                List<Models.ChiTietDonDatHang> shoppingCard;
                Object objShoppingCard = context.Session[Constants.KEY_SESSION_SHOPPING_CARD];
                if (objShoppingCard != null)
                {
                    shoppingCard = (List<Models.ChiTietDonDatHang>)objShoppingCard;
                }
                else
                {
                    shoppingCard = new List<Models.ChiTietDonDatHang>();
                    context.Session[Constants.KEY_SESSION_SHOPPING_CARD] = shoppingCard;
                }

                return shoppingCard;
            }

            public int getItemsAmountInShoppingCard(HttpContextBase context)
            {
                int result = 0;
                List<Models.ChiTietDonDatHang> shoppingCard = getShoppingCardInSessionByHttpContext(context);
                foreach (Models.ChiTietDonDatHang record in shoppingCard)
                {
                    if (record.SoLuong.HasValue)
                    {
                        result += record.SoLuong.Value;
                    }
                }

                return result;
            }
        }
    }
}