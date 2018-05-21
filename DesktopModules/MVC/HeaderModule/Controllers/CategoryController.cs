using System;
using System.Linq;
using System.Web.Mvc;
using Christoc.Modules.HeaderModule.Components;
using Christoc.Modules.HeaderModule.Models;
using DotNetNuke.Web.Mvc.Framework.Controllers;
using DotNetNuke.Web.Mvc.Framework.ActionFilters;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework.JavaScriptLibraries;
using System.Collections.Generic;
using DotNetNuke.Web.Mvc.Common;
using DotNetNuke.Web.Mvc.Routing;
using DotNetNuke.Collections;

namespace Christoc.Modules.HeaderModule.Controllers
{
    public class CategoryController : DnnController
    {
       [DnnHandleError]
       
        public ActionResult Index()
        {
            
            CategoryManager cm = new CategoryManager();
            //get categories


            // Query for customers from London
            IEnumerable<Category> ct;
            //ViewBag.categorieslist = cm.GetCategories();
            List<Category> catlist = new List<Category>();
           
           
            ct = cm.GetCategories();
            //sorting for to display child categories in the perfect parent category
            string[] ParentCatArr = new string[10];
            int i = 0;
            var cts = from c in ct where c.PortalID == PortalSettings.PortalId
                      orderby c.ParentID
                      select c; 
            foreach (var Category in cts)
            {
                Category cat = new Category();
                if (Category.ParentID==0)
                {
                    cat.CategoryID = Category.CategoryID;
                    cat.CategoryName = Category.CategoryName;
                    cat.isHaveParent = false;
                    cat.ParentID = Category.ParentID;
                    cat.PortalID = Category.PortalID;
                    cat.ParentName = Category.CategoryName;
                    cat.CatSEOURL = Category.CatSEOURL;
                }
                else
                {

                    cat.CategoryID = Category.CategoryID;
                    cat.CategoryName = Category.CategoryName;
                    cat.isHaveParent = true;
                    cat.ParentID = Category.ParentID;
                    cat.PortalID = Category.PortalID;
                    cat.CatSEOURL = Category.CatSEOURL;
                    int a = Category.ParentID;

                    var ab = (from c in ct
                              where c.CategoryID == a
                              select c).ToList<Category>();

                    cat.ParentName = ab[0].CategoryName;
                    if (!ParentCatArr.Contains(cat.ParentName))
                    {
                        ParentCatArr[i] = ab[0].CategoryName;
                        i++;
                    }
                }

                catlist.Add(cat);
            }
            ViewBag.ParentCatArr = ParentCatArr;
           
            return View(catlist);
           
        }
       
    }
}