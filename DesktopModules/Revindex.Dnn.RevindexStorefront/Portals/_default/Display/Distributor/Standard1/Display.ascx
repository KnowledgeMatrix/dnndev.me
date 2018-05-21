<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Distributor.Standard1.Display" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfDistributorContainer">
	<dnn2:DnnTreeView ID="DistributorDnnTreeView" runat="server" ShowLineImages="false" CssClass="rvdsfDistributorTreeView" Skin="">
		<NodeTemplate>
			<a href='<%# DataBinder.Eval(Container, "NavigateUrl") %>'>
				<%# DataBinder.Eval(Container, "Text") %></a>
		</NodeTemplate>
	</dnn2:DnnTreeView>
</div>
