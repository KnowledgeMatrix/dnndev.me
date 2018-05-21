using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Web.Client.ClientResourceManagement;


public partial class DesktopModules_TestDemo_DemoModule : PortalModuleBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write("The page load is Completed");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Button1.Text = "Please wait";
        Button1.BackColor = System.Drawing.Color.Red;
        Button1.ForeColor = System.Drawing.Color.Black;
    }
}