<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Manufacturer.Standard2.Display" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfManufacturerContainer">
	<dnn2:DnnTreeView ID="ManufacturerDnnTreeView" runat="server" ShowLineImages="false" CssClass="rvdsfManufacturerTreeView" Skin="">
		<NodeTemplate>
			<a href='<%# DataBinder.Eval(Container, "NavigateUrl") %>'>
				<%# DataBinder.Eval(Container, "Text") %></a>
		</NodeTemplate>
	</dnn2:DnnTreeView>
</div>
