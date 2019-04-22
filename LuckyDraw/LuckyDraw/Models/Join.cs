using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LuckyDraw.Models
{
    public class Join
    {
        public string qq;
        public string nickname;
        public Dictionary<DateTime, string> datetime_contain = new Dictionary<DateTime, string>();
        public string prize;
        public bool canPrize = false;
        public int score;
        public DateTime publish_time;
    }
}