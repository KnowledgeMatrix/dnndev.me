using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

using DotNetNuke.Entities.Users;
using DotNetNuke.UI.Skins;

using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard;
using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard.Collection.Subject;
using EasyDNNSolutions.EasyDNNstyleWizard.Library;
using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard.Meta;

namespace EasyDNNSolutions.EasyDNNstyleWizard.StyleWizard.SkinObjects
{
	public partial class Skin : SkinObjectBase
	{

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad(e);

			string clientSkinPath = PortalSettings.ActiveTab.SkinSrc,
				skinFile = clientSkinPath.Substring(clientSkinPath.LastIndexOf('/') + 1);

			skinFile = skinFile.Remove(skinFile.IndexOf('.'));

			clientSkinPath = clientSkinPath.Remove(clientSkinPath.LastIndexOf('/') + 1);
			string themeName = clientSkinPath.Remove(clientSkinPath.LastIndexOf('/')),
				themePortal = themeName.Remove(themeName.LastIndexOf('/'));

			themeName = themeName.Substring(themeName.LastIndexOf('/') + 1);

			themePortal = themePortal.Remove(themePortal.LastIndexOf('/'));
			themePortal = themePortal.Substring(themePortal.LastIndexOf('/') + 1);

			Control cssPageControl = Page.FindControl("CSS");

			if (cssPageControl == null || Page.Header.FindControl(ID) != null)
				return;


			UserInfo user = (UserInfo) Context.Items["UserInfo"];

			MetaDefinition meta = MetaDefinition.MetaFromFolder(
				Server.MapPath(clientSkinPath) + "StyleWizard\\",
				true,
				(user != null && (user.IsSuperUser || user.IsInRole(PortalSettings.AdministratorRoleName)))
			);

			if (meta == null)
				return;

			AdditionalObjectResources themeObjectResources = meta.GetAdditionalObjectResources(
				PortalSettings.PortalId.ToString(),
				skinFile,
				"eds_skin_" + themeName,
				clientSkinPath + meta.assetsClientPath
			);

			foreach (HtmlLink linkControl in themeObjectResources.css)
			{
				if (Page.Header.FindControl(linkControl.ID) == null)
					cssPageControl.Controls.Add(linkControl);
			}

			ActiveStyle activeStyle = meta.GetActiveStyle(PortalSettings.PortalId, skinFile);

			if (activeStyle.type == "predefined" && activeStyle.id == "default")
				return;

			string id = String.Concat(
				"skinStyleCss_",
				(themePortal == "_default" ? "" : themePortal + "_"),
				themeName,
				"_style_",
				activeStyle.type, "_", activeStyle.id
			);
			string href = String.Concat(
				clientSkinPath,
				meta.assetsClientPath,
				"css/",
				activeStyle.type,
				"/",
				activeStyle.id,
				".css"
			);

			cssPageControl.Controls.Add(Utility.CreateCssLinkControl(id, href));
		}

	}
}