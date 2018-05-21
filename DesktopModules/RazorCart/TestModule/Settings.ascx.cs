using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;

public partial class DesktopModules_RazorCart_TestModule_Settings : ModuleSettingsBase
{
     #region Base Method Implementations
        /// -----------------------------------------------------------------------------
        /// <summary>
        /// LoadSettings loads the settings from the Database and displays them
        /// </summary>
        /// -----------------------------------------------------------------------------
        public override void LoadSettings()
        {
            try
            {
                if (Page.IsPostBack == false)
                {
                    //Check for existing settings and use those on this page
                    /* uncomment to load saved settings in the text boxes*/
                    if (Settings.Contains("ShowCompletedTasks"))
                    {
                        ShowCompletedTasksSelector.SelectedValue = Settings["ShowCompletedTasks"].ToString();
                   }
                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }
        /// -----------------------------------------------------------------------------
        /// <summary>
        /// UpdateSettings saves the modified settings to the Database
        /// </summary>
        /// -----------------------------------------------------------------------------
        public override void UpdateSettings()
        {
            try
            {
                var modules = new ModuleController();
                modules.UpdateModuleSetting(ModuleId, "ShowCompletedTasks", ShowCompletedTasksSelector.SelectedValue);
             }
            catch (Exception exc)
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }
        #endregion

    

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}

