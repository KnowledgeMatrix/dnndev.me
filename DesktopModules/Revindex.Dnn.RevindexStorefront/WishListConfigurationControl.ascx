<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WishListConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WishListConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Wish list</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="WishListAddToCartInPlaceLabelControl" runat="server" Text="Add to cart in-place:" HelpText="Adding product to cart will stay on the same page." />
			<asp:CheckBox ID="WishListAddToCartInPlaceCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="WishListDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Wish List module."/>
			<uc1:DisplayTemplateDropDownListControl ID="WishListDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="WishListDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="WishListDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
