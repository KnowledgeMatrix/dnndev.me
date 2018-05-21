<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RecurringSalesOrderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RecurringSalesOrderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<h2>Recurring sales order</h2>
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
			<dnn1:LabelControl ID="RecurringSalesOrderCustomerSetStatusCancelActiveLabelControl" runat="server" Text="Allow customer to cancel recurring order:" />
			<asp:CheckBox ID="RecurringSalesOrderCustomerSetStatusCancelActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderCustomerSetStatusHoldActiveLabelControl" runat="server" Text="Allow customer to halt recurring order:" />
			<asp:CheckBox ID="RecurringSalesOrderCustomerSetStatusHoldActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderCustomerSetStatusActiveActiveLabelControl" runat="server" Text="Allow customer to resume inactive recurring order:" HelpText="Allow customer to re-activate a recurring order that is currently in cancelled or hold status." />
			<asp:CheckBox ID="RecurringSalesOrderCustomerSetStatusActiveActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderGroupOrdersActiveLabelControl" runat="server" Text="Group related orders:" HelpText="When possible, multiple recurring orders that are due on the same date with the same shipping, same payment method, etc. should be grouped into a single sales order to reduce shipping cost and payment transaction fees." />
			<asp:CheckBox ID="RecurringSalesOrderGroupOrdersActiveCheckBox" runat="server" />
		</div>
	</fieldset>
	<h2 id="RetryFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Retry incomplete payment</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderPaymentIncompleteRetryActiveLabelControl" runat="server" Text="Retry on update:" HelpText="Allow the system to reattempt charging the customer's credit card for previous active orders with incomplete payment when the customer updates his payment information." />
			<asp:CheckBox ID="RecurringSalesOrderPaymentIncompleteRetryActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderPaymentIncompleteRetryIntervalLabelControl" runat="server" HelpText="The number of days before automatically reattempt charging the customer's credit card for previous active orders with incomplete payment. Zero indicates no automatic reattempt." Text="Automatic retry interval:" CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="RecurringSalesOrderPaymentIncompleteRetryIntervalRequiredFieldValidator" runat="server" ControlToValidate="RecurringSalesOrderPaymentIncompleteRetryIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Interval is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="RecurringSalesOrderPaymentIncompleteRetryIntervalRangeValidator" runat="server" ControlToValidate="RecurringSalesOrderPaymentIncompleteRetryIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="365" MinimumValue="0" Type="Double" ValidationGroup="ConfigurationDetailsViewControl">Interval is invalid.</asp:RangeValidator>
			<asp:TextBox ID="RecurringSalesOrderPaymentIncompleteRetryIntervalTextBox" runat="server" CssClass="dnnFormRequired rvdQuantityInput">0</asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RecurringSalesOrderPaymentIncompleteRetryMaxRepeatLabelControl" runat="server" CssClass="dnnFormRequired" HelpText="Enter the maximum number of times to automatically reattempt charging the customer's credit card for previous active orders with incomplete payment. Typically, 1 or 2 max retries over a period of time is reasonable. Leave field blank to repeat perpetually." Text="Automatic retry max repeat:" />
			<asp:RequiredFieldValidator ID="RecurringSalesOrderPaymentIncompleteRetryMaxRepeatRequiredFieldValidator" runat="server" ControlToValidate="RecurringSalesOrderPaymentIncompleteRetryMaxRepeatDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max repeat is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RecurringSalesOrderPaymentIncompleteRetryMaxRepeatDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput">
			</dnn2:DnnNumericTextBox>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</asp:Panel>
