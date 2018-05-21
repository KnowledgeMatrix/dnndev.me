<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefront.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefront" %>
<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<a id="RvdsfContentAnchor" name="RvdsfContentAnchor" class="rvdModuleStartAnchor"></a>
<asp:UpdateProgress ID="UpdateProgress" runat="server">
	<ProgressTemplate>
		<div class="rvdUpdateProgressContainer">
			<asp:Image ID="UpdateProgressImage" runat="server" ImageUrl="~/Images/Loading.gif" CssClass="rvdUpdateProgress" />
		</div>
	</ProgressTemplate>
</asp:UpdateProgress>
<dnn2:DnnMenu ID="MainDnnMenu" runat="server" EnableShadows="true" Width="100%" Skin="Default" CssClass="rvdsfMenu" EnableViewState="False" RenderMode="Lightweight" />
<dnn2:DnnPanelBar ID="MainDnnPanelBar" runat="server" Width="100%" CssClass="rvdsfPanelBar" EnableViewState="False" ExpandMode="MultipleExpandedItems" />
<div class="rvdsfContentContainer">
	<asp:Panel ID="WelcomePanel" runat="server" Visible="false" style="text-align:center; border-bottom: 1px solid #828282; margin-top: -20px; margin-bottom: 10px; padding-top: 20px; background-color: #eee ">
		<div style="margin:10px 10px; font-weight:bold">Your store is almost ready. Follow the setup wizard below to start quickly.</div>
		<ul class="rvdsfWelcomeSteps">
			<li><asp:HyperLink ID="GeneralWelcomeHyperLink" runat="server" EnableViewState="False">1. Features</asp:HyperLink></li>
			<li><asp:HyperLink ID="TaxesWelcomeHyperLink" runat="server" EnableViewState="False">2. Taxes</asp:HyperLink></li>
			<li><asp:HyperLink ID="PaymentWelcomeHyperLink" runat="server" EnableViewState="False">3. Payment</asp:HyperLink></li>
			<li><asp:HyperLink ID="ProductsWelcomeHyperLink" runat="server" EnableViewState="False">4. Products</asp:HyperLink></li>
			<li><asp:LinkButton ID="DoneWelcomeLinkButton" runat="server" Text="" OnClick="DoneWelcomeLinkButton_Click"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span> Close</asp:LinkButton></li>
		</ul>
	</asp:Panel>
	<asp:PlaceHolder ID="ContentPlaceHolder" runat="server"></asp:PlaceHolder>
</div>
