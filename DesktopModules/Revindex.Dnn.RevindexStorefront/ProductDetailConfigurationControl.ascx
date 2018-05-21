<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductDetailConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductDetailConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Product detail</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailDisplayTemplateLabelControl" runat="server" Text="Display template:"  HelpText="The selected display template determines how to display the Product Detail module." />
			<uc1:DisplayTemplateDropDownListControl ID="ProductDetailDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductDetailDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductDetailDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailAddToCartInPlaceLabelControl" runat="server" Text="Add to cart in-place:" HelpText="Adding product to cart will stay on the same page." />
			<asp:CheckBox ID="ProductDetailAddToCartInPlaceCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailInventoryShowLabelControl" runat="server" Text="Show inventory:" />
			<asp:CheckBox ID="ProductDetailInventoryShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailSKUShowLabelControl" runat="server" Text="Show SKU:" />
			<asp:CheckBox ID="ProductDetailSKUShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailPriceShowLabelControl" runat="server" Text="Show price:" HelpText="Show price on product detail module." />
			<asp:CheckBox ID="ProductDetailPriceShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailQuantityShowLabelControl" runat="server" Text="Show quantity:" HelpText="Show quantity on product detail module." />
			<asp:CheckBox ID="ProductDetailQuantityShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailMSRPShowLabelControl" runat="server" Text="Show MSRP:" HelpText="Show MSRP on product detail module." />
			<asp:CheckBox ID="ProductDetailMSRPShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailSavingsShowLabelControl" runat="server" Text="Show savings:" HelpText="Show savings on product detail module." />
			<asp:CheckBox ID="ProductDetailSavingsShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailRewardPointsShowLabelControl" runat="server" Text="Show reward points:" HelpText="Show reward points on product detail module." />
			<asp:CheckBox ID="ProductDetailRewardPointsShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailAddToCartShowLabelControl" runat="server" Text="Show Add to Cart button:" HelpText="Show Add to Cart button on product detail module." />
			<asp:CheckBox ID="ProductDetailAddToCartShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailBuyNowShowLabelControl" runat="server" Text="Show Buy Now button:" HelpText="Show Buy Now button on product detail module." />
			<asp:CheckBox ID="ProductDetailBuyNowShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailAddToWishListShowLabelControl" runat="server" Text="Show Add to Wish List button:" HelpText="Show Add to Wish List button on product detail module." />
			<asp:CheckBox ID="ProductDetailAddToWishListShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailUpdateShowLabelControl" runat="server" Text="Show Update button:" HelpText="Show Update button on product detail module." />
			<asp:CheckBox ID="ProductDetailUpdateShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailViewCartShowLabelControl" runat="server" Text="Show View Cart button:" HelpText="Show View Cart button on product detail module." />
			<asp:CheckBox ID="ProductDetailViewCartShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailContinueShoppingShowLabelControl" runat="server" Text="Show Continue Shopping button:" HelpText="Show Continue Shopping button on product detail module." />
			<asp:CheckBox ID="ProductDetailContinueShoppingShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailContinueShoppingNavigateUrlLabelControl" runat="server" Text="Continue shopping target:" HelpText="Determine the shopping should resume from which page." />
			<asp:DropDownList ID="ProductDetailContinueShoppingNavigateUrlDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ProductDetailContinueShoppingNavigateUrlDropDownList_SelectedIndexChanged">
				<asp:ListItem Text="Default product list page" Value="" />
				<asp:ListItem Text="Last viewed product list page" Value="LastViewedProductListPage" />
				<asp:ListItem Text="Custom page" Value="CustomPage" />
			</asp:DropDownList>
		</div>
		<asp:Panel CssClass="dnnFormItem" ID="ProductDetailContinueShoppingNavigateUrlPanel" runat="server" Visible="false">
			<dnn1:LabelControl ID="SelectPageLabelControl" runat="server" Text="Select page:" />
			<dnn1:UrlControl ID="ProductDetailContinueShoppingNavigateUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="false" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowUsers="false" ></dnn1:UrlControl>
		</asp:Panel>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductDetailSocialShareShowLabelControl" runat="server" Text="Show social share buttons:" HelpText="Show social share buttons on product detail module." />
			<asp:CheckBox ID="ProductDetailSocialShareShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
