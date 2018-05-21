using System;
using System.Web.Caching;
using DotNetNuke.Common.Utilities;
using DotNetNuke.ComponentModel.DataAnnotations;
using DotNetNuke.Entities.Content;

namespace Christoc.Modules.StdRegModule.Models
{
    public class StudentReg
    {
        [TableName("StdRegModule_Students")]
        //setup the primary key for table
        [PrimaryKey("StdRegID", AutoIncrement = true)]
        //configure caching using PetaPoco
        [Cacheable("Students", CacheItemPriority.Default, 20)]
       
        //scope the objects to the ModuleId of a module on a page (or copy of a module on a page)
        [Scope("ModuleId")]
        public int StdRegID { get; set; } = -1;
        public string StdName { get; set; }
        public string StdClass { get; set; } 
        public string StdClgName { get; set; }
        public int ModuleID { get; set; }
    }
}