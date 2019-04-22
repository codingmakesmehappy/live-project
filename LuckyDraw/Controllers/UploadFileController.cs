using LuckyDraw.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
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

        [HttpGet]
        public void getPoster()
        {
            System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath("~/images/海报.jpg"));
            Bitmap bitmap = new Bitmap(image, image.Width, image.Height);
            Graphics g = Graphics.FromImage(bitmap);
            float fontSize = 80.0f;             //字体大小
            //float textWidth = text.Length * fontSize;  //文本的长度
            //下面定义一个矩形区域，以后在这个矩形里画上白底黑字
            float rectX = 500;
            float rectY = 1200;
            float rectWidth = 3000;  // text.Length * (fontSize + 40);
            float rectHeight = 150;
            //声明矩形域
            //RectangleF textArea = new RectangleF(rectX, rectY, rectWidth, rectHeight);


           
            Font font = new Font("华文隶书", fontSize, FontStyle.Bold);   //定义字体
            //Font font2 = new Font("楷体", fontSize, FontStyle.Bold);   //定义字体
            //font.Bold = true;

            Brush whiteBrush = new SolidBrush(Color.DodgerBlue);   //白笔刷，画文字用
            //Brush blackBrush = new SolidBrush(Color.Black);   //黑笔刷，画背景用

            //g.FillRectangle(blackBrush, rectX, rectY, rectWidth, rectHeight);
            string text = string.Format("{0,-30}", "qq") + string.Format("{0,-30}", "昵称") + string.Format("{0,-30}", "奖品");
            g.DrawString(text, font, whiteBrush, new RectangleF(rectX,rectY,rectWidth,rectHeight), StringFormat.GenericDefault);
            rectY += rectHeight;
            List<Person> list = Option.getAwardInfo();
            foreach (Person person in list)
            {
                text = string.Format("{0,-30}", person.qq) + string.Format("{0,-30}", person.nickname) + string.Format("{0,-30}", person.prize);
                g.DrawString(text, font, whiteBrush, new RectangleF(rectX, rectY, rectWidth, rectHeight), StringFormat.GenericDefault);
                rectY += rectHeight;
            }
            

            //g.DrawString(text, font, whiteBrush, new RectangleF(rectX, image.Height/2, 270, 270));

            //g.DrawString("168元", font2, new SolidBrush(Color.Firebrick), new RectangleF(rectX, image.Height - 150, rectWidth, rectHeight));

            ////-------------------  绘制高质量 -------------------------------------------
            //设置 System.Drawing.Graphics对象的SmoothingMode属性为HighQuality 
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //下面这个也设成高质量 
            g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
            //下面这个设成High 
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;

            /*
            //画专属推广二维码
            System.Drawing.Image qrCodeImage = System.Drawing.Image.FromFile(Server.MapPath(@"/Content/images/money-cards.png"));
            g.DrawImage(qrCodeImage, new Rectangle(image.Width - qrCodeImage.Width - 200,
            image.Height - qrCodeImage.Height - 200,
            qrCodeImage.Width,
            qrCodeImage.Height),
            0, 0, qrCodeImage.Width, qrCodeImage.Height, GraphicsUnit.Pixel);
            //画微信昵称
            g.DrawString("小马快跑", font, new SolidBrush(Color.Red), new Rectangle(image.Width - qrCodeImage.Width - 200,
            image.Height - qrCodeImage.Height - 300,
            qrCodeImage.Width + 100,
            50));
            */
            MemoryStream ms = new MemoryStream();

            /*
            //输出方法一：将文件生成并保存到C盘
            string path = "D:\\test\\" + picname + ".png";
            bitmap.Save(path, System.Drawing.Imaging.ImageFormat.Jpeg);
            */

            //输出方法二，显示在网页中，保存为Jpg类型
            bitmap.Save(ms, ImageFormat.Jpeg);
            Response.Clear();
            Response.ContentType = "image/jpeg";
            Response.BinaryWrite(ms.ToArray());

            g.Dispose();
            bitmap.Dispose();
            image.Dispose();
        }
    }
}