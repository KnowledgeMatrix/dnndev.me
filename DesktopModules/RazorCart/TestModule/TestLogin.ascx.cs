using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;

public partial class DesktopModules_MVC_TestModule_TestLogin : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write("Test login module loaded");
    }
      protected void Button1_Click(object sender, EventArgs e)
    {
        Button1.Text = "Please wait";
        Button1.BackColor = System.Drawing.Color.Red;
        Button1.ForeColor = System.Drawing.Color.Black;
    }
}