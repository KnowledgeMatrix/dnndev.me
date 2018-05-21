//
// Requires Revindex/Global.js
//

var Revindex = Revindex || {};
Revindex.Dnn = Revindex.Dnn || {};
Revindex.Dnn.RevindexStorefront = Revindex.Dnn.RevindexStorefront || {};

function XmlDnnTreeView_Load(sender, eventArgs)
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

function XmlTextBox_Change(sender)
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

function XmlDnnTreeView_ClientNodeDropping(sender, eventArgs) 
{
	var destinationNode = eventArgs.get_destNode();
	var sourceNode = eventArgs.get_sourceNode();

	if (destinationNode != null && sourceNode.get_treeView() == destinationNode.get_treeView())
	{
		// Drag and drop to within same tree
		TreeViewDroppingHandler(sender, eventArgs);
	}
	else
	{
		// Drag and drop to a text box
		var target = eventArgs.get_htmlElement();
		var treeNode = eventArgs.get_sourceNode();

		if (target.tagName == 'TEXTAREA' && treeNode.get_attributes().getAttribute('____type') == 'e')
		{
			// Insert at caret position
			if (document.selection) 
			{ 
				target.focus(); 
				var sel = document.selection.createRange(); 
				sel.text = GetTreeValuePathFromTreeNode(eventArgs.get_sourceNode()); 
				target.focus(); 
			} 
			else if (target.selectionStart || target.selectionStart == '0') 
			{ 
				var startPos = target.selectionStart; 
				var endPos = target.selectionEnd; 
				var scrollTop = target.scrollTop; 
				target.value = target.value.substring(0, startPos) + GetTreeValuePathFromTreeNode(eventArgs.get_sourceNode()) + target.value.substring(endPos, target.value.length); 
				target.focus(); 
				target.selectionStart = startPos + eventArgs.get_sourceNode().get_value().length; 
				target.selectionEnd = startPos + eventArgs.get_sourceNode().get_value().length; 
				target.scrollTop = scrollTop; 
			} 
			else 
			{ 
				target.value += GetTreeValuePathFromTreeNode(eventArgs.get_sourceNode()); 
				target.focus(); 
			}
		}
	}
}

function XmlDnnTreeView_ClientContextMenuShowing(sender, eventArgs)
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
		var newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Custom attribute");
		newMenuItem.set_value("addattribute|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlAttributeIcon.gif"));
		addMenuItem.get_items().add(newMenuItem);

		newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Comment");
		newMenuItem.set_value("addcomment|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlCommentIcon.gif"));
		addMenuItem.get_items().add(newMenuItem);

		newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Element");
		newMenuItem.set_value("addelement|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlElementIcon.gif"));
		addMenuItem.get_items().add(newMenuItem);

		newMenuItem = new Telerik.Web.UI.RadMenuItem();
		newMenuItem.set_text("Text");
		newMenuItem.set_value("addtext|");
		newMenuItem.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AddXmlTextIcon.gif"));
		addMenuItem.get_items().add(newMenuItem);
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

function XmlDnnTreeView_ClientContextMenuClicked(sender, eventArgs)
{
	DnnTreeViewClientContextMenuClickedHandler(sender, eventArgs)
}
