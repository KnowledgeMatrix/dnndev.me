<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductComparisonConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductComparisonConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>Product comparison</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductComparisonDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Product Comparison module."/>
			<uc1:DisplayTemplateDropDownListControl ID="ProductComparisonDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductComparisonDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductComparisonDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxProductsLabelControl" runat="server" Text="Max products:" HelpText="Specify the maximum number of products to compare between 2 to 8." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="MaxProductsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max products is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="MaxProductsRangeValidator" runat="server" ControlToValidate="MaxProductsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="8" MinimumValue="2" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Max products is invalid.</asp:RangeValidator>
			<asp:TextBox ID="MaxProductsTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SkuShowLabelControl" runat="server" Text="Show SKU:" />
			<asp:CheckBox ID="SkuShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>