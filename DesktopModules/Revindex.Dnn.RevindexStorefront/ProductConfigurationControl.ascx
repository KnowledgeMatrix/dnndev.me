<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<h2>Product</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<script type="text/javascript">
	jQuery(function ($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="GeneralFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">General</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductReviewsAnonymousAccountActiveLabelControl" runat="server" Text="Allow anonymous reviews:" />
			<asp:CheckBox ID="ProductReviewsAnonymousAccountActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductReviewsModerationActiveLabelControl" runat="server" Text="Moderate reviews:" />
			<asp:CheckBox ID="ProductReviewsModerationActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductReviewsUserMaxReviewLabelControl" runat="server" Text="Max reviews per user:" />
			<asp:RequiredFieldValidator ID="ProductReviewsUserMaxReviewRequiredFieldValidator" runat="server" ControlToValidate="ProductReviewsUserMaxReviewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max reviews is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductReviewsUserMaxReviewDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1" Value="1" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
	</fieldset>
	<script type="text/javascript">
		$(document).ready(function ()
		{
			// Expand features section by default
			if (document.cookie.indexOf("FeaturesFormSectionHead") < 0)
				$("#FeaturesFormSectionHead > a").click();
		});
	</script>
	<h2 id="FeaturesFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Features</a></h2>
	<fieldset>
		<p>
			The Storefront has many powerful features to help you sell more. Enable just the right features you need to keep your site fast and streamlined.
		</p>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="LabelControl1" runat="server" Text="" />
			<a class="dnnTertiaryAction" href="#" onclick="$('.rvdsfFeaturesContainer').find('input').prop('checked', true); return false;">Select all</a>
			<a class="dnnTertiaryAction" href="#" onclick="$('.rvdsfFeaturesContainer').find('input').prop('checked', false); return false;">Deselect all</a>
			<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable other features" CssClass="dnnTertiaryAction" />
		</div>
		<div class="rvdsfFeaturesContainer">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductAttributeActiveLabelControl" runat="server" Text="Product attributes:" HelpText="Allow adding attributes usually intended for listing product specifications such dimensions, sizes, material, etc." />
				<asp:CheckBox ID="ProductAttributeActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductAvailabilityActiveLabelControl" runat="server" Text="Product availability:" HelpText="Allow configuring when this product should be available based on rules." />
				<asp:CheckBox ID="ProductAvailabilityActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductBookingActiveLabelControl" runat="server" Text="Booking products:" HelpText="Allow configuring booking products for reservations, hotels, events, etc." />
				<asp:CheckBox ID="ProductBookingActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductComponentActiveLabelControl" runat="server" Text="Bundled products:" HelpText="Allow configuring bundled products consisting of components and parts." />
				<asp:CheckBox ID="ProductComponentActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RelatedProductActiveLabelControl" runat="server" Text="Related products:" HelpText="Allow configuring related products." />
				<asp:CheckBox ID="RelatedProductActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RequiredProductActiveLabelControl" runat="server" Text="Required products:" HelpText="Allow configuring products that must be purchased together. (e.g. to include a setup fee)." />
				<asp:CheckBox ID="RequiredProductActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductDynamicFormActiveLabelControl" runat="server" Text="Custom fields:" HelpText="Allow configuring custom fields to capture additional information from customer." />
				<asp:CheckBox ID="ProductDynamicFormActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductExtensionActiveLabelControl" runat="server" Text="Extensions:" HelpText="Allow storing additional arbitrary data related to a product." />
				<asp:CheckBox ID="ProductExtensionActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductVariantGroupActiveLabelControl" runat="server" Text="Product variant groups:" HelpText="Allow grouping multiple variants by type (e.g. color or size)." />
				<asp:CheckBox ID="ProductVariantGroupActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductActionActiveLabelControl" runat="server" Text="Product actions:" HelpText="Allow executing an action (e.g. send email or grant role)" />
				<asp:CheckBox ID="ProductActionActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductReviewsActiveLabelControl" runat="server" Text="Product reviews:" HelpText="Allow managing product reviews." />
				<asp:CheckBox ID="ProductReviewsActiveCheckBox" runat="server" />
			</div>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
		<li>
			<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
		<li>
			<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
		</li>
	</ul>
</asp:Panel>
