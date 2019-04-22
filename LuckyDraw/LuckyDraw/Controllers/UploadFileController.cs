﻿using LuckyDraw.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LuckyDraw.Controllers
{
    public class UploadFileController : Controller
    {
        // GET: UploadFile
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult upload(HttpPostedFileBase file)
        {
            return Json(new { status = MessageHandler.ReadMessage(file, Server.MapPath("~/App_Data/")) });
        }

        public ActionResult upload()
        {
            return View();
        }
    }
}