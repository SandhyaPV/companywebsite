using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace FunBook.Models
{
    public class login
    {
        
        public string email { set; get; }
        public string password { set; get; }
    }
}