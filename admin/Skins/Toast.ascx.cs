#region Copyright
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2013
// by DotNetNuke Corporation
// All Rights Reserved
#endregion

#region Usings

using System;
using System.Collections.Generic;
using System.Net;
using DotNetNuke.Common;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Localization;
using DotNetNuke.Web.Client.ClientResourceManagement;
using DotNetNuke.Framework.JavaScriptLibraries;

#endregion

namespace DotNetNuke.UI.Skins.Controls
{
    public partial class Toast : SkinObjectBase
    {

        private const string MyFileName = "Toast.ascx";

        public bool IsOnline()
        {
             var userInfo = UserController.Instance.GetCurrentUserInfo();
             return userInfo.UserID != -1;
        }

        public string GetNotificationLink()
        {
            return GetMessageLink() + "?view=notifications&action=notifications";
        }

        public string GetMessageLink()
        {
            return Globals.NavigateURL(GetMessageTab(), "", string.Format("userId={0}", PortalSettings.UserId));
        }

        public string GetMessageLabel()
        {
            return Localization.GetString("SeeAllMessage", Localization.GetResourceFile(this, MyFileName));
        }

        public string GetNotificationLabel()
        {
            return Localization.GetString("SeeAllNotification", Localization.GetResourceFile(this, MyFileName));
        }

        //This method is copied from user skin object
        private int GetMessageTab()
        {
            var cacheKey = string.Format("MessageCenterTab:{0}", PortalSettings.PortalId);
            var messageTabId = DataCache.GetCache<int>(cacheKey);
            if (messageTabId > 0)
                return messageTabId;

            //Find the Message Tab
            messageTabId = FindMessageTab();

            //save in cache
            //NOTE - This cache is not being cleared. There is no easy way to clear this, except Tools->Clear Cache
            DataCache.SetCache(cacheKey, messageTabId, TimeSpan.FromMinutes(20));

            return messageTabId;
        }

        //This method is copied from user skin object
        private int FindMessageTab()
        {
            var tabController = new TabController();
            var moduleController = new ModuleController();

            //On brand new install the new Message Center Module is on the child page of User Profile Page 
            //On Upgrade to 6.2.0, the Message Center module is on the User Profile Page
            var profileTab = tabController.GetTab(PortalSettings.UserTabId, PortalSettings.PortalId, false);
            if (profileTab != null)
            {
                var childTabs = tabController.GetTabsByPortal(profileTab.PortalID).DescendentsOf(profileTab.TabID);
                foreach (TabInfo tab in childTabs)
                {
                    foreach (KeyValuePair<int, ModuleInfo> kvp in moduleController.GetTabModules(tab.TabID))
                    {
                        var module = kvp.Value;
                        if (module.DesktopModule.FriendlyName == "Message Center")
                        {
                            return tab.TabID;                            
                        }
                    }
                }
            }

            //default to User Profile Page
            return PortalSettings.UserTabId;            
        }        

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            JavaScript.RequestRegistration(CommonJs.jQueryUI);

            ClientResourceManager.RegisterScript(Page, "~/DesktopModules/DNNCorp/Mechanics/Scripts/contrib/jquery-toastmessage-plugin/javascript/jquery.toastmessage.js", DotNetNuke.Web.Client.FileOrder.Js.jQuery);
            ClientResourceManager.RegisterStyleSheet(Page, "~/DesktopModules/DNNCorp/Mechanics/Scripts/contrib/jquery-toastmessage-plugin/resources/css/jquery.toastmessage.css", DotNetNuke.Web.Client.FileOrder.Css.DefaultCss);

        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            Visible = Response.StatusCode == (int)HttpStatusCode.OK;
        }
    }
}