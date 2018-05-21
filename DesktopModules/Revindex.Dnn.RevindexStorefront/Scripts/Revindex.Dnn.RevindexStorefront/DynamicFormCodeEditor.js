//
// Requires Revindex/Global.js
//

var Revindex = Revindex || {};
Revindex.Dnn = Revindex.Dnn || {};
Revindex.Dnn.RevindexStorefront = Revindex.Dnn.RevindexStorefront || {};

function CodeDnnTreeView_Load(sender, eventArgs)
{
	try
	{
		sender._sourceTextBox = document.getElementById(sender.get_attributes().getAttribute("SourceCodeTextBoxID"));
		RenderDesignFromSource(sender, sender._sourceTextBox);
	}
	catch (ex)
	{
		document.getElementById(sender.get_attributes().getAttribute("SummaryLabelID")).innerHTML = "Syntax error in the XML is preventing the designer from loading. Please correct the error in the source view. " + ex.message;
	}
}

function CodeTextBox_Change(sender)
{
	var summaryLabel = document.getElementById($find(sender.getAttribute("DesignTreeViewID")).get_attributes().getAttribute("SummaryLabelID"));
	summaryLabel.innerHTML = "";
	try
	{
		RenderDesignFromSource($find(sender.getAttribute("DesignTreeViewID")), sender)
	}
	catch (ex)
	{
		summaryLabel.innerHTML = "Syntax error in the XML is preventing the designer from loading. Please correct the error in the source view. " + ex.message;
	}
}

function CodeDnnTreeView_ClientNodeDropping(sender, eventArgs) 
{
	TreeViewDroppingHandler(sender, eventArgs);
}

function CodeDnnTreeView_ClientContextMenuShowing(sender, eventArgs)
{
	sender.unselectAllNodes();
	var treeNode = eventArgs.get_node();
    treeNode.set_selected(true);

	var menu = eventArgs.get_menu();
	menu.get_items().clear();

	// Add operations
	var addMenuItem = new Telerik.Web.UI.RadMenuItem();
	addMenuItem.set_text("Add");
	menu.get_items().add(addMenuItem);

	if (treeNode.get_attributes().getAttribute("____type").match(/[e]/i) != null)
	{
		if (treeNode.get_value().indexOf("asp:") == 0)
			treeNode.AspDefinition = aspElements[treeNode.get_value()];

		var newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Attributes");
		addMenuItem.get_items().add(newMenuItem);

		if (treeNode.AspDefinition != null)
		{
			for (var i in treeNode.AspDefinition.Attributes)
			{
				if (treeNode.get_attributes().getAttribute('___' + treeNode.AspDefinition.Attributes[i].Name) == null || treeNode.get_attributes().getAttribute('___' + treeNode.AspDefinition.Attributes[i].Name) == '___UNDEFINED___')
				{
					var newChildMenuItem = new Telerik.Web.UI.RadMenuItem();
					newChildMenuItem.set_text("Attribute \"" + treeNode.AspDefinition.Attributes[i].Name + "\"");
					newChildMenuItem.set_value("addattribute|" + '___' + treeNode.AspDefinition.Attributes[i].Name);
					newChildMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlAttributeIcon.gif"));
					newMenuItem.get_items().add(newChildMenuItem);
				}
			}
		}
		
		var newChildMenuItem = new Telerik.Web.UI.RadMenuItem();
		newChildMenuItem.set_text("Custom attribute");
		newChildMenuItem.set_value("addattribute|");
		newChildMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlAttributeIcon.gif"));
		newMenuItem.get_items().add(newChildMenuItem);

		if (treeNode.AspDefinition == null || jQuery.inArray("", treeNode.AspDefinition.AllowableChildElements) >= 0)
		{
			newMenuItem = new Telerik.Web.UI.RadMenuItem();
			newMenuItem.set_text("Comment");
			newMenuItem.set_value("addcomment|");
			newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlCommentIcon.gif"));
			addMenuItem.get_items().add(newMenuItem);
		}

		newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Controls");
		addMenuItem.get_items().add(newMenuItem);

			// Add allowable controls
			for (var i in aspElements)
			{
				// If tree node is an XSL element, only allow parent and child elements that are allowed by the definition.
				if (treeNode.AspDefinition != null)
				{
					if (jQuery.inArray(treeNode.get_value(), aspElements[i].AllowableParentElements) < 0)
						continue;

					if (jQuery.inArray(aspElements[i].Name, treeNode.AspDefinition.AllowableChildElements) < 0)
						continue;
				}
				else
				{
					if (jQuery.inArray('', aspElements[i].AllowableParentElements) < 0)
						continue;
				}

				var newChildMenuItem = new Telerik.Web.UI.RadMenuItem();
				newChildMenuItem.set_text(aspElements[i].Name + ' - ' + aspElements[i].Description);
				newChildMenuItem.set_value("addcontrol|" + aspElements[i].Name);
				newChildMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddAspElementIcon.gif"));
				newMenuItem.get_items().add(newChildMenuItem);
			}

		// Hide node if there are no active child items
		if (!HaveActiveChildMenuItems(newMenuItem))
			newMenuItem.hide();

		if (treeNode.AspDefinition == null || jQuery.inArray("", treeNode.AspDefinition.AllowableChildElements) >= 0)
		{

			newMenuItem = new Telerik.Web.UI.RadMenuItem();
			newMenuItem.set_text("Element");
			newMenuItem.set_value("addelement|");
			newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlElementIcon.gif"));
			addMenuItem.get_items().add(newMenuItem);

			//newMenuItem = new Telerik.Web.UI.RadMenuItem();
			//newMenuItem.set_text("Unparsed character data");
			//newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlCDataIcon.gif"));
			//addMenuItem.get_items().add(newMenuItem);
		}

		// Only add value type if tree node permits
		if (treeNode.AspDefinition == null || jQuery.inArray("", treeNode.AspDefinition.AllowableChildElements) >= 0)
		{
			newMenuItem = new Telerik.Web.UI.RadMenuItem();
			newMenuItem.set_text("Text");
			newMenuItem.set_value("addtext|");
			newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlTextIcon.gif"));
			addMenuItem.get_items().add(newMenuItem);
		}		
	}

	// Hide node if there are no active child items
	if (!HaveActiveChildMenuItems(addMenuItem))
		addMenuItem.hide();

	// Edit operations
	var editMenuItem = new Telerik.Web.UI.RadMenuItem();
	editMenuItem.set_text("Edit");
	menu.get_items().add(editMenuItem);

	if (treeNode.get_attributes().getAttribute("____type") == "e")
	{
		for (var attrName in treeNode.get_attributes()._data)
		{
			if (attrName != "____type" && treeNode.get_attributes().getAttribute(attrName) != '___UNDEFINED___')
			{
				var newMenuItem = new Telerik.Web.UI.RadMenuItem();
				newMenuItem.set_text("Attribute \"" + attrName.substring(3) + "\"");
				newMenuItem.set_value("editattribute|" + attrName);
				newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/EditXmlAttributeIcon.gif"));
				editMenuItem.get_items().add(newMenuItem);
			}
		}

		if (treeNode.get_value().indexOf("xsl:") < 0)
		{
			var newMenuItem = new Telerik.Web.UI.RadMenuItem();
			newMenuItem.set_text("Name");
			newMenuItem.set_value("editname|");
			newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/EditXmlElementIcon.gif"));
			editMenuItem.get_items().add(newMenuItem);
		}
	}
	else if (treeNode.get_attributes().getAttribute("____type") == "t")
	{
		var newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Text");
		newMenuItem.set_value("edittext|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/EditXmlTextIcon.gif"));
		editMenuItem.get_items().add(newMenuItem);
	}
	else if (treeNode.get_attributes().getAttribute("____type") == "c")
	{
		var newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Comment");
		newMenuItem.set_value("editcomment|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/EditXmlCommentIcon.gif"));
		editMenuItem.get_items().add(newMenuItem);
	}
	else if (treeNode.get_attributes().getAttribute("____type") == "d")
	{
		var newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Unparsed character data");
		newMenuItem.set_value("editcdata|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/EditXmlCDataIcon.gif"));
		editMenuItem.get_items().add(newMenuItem);
	}

	// Hide node if there are no active child items
	if (!HaveActiveChildMenuItems(editMenuItem))
		editMenuItem.hide();


	// Remove operations
	var removeMenuItem = new Telerik.Web.UI.RadMenuItem();
	removeMenuItem.set_text("Remove");
	menu.get_items().add(removeMenuItem);

	if (treeNode.get_attributes().get_count() > 0)
	{
		for (var attrName in treeNode.get_attributes()._data)
		{
			if (attrName != "____type" && treeNode.get_attributes().getAttribute(attrName) != '___UNDEFINED___')
			{
				var newMenuItem = new Telerik.Web.UI.RadMenuItem();
				newMenuItem.set_text("Attribute \"" + attrName.substring(3) + "\"");
				newMenuItem.set_value("removeattribute|" + attrName);
				newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/RemoveXmlAttributeIcon.gif"));
				removeMenuItem.get_items().add(newMenuItem);
			}
		}
	}

	var newMenuItem = new Telerik.Web.UI.RadMenuItem();
	newMenuItem.set_text("Node");
	newMenuItem.set_value("removenode|");
	newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/RemoveXmlNodeIcon.gif"));
	removeMenuItem.get_items().add(newMenuItem);

    // Collapse all
	var collapseMenuItem = new Telerik.Web.UI.RadMenuItem();
	collapseMenuItem.set_text("Collapse all");
	collapseMenuItem.set_value("collapseall|");
	menu.get_items().add(collapseMenuItem);

    // Expand all
	var expandMenuItem = new Telerik.Web.UI.RadMenuItem();
	expandMenuItem.set_text("Expand all");
	expandMenuItem.set_value("expandall|");
	menu.get_items().add(expandMenuItem);
}

function CodeDnnTreeView_ClientContextMenuClicked(sender, eventArgs)
{
	DnnTreeViewClientContextMenuClickedHandler(sender, eventArgs);
}