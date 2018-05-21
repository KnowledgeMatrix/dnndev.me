#region Copyright
// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2013
// by DotNetNuke Corporation
// All Rights Reserved
#endregion

#region Usings

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

using DotNetNuke.Common;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Tabs;
using DotNetNuke.Entities.Users;
using DotNetNuke.Services.Authentication;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using DotNetNuke.Services.Social.Notifications;
using DotNetNuke.Services.Social.Messaging.Internal;

#endregion

namespace DotNetNuke.UI.Skins.Controls
{
    public partial class UserAndLogin : SkinObjectBase
    {
        private const string MyFileName = "UserAndLogin.ascx";

        protected string AvatarImageUrl
        {
            get
            {
                return string.Format(Globals.UserProfilePicRelativeUrl(), PortalSettings.UserId, 32, 32); 
            }
        }

        protected bool CanRegister
        {
            get
            {
                return ((PortalSettings.UserRegistration != (int) Globals.PortalRegistrationType.NoRegistration)
                    && (PortalSettings.Users < PortalSettings.UserQuota || PortalSettings.UserQuota == 0));
            }
        }

        protected string DisplayName
        {
            get
            {
                return PortalSettings.UserInfo.DisplayName;
            }
        }

        protected bool IsAuthenticated
        {
            get
            {
                return Request.IsAuthenticated;
            }
        }

        protected string LoginUrl
        {
            get
            {
                string returnUrl = HttpContext.Current.Request.RawUrl;
                if (returnUrl.IndexOf("?returnurl=", StringComparison.Ordinal) != -1)
                {
                    returnUrl = returnUrl.Substring(0, returnUrl.IndexOf("?returnurl=", StringComparison.Ordinal));
                }
                returnUrl = HttpUtility.UrlEncode(returnUrl);

                return Globals.LoginURL(returnUrl, (Request.QueryString["override"] != null));
            }
        }

        protected string LoginUrlForClickEvent
        {
            get
            {
                var url = LoginUrl;

                if (UsePopUp)
                {
                    return "return " + UrlUtils.PopUpUrl(LoginUrl, this, PortalSettings, true, false, 300, 650);
                }

                return string.Empty;
            }
        }

        protected bool UsePopUp
        {
            get
            {
                return PortalSettings.EnablePopUps 
                    && PortalSettings.LoginTabId == Null.NullInteger
                    && !HasSocialAuthenticationEnabled();
            }
        }

        protected string RegisterUrl
        {
            get
            {
                return Globals.RegisterURL(HttpUtility.UrlEncode(Globals.NavigateURL()), Null.NullString);
            }
        }

        protected string RegisterUrlForClickEvent
		{
			get
			{
				if (UsePopUp)
				{
					return "return " + UrlUtils.PopUpUrl(RegisterUrl, this, PortalSettings, true, false, 600, 950);
				}

				return string.Empty;
			}
 		}

        protected string UserProfileUrl
        {
            get
            {
                return Globals.UserProfileURL(PortalSettings.UserInfo.UserID); ;
            }
        }

        protected string LocalizeString(string key)
        {
            return Localization.GetString(key, Localization.GetResourceFile(this, MyFileName)); 
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            registerLink.NavigateUrl = RegisterUrl;
            loginLink.NavigateUrl = LoginUrl;
            viewProfileLink.NavigateUrl = Globals.UserProfileURL(PortalSettings.UserId);
            viewProfileImageLink.NavigateUrl = Globals.UserProfileURL(PortalSettings.UserId);
            logoffLink.NavigateUrl = Globals.NavigateURL(PortalSettings.ActiveTab.TabID, "Logoff");
            editProfileLink.NavigateUrl = Globals.NavigateURL(PortalSettings.UserTabId, "Profile", "userId=" + PortalSettings.UserId, "pageno=2");
            accountLink.NavigateUrl = Globals.NavigateURL(PortalSettings.UserTabId, "Profile", "userId=" + PortalSettings.UserId, "pageno=1");
            messagesLink.NavigateUrl = Globals.NavigateURL(GetMessageTab(), "", string.Format("userId={0}", PortalSettings.UserId)); ;
            notificationsLink.NavigateUrl = messagesLink.NavigateUrl + "#dnnCoreNotification";

            var unreadMessages = InternalMessagingController.Instance.CountUnreadMessages(PortalSettings.UserId, PortalSettings.PortalId);
            var unreadAlerts = NotificationsController.Instance.CountNotifications(PortalSettings.UserId, PortalSettings.PortalId);

            if(unreadMessages > 0)
            {
                messageCount.Text = unreadMessages.ToString(CultureInfo.InvariantCulture);

                messages.Text = unreadMessages.ToString(CultureInfo.InvariantCulture);
                messages.ToolTip = unreadMessages == 1 
                                    ? LocalizeString("OneMessage") 
                                    : String.Format(LocalizeString("MessageCount"), unreadMessages);
            }

            if (unreadAlerts > 0)
            {
                notificationCount.Text = unreadAlerts.ToString(CultureInfo.InvariantCulture);
            }


            if (UsePopUp)
            {
                registerLink.Attributes.Add("onclick", RegisterUrlForClickEvent);
                loginLink.Attributes.Add("onclick", LoginUrlForClickEvent);
            }

            profilePicture.ImageUrl = AvatarImageUrl;
            profilePicture.AlternateText = Localization.GetString("ProfilePicture", Localization.GetResourceFile(this, MyFileName));
        }

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

        private bool HasSocialAuthenticationEnabled()
        {
            return (from a in AuthenticationController.GetEnabledAuthenticationServices()
                    let enabled = (a.AuthenticationType == "Facebook"
                                     || a.AuthenticationType == "Google"
                                     || a.AuthenticationType == "Live"
                                     || a.AuthenticationType == "Twitter")
                                  ? PortalController.GetPortalSettingAsBoolean(a.AuthenticationType + "_Enabled", PortalSettings.PortalId, false)
                                  : !string.IsNullOrEmpty(a.LoginControlSrc) && (LoadControl("~/" + a.LoginControlSrc) as AuthenticationLoginBase).Enabled
                    where a.AuthenticationType != "DNN" && enabled
                    select a).Any();
        }
    }
}