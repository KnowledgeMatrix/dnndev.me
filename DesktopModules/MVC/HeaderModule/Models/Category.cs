using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Christoc.Modules.HeaderModule.Models
{
    public class Category
    {
       

       
        public int CategoryID { get; set; } = -1;
        public string CategoryName { get; set; }
        public int ParentID { get; set; }
        public int PortalID { get; set; }
        public bool isHaveParent { get; set; }
        public string ParentName { get; set; }
        public string CatSEOURL { get; set; }

    }
}