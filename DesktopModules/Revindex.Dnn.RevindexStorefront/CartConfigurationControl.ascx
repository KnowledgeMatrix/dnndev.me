<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CartConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Cart</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartAbandonTimeoutLabelControl" runat="server" Text="Cart abandon timeout:" HelpText="The amount of time in seconds when a cart is considered abandoned." CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="CartAbandonTimeoutRequiredFieldValidator" runat="server" ControlToValidate="CartAbandonTimeoutDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Session timeout is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="CartAbandonTimeoutDnnNumericTextBox" runat="server" Skin="" Value="1200" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Cart module." />
			<uc1:DisplayTemplateDropDownListControl ID="CartDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="CartDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="CartDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartContinueShoppingNavigateUrlLabelControl" runat="server" Text="Continue shopping target:" HelpText="Determine the shopping should resume from which page." />
			<asp:DropDownList ID="CartContinueShoppingNavigateUrlDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CartContinueShoppingNavigateUrlDropDownList_SelectedIndexChanged">
				<asp:ListItem Text="Default product list page" Value="" />
				<asp:ListItem Text="Last viewed product detail page" Value="LastViewedProductDetailPage" />
				<asp:ListItem Text="Last viewed product list page" Value="LastViewedProductListPage" />
				<asp:ListItem Text="Custom page" Value="CustomPage" />
			</asp:DropDownList>
		</div>
		<asp:Panel CssClass="dnnFormItem" ID="CartContinueShoppingNavigateUrlPanel" runat="server" Visible="false">
			<dnn1:LabelControl ID="SelectPageLabelControl" runat="server" Text="Select page:" />
			<dnn1:UrlControl ID="CartContinueShoppingNavigateUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="false" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowUsers="false" ></dnn1:UrlControl>
		</asp:Panel>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartSessionTimeoutLabelControl" runat="server" HelpText="The number of seconds before the cart session is expired. This is a sliding expiry." Text="Session timeout:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="CartSessionTimeoutRequiredFieldValidator" runat="server" ControlToValidate="CartSessionTimeoutDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Session timeout is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="CartSessionTimeoutDnnNumericTextBox" runat="server" Skin="" Value="1200" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartSessionLogoutLabelControl" runat="server" HelpText="Clear cart session if user logged out from the site." Text="Session logout:" />
			<asp:CheckBox ID="CartSessionLogoutCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CartCouponShowLabelControl" runat="server" Text="Show coupon:" HelpText="Allow entering coupon code." />
            <asp:CheckBox ID="CartCouponShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CartEstimateShippingTaxShowLabelControl" runat="server" Text="Show estimate shipping and taxes:" HelpText="Allow shipping and tax estimation." />
            <asp:CheckBox ID="CartEstimateShippingTaxShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
	</ul>
</div>
