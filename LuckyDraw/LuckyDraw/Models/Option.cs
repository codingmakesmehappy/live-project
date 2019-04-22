using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace LuckyDraw.Models
{
    public static class Option
    { 
        public enum Filter
        {
            none, normal, deep
        }
        private static Filter filter=Filter.none;
        private static Award award;
        private static int count=1;
        private static double statNumRate = 0.3;
        private static double statTimeRate = 1-statNumRate;
        private static string canPrizeStr = "#我要换组#、#我要红包#、#我爱软工实践#";
        private static string prize = "肥皂一块";
        private static DateTime start = DateTime.Parse("2022-08-20 00:00:00");
        private static DateTime end = DateTime.Parse("2023-01-01 00:00:00");
        private static DateTime open = DateTime.Parse("2023-01-01 12:00:00");

        public static void setFilter(string f)
        {
            if (f.Equals("deep"))
            {
                filter = Filter.deep;
            }
            else if (f.Equals("normal"))
            {
                filter = Filter.normal;
            }
            else if(f.Equals("none")){
                filter = Filter.none;
            }
        }

        public static void setKeyWord(string key)
        {
            canPrizeStr = key;
        }

        public static void setCount(int cnt)
        {
            count = cnt;
        }

        public static void setStart(DateTime t)
        {
            start = t;
        }

        public static void setEnd(DateTime t)
        {
            end = t;
        }

        public static void setOpen(DateTime t)
        {
            open = t;
        }

        public static void setPrize(string str)
        {
            prize = str;
        }

        /// <summary>
        /// 过滤器
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        public static bool islegal(Message message)
        {
            if (filter == Filter.none)
            {
                if(!(message.nickname.Trim().Equals("系统消息")))
                    return true;
                return false;
            }else if (filter == Filter.normal)
            {
                if (message.nickname.Trim().Equals("助教") || message.nickname.Trim().Equals("教师") || message.contain.Trim().Equals(""))
                    return false;
                return true;
            }
            else
            {
                return false;
            }
            
        }

        /// <summary>
        /// 加权随机抽一个
        /// </summary>
        /// <param name="joins"></param>
        /// <returns></returns>
        public static Join weightedRandom(ref List<Join> joins)
        {
            int sum = 0;
            foreach(Join join in joins)
            {
                sum += join.score;
            }
            int random = new Random().Next(sum);
            foreach(Join join in joins)
            {
                random -= join.score;
                if (random < 0)
                {
                    join.prize = prize;
                    joins.Remove(join);
                    return join;
                }
                    
            }
            return null;
        }

        /// <summary>
        /// 抽取所有人
        /// </summary>
        /// <param name="dic"></param>
        /// <returns></returns>
        public static Award randomPrize(Dictionary<string,Join> dic)
        {
            List<Join> joins = new List<Join>();
            Award award = new Award();
            award.title = canPrizeStr;
            foreach(Join join in dic.Values.ToList<Join>())
            {
                if (join.canPrize&&filter==Filter.none)//有效参与者,不过滤
                {
                    TimeSpan ts = DateTime.Parse("2030-1-1") - join.publish_time;
                    join.score = (int)sigmoid(statNumRate * join.datetime_contain.Count + statTimeRate * ts.TotalMilliseconds)*10;
                    joins.Add(join);
                }
                else if(join.canPrize && filter == Filter.normal && join.datetime_contain.Count > 1)//有效参与者,普通过滤
                {
                    TimeSpan ts = DateTime.Parse("2030-1-1") - join.publish_time;
                    join.score = (int)sigmoid(statNumRate * join.datetime_contain.Count + statTimeRate * ts.TotalMilliseconds) * 10;
                    joins.Add(join);
                }
                else if(join.canPrize && filter == Filter.deep && join.datetime_contain.Count > 1)//有效参与者,深度过滤
                {

                }
            }
            int prizeNum = count;
            for (int i = 0; i < prizeNum; ++i)//开始抽取
            {
                award.awardList.Add(weightedRandom(ref joins));
            }
            return award;
        }

        /// <summary>
        /// 将分数占比映射成0-1
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static double sigmoid(double val)
        {
            return 1.0 / (1 + Math.Exp(-val));
        }

        public static string LuckyDraw(string filter, string key, DateTime start, DateTime end, DateTime open, string prize, int count)
        {
            setFilter(filter);
            setKeyWord(key);
            setStart(start);
            setEnd(end);
            setOpen(open);
            setPrize(prize);
            setCount(count);
            SQLManager sl = new SQLManager();
            DataTable dt = sl.UniversalGetAPI("select *from message");
            Dictionary<string, Join> dictionary = new Dictionary<string, Join>();//存储潜在有效参与抽奖者
            //过滤处理
            for (int i = 0; dt != null && i < dt.Rows.Count; ++i)
            {
                Message message = new Message
                {
                    id = dt.Rows[i]["id"].ToString(),
                    qq = dt.Rows[i]["qq"].ToString(),
                    nickname = dt.Rows[i]["nickname"].ToString(),
                    publish_time = dt.Rows[i]["publish_time"].ToString(),
                    contain = dt.Rows[i]["contain"].ToString()
                };
                if (islegal(message))
                {
                    if (!dictionary.ContainsKey(message.qq))
                    {
                        Join join = new Join
                        {
                            qq = message.qq,
                            nickname = message.nickname
                        };
                        if (message.contain.Contains(canPrizeStr)&&DateTime.Compare(DateTime.Parse(message.publish_time),start)>=0&& DateTime.Compare(DateTime.Parse(message.publish_time), end) <= 0)
                        {
                            join.publish_time = Convert.ToDateTime(message.publish_time);
                            join.canPrize = true;
                        }  
                        join.datetime_contain.Add(Convert.ToDateTime(message.publish_time),message.contain);
                        dictionary.Add(message.qq,join);
                    }
                    else
                    {
                        Join join;
                        dictionary.TryGetValue(message.qq,out join);
                        if (message.contain.Contains(canPrizeStr) && DateTime.Compare(DateTime.Parse(message.publish_time), start) >= 0 && DateTime.Compare(DateTime.Parse(message.publish_time), end) <= 0)
                        {
                            join.publish_time = Convert.ToDateTime(message.publish_time);
                            join.canPrize = true;
                        }
                        try
                        {
                            join.datetime_contain.Add(Convert.ToDateTime(message.publish_time), message.contain);
                        }
                        catch (Exception e) { }
                    }
                }
            }
            //抽奖
            award = randomPrize(dictionary);
            return "success";
        }

        public static List<Person> getAwardInfo()
        {
            List<Person> list = new List<Person>();
            if (DateTime.Compare(DateTime.Now, open) >= 0)
            {
                for (int i = 0; i < award.awardList.Count; ++i)
                {
                    list.Add(new Person()
                    {
                        qq = award.awardList[i].qq,
                        nickname = award.awardList[i].nickname,
                        prize = award.awardList[i].prize,
                        speakNum= award.awardList[i].datetime_contain.Count,
                    });
                }
                return list;
            }
            return null;
        }
    }
}