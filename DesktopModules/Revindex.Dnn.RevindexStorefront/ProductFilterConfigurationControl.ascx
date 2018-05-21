<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductFilterConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductFilterConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>Product filter</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Product Filter module."/>
			<uc1:DisplayTemplateDropDownListControl ID="ProductFilterDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductFilterDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductFilterDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterDistributorFilterableLabelControl" runat="server" Text="Distributor filterable:" />
			<asp:CheckBox ID="ProductFilterDistributorFilterableCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterDistributorDisplayOrderLabelControl" runat="server" Text="Distributor display order:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="ProductFilterDistributorDisplayOrderRequiredFieldValidator" runat="server" ControlToValidate="ProductFilterDistributorDisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductFilterDistributorDisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterManufacturerFilterableLabelControl" runat="server" Text="Manufacturer filterable:" />
			<asp:CheckBox ID="ProductFilterManufacturerFilterableCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterManufacturerDisplayOrderLabelControl" runat="server" Text="Manufacturer display order:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="ProductFilterManufacturerDisplayOrderRequiredFieldValidator" runat="server" ControlToValidate="ProductFilterManufacturerDisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductFilterManufacturerDisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterSellerFilterableLabelControl" runat="server" Text="Seller filterable:" />
			<asp:CheckBox ID="ProductFilterSellerFilterableCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterSellerDisplayOrderLabelControl" runat="server" Text="Seller display order:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="ProductFilterSellerDisplayOrderRequiredFieldValidator" runat="server" ControlToValidate="ProductFilterSellerDisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductFilterSellerDisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterPriceFilterableLabelControl" runat="server" Text="Price filterable:" />
			<asp:CheckBox ID="ProductFilterPriceFilterableCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterPriceStepSizeLabelControl" runat="server" Text="Price step size:" HelpText="The step size determines the incremental amount of value that will change when moving between the numeric range." />
			<asp:RequiredFieldValidator ID="ProductFilterPriceStepSizeRequiredFieldValidator" runat="server" ControlToValidate="ProductFilterPriceStepSizeDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Step size is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductFilterPriceStepSizeDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="1" NumberFormat-GroupSizes="9" MinValue="0.1" EnableSingleInputRendering="False" Value="1.0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductFilterPriceDisplayOrderLabelControl" runat="server" Text="Price display order:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="ProductFilterPriceDisplayOrderRequiredFieldValidator" runat="server" ControlToValidate="ProductFilterPriceDisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ProductFilterPriceDisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
