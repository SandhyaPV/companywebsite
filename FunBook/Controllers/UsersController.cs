using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using FunBookDataAccess;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace FunBook.Controllers
{
    public class UsersController : ApiController
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["SqlConnection"].ConnectionString);

        public IEnumerable<tbl_userdetails> Get()
        {
            using (dbFunbookEntities entities = new dbFunbookEntities())
            {
                return entities.tbl_userdetails.ToList();
            }
        }

       

        [HttpPost]
        public string PostRegistration(string email, string name, string password)
        {
            using (dbFunbookEntities entities = new dbFunbookEntities())
            {
                var result = entities.spUserReg(email, name, password);
                return result.ToString();
            }
        }
    


        [HttpPost]
        public HttpResponseMessage PostCheckLogin(string email, string password)
        {
                using (dbFunbookEntities entities = new dbFunbookEntities())
                {
                string pwd= GetMd5HashData(password);
                pwd = pwd.ToUpper();
                var result = entities.spChecklogin(email, pwd).FirstOrDefault();
                    return Request.CreateResponse(HttpStatusCode.OK, result);
            }
        }

        //Generate hashing
        public static string GetMd5HashData(string stext)
        {
            return string.Join("", MD5.Create().ComputeHash(System.Text.Encoding.ASCII.GetBytes(stext)).Select(s => s.ToString("x2")));
        }



        [HttpPost]
        public HttpResponseMessage PostGetlogins()
        {
            SqlCommand cmd = new SqlCommand("spGetlogins", con);
            DataTable dt = new DataTable();
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            con.Open();
            da.Fill(dt);
            con.Close();
            return Request.CreateResponse(HttpStatusCode.OK, dt);
        }
    }
}
