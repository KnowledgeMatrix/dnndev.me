<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductSearchConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductSearchConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Product search</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Product Search module."/>
			<uc1:DisplayTemplateDropDownListControl ID="ProductSearchDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductSearchDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductSearchDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchResultsMaxLabelControl" runat="server" Text="Max results:" HelpText="Limit the maximum number of results to return to improve query performance. Enter a very large number if you don't want to limit the number of results returned."/>
			<asp:RequiredFieldValidator ID="ProductSearchResultsMaxRequiredFieldValidator" runat="server" ControlToValidate="ProductSearchResultsMaxDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max results is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductSearchResultsMaxDnnNumericTextBox" runat="server" Skin="" Value="100" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchNameSearchableLabelControl" runat="server" Text="Name searchable:" />
			<asp:CheckBox ID="ProductSearchNameSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchOverviewSearchableLabelControl" runat="server" Text="Overview searchable:" />
			<asp:CheckBox ID="ProductSearchOverviewSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchSummarySearchableLabelControl" runat="server" Text="Summary searchable:" />
			<asp:CheckBox ID="ProductSearchSummarySearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchSpecificationsSearchableLabelControl" runat="server" Text="Specifications searchable:" />
			<asp:CheckBox ID="ProductSearchSpecificationsSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchTermsSearchableLabelControl" runat="server" Text="Terms searchable:" />
			<asp:CheckBox ID="ProductSearchTermsSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchFAQSearchableLabelControl" runat="server" Text="FAQ searchable:" />
			<asp:CheckBox ID="ProductSearchFAQSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchBuyingGuideSearchableLabelControl" runat="server" Text="Buying guide searchable:" />
			<asp:CheckBox ID="ProductSearchBuyingGuideSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductSearchSKUSearchableLabelControl" runat="server" Text="SKU searchable:" />
			<asp:CheckBox ID="ProductSearchSKUSearchableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="ProductSearchPhraseOperatorLabelControl" runat="server" Text="Default phrase operator:" HelpText="The logical boolean operator that should be used to combine separate search phrases together." />
            <asp:RadioButtonList ID="ProductSearchPhraseOperatorRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons">
                <asp:ListItem Text="AND" Value="AND" ></asp:ListItem>
                <asp:ListItem Text="OR" Value="OR" Selected="True"></asp:ListItem>
            </asp:RadioButtonList>
        </div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
