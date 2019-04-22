using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace LuckyDraw.Models
{
    public class SQLManager
    {
        private SqlConnection conn = new SqlConnection();

        public SQLManager(string uid, string pwd, string dataBaseName)
        {
            conn.ConnectionString = $"server = .;uid = {uid};pwd = {pwd}; database = " + dataBaseName;
        }

        public SQLManager(string dataBaseName, string server = ".", string uid = "uid", string pwd = "pwd")
        {
            conn.ConnectionString = $"server = {dataBaseName};uid = {uid};pwd = {pwd}; database = " + dataBaseName;
        }

        public SQLManager()
        {
            conn.ConnectionString = $"server = .;uid = uid;pwd = pwd; database = LuckDraw";
        }

        /// <summary>
        /// 读取表的全部内容///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <returns></returns>
        public DataTable ReadList(string ListName)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter($"select * from {ListName};", conn);
                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                conn.Close();
                return dataSet.Tables[0];
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 读取表的全部内容///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="Filter">条件筛选器WHERE</param>
        /// <returns></returns>
        public DataTable ReadList(string ListName, string Filter)
        {
            try
            {
                conn.Open();
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter($"select * from {ListName}; where {Filter}", conn);
                DataSet dataSet = new DataSet();
                sqlDataAdapter.Fill(dataSet);
                conn.Close();
                return dataSet.Tables[0];
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 验证用户凭据///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="IDColName">用户名所在的列名</param>
        /// <param name="ID">用户名</param>
        /// <param name="PWDColName">密码所在的列名</param>
        /// <param name="PWD">密码</param>
        /// <returns></returns>
        public bool ValidUser(string ListName, string IDColName, string ID, string PWDColName, string PWD)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand($"SELECT * FROM {ListName} WHERE {IDColName} = @ID AND {PWDColName} = @PWD;");
                cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@PWD", PWD);
                cmd.Connection = conn;
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    conn.Close();
                    return true;
                }
                else
                {
                    conn.Close();
                    return false;
                }
            }
            catch { return false; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 判断是否存在指定列的某行值///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="ColName">指定的列名</param>
        /// <param name="Value">需要验证的值</param>
        /// <returns></returns>
        public bool Exists(string ListName, string ColName, string Value)
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand($"SELECT * FROM {ListName} WHERE {ColName} = @Value;");
            cmd.Parameters.AddWithValue("@Value", Value);
            cmd.Connection = conn;
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                conn.Close();
                return true;
            }
            else
            {
                conn.Close();
                return false;
            }
        }

        /// <summary>
        /// 插入单列单行///
        /// </summary>
        /// <param name="ListName">要插入的表名</param>
        /// <param name="ColName">指定的列名</param>
        /// <param name="Value">要插入的值</param>
        /// <returns></returns>
        public bool Insert(string ListName, string ColName, string Value)
        {
            try
            {
                SqlCommand cmd = new SqlCommand($"insert into {ListName} ({ColName}) values('{Value}')", conn);

                conn.Open();

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();

                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 插入新的一行///支持多列插入///
        /// </summary>
        /// <param name="ListName">要插入的表名</param>
        /// <param name="value">要插入的列名和对应的值///列名之间用逗号隔开///列名对应的值在指定完列名后指定同理也用逗号隔开///列名参数个数必须为偶数</param>
        /// <returns></returns>
        public bool Insert(string ListName, params string[] value)
        {
            try
            {
                if (value.Length % 2 != 0)
                    return false;
                int half = value.Length / 2;
                string colName = "", colValue = "";
                for (int i = 0; i < half; i++)
                {
                    if (i != half - 1)
                        colName = colName + value[i] + ",";
                    else
                        colName = colName + value[i];
                }
                for (int i = half; i < value.Length; i++)
                {
                    if (i != value.Length - 1)
                        colValue = colValue + "'" + value[i] + "',";
                    else
                        colValue = colValue + "'" + value[i] + "'";
                }
                SqlCommand cmd = new SqlCommand($"INSERT INTO {ListName} ({colName}) VALUES ({colValue});", conn);

                conn.Open();

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 删除指定的行///
        /// </summary>
        /// <param name="ListName">要删除的表名</param>
        /// <param name="Filter">条件筛选器WHERE</param>
        /// <returns></returns>
        public bool Delete(string ListName, string Filter)
        {
            try
            {
                SqlCommand cmd = new SqlCommand($"DELETE FROM {ListName} WHERE {Filter};", conn);

                conn.Open();

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 更新指定行数据///
        /// </summary>
        /// <param name="ListName">要更新的表名</param>
        /// <param name="Filter">条件筛选器WHERE</param>
        /// <param name="UpdateColName">要更新的列名</param>
        /// <param name="UpdateValue">要更新的列名对应的值</param>
        /// <returns></returns>
        public bool Update(string ListName, string Filter, string UpdateColName, string UpdateValue)
        {
            try
            {
                SqlCommand cmd = new SqlCommand($"UPDATE {ListName} SET {UpdateColName} = '{UpdateValue}' WHERE {Filter};", conn);
                conn.Open();
                cmd.Connection = conn;
                cmd.ExecuteNonQuery();
                conn.Close();
                return true;
            }
            catch
            {
                conn.Close();
                return false;
            }
        }

        /// <summary>
        /// 更新指定行数据///
        /// </summary>
        /// <param name="ListName">要更新的表名</param>
        /// <param name="Filter">条件筛选器WHERE</param>
        /// <param name="value">要更新的列名和对应的值///列名之间用逗号隔开///列名对应的值在指定完列名后指定同理也用逗号隔开///列名参数个数必须为偶数</param>
        /// <returns></returns>
        public bool Update(string ListName, string Filter, params string[] value)
        {
            try
            {
                if (value.Length % 2 != 0)
                    return false;
                int half = value.Length / 2;
                string final = "";
                for (int i = 0; i < half; i++)
                {
                    if (i != half - 1)
                        final = final + $" {value[i]} = '{value[i + half]}',";
                    else
                        final = final + $" {value[i]} = '{value[i + half]}'";
                }
                SqlCommand cmd = new SqlCommand($"UPDATE {ListName} SET {final} WHERE {Filter};", conn);

                conn.Open();

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 获取指定列///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="ColName">指定的列名</param>
        /// <returns></returns>
        public DataTable GetCol(string ListName, string ColName)
        {
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter($"SELECT {ColName} FROM {ListName};", conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, ListName); //用适配对象填充表对象//
                dt = st.Tables[ListName];
                conn.Close();
                return dt;
            }
            catch
            {
                return null;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 获取指定列///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="ColName">指定的列名</param>
        /// <param name="Filter">条件筛选器WHERE</param>
        /// <returns></returns>
        public DataTable GetCol(string ListName, string ColName, string Filter)
        {
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter($"SELECT {ColName} FROM {ListName} WHERE {Filter};", conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, ListName); //用适配对象填充表对象//
                dt = st.Tables[ListName];
                conn.Close();
                return dt;
            }
            catch
            {
                return null;
            }
            finally
            {
                conn.Close();
            }
        }

        /// <summary>
        /// 获取指定行///
        /// </summary>
        /// <param name="ListName">要读取的表名</param>
        /// <param name="ColName">指定的列名</param>
        /// <param name="ColValue">指定的列名所对应的值</param>
        /// <returns></returns>
        public DataRow GetRow(string ListName, string ColName, string ColValue)
        {
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter($"SELECT * FROM {ListName} WHERE {ColName} = '{ColValue}';", conn); //创建适配对象//
            DataSet st = new DataSet();
            DataTable dt = new DataTable(); //新建表对象//
            da.Fill(st, ListName); //用适配对象填充表对象//
            dt = st.Tables[ListName];
            conn.Close();
            return dt.Rows.Count == 0?null:dt.Rows[0];
        }

        /// <summary>
        /// 通用修改函数///
        /// </summary>
        /// <param name="SQLCommand">执行SQL语句</param>
        /// <returns></returns>
        public bool UniversalSetAPI(string SQLCommand)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(SQLCommand, conn);

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();
                return true;
            }
            catch { return false; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 通用查询函数///
        /// </summary>
        /// <param name="SQLCommand">执行SQL语句</param>
        /// <returns></returns>
        public DataTable UniversalGetAPI(string SQLCommand)
        {
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(SQLCommand, conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, "Example"); //用适配对象填充表对象//
                dt = st.Tables["Example"];
                conn.Close();
                return dt;
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 通用单一查询语句///
        /// </summary>
        /// <param name="SQLCommand">执行SQL语句</param>
        /// <returns></returns>
        public string UniversalGetValue(string SQLCommand)
        {
            try
            {
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(SQLCommand, conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, "Example"); //用适配对象填充表对象//
                dt = st.Tables["Example"];
                conn.Close();
                return dt.Rows[0][0].ToString();
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 标准修改语句///
        /// </summary>
        /// <param name="sqlCommand">执行SQL语句</param>
        /// <returns></returns>
        public bool Standard_POST_API(string sqlCommand)
        {
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sqlCommand, conn);

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                conn.Close();
                return true;
            }
            catch { return false; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 标准查询语句///
        /// </summary>
        /// <param name="sqlCommand">执行SQL语句</param>
        /// <returns></returns>
        public DataTable Standard_Get_API(string sqlCommand)
        {
            try
            {
                //ASP.NET中使用 GridView GridView1 = new GridView();//
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlCommand, conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, "Example"); //用适配对象填充表对象//
                dt = st.Tables["Example"];
                conn.Close();
                return dt;
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        /// <summary>
        /// 标准单一查询语句///
        /// </summary>
        /// <param name="sqlCommand">执行SQL语句param>
        /// <returns></returns>
        public string Ones_Get_API(string sqlCommand)
        {
            try
            {
                //ASP.NET中使用 GridView GridView1 = new GridView();//
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(sqlCommand, conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, "Example"); //用适配对象填充表对象//
                dt = st.Tables["Example"];
                conn.Close();
                return dt.Rows[0][0].ToString();
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        public string Ones_Get_API(string ListName, string Filter, string ColName)
        {
            try
            {
                //ASP.NET中使用 GridView GridView1 = new GridView();//
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter($"select {ColName} from {ListName} where {Filter};", conn); //创建适配对象//
                DataSet st = new DataSet();
                DataTable dt = new DataTable(); //新建表对象//
                da.Fill(st, "Example"); //用适配对象填充表对象//
                dt = st.Tables["Example"];
                conn.Close();
                return dt.Rows[0][0].ToString();
            }
            catch { return null; }
            finally { conn.Close(); }
        }

        public bool UpdateUnSafe(string ListName, string Filter, params string[] value)
        {
            try
            {
                if (value.Length % 2 != 0)
                    return false;
                int half = value.Length / 2;
                string final = "";
                for (int i = 0; i < half; i++)
                {
                    if (i != half - 1)
                        final = final + $" {value[i]} = '{value[i + half]}',";
                    else
                        final = final + $" {value[i]} = '{value[i + half]}'";
                }
                SqlCommand cmd = new SqlCommand($"UPDATE {ListName} SET {final} WHERE {Filter};", conn);

                cmd.Connection = conn;
                cmd.ExecuteNonQuery();

                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 开启SQL Connection///
        /// </summary>
        /// <returns></returns>
        public bool Open()
        {
            try
            {
                conn.Open();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 关闭SQL Connection///
        /// </summary>
        /// <returns></returns>
        public bool Close()
        {
            try
            {
                conn.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 返回Connection///
        /// </summary>
        /// <returns></returns>
        public SqlConnection ReturnConnection()
        {
            return conn;
        }

        /// <summary>
        /// 返回连接字符串///
        /// </summary>
        /// <returns></returns>
        public string ReturnInfo()
        {
            return conn.ConnectionString;
        }

        /// <summary>
        /// 打开SDC文档///
        /// </summary>
        /// <param name="path">文件路径</param>
        /// <returns></returns>
        public string OpenSdc_API(string path)    //打开Sdc文档//
        {
            StreamReader sr = new StreamReader(path, Encoding.UTF8);
            String line, r = "";
            bool firstread = true;
            while ((line = sr.ReadLine()) != null)
            {
                if (firstread == true)
                {
                    r = line.ToString();
                    firstread = false;
                }
                else
                {
                    r += "\n" + line.ToString();
                }
            }
            sr.Close();
            return r;
        }

        /// <summary>
        /// 保存Sdc文档///
        /// </summary>
        /// <param name="path">路径</param>
        /// <param name="content">欲写入的全部内容</param>
        public void SaveSdc(string path, string content)
        {
            FileStream fs = new FileStream(path, FileMode.Create);
            StreamWriter sw = new StreamWriter(fs);
            try
            {
                //开始写入//
                sw.Write(content);
                //清空缓冲区//
                sw.Flush();
                //关闭流//
                sw.Close();
                fs.Close();
            }
            catch
            {
                fs.Close();
            }
        }


        ///>>>>>>>>>>>>>>>>>>>>>>X功能<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<///
        /// <summary>
        /// 泛型读取转换功能///
        /// </summary>
        /// <typeparam name="T">转换对象类型///只允许为包含属性的类</typeparam>
        /// <param name="cmd">数据库查询语句</param>
        /// <param name="extendProperties">拓展替换参数///用于对象属性名和对应列名不匹配时进行替换</param>
        /// <returns>返回对象List列表或为null值</returns>
        public List<T> X_Out_API<T>(string cmd, params x_param_replace[] extendProperties) where T : class, new()
        {
            try
            {
                DataTable dt = Standard_Get_API(cmd);
                List<T> ReClass = new List<T>();
                foreach (DataRow dr in dt.Rows)
                {
                    T tempClass = new T();
                    Type type = tempClass.GetType();
                    PropertyInfo[] info = type.GetProperties();
                    foreach (PropertyInfo pi in info)
                    {
                        try
                        {
                            pi.SetValue(tempClass, dr[pi.Name].ToString());
                        }
                        catch
                        {
                            foreach (x_param_replace xp in extendProperties)
                            {
                                xp.dr = dr;
                                if (pi.Name == xp.propertyName)
                                {
                                    pi.SetValue(tempClass, xp.GetValue());
                                    break;
                                }
                            }
                        }
                    }
                    ReClass.Add(tempClass);
                }
                return ReClass;
            }
            catch
            {
                return null;
            }
        }
    }

    /// <summary>
    /// SQLManager拓展参数替换类///
    /// </summary>
    public class x_param_replace
    {
        /// <summary>
        /// 原属性名称///
        /// </summary>
        public string propertyName { get; set; }

        /// <summary>
        /// 拓展查找命令语句///
        /// </summary>
        public string cmd { get; set; }

        /// <summary>
        /// 访问数据库名///
        /// </summary>
        public string dataBaseName { get; set; }

        /// <summary>
        /// 实时查询对应的关键列名///用于返回该查询行对应的某一列值///
        /// </summary>
        public string keyWord { get; set; }

        /// <summary>
        /// 拓展参数对应的返回结果///
        /// </summary>
        public string value { get; set; }

        /// <summary>
        /// 可拓展查询语句多条实时查询对应的关键列名///用于返回该查询行对应的多列值///在参数cmd中用{n}的方式按顺序标记///
        /// </summary>
        public string[] keyWords { get; set; }

        /// <summary>
        /// 实时查询对应的行///
        /// </summary>
        public DataRow dr { get; set; }

        /// <summary>
        /// 直接置换查找列名///默认列名对应属性名///
        /// </summary>
        /// <param name="propertyName">对象属性名</param>
        /// <param name="replaceName">要查找的列名</param>
        public x_param_replace(string propertyName, string replaceName)
        {
            this.propertyName = propertyName;
            GetValue(replaceName);
        }

        /// <summary>
        /// 通过查询语句来查找属性值///注意数据库名一定要填写///
        /// </summary>
        /// <param name="propertyName"></param>
        /// <param name="cmd"></param>
        /// <param name="dataBaseName"></param>
        /// <param name="keyWords"></param>
        public x_param_replace(string propertyName, string cmd, string dataBaseName, params string[] keyWords)
        {
            this.propertyName = propertyName;
            this.cmd = cmd;
            this.keyWords = keyWords;
            this.dataBaseName = dataBaseName;
        }

        /// <summary>
        /// 通过查询语句来查找属性值///
        /// </summary>
        /// <param name="propertyName"></param>
        /// <param name="cmd"></param>
        /// <param name="keyWord"></param>
        /// <param name="dataBaseName"></param>
        public x_param_replace(string propertyName, string cmd, string keyWord, string dataBaseName = "ADSX")
        {
            this.propertyName = propertyName;
            this.cmd = cmd;
            this.keyWord = keyWord;
            this.dataBaseName = dataBaseName;
        }

        /// <summary>
        /// 直接替换名称中间函数///
        /// </summary>
        /// <param name="replaceName"></param>
        public void GetValue(string replaceName)
        {
            value = replaceName;
        }

        /// <summary>
        /// 返回查找的值对应的结果///
        /// </summary>
        /// <returns></returns>
        public string GetValue()
        {
            if (keyWord == null && keyWords == null)
            {
                return dr[value].ToString();
            }
            if (keyWord != null)
            {
                SQLManager sl = new SQLManager();
                value = sl.Ones_Get_API(string.Format(cmd, dr[keyWord].ToString()));
                return value;
            }
            else
            {
                SQLManager sl = new SQLManager();
                value = sl.Ones_Get_API(string.Format(cmd, keyWords));
                return value;
            }
        }
    }
}