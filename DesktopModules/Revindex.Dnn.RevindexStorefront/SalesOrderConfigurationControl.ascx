<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesOrderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesOrderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>
	Sales order</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SalesOrderMethodsPurchaseOrderActiveLabelControl" runat="server" Text="Enable purchase order:" />
			<asp:CheckBox ID="SalesOrderMethodsPurchaseOrderActiveCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SalesOrderSalesOrderNumberFormatLabelControl" runat="server" Text="Sales order number format:" HelpText="Change how your sales order number should be displayed by applying a string format where the {0} token is replaced with the actual number. E.g. if your format is &quot;INV-{0}&quot;, the customer will see the order number appear as &quot;INV-9999&quot;. Changes made here only affect new orders. Leave the default as &quot;{0}&quot; if you don't want to apply a different format." CssClass="dnnFormRequired"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="SalesOrderSalesOrderNumberFormatTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Sales order number format is required.</asp:RequiredFieldValidator>
			<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="SalesOrderSalesOrderNumberFormatTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\w-.]*\{0:?[\w.#]*\}[\w-.]*$" ValidationGroup="ConfigurationDetailsViewControl">Sales order number format is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="SalesOrderSalesOrderNumberFormatTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="NextSalesOrderNumberLabelControl" runat="server" Text="Next sales order number sequence:" HelpText="Enter a numeric value to change the next available sales order number sequence. You can only enter a value larger than the last generated order number. E.g. Enter a value 1001 if you want the next sequence to start at 1001 to improve your store credibility." CssClass="dnnFormRequired"/>
            <asp:RequiredFieldValidator ID="NextSalesOrderNumberRequiredFieldValidator" runat="server" ControlToValidate="NextSalesOrderNumberDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Next sales order number is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="NextSalesOrderNumberDnnNumericTextBox" runat="server" Skin="" Value="0" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
        </div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SalesOrderBusinessTaxNumberValidateLabelControl" runat="server" Text="Validate business tax number:" />
			<asp:CheckBox ID="SalesOrderBusinessTaxNumberValidateCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SalesOrderIncompleteOrdersAutoDeleteLabelControl" runat="server" Text="Days before deleting incomplete orders:" HelpText="Automatically delete incomplete orders older than the number of days specified. Leave blank if you don't want to automatically delete incomplete orders. Incomplete orders are open orders that have not completed checkout. If you enter a value, the number of days should be greater than your cart abandon and session timeout settings to avoid deleting an active customer cart still in progress."/>
			<dnn2:DnnNumericTextBox ID="SalesOrderIncompleteOrdersAutoDeleteDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="0" MaxValue="24855" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SalesOrderPreorderProcessBehaviorLabelControl" runat="server" Text="Preorder process behavior:" HelpText="Determines how a preorder should be processed." />
			<asp:DropDownList ID="SalesOrderPreorderProcessBehaviorDropDownList" runat="server">
				<asp:ListItem Text="Manual process" Value="1" />
				<asp:ListItem Text="Automatically process. Retry later on invalid product." Value="2" />
			</asp:DropDownList>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
