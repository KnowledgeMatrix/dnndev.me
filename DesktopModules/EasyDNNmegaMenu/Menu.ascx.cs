using System;
using DotNetNuke.UI.Skins;
using DotNetNuke.UI.WebControls;
using DotNetNuke.UI;
using DdrLocaliser = DotNetNuke.Web.DDRMenu.Localisation.Localiser;
using System.Collections.Generic;
using EasyDNNSolutions.Modules.EasyDNNmegaMenu.Library.MegaMenu;
using System.Web.UI.WebControls;
using EasyDNNSolutions.Modules.EasyDNNmegaMenu.Library;
using System.Data;
using EasyDNNSolutions.Modules.EasyDNNmegaMenu.Library.Db;
using Newtonsoft.Json;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Host;

namespace EasyDNNSolutions.Modules.EasyDNNmegaMenu.SkinObjects
{
	public partial class Menu : SkinObjectBase
	{

		protected override void OnLoad(EventArgs e)
		{
			base.OnLoad(e);

			DNNNodeCollection navigationNodes = Navigation.GetNavigationNodes(
				ClientID,
				Navigation.ToolTipSource.None,
				-1,
				-1,
				(int)Navigation.NavNodeOptions.IncludeSiblings + (int)Navigation.NavNodeOptions.IncludeSelf
			);

			navigationNodes = DdrLocaliser.LocaliseDNNNodeCollection(navigationNodes);
			string cacheKeyMegaMenuSettings = string.Format(Constants.SettingsCacheKey, PortalSettings.PortalId);
			DataSet existingSettingsSet = (DataSet)DataCache.GetCache(cacheKeyMegaMenuSettings);
			if (existingSettingsSet == null)
			{
				existingSettingsSet = new Database(
					QueryType.Select,
					"SELECT settingsJson " +
					"FROM [{{prefix}}portalSettings] " +
					"WHERE portalId = " + PortalSettings.PortalId
				)
				.Execute();
				DataCache.SetCache(cacheKeyMegaMenuSettings, existingSettingsSet, TimeSpan.FromMinutes(20 * Convert.ToInt32(Host.PerformanceSetting)));
			}

			MegaMenuDefinition megaMenuDefinition = null;
			Dictionary<string, Item> itemsMeta = null;
			JsonSerializerSettings dbJsonSettings = new JsonSerializerSettings
			{
				NullValueHandling = NullValueHandling.Ignore,
				TypeNameHandling = TypeNameHandling.Objects
			};

			if (existingSettingsSet.Tables[0].Rows.Count > 0)
			{
				try
				{
					megaMenuDefinition = JsonConvert.DeserializeObject<MegaMenuDefinition>(existingSettingsSet.Tables[0].Rows[0]["settingsJson"].ToString(), dbJsonSettings);
					itemsMeta = megaMenuDefinition.items;
				}
				catch
				{ }
			}

			int i = 0,
				l = navigationNodes.Count;

			if (l == 0)
				return;

			Controls.Add(
				new Literal
				{
					Text = "<ol>"
				}
			);

			for (; i < l; i++)
			{
				DNNNode node = navigationNodes[i];

				Item.RenderMarkup(node, 0, i == 0, i == l - 1, itemsMeta, this);
			}

			Controls.Add(
				new Literal
				{
					Text = "</ol>"
				}
			);
		}

	}
}