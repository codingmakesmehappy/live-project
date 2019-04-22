using LuckyDraw.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LuckyDraw.Controllers
{
    public class OptionController : Controller
    {
        // GET: Option
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult luckyDraw(string filter,string key,DateTime start,DateTime end,DateTime open,string prize,int count)
        {
            return Json(new { status = Option.LuckyDraw(filter, key, start, end, open, prize, count) }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult getAwardInfo()
        {
            List<Person> list = Option.getAwardInfo();
            return Json(new { status=list==null?"failed":"success",list=list},JsonRequestBehavior.AllowGet);
        }
    }
}