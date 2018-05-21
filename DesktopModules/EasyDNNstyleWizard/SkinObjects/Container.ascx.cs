#define EDNConCompDirDNN62
using System;
using System.IO;
using System.Web.UI;

using DotNetNuke.Entities.Modules;
using DotNetNuke.UI.Skins;

using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard;
using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard.Collection.Subject;
using EasyDNNSolutions.EasyDNNstyleWizard.Library;
using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard.Collection.StyleGroup;
using System.Web.UI.HtmlControls;
using DotNetNuke.Entities.Users;
using EasyDNNSolutions.EasyDNNstyleWizard.Library.StyleWizard.Meta;

namespace EasyDNNSolutions.EasyDNNstyleWizard.StyleWizard.SkinObjects
{
	public partial class Container : SkinObjectBase
	{

		public string templateGroup { get; set; }

		protected override void OnLoad(EventArgs onloadEvent)
		{
			base.OnLoad(onloadEvent);
#if EDNConCompDirDNN62
			ModuleInfo moduleInfo = ModuleControl.ModuleContext.Configuration;
#else
			ModuleInfo moduleInfo = DotNetNuke.UI.Containers.Container.GetPortalModuleBase(this).ModuleConfiguration;
#endif

			if (moduleInfo.IsDeleted)
				return;

			UserInfo user = (UserInfo) Context.Items["UserInfo"];

			MetaDefinition meta = MetaDefinition.MetaFromFolder(
				Server.MapPath(moduleInfo.ContainerPath) + "StyleWizard\\",
				true,
				(user != null && (user.IsSuperUser || user.IsInRole(PortalSettings.AdministratorRoleName)))
			);

			if
			(
				meta == null ||
				String.IsNullOrEmpty(moduleInfo.ContainerSrc) ||
				!moduleInfo.ContainerSrc.Contains("/") ||
				String.IsNullOrEmpty(moduleInfo.ContainerPath)
			)
				return;

			string containerFilename = moduleInfo.ContainerSrc.Substring(moduleInfo.ContainerSrc.LastIndexOf('/') + 1),
				containerTheme = moduleInfo.ContainerPath.Remove(moduleInfo.ContainerPath.Length - 1);

			if (!containerTheme.Contains("/"))
				return;

			string containerPortalFolderName = containerTheme.Remove(containerTheme.LastIndexOf('/'));

			if (!containerPortalFolderName.Contains("/"))
				return;

			containerPortalFolderName = containerPortalFolderName.Remove(containerPortalFolderName.LastIndexOf('/'));
			containerPortalFolderName = containerPortalFolderName.Substring(containerPortalFolderName.LastIndexOf('/') + 1);

			containerTheme = containerTheme.Substring(containerTheme.LastIndexOf('/') + 1);

			if (containerFilename.Contains("."))
				containerFilename = containerFilename.Remove(containerFilename.IndexOf('.'));

			ActiveStyle activeStyle = meta.GetActiveStyle(PortalSettings.PortalId, containerFilename);

			if (String.IsNullOrEmpty(templateGroup))
				templateGroup = "default";

			containerClass.Text = String.Concat(
				"eds_containers_", containerTheme,
				" eds_templateGroup_", templateGroup,
				" eds_template_", containerFilename,
				(activeStyle.type != "predefined" || activeStyle.id != "default" ? " eds_style_" + activeStyle.type + "_" + activeStyle.id : "")
			);

			string containerDirectoryPath = Server.MapPath(moduleInfo.ContainerPath);

			Control cssPageControl = Page.FindControl("CSS");

			if (cssPageControl == null || Page.Header.FindControl(ID) != null)
				return;

			AdditionalObjectResources themeObjectResources = meta.GetAdditionalObjectResources(
				PortalSettings.PortalId.ToString(),
				containerFilename,
				"eds_skin_" + containerTheme,
				moduleInfo.ContainerPath + meta.assetsClientPath
			);

			foreach (HtmlLink linkControl in themeObjectResources.css)
			{
				if (Page.Header.FindControl(linkControl.ID) == null)
					cssPageControl.Controls.Add(linkControl);
			}

			if (!File.Exists(containerDirectoryPath + "StyleWizard\\developerMode") && File.Exists(containerDirectoryPath + "container.css"))
				return;

			new ContainerController(
				containerTheme,
				containerPortalFolderName,
				PortalSettings.HomeDirectoryMapPath,
				PortalSettings.HomeDirectory,
				PortalSettings,
				user
			)
				.rebuildCss();

			cssPageControl.Controls.Add(Utility.CreateCssLinkControl(
				containerPortalFolderName + "_" + containerTheme + "_containers",
				moduleInfo.ContainerPath + "container.css"
			));
		}

	}
}