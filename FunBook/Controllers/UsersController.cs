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
using System.Threading.Tasks;
using FunBook.Models;

namespace FunBook.Controllers
{
    public class UsersController : ApiController
    {
        public async Task<IEnumerable<spGetalldetails_Result>> GetUsers()
        {
            using (dbFunbookEntities entities = new dbFunbookEntities())
            {
                    try
                    {
                        return await entities.Database.SqlQuery<spGetalldetails_Result>("spGetalldetails").ToListAsync();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
            }
        }
      
        [HttpPost]
        public HttpResponseMessage PostRegistration(string email, string name, string password)
        {
            using (dbFunbookEntities entities = new dbFunbookEntities())
            {
                var result = entities.spUserReg(email, name, password).FirstOrDefault();
                var output = new
                {
                    Result = result
                };
                return Request.CreateResponse(HttpStatusCode.OK, output);
            }
        }
    

        [HttpPost]
        public HttpResponseMessage PostCheckLogin(string email,string password)
        {
                using (dbFunbookEntities entities = new dbFunbookEntities())
                {
                    var userAgent = Request.Headers.UserAgent.ToString();
                    string pwd = GetMd5HashData(password);
                    pwd = pwd.ToUpper();
                    var result = entities.spChecklogin(email, pwd).FirstOrDefault();
                    var output = new
                    {
                        Result = result
                    };
                    return Request.CreateResponse(HttpStatusCode.OK, output);
                }
        }

        //Generate hashing
        public static string GetMd5HashData(string stext)
        {
            return string.Join("", MD5.Create().ComputeHash(System.Text.Encoding.ASCII.GetBytes(stext)).Select(s => s.ToString("x2")));
        }

    }
}
