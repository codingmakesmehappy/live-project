using LuckyDraw.Models;
using System;
using System.Collections.Generic;
using System.IO;
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
        public ActionResult upload(HttpPostedFileBase file,string choice)
        {
            return Json(new { status = MessageHandler.ReadMessage(file, Server.MapPath("~/App_Data/"),choice) });
        }

        public ActionResult upload()
        {
            return View();
        }

        [HttpGet]
        public FileResult getFile()
        {
            List<Person> list = Option.getAwardInfo();

            //创建Excel文件的对象
            NPOI.HSSF.UserModel.HSSFWorkbook book = new NPOI.HSSF.UserModel.HSSFWorkbook();
            //添加一个sheet
            NPOI.SS.UserModel.ISheet sheet1 = book.CreateSheet("Sheet1");

            //给sheet1添加第一行的头部标题
            NPOI.SS.UserModel.IRow row1 = sheet1.CreateRow(0);
            row1.CreateCell(0).SetCellValue("qq");
            row1.CreateCell(1).SetCellValue("昵称");
            row1.CreateCell(2).SetCellValue("奖品");
            row1.CreateCell(3).SetCellValue("有效发言次数");
            //将数据逐步写入sheet1各个行
            for (int i = 0; i < list.Count; i++)
            {
                NPOI.SS.UserModel.IRow rowtemp = sheet1.CreateRow(i + 1);
                rowtemp.CreateCell(0).SetCellValue(list[i].qq);
                rowtemp.CreateCell(1).SetCellValue(list[i].nickname);
                rowtemp.CreateCell(2).SetCellValue(list[i].prize);
                rowtemp.CreateCell(3).SetCellValue(list[i].speakNum);
            }
            // 写入到客户端 
            System.IO.MemoryStream ms = new System.IO.MemoryStream();
            book.Write(ms);
            ms.Seek(0, SeekOrigin.Begin);
            return File(ms, "application/vnd.ms-excel", "获奖表.xls");
        }
    }
}