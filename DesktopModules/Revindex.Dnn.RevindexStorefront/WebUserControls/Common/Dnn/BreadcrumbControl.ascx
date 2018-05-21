<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BreadcrumbControl.ascx.cs" Inherits="Revindex.Web.UI.WebUserControls.Dnn.BreadcrumbControl" %>
<ul class="rvdBreadcrumb">
<asp:Repeater ID="BreadcrumbRepeater" runat="server">
	<ItemTemplate>
		<li><a href='<%# Eval("Value") %>'><%# Eval("Text") %></a></li>
	</ItemTemplate>
</asp:Repeater>
</ul>