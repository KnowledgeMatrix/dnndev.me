<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Category.Standard3.Display" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfCategoryContainer">
	<dnn2:DnnTreeView ID="CategoryDnnTreeView" runat="server" ShowLineImages="false" CssClass="rvdsfCategoryTreeView" Skin="">
		<NodeTemplate>
			<a href='<%# DataBinder.Eval(Container, "NavigateUrl") %>'>
				<%# DataBinder.Eval(Container, "Text") %></a>
		</NodeTemplate>
	</dnn2:DnnTreeView>
</div>