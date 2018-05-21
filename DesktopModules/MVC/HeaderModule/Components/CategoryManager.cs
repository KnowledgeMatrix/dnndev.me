
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Christoc.Modules.HeaderModule.Models;
using DotNetNuke.Framework;
using DotNetNuke.Data;

namespace Christoc.Modules.HeaderModule.Components
{
    public class CategoryManager
    {
        public IEnumerable<Category> GetCategories()
        {
            IEnumerable<Category> cat;
            using (IDataContext ctx = DataContext.Instance())
            {
                cat = ctx.ExecuteQuery<Category>(System.Data.CommandType.Text, "select * from Smith_Category");
            }
            return cat;
        }

        public string GetParentCategories(int parentid)
        {
            string pcat;
            using (IDataContext ctx = DataContext.Instance())
            {
                // pcat = ctx.ExecuteQuery<Category>(System.Data.CommandType.Text, "select CategoryName from Smith_Category where CategoryID="+parentid);
                 pcat = ctx.ExecuteScalar<Category>(System.Data.CommandType.Text, "select CategoryName from Smith_Category where CategoryID=" + parentid).ToString();
            }
            return pcat;
        }
    }
}