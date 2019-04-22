using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LuckyDraw.Models
{
    public class Message
    {
        public string id { get; set; }
        public string qq { get; set; }
        public string nickname { get; set; }
        public string contain { get; set; }
        public string publish_time { get; set; }
    }

    public class Person
    {
        public string qq { get; set; }
        public string nickname { get; set; }
        public string prize { get; set; }
        public int speakNum { get; set; }
    }

    public class Award
    {
        public string title;
        public List<Join> awardList = new List<Join>();
    }

}