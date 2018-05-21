<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductSearch.Standard2.Display" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<asp:Panel ID="SearchFormPanel" runat="server" DefaultButton="SearchLinkButton" Width="100%" CssClass="rvdsfProductSearchContainer">
	<asp:TextBox ID="QueryTextBox" runat="server" CssClass="rvdsfProductSearchQueryTextBox"></asp:TextBox>
	<asp:LinkButton ID="SearchLinkButton" runat="server" OnClick="SearchLinkButton_Click" resourcekey="SearchLinkButton" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction">
	</asp:LinkButton>
</asp:Panel>
