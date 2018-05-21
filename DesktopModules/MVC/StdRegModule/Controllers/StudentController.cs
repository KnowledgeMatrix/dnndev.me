using System;
using System.Linq;
using System.Web.Mvc;
using Christoc.Modules.StdRegModule.Components;
using Christoc.Modules.StdRegModule.Models;
using DotNetNuke.Web.Mvc.Framework.Controllers;
using DotNetNuke.Web.Mvc.Framework.ActionFilters;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework.JavaScriptLibraries;
using System.Collections.Generic;
using DotNetNuke.Web.Mvc.Common;
using DotNetNuke.Web.Mvc.Routing;
using DotNetNuke.Collections;

namespace Christoc.Modules.StdRegModule.Controllers
{
    public class StudentController : DnnController
    {
     [DnnHandleError]
        
        public ActionResult Index()
        {
            StudentManager std = new StudentManager();
            //ViewBag.StudentsList = std.GetStudents(ModuleContext.ModuleId).Count();
            //IList<StudentReg> studentList = new List<StudentReg>() {
            //        new StudentReg(){ StdRegID=1, StdName="Steve", StdClass = "b.tech",StdClgName="svcet" },
            //       new StudentReg(){ StdRegID=1, StdName="Steve", StdClass = "b.tech",StdClgName="svcet" },
            //       new StudentReg(){ StdRegID=1, StdName="Steve", StdClass = "b.tech",StdClgName="svcet" },
            //       new StudentReg(){ StdRegID=1, StdName="Steve", StdClass = "b.tech",StdClgName="svcet" },
            //       new StudentReg(){ StdRegID=1, StdName="Steve", StdClass = "b.tech",StdClgName="svcet" }
            //    };
            // ViewBag.TotalStudents = studentList.Count;
            IEnumerable<StudentReg> students;
            if (ModuleContext!=null)
            {
               students = std.GetStudents(ModuleContext.ModuleId);
                Session["moduleid"] = ModuleContext.ModuleId;
                
            }
            else
            
                //ModuleContext.ModuleId = Convert.ToInt32(Session["moduleid"]);
                 students = std.GetStudents(Convert.ToInt32(Session["moduleid"]));
           
                return View(students);
        }
        public ActionResult AddStudent()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddStudent(StudentReg stdnt)
        {
            StudentManager std = new StudentManager();
            stdnt.ModuleID = ModuleContext.ModuleId;
            std.AddStudent(stdnt);

            var routeVals = TypeHelper.ObjectToDictionary(RouteData.Values);
            routeVals["controller"] = "Student";
            routeVals["action"] = "Index";
            return Redirect(ModuleRoutingProvider.Instance().GenerateUrl(routeVals, ModuleContext));
            // return RedirectToDefaultRoute();
        }
        public ActionResult EditStudent(int StdRegID)
        {
            StudentManager std = new StudentManager();
            var stdnt = std.GetStudent(StdRegID);
       StudentReg sa = new StudentReg();
            foreach (var item in stdnt)
            {
                sa = item;
            }
           
            return View(sa);
        }
        [HttpPost]
        public ActionResult EditStudent(StudentReg stdnt)
        {
            StudentManager std = new StudentManager();
            stdnt.ModuleID = ModuleContext.ModuleId;
            std.EditStudent(stdnt);
             return RedirectToDefaultRoute();
           // return RedirectToAction("Index");
        }
        public ActionResult DeleteStudent(int StdRegID)
        {
            StudentManager std = new StudentManager();
            std.DeleteStudent(StdRegID);

            return RedirectToDefaultRoute();
        }
        public ActionResult Settings()
        {
            var settings = new Models.StudentSettings();
            settings.IsPassed = ModuleContext.Configuration.ModuleSettings.GetValueOrDefault("StdRegModule_IsPassed", false);
            settings.Marks = ModuleContext.Configuration.ModuleSettings.GetValueOrDefault("StdRegModule_Marks", "100%");

            return View(settings);

        }
        [ValidateInput(false)]
        [DotNetNuke.Web.Mvc.Framework.ActionFilters.ValidateAntiForgeryToken]
        [HttpPost]
        public ActionResult Settings(Models.StudentSettings stdset)
        {
            ModuleContext.Configuration.ModuleSettings["StdRegModule_IsPassed"] = stdset.IsPassed.ToString();
            ModuleContext.Configuration.ModuleSettings["StdRegModule_Marks"] = stdset.Marks;

            return RedirectToDefaultRoute();

        }
    }
}