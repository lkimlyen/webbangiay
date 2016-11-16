using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shop.Models;

namespace Shop.Controllers
{
    public abstract class BaseController : Controller
    {
        public QLShopOnlineEntities db = new QLShopOnlineEntities();
    }
}