using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace LuckyDraw.Models
{
    public class MessageHandler
    {
        public static string ReadMessage(HttpPostedFileBase file,string filePath)
        {
            if (file != null)
            {
                //得到的名字是文件在本地机器的绝对路径
                var strLocalFullPathName = file.FileName;
                //提取出单独的文件名，不需要路径
                var strFileName = Path.GetFileName(strLocalFullPathName);
                var ext = strFileName.Substring(strFileName.LastIndexOf('.') + 1);
                if (!ext.Equals("txt"))  //只允许上传txt
                    return "failed";
                if (!Directory.Exists(filePath))
                {
                    Directory.CreateDirectory(filePath);
                }
                if(File.Exists(Path.Combine(filePath, strFileName))){
                    return "exists";
                }
                SQLManager sl = new SQLManager();
                //将接收到文件保存在服务器指定上当
                file.SaveAs(Path.Combine(filePath, strFileName));

                StreamReader reader = new StreamReader(Path.Combine(filePath, strFileName));
                string line;
                line = reader.ReadLine();
                while (true)
                {
                    if (line == null)
                        break;
                    if (isTitle(line))
                    {
                        string[] arr = line.Split(' ');
                        string datetime = arr[0] + " " + arr[1] + ".000";
                        string[] arr2 = arr[2].Split('(');
                        string qq;
                        if (arr2.Length > 1)
                            qq = arr2[1].Split(')')[0];
                        else
                        {
                            arr2 = arr[2].Split('<');
                            qq= arr2[1].Split('>')[0];
                        }
                            
                        string nickname = arr2[0];
                        string contain = "";
                        while ((line = reader.ReadLine())!=null&&!isTitle(line))
                        {
                            contain += line;
                        }
                        
                        sl.Insert("message", "qq", "nickname", "publish_time", "contain",qq ,nickname , datetime, contain);
                    }
                }

                return "success";
            }
            return "failed";
        }

        public static bool isTitle(string line)
        {
            string[] arr = line.Split(' ');
            if (arr.Length == 3 && Regex.IsMatch(arr[0], "((?!0000)[0-9]{4}-((0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-8])|(0[13-9]|1[0-2])-(29|30)|(0[13578]|1[02])-31)|([0-9]{2}(0[48]|[2468][048]|[13579][26])|(0[48]|[2468][048]|[13579][26])00)-02-29)") && Regex.IsMatch(arr[1], "(0[1-9]|1[0-9]|2[0-3]):(0[0-9]|[1-5][0-9]|60):(0[0-9]|[1-5][0-9]|60)"))
                return true;
            return false;
        }
    }
}