
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Christoc.Modules.StdRegModule.Models;
using DotNetNuke.Framework;
using DotNetNuke.Data;

namespace Christoc.Modules.StdRegModule.Components
{
    interface IStudentManager
    {
        IEnumerable<StudentReg> GetStudents(int moduleid);

        void AddStudent(StudentReg std);
        void EditStudent(StudentReg std);
        IEnumerable<StudentReg> GetStudent(int StdRegId);
        void DeleteStudent(int StdRegId);
    }
    public class StudentManager/*:ServiceLocator<IStudentManager,StudentManager>,IStudentManager*/
    {
        public IEnumerable<StudentReg> GetStudents(int moduleid)
        {
            IEnumerable<StudentReg> s;
            using (IDataContext ctx = DataContext.Instance())
            {
                s = ctx.ExecuteQuery<StudentReg>(System.Data.CommandType.StoredProcedure, "StdRegModule_getStudents", moduleid);
            }
            return s;


            //using (IDataContext ctx = DataContext.Instance())
            //{
            //    var rep = ctx.GetRepository<StudentReg>();
            //    s = rep.Get(moduleid);

            //}
            //return s;
        }
        //protected override System.Func<IStudentManager> GetFactory()
        //{
        //    return () => new StudentManager();
        //}    
        public void AddStudent(StudentReg std)
        {
            using(IDataContext ctx = DataContext.Instance())
            {
                
                ctx.Execute(System.Data.CommandType.StoredProcedure, "StdRegModule_AddStudent", std.StdName,std.StdClass,std.StdClgName,std.ModuleID);
               
            }
        }
        public void EditStudent(StudentReg std)
        {
            using (IDataContext ctx = DataContext.Instance())
            {

                ctx.Execute(System.Data.CommandType.StoredProcedure, "StdRegModule_UpdateStudent", std.StdName, std.StdClass, std.StdClgName, std.ModuleID,std.StdRegID);

            }
        }


        public IEnumerable<StudentReg> GetStudent(int StdRegId)
        {
            IEnumerable<StudentReg> s;
           
            using (IDataContext ctx = DataContext.Instance())
            {
                s= ctx.ExecuteQuery<StudentReg>(System.Data.CommandType.StoredProcedure, "StdRegModule_getStudent", StdRegId);
                
            }
            return s;
        }

        public void DeleteStudent(int StdRegId)
        {
            using (IDataContext ctx = DataContext.Instance())
            {

                ctx.Execute(System.Data.CommandType.StoredProcedure, "StdRegModule_DeleteStudent", StdRegId);

            }
        }

       
    }
}