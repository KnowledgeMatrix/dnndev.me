<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductListConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductListConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Product list</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListDisplayTemplateLabelControl" runat="server" Text="Display template:"  HelpText="The selected display template determines how to display the Product List module." />
			<uc1:DisplayTemplateDropDownListControl ID="ProductListDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductListDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductListDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListAddToCartInPlaceLabelControl" runat="server" Text="Add to cart in-place:" HelpText="Adding product to cart will stay on the same page." />
			<asp:CheckBox ID="ProductListAddToCartInPlaceCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListSortNaturalActiveLabelControl" runat="server" Text="Enable natural sort:" HelpText="By default, the alphanumeric sort follows the computer ordering of individual characters (e.g. A1, A10, A2, A3). If natural sort is enabled, the alphanumeric will follow the ordering that is more suitable for humans (e.g. A1, A2, A3, A10)." />
			<asp:CheckBox ID="ProductListSortNaturalActiveCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListResultsMaxLabelControl" runat="server" Text="Max results:" HelpText="Limit the maximum number of results to return to improve listing performance. Enter a very large number if you don't want to limit the number of results returned."/>
			<asp:RequiredFieldValidator ID="ProductListResultsMaxRequiredFieldValidator" runat="server" ControlToValidate="ProductListResultsMaxDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max results is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductListResultsMaxDnnNumericTextBox" runat="server" Skin="" Value="100" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListSubCategoryShowLabelControl" runat="server" Text="Show sub-categories:" HelpText="Show sub-categories on product list module." />
			<asp:CheckBox ID="ProductListSubCategoryShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListSummaryShowLabelControl" runat="server" Text="Show summary:" HelpText="Show summary on product list module." />
			<asp:CheckBox ID="ProductListSummaryShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListMSRPShowLabelControl" runat="server" Text="Show MSRP:" HelpText="Show Manufacturer Suggested Retail Price (MSRP) on product list module." />
			<asp:CheckBox ID="ProductListMSRPShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListPriceShowLabelControl" runat="server" Text="Show price:" HelpText="Show price on product list module." />
			<asp:CheckBox ID="ProductListPriceShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListQuantityShowLabelControl" runat="server" Text="Show quantity:" HelpText="Show quantity on product list module." />
			<asp:CheckBox ID="ProductListQuantityShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListSavingsShowLabelControl" runat="server" Text="Show savings:" HelpText="Show savings on product list module." />
			<asp:CheckBox ID="ProductListSavingsShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListAddToCartShowLabelControl" runat="server" Text="Show Add to Cart button:" HelpText="Show Add to Cart button on product list module." />
			<asp:CheckBox ID="ProductListAddToCartShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListBuyNowShowLabelControl" runat="server" Text="Show Buy Now button:" HelpText="Show Buy Now button on product list module." />
			<asp:CheckBox ID="ProductListBuyNowShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductListSeeDetailsShowLabelControl" runat="server" Text="Show See Details button:" HelpText="Show See Details button on product list module." />
			<asp:CheckBox ID="ProductListSeeDetailsShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
